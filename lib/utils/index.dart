import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constraints.dart';

const studentToken =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiVGFtbnRzZTYyNzUyXHJcbiIsInJvbGUiOiJTdHVkZW50IiwiZW1haWwiOiJ0YW1udHNlNjI3NTJAZnB0LmVkdS52biIsInBpY3R1cmUiOiJodHRwczovL2xoNC5nb29nbGV1c2VyY29udGVudC5jb20vLWZKWE53VUdmQXFVL0FBQUFBQUFBQUFJL0FBQUFBQUFBQUFBL0FNWnV1Y2tzZDJuRVBpSjhHY3ZOeEpMcmhiSGJPc0RjZkEvczk2LWMvcGhvdG8uanBnIiwiZGlzcGxheV9uYW1lIjoiTmd1eWVuIFRoYW5oIFRhbSAtIEsxMSBGVUcgSENNIiwidXNlcl9pZCI6InRod2JCdW8yWEJNUU11ejlIR1VUSFB0cWFnRTMiLCJuYmYiOjE1OTUzMTMwNjgsImV4cCI6MTU5NTkxNzg2OCwiaWF0IjoxNTk1MzEzMDY4fQ.fVshA3k1EuEZSksn_n8cVmSigPHbHpj_kALDK7U4Wkw';

Future<bool> setFCMToken(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString('FCMToken', value);
}

Future<String> getFCMToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('FCMToken');
}

Future<bool> setToken(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString('token', studentToken);
}

Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

class CustomInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    print(
        "REQUEST[${options?.method}] => PATH: ${options?.path} HEADER: ${options.headers.toString()}");
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

  set setToken(token) {
    options.headers["Authorization"] = "Bearer $token";
  }
}

final requestObj = new MyRequest();
final request = requestObj.request;
