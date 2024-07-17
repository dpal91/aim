class ForgotPassword {
  int? statusCode;
  String? message;
  Data? data;

  ForgotPassword({this.statusCode, this.message, this.data});

  ForgotPassword.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? fullName;
  String? roleName;
  String? mobile;
  int? mobileVerified;
  int? mobileOtp;
  String? countryCode;
  int? resetOtp;
  String? email;
  int? loggedCount;
  int? verified;
  int? financialApproval;
  int? installmentApproval;
  int? enableInstallments;
  int? disableCashback;
  int? enableRegistrationBonus;
  String? avatarSettings;
  String? meetingType;
  String? status;
  int? accessContent;
  int? newsletter;
  int? publicMessage;
  int? affiliate;
  int? canCreateStore;
  int? ban;
  int? offline;
  int? createdAt;

  Data({
    this.id,
    this.fullName,
    this.roleName,
    this.mobile,
    this.mobileVerified,
    this.mobileOtp,
    this.countryCode,
    this.resetOtp,
    this.email,
    this.loggedCount,
    this.verified,
    this.financialApproval,
    this.installmentApproval,
    this.enableInstallments,
    this.disableCashback,
    this.enableRegistrationBonus,
    this.avatarSettings,
    this.meetingType,
    this.status,
    this.accessContent,
    this.newsletter,
    this.publicMessage,
    this.affiliate,
    this.canCreateStore,
    this.ban,
    this.offline,
    this.createdAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    roleName = json['role_name'];
    mobile = json['mobile'];
    mobileVerified = json['mobile_verified'];
    mobileOtp = json['mobile_otp'];
    countryCode = json['country_code'];
    resetOtp = json['reset_otp'];
    email = json['email'];
    loggedCount = json['logged_count'];
    verified = json['verified'];
    financialApproval = json['financial_approval'];
    installmentApproval = json['installment_approval'];
    enableInstallments = json['enable_installments'];
    disableCashback = json['disable_cashback'];
    enableRegistrationBonus = json['enable_registration_bonus'];
    avatarSettings = json['avatar_settings'];
    meetingType = json['meeting_type'];
    status = json['status'];
    accessContent = json['access_content'];
    newsletter = json['newsletter'];
    publicMessage = json['public_message'];
    affiliate = json['affiliate'];
    canCreateStore = json['can_create_store'];
    ban = json['ban'];
    offline = json['offline'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['role_name'] = roleName;
    data['mobile'] = mobile;
    data['mobile_verified'] = mobileVerified;
    data['mobile_otp'] = mobileOtp;
    data['country_code'] = countryCode;
    data['reset_otp'] = resetOtp;
    data['email'] = email;
    data['logged_count'] = loggedCount;
    data['verified'] = verified;
    data['financial_approval'] = financialApproval;
    data['installment_approval'] = installmentApproval;
    data['enable_installments'] = enableInstallments;
    data['disable_cashback'] = disableCashback;
    data['enable_registration_bonus'] = enableRegistrationBonus;
    data['avatar_settings'] = avatarSettings;
    data['meeting_type'] = meetingType;
    data['status'] = status;
    data['access_content'] = accessContent;
    data['newsletter'] = newsletter;
    data['public_message'] = publicMessage;
    data['affiliate'] = affiliate;
    data['can_create_store'] = canCreateStore;
    data['ban'] = ban;
    data['offline'] = offline;
    data['created_at'] = createdAt;
    return data;
  }
}
