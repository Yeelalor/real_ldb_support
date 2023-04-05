// To parse this JSON data, do
//
//     final sumfeemodel = sumfeemodelFromJson(jsonString);

import 'dart:convert';

List<Sumfeemodel> sumfeemodelFromJson(String str) => List<Sumfeemodel>.from(json.decode(str).map((x) => Sumfeemodel.fromJson(x)));

String sumfeemodelToJson(List<Sumfeemodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sumfeemodel {
    Sumfeemodel({
        required this.fromAccount,
        required this.amount,
        required this.ccy,
    });

    String fromAccount;
    int amount;
    int ccy;

    factory Sumfeemodel.fromJson(Map<String, dynamic> json) => Sumfeemodel(
        fromAccount: json["fromAccount"],
        amount: json["amount"],
        ccy: json["ccy"],
    );

    Map<String, dynamic> toJson() => {
        "fromAccount": fromAccount,
        "amount": amount,
        "ccy": ccy,
    };
}
