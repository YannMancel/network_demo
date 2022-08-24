import 'package:dio/dio.dart' show Dio, DioError, Options, Response;
import 'package:flutter/foundation.dart';
import 'package:network_demo/_features.dart';

class DioRepository implements NetworkRepositoryInterface {
  const DioRepository({required this.dio});

  final Dio dio;

  Future<Result<T>> runGuardedAsync<T>({
    required AsyncValueGetter<Response<T>> run,
  }) async {
    try {
      final response = await run();
      return Result<T>.data(value: response.data);
    } on DioError catch (e) {
      return Result<T>.error(exception: e);
    } catch (e) {
      return Result<T>.error(exception: Exception(e.toString()));
    }
  }

  @override
  Future<Result<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return runGuardedAsync(
      run: () async => dio.get<T>(
        path,
        queryParameters: queryParameters,
      ),
    );
  }

  @override
  Future<Result<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    return runGuardedAsync(
      run: () async => dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: headers != null ? Options(headers: headers) : null,
      ),
    );
  }
}
