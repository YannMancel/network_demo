import 'package:dio/dio.dart' show BaseOptions, Dio;
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show Provider, StateNotifier, StateNotifierProvider;
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

final userLogicRef = Provider<UserLogicInterface>(
  (ref) => UserLogic(reader: ref.read),
  name: 'userLogicRef',
);

final usersRef = StateNotifierProvider<StateNotifier<Result<List<User>>>,
    Result<List<User>>>(
  (ref) => ref.watch(userLogicRef).stateNotifier,
  name: 'usersRef',
);
