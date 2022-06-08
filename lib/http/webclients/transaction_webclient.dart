import 'dart:convert';
import 'package:bytebank/http/webclient.dart';
import 'package:http/http.dart' as http;
import '../../models/transaction.dart';

class TransactionWebClient {
  // Recupera todas as transações
  Future<List<Transaction>> findAll() async {
    // Chamada para recuperar todos os dados de transferencias
    final http.Response response = await client.get(Uri.parse(baseURL)).timeout(
          const Duration(seconds: 5),
        );
    // Decodificação dos dados JSON
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  //
  Future<Transaction> save(Transaction transaction) async {
    // Converte a transacion para um Map
    Map<String, dynamic> transactionMap = transaction.toJson();
    // Depois para um json
    final String transactionJson = jsonEncode(transactionMap);

    final http.Response response = await client.post(
      Uri.parse(baseURL),
      headers: {'Content-type': 'application/json', 'password': '1000'},
      body: transactionJson,
    );
    return Transaction.fromJson(jsonDecode(response.body));
  }
}
