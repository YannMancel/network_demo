import 'package:network_demo/_features.dart';

abstract class UserRepositoryInterface {
  Future<Result<User>> createUser(User user);
  Future<Result<List<User>>> getUsers();
}
