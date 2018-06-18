import 'dart:async';

import 'package:courses_in_english/io/connect/provider_factory.dart';
import 'package:courses_in_english/io/connect/providers/department_provider.dart';
import 'package:courses_in_english/io/connect/providers/user_provider.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/model/user/user.dart';

/// This class controls the creation of users.
class UserCreationController {
  final UserProvider userProvider;
  final DepartmentProvider departmentProvider;

  Iterable<Department> _departments;
  /// Call UserCreationController.prepare before accessing this getter.
  /// UserCreationController.ready tells if this getter is prepared.
  Iterable<Department> get departments => _departments;

  UserCreationController(ProviderFactory providerFactory)
      : userProvider = providerFactory.createUserProvider(),
        departmentProvider = providerFactory.createDepartmentProvider();

  /// Prepare UserCreationController by downloading available departments for selection.
  /// Returns prepared UserCreationController
  Future<UserCreationController> prepare() async {
    _departments = await departmentProvider.getDepartments();
    return this;
  }

  Future<User> createUser(String firstName, String lastName, String password, String email) {
    // TODO Implement user creation using userProvider
    throw new UnimplementedError("User creation not implemented yet!");
  }

  bool get ready => departments != null;

}
