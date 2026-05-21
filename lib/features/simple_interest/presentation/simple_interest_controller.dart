import 'package:smplintr/core/services/base_service.dart';

import '../data/datasource/simpleinterest_remote_datasource.dart';
import '../data/repositories/simple_interest_repository_impl.dart';

class SimpleInterestController {
  late final SimpleInterestRepositoryImpl repository;

  SimpleInterestController() {
    repository = SimpleInterestRepositoryImpl(
      SimpleInterestDatasource(BaseService()),
    );
  }

  Future<String> calculate({
    required double principal,
    required double rate,
    required double time,
  }) async {
    final response = await repository.calculateInterest(
      principal: principal,
      rate: rate,
      time: time,
    );

    return response.interest.toString();
  }
}
