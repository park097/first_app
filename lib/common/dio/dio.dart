import 'package:actual/common/const/data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomInterceptor extends Interceptor {
  //외부에서 받아 올 거임,스토리지에서 토큰을 받아와야 하니까
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
  });

  // 1) 요청을 보낼때
  // 요청이 보내질때마다
  // 만약에 요청의 Header에 accessToken: true라는 값이 있다면
  // 실제 토큰을 가져와서 (storage에서) authorization: bearer $token으로
  // 헤더를 변경한다.
  //매번토큰을 집어넣을 수 없으니까, 토큰을 항상 일정하기때문에 플러터 시큐어에서 가져오니까
  @override
  //~했을 때 는 on을 붙인다.
  //요청 보내는함수가 실행이되고 요청이 보내지기전에 인터셉터 요청을 중간에
  //가로채는 순간에 실행이 됨
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    //겟메서드냐 풋메서드냐
    print('[REQ] [${options.method}] ${options.uri}');

    //보낼려는 요청의 헤더에서 값을 가져올 수 있음
    if (options.headers['accessToken'] == 'true') {
      // 헤더 삭제(헤더는 맵이니까 가능),애세스토큰 키 삭제
      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      // 실제 토큰으로 대체
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    if (options.headers['refreshToken'] == 'true') {
      // 헤더 삭제
      options.headers.remove('refreshToken');

      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      // 실제 토큰으로 대체
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    //여기서 보내지는 거임
    return super.onRequest(options, handler);
  }

  // 2) 응답을 받을때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        //응답을 받기위한 요청이 다 들어가 있음
        '[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');

    return super.onResponse(response, handler);
  }

  // 3) 에러가 났을때
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    // 401에러가 났을때 (status code)
    // 토큰을 재발급 받는 시도를하고 토큰이 재발급되면
    // 다시 새로운 토큰으로 요청을한다.

    print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    // refreshToken 아예 없으면
    // 당연히 에러를 던진다
    if (refreshToken == null) {
      // 에러를 던질때는 handler.reject를 사용한다.
      return handler.reject(err);
    }
//응답의 모든것들을 가져올수 있음,401은 토큰이 잘 못됐다는 말
    final isStatus401 = err.response?.statusCode == 401;
    //토큰을 리프레쉬 하려다가 에러가 났다는 말
    final isPathRefresh = err.requestOptions.path == '/auth/token';
//토큰을 새로 리스레쉬하려는 의도가 아니였는데 401 오류나가 났다면
    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();

      try {
        final resp = await dio.post(
          'http://$ip/auth/token',
          options: Options(
            headers: {
              'authorization': 'Bearer $refreshToken',
            },
          ),
        );

        final accessToken = resp.data['accessToken'];

        final options = err.requestOptions;

        // 토큰 변경하기
        options.headers.addAll({
          'authorization': 'Bearer $accessToken',
        });

        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        // 요청 재전송,토큰만 변경시킨대로
        final response = await dio.fetch(options);
        //성공적인 요청을 반환
        return handler.resolve(response);
      } on DioError catch (e) {
        // circular dependency error
        // A, B
        // A -> B의 친구
        // B -> A의 친구
        // A는 B의 친구구나
        // A -> B -> A -> B -> A -> B

        return handler.reject(e);
      }
    }
  }
}
