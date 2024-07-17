class OTPArguments {
  final String phoneNumber;
  final String otp;
  final bool isLogin;
  final int? categoryId;
  final String? password;
  final String? email;
  final String? fullName;

  OTPArguments({
    required this.phoneNumber,
    required this.otp,
    required this.isLogin,
    this.categoryId,
    this.password,
    this.email,
    this.fullName,
  });
}
