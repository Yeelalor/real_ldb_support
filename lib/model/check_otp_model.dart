class check_otp_model {
  String? mobileNo;
  String? message;
  String? date;

  check_otp_model({this.mobileNo, this.message, this.date});

  check_otp_model.fromJson(Map<String, dynamic> json) {
    mobileNo = json['mobileNo'];
    message = json['message'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobileNo'] = mobileNo;
    data['message'] = message;
    data['date'] = date;
    return data;
  }
}
