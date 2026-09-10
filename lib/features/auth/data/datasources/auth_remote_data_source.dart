import 'package:blog_app/core/error/exception.dart';

import 'package:blog_app/features/auth/data/models/user_models.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpwithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> loginwithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImp(this.supabaseClient);

  @override
  Future<UserModel> loginwithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw ServerException("user is null");
      }
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      if (e.code == 'over_email_send_rate_limit') {
        throw ServerException(
          'Too many signup emails were requested. Please wait a few minutes and try again.',
        );
      }
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpwithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );
      if (response.user == null) {
        throw ServerException("user is null");
      }
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      if (e.code == 'over_email_send_rate_limit') {
        throw ServerException(
          'Too many signup emails were requested. Please wait a few minutes and try again.',
        );
      }
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
