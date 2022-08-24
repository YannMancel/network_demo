import 'package:network_demo/_features.dart';

class UserRepository implements UserRepositoryInterface {
  const UserRepository(this.networkRepository);

  final NetworkRepositoryInterface networkRepository;

  String get _userPath => '/users';

  @override
  Future<Result<User>> createUser(User user) async {
    final response = await networkRepository.post(
      _userPath,
      data: User.toJson(user),
    );

    return response.when<Result<User>>(
      data: (value) => Result.runGuarded<User>(
        run: () => User.fromJson(value as Map<String, dynamic>),
      ),
      error: (e) => Result<User>.error(exception: e),
    );
  }

  @override
  Future<Result<List<User>>> getUsers() async {
    final response = await networkRepository.get<dynamic>(_userPath);

    return response.when<Result<List<User>>>(
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
}
