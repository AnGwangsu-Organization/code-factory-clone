import 'package:code_factory_clone/common/view/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
      _APP(),
  );
}

class _APP extends StatelessWidget {
  const _APP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen()
    );
  }
}

