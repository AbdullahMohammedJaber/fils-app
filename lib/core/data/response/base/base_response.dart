class BaseResponse {
  final dynamic result;

  final dynamic message;

  final dynamic code;

  BaseResponse({
    required this.result,
    required this.message,
    required this.code,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      result: json['result'],
      message: json['message'],
      code: json['code'],
    );
  }
}
