import '../../utils/storage.dart';

class ApiHeaders {
  static Map<String, String> get headers => {
    'Accept': 'application/json',
    'Accept-Language': getLocal() ?? 'sa',
    'lang': getLocal() ?? 'sa',
    'Authorization': 'Bearer ${getUserToken()}',
    'fcmToken': getFcmToken() ?? '123',
    'device_token': getFcmToken() ?? '123',
    'Content-Type': 'application/json',
    'API-KEY': '123456',
    'shop_id': getMyShopsDetails().id.toString(),
  };
}
