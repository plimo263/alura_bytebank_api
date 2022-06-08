import 'package:bytebank/database/contact_dao.dart';
import 'package:bytebank/models/contacts.dart';
import 'package:flutter/material.dart';

class ContatcsForm extends StatefulWidget {
  const ContatcsForm({Key? key}) : super(key: key);

  @override
  State<ContatcsForm> createState() => _ContatcsFormState();
}

class _ContatcsFormState extends State<ContatcsForm> {
  //
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _accountNumberController =
      TextEditingController();
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              style: const TextStyle(
                fontSize: 24,
              ),
              decoration: const InputDecoration(
                labelText: 'Full Name',
                labelStyle: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                controller: _accountNumberController,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 24,
                ),
                decoration: const InputDecoration(
                  labelText: 'Account Number',
                  labelStyle: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    final String name = _nameController.text;
                    int? accountNumber =
                        int.tryParse(_accountNumberController.text);
                    //
                    if (accountNumber != null) {
                      final contact = Contacts(0, name, accountNumber);
                      _dao
                          .save(contact)
                          .then((value) => Navigator.pop(context));
                    }
                  },
                  child: const Text('Create'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
