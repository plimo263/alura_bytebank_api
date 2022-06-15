import 'package:bytebank/screens/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'contacts_list.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('images/bytebank_logo.png'),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _FeatureItem(
                    icon: Icons.monetization_on,
                    name: 'Transfer',
                    onClick: () => _showContactsList(context),
                  ),
                  _FeatureItem(
                    icon: Icons.description,
                    name: 'Transaction Feed',
                    onClick: () => _showTransactionsList(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //
  void _showContactsList(BuildContext context) {
    //FirebaseCrashlytics.instance.crash();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return const ContactsList();
      }),
    );
  }

  _showTransactionsList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return const TransactionsList();
      }),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String name;
  final Function onClick;

  const _FeatureItem(
      {Key? key, required this.icon, required this.name, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            width: 150,
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                ),
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
