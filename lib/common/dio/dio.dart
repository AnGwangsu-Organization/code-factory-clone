import 'package:code_factory_clone/common/const/data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
  });

  // 요청을 보낼때(요청을 보내기전에 가로채서 실행)
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQUEST] [${options.method}] ${options.uri}');

    if(options.headers['accessToken'] == 'true') {
      // headers 삭제
      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      // 실제 headers 추가
      options.headers.addAll({
        'authorization': 'Bearer $token'
      });
    }

    if(options.headers['refreshToken'] == 'true') {
      // headers 삭제
      options.headers.remove('refreshToken');

      final token = await storage.read(key: REFRESH_TOKEN_KEY);
      // 실제 headers 추가
      options.headers.addAll({
        'authorization': 'Bearer $token'
      });
    }
    // return이 될때 요청이 넘어감
    return super.onRequest(options, handler);
  }

  // 응답을 받을때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('[RESPONSE] [${response.requestOptions.method}] ${response.requestOptions.uri}');

    return super.onResponse(response, handler);
  }

  // 에러가 날때
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 401에러
    // 토큰 재발급 시도
    // 다시 새로운 토큰으로 요청을 한다.
    print('[ERROR] [${err.requestOptions.method}] ${err.requestOptions.uri}');

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    // refreshToken이 없다면 error를 던진다.
    if(refreshToken == null) {
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    // refresh Error 가 아닌경우 => accessToken의 재발급후 해당 요청 재 요청
    if(isStatus401 && !isPathRefresh) {
      final dio = Dio();
      try {
        final res = await dio.post(
            'http://$ip/auth/token',
            options: Options(
                headers: {
                  'authorization': 'Bearer $refreshToken'
                }
            )
        );

        final accessToken = res.data['accessToken'];

        final options = err.requestOptions;

        // 토큰 변경
        options.headers.addAll({
          'authorization': 'Bearer $accessToken'
        });

        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        // 새로 보낸 요청(토큰만 보낸 요청)
        final response = await dio.fetch(options);
        return handler.resolve(response);
      } on DioException catch(e) {
        return handler.reject(err);
      }
    }
    return super.onError(err, handler);
  }
}