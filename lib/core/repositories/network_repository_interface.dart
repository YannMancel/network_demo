import 'package:network_demo/_features.dart';

abstract class NetworkRepositoryInterface {
  Future<Result<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  });
}
