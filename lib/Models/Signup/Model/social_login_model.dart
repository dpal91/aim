// To parse this JSON data, do
//
//     final socialLoginModel = socialLoginModelFromJson(jsonString);

import 'dart:convert';

SocialLoginModel socialLoginModelFromJson(String str) =>
    SocialLoginModel.fromJson(json.decode(str));

String socialLoginModelToJson(SocialLoginModel data) =>
    json.encode(data.toJson());

class SocialLoginModel {
  SocialLoginModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  int statusCode;
  String message;
  SocialLoginData? data;

  factory SocialLoginModel.fromJson(Map<String, dynamic> json) =>
      SocialLoginModel(
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : SocialLoginData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": data == null ? null : data!.toJson(),
      };
}

class SocialLoginData {
  SocialLoginData({
    this.id,
    this.fullName,
    this.roleName,
    this.organId,
    this.mobile,
    this.email,
    this.deviceToken,
    this.deviceType,
    this.profileImage,
    this.bio,
    this.verified,
    this.financialApproval,
    this.avatar,
    this.avatarSettings,
    this.coverImg,
    this.headline,
    this.about,
    this.address,
    this.countryId,
    this.provinceId,
    this.cityId,
    this.districtId,
    this.location,
    this.levelOfTraining,
    this.meetingType,
    this.status,
    this.accessContent,
    this.language,
    this.timezone,
    this.newsletter,
    this.publicMessage,
    this.accountType,
    this.iban,
    this.accountId,
    this.identityScan,
    this.certificate,
    this.commission,
    this.affiliate,
    this.canCreateStore,
    this.ban,
    this.banStartAt,
    this.banEndAt,
    this.offline,
    this.offlineMessage,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.token,
  });

  int? id;
  String? fullName;
  String? roleName;
  dynamic organId;
  String? mobile;
  String? email;
  String? deviceToken;
  int? deviceType;
  String? profileImage;
  dynamic bio;
  int? verified;
  int? financialApproval;
  dynamic avatar;
  dynamic avatarSettings;
  dynamic coverImg;
  dynamic headline;
  String? about;
  dynamic address;
  dynamic countryId;
  dynamic provinceId;
  dynamic cityId;
  dynamic districtId;
  dynamic location;
  dynamic levelOfTraining;
  String? meetingType;
  String? status;
  int? accessContent;
  dynamic language;
  dynamic timezone;
  int? newsletter;
  int? publicMessage;
  dynamic accountType;
  dynamic iban;
  dynamic accountId;
  dynamic identityScan;
  dynamic certificate;
  dynamic commission;
  int? affiliate;
  int? canCreateStore;
  int? ban;
  dynamic banStartAt;
  dynamic banEndAt;
  int? offline;
  String? offlineMessage;
  int? createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  String? token;

  factory SocialLoginData.fromJson(Map<String, dynamic> json) =>
      SocialLoginData(
        id: json["id"],
        fullName: json["full_name"],
        roleName: json["role_name"],
        organId: json["organ_id"],
        mobile: json["mobile"],
        email: json["email"],
        deviceToken: json["device_token"],
        deviceType: json["device_type"],
        profileImage: json["profile_image"],
        bio: json["bio"],
        verified: json["verified"],
        financialApproval: json["financial_approval"],
        avatar: json["avatar"],
        avatarSettings: json["avatar_settings"],
        coverImg: json["cover_img"],
        headline: json["headline"],
        about: json["about"],
        address: json["address"],
        countryId: json["country_id"],
        provinceId: json["province_id"],
        cityId: json["city_id"],
        districtId: json["district_id"],
        location: json["location"],
        levelOfTraining: json["level_of_training"],
        meetingType: json["meeting_type"],
        status: json["status"],
        accessContent: json["access_content"],
        language: json["language"],
        timezone: json["timezone"],
        newsletter: json["newsletter"],
        publicMessage: json["public_message"],
        accountType: json["account_type"],
        iban: json["iban"],
        accountId: json["account_id"],
        identityScan: json["identity_scan"],
        certificate: json["certificate"],
        commission: json["commission"],
        affiliate: json["affiliate"],
        canCreateStore: json["can_create_store"],
        ban: json["ban"],
        banStartAt: json["ban_start_at"],
        banEndAt: json["ban_end_at"],
        offline: json["offline"],
        offlineMessage: json["offline_message"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "role_name": roleName,
        "organ_id": organId,
        "mobile": mobile,
        "email": email,
        "device_token": deviceToken,
        "device_type": deviceType,
        "profile_image": profileImage,
        "bio": bio,
        "verified": verified,
        "financial_approval": financialApproval,
        "avatar": avatar,
        "avatar_settings": avatarSettings,
        "cover_img": coverImg,
        "headline": headline,
        "about": about,
        "address": address,
        "country_id": countryId,
        "province_id": provinceId,
        "city_id": cityId,
        "district_id": districtId,
        "location": location,
        "level_of_training": levelOfTraining,
        "meeting_type": meetingType,
        "status": status,
        "access_content": accessContent,
        "language": language,
        "timezone": timezone,
        "newsletter": newsletter,
        "public_message": publicMessage,
        "account_type": accountType,
        "iban": iban,
        "account_id": accountId,
        "identity_scan": identityScan,
        "certificate": certificate,
        "commission": commission,
        "affiliate": affiliate,
        "can_create_store": canCreateStore,
        "ban": ban,
        "ban_start_at": banStartAt,
        "ban_end_at": banEndAt,
        "offline": offline,
        "offline_message": offlineMessage,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "token": token,
      };
}
