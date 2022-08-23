import 'package:dio/dio.dart'
    show Interceptor, RequestInterceptorHandler, RequestOptions;

class AuthorizationInterceptor extends Interceptor {
  AuthorizationInterceptor(this.token);

  final String token;

  bool _needAuthorization(RequestOptions options) => options.method != 'GET';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_needAuthorization(options)) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }
}
