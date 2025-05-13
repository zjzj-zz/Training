import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _onButtonPressed() {
    // ここにボタン押下時の処理を書く（例: デバッグ出力など）
    debugPrint('ホーム画面のボタンが押されました');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ホーム')),
      body: Center(
        child: ElevatedButton(
          onPressed: _onButtonPressed,
          child: const Text('次の処理へ'),
        ),
      ),
    );
  }
}