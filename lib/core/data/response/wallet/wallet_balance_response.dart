// ignore_for_file: unnecessary_this

class BalanceResponse {
  bool? result;
  Data? data;
  dynamic code;

  BalanceResponse({this.result, this.data, this.code});

  BalanceResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = this.result;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = this.code;
    return data;
  }
}

class Data {
  String? balance;
  String? lastRecharged;

  Data({required this.balance, required this.lastRecharged});

  Data.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    lastRecharged = json['last_recharged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['balance'] = this.balance;
    data['last_recharged'] = this.lastRecharged;
    return data;
  }
}
