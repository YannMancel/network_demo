import 'package:dio/dio.dart'
    show
        DioError,
        ErrorInterceptorHandler,
        Interceptor,
        RequestInterceptorHandler,
        RequestOptions,
        Response,
        ResponseInterceptorHandler;
import 'package:network_demo/_features.dart';

class LoggerInterceptor extends Interceptor {
  String _buildMessage({required Map<String, dynamic> map}) {
    final buffer = StringBuffer();
    buffer.writeln('----------------------------------------------------');
    map.forEach((key, value) => buffer.writeln('$key: $value'));
    buffer.writeln('----------------------------------------------------');
    return buffer.toString();
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final message = _buildMessage(map: <String, dynamic>{
      'method': 'REQUEST ${options.method}',
      'headers': options.headers,
      'baseUrl': options.baseUrl,
      'path': options.path,
      'data': options.data,
    });
    Logger.info(message: message);

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final message = _buildMessage(map: <String, dynamic>{
      'method': 'RESPONSE ${response.requestOptions.method}',
      'baseUrl': response.requestOptions.baseUrl,
      'path': response.requestOptions.path,
      'statusCode': response.statusCode,
      'data': response.data,
    });
    Logger.debug(message: message);

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final message = _buildMessage(map: <String, dynamic>{
      'type': 'ERROR ${err.type}',
      'message': err.message,
      'response': err.response?.data,
      'method': 'REQUEST ${err.requestOptions.method}',
      'headers': err.requestOptions.headers,
      'baseUrl': err.requestOptions.baseUrl,
      'path': err.requestOptions.path,
    });
    Logger.error(message: message);

    super.onError(err, handler);
  }
}
