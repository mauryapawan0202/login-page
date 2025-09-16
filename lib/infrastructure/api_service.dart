import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_page/model/user_model.dart';

final objectProvider=Provider((ref) => ApiService(),);
final userListProvider=FutureProvider((ref) {
  final api=ref.read(objectProvider);
  return api.getData();
},);


class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      headers: {'Content-Type': 'application/json'},
      connectTimeout: Duration(seconds: 3),
      receiveTimeout: Duration(seconds: 3),
    ),
  );

  Future<List<UserList>> getData() async {
    final res = await dio.get('/posts');
    if (res.statusCode == 200) {
      final List data = res.data;
      log(data.length);
     return data.map((e) => UserList.fromJson(e),).toList();
    }else{
      throw Exception('no data found');
    }
  }
}
