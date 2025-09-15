import 'dart:math';
import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: '',
      headers: {'Content-Type': 'application/json'},
      connectTimeout: Duration(seconds: 3),
      receiveTimeout: Duration(seconds: 3),
    ),
  );

  Future<dynamic> getData() async {
    final res = await dio.get('/users');
    if (res.statusCode == 200) {
      final List data = res.data;
      log(data.length);
    }
  }
}
