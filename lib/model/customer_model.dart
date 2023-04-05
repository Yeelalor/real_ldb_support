// class customer_model {
//   String? cif;
//   String? name1;
//   String? name2;
//   String? mobileNo;
//   String? birdth;
//   String? account;
//   String? accountStatus;
//   String? cardNo;
//   String? ccy;

//   customer_model(
//       {this.cif,
//       this.name1,
//       this.name2,
//       this.mobileNo,
//       this.birdth,
//       this.account,
//       this.accountStatus,
//       this.cardNo,
//       this.ccy});

//   customer_model.fromJson(Map<String, dynamic> json) {
//     cif = json['cif'];
//     name1 = json['name1'];
//     name2 = json['name2'];
//     mobileNo = json['mobileNo'];
//     birdth = json['birdth'];
//     account = json['account'];
//     accountStatus = json['accountStatus'];
//     cardNo = json['cardNo'];
//     ccy = json['ccy'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['cif'] = this.cif;
//     data['name1'] = this.name1;
//     data['name2'] = this.name2;
//     data['mobileNo'] = this.mobileNo;
//     data['birdth'] = this.birdth;
//     data['account'] = this.account;
//     data['accountStatus'] = this.accountStatus;
//     data['cardNo'] = this.cardNo;
//     return data;
//   }
// }
// To parse this JSON data, do
//
//     final customerModel = customerModelFromJson(jsonString);

import 'dart:convert';

List<CustomerModel> customerModelFromJson(String str) => List<CustomerModel>.from(json.decode(str).map((x) => CustomerModel.fromJson(x)));

String customerModelToJson(List<CustomerModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerModel {
    CustomerModel({
        required this.cif,
        required this.name1,
        required this.name2,
        required this.mobileNo,
        required this.birdth,
        required this.account,
        this.accountStatus,
        this.cardNo,
        required this.ccy,
    });

    String cif;
    String name1;
    String name2;
    String mobileNo;
    String birdth;
    String account;
    dynamic accountStatus;
    dynamic cardNo;
    String ccy;

    factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        cif: json["cif"],
        name1: json["name1"],
        name2: json["name2"],
        mobileNo: json["mobileNo"],
        birdth: json["birdth"],
        account: json["account"],
        accountStatus: json["accountStatus"],
        cardNo: json["cardNo"],
        ccy: json["ccy"],
    );

    Map<String, dynamic> toJson() => {
        "cif": cif,
        "name1": name1,
        "name2": name2,
        "mobileNo": mobileNo,
        "birdth": birdth,
        "account": account,
        "accountStatus": accountStatus,
        "cardNo": cardNo,
        "ccy": ccy,
    };
}
