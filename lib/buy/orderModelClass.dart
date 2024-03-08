class OrderBuy {
  final String itemName;
  final String itemImageUrl;
  final int quantity;
  final double itemPrice;
  final double deliveryAmount;
  final double totalAmount;

  OrderBuy({
    required this.itemName,
    required this.itemImageUrl,
    required this.quantity,
    required this.itemPrice,
    required this.deliveryAmount,
    required this.totalAmount,
  });

  factory OrderBuy.fromMap(Map<String, dynamic> map) {
    return OrderBuy(
      itemName: map['itemName'],
      itemImageUrl: map['itemImageUrl'],
      quantity: map['quantity'],
      itemPrice: map['itemPrice'],
      deliveryAmount: map['deliveryAmount'],
      totalAmount: map['totalAmount'],
    );
  }

}
