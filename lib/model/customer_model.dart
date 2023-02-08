class customer_model {
  String? cif;
  String? name1;
  String? name2;
  String? mobileNo;
  String? birdth;
  String? account;
  String? accountStatus;
  String? cardNo;
  String? ccy;

  customer_model(
      {this.cif,
      this.name1,
      this.name2,
      this.mobileNo,
      this.birdth,
      this.account,
      this.accountStatus,
      this.cardNo,
      this.ccy});

  customer_model.fromJson(Map<String, dynamic> json) {
    cif = json['cif'];
    name1 = json['name1'];
    name2 = json['name2'];
    mobileNo = json['mobileNo'];
    birdth = json['birdth'];
    account = json['account'];
    accountStatus = json['accountStatus'];
    cardNo = json['cardNo'];
    ccy = json['ccy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cif'] = this.cif;
    data['name1'] = this.name1;
    data['name2'] = this.name2;
    data['mobileNo'] = this.mobileNo;
    data['birdth'] = this.birdth;
    data['account'] = this.account;
    data['accountStatus'] = this.accountStatus;
    data['cardNo'] = this.cardNo;
    return data;
  }
}
