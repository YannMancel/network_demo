import 'package:dio/dio.dart' show BaseOptions, Dio;
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show FutureProvider, Provider;
import 'package:network_demo/_features.dart';

final tokenRef = Provider<String>(
  (_) => const String.fromEnvironment('TOKEN'),
  name: 'tokenRef',
);

final dioRef = Provider<Dio>(
  (ref) {
    final token = ref.watch(tokenRef);
    final options = BaseOptions(
      baseUrl: 'https://gorest.co.in/public/v2',
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: <String, dynamic>{'Authorization': 'Bearer $token'},
    );
    return Dio(options);
  },
  name: 'dioRef',
);

final networkRepositoryRef = Provider<NetworkRepositoryInterface>(
  (ref) {
    final dio = ref.watch(dioRef);
    return DioRepository(dio: dio);
  },
  name: 'networkRepositoryRef',
);

final usersRef = FutureProvider<Result<List<User>>>(
  (ref) async {
    final networkRepository = ref.watch(networkRepositoryRef);

    final response = await networkRepository.get<dynamic>('/users');
    return response.when<Result<List<User>>>(
      data: (value) {
        try {
          final users = (value as List<dynamic>)
              .cast<Map<String, dynamic>>()
              .map(User.fromJson)
              .toList(growable: false);

          return Result<List<User>>.data(value: users);
        } catch (e) {
          return Result<List<User>>.error(exception: Exception(e.toString()));
        }
      },
      error: (e) => Result<List<User>>.error(exception: e),
    );
  },
  name: 'usersRef',
);
