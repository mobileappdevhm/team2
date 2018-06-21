import 'dart:async';

import 'package:courses_in_english/io/inet/inet_provider_factory.dart';
import 'package:courses_in_english/io/inet/providers/department_provider.dart';
// import 'package:courses_in_english/io/inet/providers/user_provider.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/model/user/user.dart';

/// This class controls the creation of users.
class UserCreationController {
  // InetUserProvider _userProvider;
  InetDepartmentProvider _departmentProvider;

  Iterable<Department> _departments;

  void injectDependencies(InetProviderFactory providerFactory) {
    // _userProvider = providerFactory.createUserProvider();
    _departmentProvider = providerFactory.createDepartmentProvider();
  }

  /// Call UserCreationController.prepare before accessing this getter.
  /// UserCreationController.ready tells if this getter is prepared.
  Iterable<Department> get departments => _departments;

  /// Prepare UserCreationController by downloading available departments for selection.
  /// Returns prepared UserCreationController
  Future<UserCreationController> prepare() async {
    _departments = await _departmentProvider.getDepartments();
    return this;
  }

  Future<User> createUser(
      String firstName, String lastName, String password, String email) {
    // TODO Implement user creation using userProvider
    throw new UnimplementedError("User creation not implemented yet!");
  }

  bool get ready => departments != null;
}
