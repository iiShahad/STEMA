import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:stema/core/core.dart';
import 'package:stema/features/auth/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(supabase: ref.watch(supabaseProvider)),
);

class AuthRepository {
  final SupabaseClient _supabase;
  const AuthRepository({required SupabaseClient supabase})
      : _supabase = supabase;

  Stream<AuthState> get authStateChange => _supabase.auth.onAuthStateChange;

  FutureEither<UserModel> signup(
      String email, String password, String username) async {
    try {
      final res = await _supabase.auth.signUp(
          email: email, password: password, data: {"username": username});
      final currentUser = await getUserData(res.user!.id);
      return right(currentUser);
    } on AuthException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure("Connection Error"));
    }
  }

  FutureEither<UserModel> signin(String email, String password) async {
    try {
      final res = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final currentUser = await getUserData(res.user!.id);
      return right(currentUser);
    } on AuthException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure("Connection Error"));
    }
  }

  FutureVoid signout() async {
    try {
      return right(await _supabase.auth.signOut());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<UserModel> getUserData(String userId) async {
    final data = await _supabase.from('user').select().eq('id', userId);
    final user = UserModel.fromJson(data[0]);
    return user;
  }
}
