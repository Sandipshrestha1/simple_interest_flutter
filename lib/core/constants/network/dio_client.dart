import 'package:dio/dio.dart';
import 'package:smplintr/core/constants/api_constant.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late Dio dio;

  factory DioClient() => _instance;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {"Content-Type": "application/json"},
      ),
    );
  }

  // 👇 ADD THIS (important for clean usage)
  static Dio get instance => _instance.dio;
}
