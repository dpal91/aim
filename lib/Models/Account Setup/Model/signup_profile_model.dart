class SignupProfileModel {
  int? statusCode;
  String? message;
  Data? responseData;

  SignupProfileModel({
    this.statusCode,
    this.message,
    this.responseData,
  });

  SignupProfileModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    responseData = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (responseData != null) {
      data['data'] = responseData!.toJson();
    }
    return data;
  }
}

class Data {
  String? fullName;
  String? email;
  String? mobile;
  String? countryCode;
  int? mobileOtp;
  String? roleName;
  String? courseCategoryId;
  String? about;
  String? offlineMessage;
  String? profileImage;
  int? createdAt;
  int? id;
  String? token;

  Data({
    this.fullName,
    this.email,
    this.mobile,
    this.countryCode,
    this.mobileOtp,
    this.roleName,
    this.courseCategoryId,
    this.about,
    this.offlineMessage,
    this.profileImage,
    this.createdAt,
    this.id,
    this.token,
  });

  Data.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    email = json['email'];
    mobile = json['mobile'];
    countryCode = json['country_code'];
    mobileOtp = json['mobile_otp'];
    roleName = json['role_name'];
    courseCategoryId = json['course_category_id'];
    about = json['about'];
    offlineMessage = json['offline_message'];
    profileImage = json['profile_image'];
    createdAt = json['created_at'];
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['email'] = email;
    data['mobile'] = mobile;
    data['country_code'] = countryCode;
    data['mobile_otp'] = mobileOtp;
    data['role_name'] = roleName;
    data['course_category_id'] = courseCategoryId;
    data['about'] = about;
    data['offline_message'] = offlineMessage;
    data['profile_image'] = profileImage;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['token'] = token;
    return data;
  }
}
