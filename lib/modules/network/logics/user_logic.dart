import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart' show Reader;
import 'package:network_demo/_features.dart';

abstract class UserLogicInterface {
  Stream<Result<List<User>>> get stream;
  Future<Result<User>> addUser();
  void onDispose();
}

class UserLogic implements UserLogicInterface {
  UserLogic({required this.reader}) {
    _streamController = StreamController();
    _populate();
  }

  final Reader reader;
  late final StreamController<Result<List<User>>> _streamController;
  late Result<List<User>> _currentResult;

  set data(Result<List<User>> result) {
    _currentResult = result;
    _streamController.sink.add(result);
  }

  UserRepositoryInterface get _repository => reader(userRepositoryRef);

  Future<void> _populate() async {
    data = await _repository.getUsers();
  }

  User get _userGenerator {
    return const User(
      name: 'BILI',
      email: 'fake@yopmail.fr',
      gender: 'male',
      status: 'inactive',
    );
  }

  @override
  Stream<Result<List<User>>> get stream => _streamController.stream.distinct();

  @override
  Future<Result<User>> addUser() async {
    final result = await _repository.createUser(_userGenerator);

    result.whenOrNull<void>(
      data: (user) {
        assert(user != null, 'user must be not null.');

        data = Result<List<User>>.data(
          value: _currentResult.when<List<User>>(
            data: (users) => <User>[user!, if (users != null) ...users],
            error: (_) => <User>[user!],
          ),
        );
      },
    );

    return result;
  }

  @override
  void onDispose() {
    Future.sync(() async => _streamController.close());
  }
}
