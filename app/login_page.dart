import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../store/auth_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _storeController = TextEditingController();
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await ref.read(authControllerProvider).login(
        store: _storeController.text,
        account: _accountController.text,
        password: _passwordController.text,
      );
      // トークンがセットされていればログイン成功として次画面に遷移するなど
    } catch (_) {
      setState(() {
        _errorMessage = 'ログインに失敗しました';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final token = ref.watch(authTokenProvider);
    // tokenがnullでなければログイン済み などの分岐も可能

    return Scaffold(
      appBar: AppBar(title: const Text('ログイン')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _storeController,
              decoration: const InputDecoration(labelText: '店舗名'),
            ),
            TextField(
              controller: _accountController,
              decoration: const InputDecoration(labelText: '口座番号'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'パスワード'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            if (_errorMessage != null)
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _handleLogin,
                    child: const Text('ログイン'),
                  ),
          ],
        ),
      ),
    );
  }
}