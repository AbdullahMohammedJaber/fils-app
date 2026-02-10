// ignore_for_file: non_constant_identifier_names

class UpdateResponse {
  final String version_android;
  final String version_ios;
  final bool show_update_android;
  final bool show_update_ios;
  final bool force_update_android;
  final bool force_update_ios;

  UpdateResponse({
    required this.version_android,
    required this.version_ios,
    required this.show_update_android,
    required this.show_update_ios,
    required this.force_update_android,
    required this.force_update_ios,
  });

  factory UpdateResponse.fromJson(Map<String, dynamic> json) {
    return UpdateResponse(
      version_android: json['version_android'],
      version_ios: json['version_ios'],
      show_update_android: json['show_update_android'],
      show_update_ios: json['show_update_ios'],
      force_update_android: json['force_update_android'],
      force_update_ios: json['force_update_ios'],
    );
  }
  Map<String , dynamic> toMap (){
    return {
      'version_android':version_android,
      'version_ios':version_ios,
      'show_update_android':show_update_android,
      'show_update_ios':show_update_ios,
      'force_update_android':force_update_android,
      'force_update_ios':force_update_ios,

    };
  }
}
