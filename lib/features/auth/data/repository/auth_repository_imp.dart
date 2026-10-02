import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';

import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/data/models/user_models.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImp(this.remoteDataSource, this.connectionChecker);
  final ConnectionChecker connectionChecker;

  @override
  Future<Either<Failures, void>> logout() async {
    try {
      await remoteDataSource.logout();
      return right(null);
    } catch (e) {
      return left(Failures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, User>> currentUser() async {
    final session = remoteDataSource.currentUserSession;
    if (session == null) {
      return left(Failures("user is not logged in"));
    }

    final sessionUser = UserModel(
      id: session.user.id,
      name: "",
      email: session.user.email ?? "",
      password: "",
    );

    if (!await connectionChecker.isConnected) {
      return right(sessionUser);
    }

    try {
      final user = await remoteDataSource.getCurrentUserData();
      return right(user ?? sessionUser);
    } catch (_) {
      return right(sessionUser);
    }
  }

  @override
  Future<Either<Failures, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signUpwithEmailPassword(
        email: email,
        password: password,
        name: name,
      ),
    );
  }

  @override
  Future<Either<Failures, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.loginwithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failures, User>> _getUser(Future<User> Function() fn) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failures(" No internet connection "));
      }
      final user = await fn();
      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failures(e.message));
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }
}
