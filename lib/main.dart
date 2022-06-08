import 'package:bytebank/theme/style.dart';
import 'package:flutter/material.dart';
//
import 'screens/dashboard.dart';

void main() {
  // save(
  //   Transaction(
  //     2000,
  //     Contacts(
  //       0,
  //       'Fran',
  //       1500,
  //     ),
  //   ),
  // ).then((transaction) => debugPrint(transaction.toString()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getTheme(),
      home: const Dashboard(),
    );
  }
}
