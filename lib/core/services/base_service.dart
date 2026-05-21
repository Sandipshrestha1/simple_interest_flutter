import 'package:dio/dio.dart';
import 'package:smplintr/core/constants/network/dio_client.dart';

class BaseService {
  final Dio _dio = DioClient.instance;

  // POST
  Future<Map<String, dynamic>> post(
    String url,
    Map<String, dynamic> data,
  ) async {
    final response = await _dio.post(url, data: data);
    return response.data;
  }

  // GET
  Future<Map<String, dynamic>> get(String url) async {
    final response = await _dio.get(url);
    return response.data;
  }
}
