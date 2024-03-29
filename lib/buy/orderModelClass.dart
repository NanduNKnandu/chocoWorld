class OrderBuy {
  final String orderId;
  final String itemName;
  final String itemImageUrl;
  final int quantity;
  final double itemPrice;
  final double deliveryAmount;
  final double totalAmount;
  final String status;
  final Address? deliveryAddress;

  OrderBuy({
    required this.orderId,
    required this.itemName,
    required this.itemImageUrl,
    required this.quantity,
    required this.itemPrice,
    required this.deliveryAmount,
    required this.totalAmount,
    required this.status,
    this.deliveryAddress,
  });

  factory OrderBuy.fromMap(Map<String, dynamic> map) {
    return OrderBuy(
      orderId: map['orderId'],
      itemName: map['itemName'],
      itemImageUrl: map['itemImageUrl'],
      quantity: map['quantity'],
      itemPrice: map['itemPrice'],
      deliveryAmount: map['deliveryAmount'],
      totalAmount: map['totalAmount'],
      status: map['status'] ?? 'Order Confirmed',
      deliveryAddress: map['deliveryAddress'] != null
          ? Address.fromMap(map['deliveryAddress'])
          : null,
    );
  }
}

class Address {
  final String name;
  final String phoneNumber;
  final String houseNo;
  final String city;
  final String state;
  final String pincode;

  Address({
    required this.name,
    required this.phoneNumber,
    required this.houseNo,
    required this.city,
    required this.state,
    required this.pincode,
  });

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      name: map['Name'],
      phoneNumber: map['PhoneNumber'],
      houseNo: map['houseNo'],
      city: map['city'],
      state: map['state'],
      pincode: map['Pincode'],
    );
  }
}