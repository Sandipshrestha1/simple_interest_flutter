import 'package:smplintr/core/services/base_service.dart';
import 'package:smplintr/features/simple_interest/data/datasource/simpleinterest_remote_datasource.dart';
import 'package:smplintr/features/simple_interest/data/repositories/simple_interest_repository_impl.dart';

import '../domain/entities/simple_interest.dart';

class SimpleInterestController {
  final repository = SimpleInterestRepositoryImpl(
    SimpleInterestDatasource(BaseService()),
  );

  Future<SimpleInterest> calculate({
    required double principal,
    required double rate,
    required double time,
  }) async {
    return await repository.calculateInterest(
      principal: principal,
      rate: rate,
      time: time,
    );
  }
}
