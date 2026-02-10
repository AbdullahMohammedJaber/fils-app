import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneText extends StatelessWidget {
  final String phone;

  const PhoneText({super.key, required this.phone});

  Future<void> _launchPhone() async {
    final Uri uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('لا يمكن فتح تطبيق الهاتف');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: GestureDetector(
        onTap: _launchPhone,
        child: Text(
          phone,
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}