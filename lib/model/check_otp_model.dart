
import 'dart:convert';

List<CheckOtpModel> checkOtpModelFromJson(String str) => List<CheckOtpModel>.from(json.decode(str).map((x) => CheckOtpModel.fromJson(x)));

String checkOtpModelToJson(List<CheckOtpModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CheckOtpModel {
    CheckOtpModel({
        required this.mobileNo,
        required this.message,
        required this.date,
    });

    String mobileNo;
    String message;
    DateTime date;

    factory CheckOtpModel.fromJson(Map<String, dynamic> json) => CheckOtpModel(
        mobileNo: json["mobileNo"],
        message: json["message"],
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "mobileNo": mobileNo,
        "message": message,
        "date": date.toIso8601String(),
    };
}




