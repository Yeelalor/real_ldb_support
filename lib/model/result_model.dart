
class result_model {
  String? fromAccount;
  String? amount;
  String? ccy;

  result_model({this.fromAccount, this.amount, this.ccy});

  result_model.fromJson(Map<String, dynamic> json) {
    fromAccount = json['fromAccount'];
    amount = json['amount'];
    ccy = json['ccy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fromAccount'] = this.fromAccount;
    data['amount'] = this.amount;
    data['ccy'] = this.ccy;
    return data;
  }
}