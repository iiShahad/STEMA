import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stema/features/auth/models/user_model.dart';
import 'package:stema/features/auth/repository/auth_repository.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = Provider(
  (ref) => AuthController(
      authRepository: ref.watch(authRepositoryProvider), ref: ref),
);

class AuthController {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref;

  void signup(String username, String email, String password) async {
    final data = await _authRepository.signup(email, password, username);
    data.fold(
      (l) => null,
      (r) => _ref.read(userProvider.notifier).update((state) => r),
    );
  }

  void signin(String email, String password) async {
    final data = await _authRepository.signin(email, password);
    data.fold(
      (l) => null,
      (r) => _ref.read(userProvider.notifier).update((state) => r),
    );
  }

  void signout() async {
    final data = await _authRepository.signout();
    data.fold((l) => null, (r) => null);
  }
}
