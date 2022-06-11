import 'dart:convert';
import 'package:bytebank/http/webclient.dart';
import 'package:http/http.dart' as http;
import '../../models/transaction.dart';

class TransactionWebClient {
  static final Map<int, String> httpErrorMap = {
    400: 'there was an error submitting transaction',
    401: 'authentication failed',
  };

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
  Future<Transaction> save(Transaction transaction, String password) async {
    // Converte a transacion para um Map
    Map<String, dynamic> transactionMap = transaction.toJson();
    // Depois para um json
    final String transactionJson = jsonEncode(transactionMap);

    final http.Response response = await client.post(
      Uri.parse(baseURL),
      headers: {'Content-type': 'application/json', 'password': password},
      body: transactionJson,
    );
    // Lidando com os erros (conhecidos e desconhecidos)
    if (response.statusCode != 200) {
      _throwHttpError(response.statusCode);
    }

    return Transaction.fromJson(jsonDecode(response.body));
  }

  void _throwHttpError(int statusCode) {
    // Lidando com os erros (conhecidos e desconhecidos)
    if (TransactionWebClient.httpErrorMap.containsKey(statusCode)) {
      throw Exception(TransactionWebClient.httpErrorMap[statusCode]);
    } else {
      throw Exception('Unknown Error');
    }
  }
}
