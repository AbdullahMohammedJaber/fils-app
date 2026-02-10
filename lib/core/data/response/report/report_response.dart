// To parse this JSON data, do
//
//     final reportsResponse = reportsResponseFromJson(jsonString);

import 'dart:convert';

ReportsResponse reportsResponseFromJson(String str) => ReportsResponse.fromJson(json.decode(str));

String reportsResponseToJson(ReportsResponse data) => json.encode(data.toJson());

class ReportsResponse {
  bool result;
  Data data;

  ReportsResponse({
    required this.result,
    required this.data,
  });

  factory ReportsResponse.fromJson(Map<String, dynamic> json) => ReportsResponse(
    result: json["result"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "data": data.toJson(),
  };
}

class Data {
  int totalOrders;
  int paidOrders;
  int deliveredOrders;
  int canceledOrders;
  int products;
  String totalSales;

  Data({
    required this.totalOrders,
    required this.paidOrders,
    required this.deliveredOrders,
    required this.canceledOrders,
    required this.products,
    required this.totalSales,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalOrders: json["total_orders"],
    paidOrders: json["paid_orders"],
    deliveredOrders: json["delivered_orders"],
    canceledOrders: json["canceled_orders"],
    products: json["products"],
    totalSales: json["total_sales"],
  );

  Map<String, dynamic> toJson() => {
    "total_orders": totalOrders,
    "paid_orders": paidOrders,
    "delivered_orders": deliveredOrders,
    "canceled_orders": canceledOrders,
    "products": products,
    "total_sales": totalSales,
  };
}
