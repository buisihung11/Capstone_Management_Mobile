import 'package:dio/dio.dart';

import '../constraints.dart';

// class RequestClient extends BaseClient {
//   Client _inner;
//   static final String baseURL = SERVER_API;

//   RequestClient() {
//     _inner = Client();
//   }

//   Future<StreamedResponse> send(BaseRequest request) {
//     request.headers["authorization"] = "Bearer token";
//     return _inner.send(request);
//   }
// }

class CustomInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    print("REQUEST[${options?.method}] => PATH: ${options?.path}");
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) async {
    print(
        "RESPONSE[${response?.statusCode}] => PATH: ${response?.request?.path}");
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    print("ERROR[${err?.response?.statusCode}] => PATH: ${err?.request?.path}");
    return super.onError(err);
  }
}

// or new Dio with a BaseOptions instance.

class MyRequest {
  static BaseOptions options = new BaseOptions(
    baseUrl: SERVER_API,
    headers: {
      Headers.contentTypeHeader: "application/json",
      Headers.wwwAuthenticateHeader: "Bearer Token",
    },
  );
  Dio _inner;
  MyRequest() {
    _inner = new Dio(options);
    _inner.interceptors.add(CustomInterceptors());
  }

  Dio get request {
    return _inner;
  }
}
