



class OrderRequest {
  final String name;
  final String email;
  final String phone;
  final String address;

  OrderRequest({required this.name, required this.email, required this.phone, required this.address});
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
    };
  }
  
}