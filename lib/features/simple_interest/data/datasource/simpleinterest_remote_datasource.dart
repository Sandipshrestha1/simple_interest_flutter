import 'package:smplintr/core/constants/api_constant.dart';
import 'package:smplintr/core/services/base_service.dart';

class SimpleInterestDatasource {
  final BaseService baseService;

  SimpleInterestDatasource(this.baseService);

  Future<Map<String, dynamic>> calculateInterest(Map<String, dynamic> data) {
    return baseService.post(ApiConstants.postSimpleInterest, data);
  }
}
