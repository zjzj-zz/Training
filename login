import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock App Login',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('株取引アプリ', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _storeController = TextEditingController();
  final _customerController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _storeController.dispose();
    _customerController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // ログイン処理をここに追加
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text('ログイン成功'),
          content: Text('ダミー処理ですがログインできました。'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ログイン')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _storeController,
                decoration: const InputDecoration(labelText: '店舗番号（5桁）'),
                keyboardType: TextInputType.number,
                maxLength: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '店舗番号を入力してください';
                  } else if (!RegExp(r'^\d{5}$').hasMatch(value)) {
                    return '5桁の数字で入力してください';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _customerController,
                decoration: const InputDecoration(labelText: '顧客コード（7桁）'),
                keyboardType: TextInputType.number,
                maxLength: 7,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '顧客コードを入力してください';
                  } else if (!RegExp(r'^\d{7}$').hasMatch(value)) {
                    return '7桁の数字で入力してください';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'パスワード（英数字32桁以内）'),
                obscureText: true,
                maxLength: 32,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'パスワードを入力してください';
                  } else if (!RegExp(r'^[a-zA-Z0-9]{1,32}$').hasMatch(value)) {
                    return '英数字32桁以内で入力してください';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: const Text('ログイン'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
