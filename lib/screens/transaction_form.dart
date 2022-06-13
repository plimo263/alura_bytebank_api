import 'dart:async';

import 'package:bytebank/components/progress.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/models/contacts.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/transaction.dart';

class TransactionForm extends StatefulWidget {
  final Contacts contact;

  const TransactionForm({Key? key, required this.contact}) : super(key: key);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();
  final String uuid = const Uuid().v4();
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: _sending,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Progress(message: 'Sending...'),
                ),
              ),
              Text(
                widget.contact.name,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: const TextStyle(fontSize: 24.0),
                  decoration: const InputDecoration(labelText: 'Value'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: const Text('Transfer'),
                    onPressed: () async {
                      double? value = double.tryParse(_valueController.text);

                      await showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return TransactionAuthDialog(
                              onConfirm: (String password) {
                                if (value != null) {
                                  _save(uuid, value, password, context);
                                }
                              },
                            );
                          });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(String inUuid, double value, String password,
      BuildContext context) async {
    final transactionCreated = Transaction(inUuid, value, widget.contact);
    setState(() {
      _sending = true;
    });
    await _send(transactionCreated, password, context).whenComplete(() {
      setState(() {
        _sending = false;
      });
    });

    _showSuccessfulMessage(context);
  }

  void _showSuccessfulMessage(BuildContext context) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return const SuccessDialog('successful transaction');
        }).then((value) => Navigator.pop(context));
  }

  Future<Transaction> _send(
      Transaction transactionCreated, String password, BuildContext context) {
    return _webClient.save(transactionCreated, password).catchError((e) {
      _showFailureMessage(context, message: 'timeout submitting transaction');
    }, test: (e) => e is TimeoutException).catchError((e) {
      _showFailureMessage(context, message: e.message);
    }, test: (e) => e is HttpException).catchError((e) {
      _showFailureMessage(context, message: e.message);
    }, test: (e) => e is Exception);
  }

  void _showFailureMessage(BuildContext context,
      {String message = 'Unknown error'}) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
        });
  }
}
