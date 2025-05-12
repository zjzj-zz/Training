import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/auth_api.dart';

final authTokenProvider = StateProvider<String?>((ref) => null);

final authControllerProvider = Provider<AuthController>((ref) {
  return AuthController(ref);
});

class AuthController {
  final Ref ref;

  AuthController(this.ref);

  Future<void> login({
    required String store,
    required String account,
    required String password,
  }) async {
    final token = await AuthApi.login(
      store: store,
      account: account,
      password: password,
    );
    ref.read(authTokenProvider.notifier).state = token;
  }

  void logout() {
    ref.read(authTokenProvider.notifier).state = null;
  }
}