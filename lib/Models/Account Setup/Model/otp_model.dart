class OTPModel {
  int? statusCode;
  String? message;
  int? data;

  OTPModel({this.statusCode, this.message, this.data});

  OTPModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}
