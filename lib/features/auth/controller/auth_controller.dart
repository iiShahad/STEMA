import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stema/features/auth/models/user_model.dart';
import 'package:stema/features/auth/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = Provider(
  (ref) => AuthController(
      authRepository: ref.watch(authRepositoryProvider), ref: ref),
);

final authStateChangeProvider = StreamProvider<AuthState>((ref) {
  final authStateChange = ref.watch(authRepositoryProvider).authStateChange;
  return authStateChange;
});

class AuthController {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref;

  Future signup(String username, String email, String password) async {
    final data = await _authRepository.signup(email, password, username);
    data.fold(
      (l) {
        throw l; // This will throw the 'Failure' exception
      },
      (r) {
        _ref.read(userProvider.notifier).update((state) => r);
      },
    );
  }

  Future signin(String email, String password) async {
    final data = await _authRepository.signin(email, password);
    data.fold(
      (l) {
        throw l; // This will throw the 'Failure' exception
      },
      (r) {
        _ref.read(userProvider.notifier).update((state) => r);
      },
    );
  }

  void signout() async {
    final data = await _authRepository.signout();
    data.fold((l) => null, (r) => null);
  }

  Future<UserModel> getUserData(String uid) async {
    final data = await _authRepository.getUserData(uid);
    return data;
  }
}
