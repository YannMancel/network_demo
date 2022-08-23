import 'package:dio/dio.dart' show BaseOptions, Dio;
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show Provider, StreamProvider;
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

final userLogicRef = Provider.autoDispose<UserLogicInterface>(
  (ref) {
    final logic = UserLogic(reader: ref.read);
    ref.onDispose(logic.onDispose);
    return logic;
  },
  name: 'userLogicRef',
);

final usersRef = StreamProvider.autoDispose<Result<List<User>>>(
  (ref) => ref.watch(userLogicRef).stream,
  name: 'usersRef',
);
