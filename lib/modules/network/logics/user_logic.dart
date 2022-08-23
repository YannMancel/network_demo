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

  String get _userPath => '/users';

  NetworkRepositoryInterface get _network => reader(networkRepositoryRef);

  Future<void> _populate() async {
    final response = await _network.get<dynamic>(_userPath);
    state = response.when<Result<List<User>>>(
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
  StateNotifier<Result<List<User>>> get stateNotifier => this;

  @override
  Future<Result<User>> addUser(User user) async {
    final response = await _network.post(
      _userPath,
      data: User.toJson(user),
    );

    return response.when<Result<User>>(
      data: (value) => Result.runGuarded<User>(
        run: () {
          final newUser = User.fromJson(value as Map<String, dynamic>);

          state = Result<List<User>>.data(
            value: state.when<List<User>>(
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
}
