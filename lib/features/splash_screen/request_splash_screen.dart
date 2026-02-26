import 'dart:convert';

import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
 import 'package:fils/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SplashRequest {
  SplashRequest._();

  static Future<void> callFunction(BuildContext context) async {
    Future.delayed(Duration(seconds: 2), () async {
      
        final url = Uri.parse("https://get.geojs.io/v1/ip/geo.json");

        final response = await http.get(url);
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          print("==============>>>> ${data["timezone"]}");
          setTimeZoon(data["timezone"]);
          if(isLogin()){
          ToRemoveAll(AppRoutes.rootGeneral);
           
          }else{
            ToRemoveAll(AppRoutes.landingPage);
          }
        }
      
      
    });
  }
}
