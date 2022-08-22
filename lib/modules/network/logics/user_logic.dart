import 'package:hooks_riverpod/hooks_riverpod.dart' show Reader, StateNotifier;
import 'package:network_demo/_features.dart';

abstract class UserLogicInterface {
  StateNotifier<Result<List<User>>> get stateNotifier;
  Future<Result<User>> addUser(User user);
}

class UserLogic extends StateNotifier<Result<List<User>>>
    implements UserLogicInterface {
  UserLogic({required this.reader})
      : super(Result<List<User>>.data(value: List<User>.empty())) {
    _populate();
  }

  final Reader reader;

  NetworkRepositoryInterface get _network {
    return reader(networkRepositoryRef);
  }

  Future<void> _populate() async {
    final response = await _network.get<dynamic>('/users');
    state = response.when<Result<List<User>>>(
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
  }

  @override
  StateNotifier<Result<List<User>>> get stateNotifier => this;

  @override
  Future<Result<User>> addUser(User user) async {
    final response = await _network.post(
      '/users',
      data: User.toJson(user),
    );

    return response.when<Result<User>>(
      data: (value) {
        try {
          final newUser = User.fromJson(value as Map<String, dynamic>);

          state = Result<List<User>>.data(
            value: state.when(
              data: (users) => <User>[if (users != null) ...users, newUser],
              error: (_) => <User>[newUser],
            ),
          );

          return Result<User>.data(value: newUser);
        } catch (e) {
          return Result<User>.error(exception: Exception(e.toString()));
        }
      },
      error: (e) => Result<User>.error(exception: e),
    );
  }
}
