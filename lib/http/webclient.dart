import 'package:http_interceptor/http_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

// Interceptador para acompanhar atividades request/response
final InterceptedClient client = InterceptedClient.build(
  interceptors: [LoggingInterceptor()],
  requestTimeout: const Duration(seconds: 5),
);
// URL base
const baseURL = 'http://192.168.0.69:8081/transactions';
