import 'package:code_factory_clone/common/const/colors.dart';
import 'package:code_factory_clone/common/const/data.dart';
import 'package:code_factory_clone/common/layout/default_layout.dart';
import 'package:code_factory_clone/common/secure_storage/secure_storage.dart';
import 'package:code_factory_clone/common/view/root_tab.dart';
import 'package:code_factory_clone/user/view/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  // * 위젯이 처음 생성됐을 때 동작하는 함수
  // * await 불가
  @override
  void initState() {
    super.initState();

    checkToken();
  }

  void checkToken() async {
    final storage = ref.read(secureStorageProvider);

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final dio = Dio();

    try {
      final res = await dio.post(
        'http://$ip/auth/token',
        options: Options(
          headers: {
            'authorization': 'Bearer $refreshToken',
          }
        )
      );
      await storage.write(key: ACCESS_TOKEN_KEY, value: res.data['accessToken']);

    } catch(err) {
      print(err);
      await storage.deleteAll();
      Navigator.of(context).push(
          MaterialPageRoute(
              builder: (_) => const LoginScreen()
          )
      );
    }


    Future.delayed(Duration(seconds: 2), () {
      if(refreshToken == null || accessToken == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const RootTab()),
                (route) => false);
      }
    });
  }

  void deleteToken() async {
    final storage = ref.read(secureStorageProvider);

    await storage.deleteAll();
  }


  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        backgroundColor: PRIMARY_COLOR,
        child: SizedBox(
          width: MediaQuery.of(context).size.width, // 너비를 최대한
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'asset/img/logo/logo.png',
                width: MediaQuery.of(context).size.width / 2,
              ),
              const SizedBox(height: 16),
              const CircularProgressIndicator(
                color: Colors.white,
              )
            ],
          ),
        )
    );
  }
}
