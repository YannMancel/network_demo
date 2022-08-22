import 'package:dio/dio.dart' show Dio, DioError;
import 'package:network_demo/_features.dart';

class DioRepository implements NetworkRepositoryInterface {
  const DioRepository({required this.dio});

  final Dio dio;

  @override
  Future<Result<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get<T>(
        path,
        queryParameters: queryParameters,
      );

      return Result<T>.data(value: response.data);
    } on DioError catch (e) {
      return Result<T>.error(exception: Exception(e.toString()));
    } catch (e) {
      return Result<T>.error(exception: Exception(e.toString()));
    }
  }
}
