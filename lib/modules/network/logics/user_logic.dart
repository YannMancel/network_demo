import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart' show Reader;
import 'package:network_demo/_features.dart';

abstract class UserLogicInterface {
  Stream<Result<List<User>>> get stream;
  Future<Result<User>> addUser(User user);
  void onDispose();
}

class UserLogic implements UserLogicInterface {
  UserLogic({required this.reader}) {
    _streamController = StreamController();
    _populate();
  }

  final Reader reader;
  late final StreamController<Result<List<User>>> _streamController;

  set data(Result<List<User>> result) => _streamController.sink.add(result);

  String get _userPath => '/users';

  NetworkRepositoryInterface get _network => reader(networkRepositoryRef);

  Future<void> _populate() async {
    final response = await _network.get<dynamic>(_userPath);
    data = response.when<Result<List<User>>>(
      data: (value) => Result.runGuarded<List<User>>(
        run: () {
          return (value as List<dynamic>)
              .cast<Map<String, dynamic>>()
              .map(User.fromJson)
              .toList(growable: false);
        },
      ),
      error: (e) => Result<List<User>>.error(exception: e),
    );
  }

  @override
  Stream<Result<List<User>>> get stream => _streamController.stream.distinct();

  @override
  Future<Result<User>> addUser(User user) async {
    final response = await _network.post(
      _userPath,
      data: User.toJson(user),
    );

    final lastData = await _streamController.stream.last;

    return response.when<Result<User>>(
      data: (value) => Result.runGuarded<User>(
        run: () {
          final newUser = User.fromJson(value as Map<String, dynamic>);

          data = Result<List<User>>.data(
            value: lastData.when<List<User>>(
              data: (users) => <User>[newUser, if (users != null) ...users],
              error: (_) => <User>[newUser],
            ),
          );

          return newUser;
        },
      ),
      error: (e) => Result<User>.error(exception: e),
    );
  }

  @override
  void onDispose() {
    Future.sync(() async => _streamController.close());
  }
}
