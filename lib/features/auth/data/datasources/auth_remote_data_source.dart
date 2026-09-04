import 'package:blog_app/core/error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUpwithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<String> loginwithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImp(this.supabaseClient);

  @override
  Future<String> loginwithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement loginwithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<String> signUpwithEmailPassword({
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
      return response.user!.id;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
