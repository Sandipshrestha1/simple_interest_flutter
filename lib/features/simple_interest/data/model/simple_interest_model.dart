class SimpleInterestRequestModel {
  final double principal;
  final double rate;
  final double time;
  SimpleInterestRequestModel({
    required this.principal,
    required this.rate,
    required this.time,
  });
  Map<String, dynamic> toJson() {
    return {"principal": principal, "rate": rate, "time": time};
  }
}

class SimpleInterestResponseModel {
  final double principal;
  final double interest;
  final double totalAmount;

  SimpleInterestResponseModel({
    required this.principal,
    required this.interest,
    required this.totalAmount,
  });

  factory SimpleInterestResponseModel.fromJson(Map<String, dynamic> json) {
    return SimpleInterestResponseModel(
      principal: (json["principal"] as num).toDouble(),
      interest: (json["interest"] as num).toDouble(),
      totalAmount: (json["total_amount"] as num).toDouble(),
    );
  }
}
