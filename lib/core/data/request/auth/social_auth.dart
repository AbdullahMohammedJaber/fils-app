class SocialAuth {
  final String userType;
  final dynamic accessSecret;
  final dynamic accessToken;
  final dynamic socialProvider;
  final dynamic providerId;

  SocialAuth({
    required this.userType,
    required this.accessSecret,
    required this.accessToken,
    required this.socialProvider,
    required this.providerId,
  });

  Map<String, dynamic> toJson() {
    return {
      "user_type": userType,
      "access_secret": accessSecret,
      "access_token": accessToken,
      "social_provider": socialProvider,
      "provider": providerId,
    };
  }
}
