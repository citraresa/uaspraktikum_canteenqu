class ProductCitra {
  final String productId;
  final String name;
  final int price;
  final int stock;
  final String imageUrl;

  ProductCitra({
    required this.productId,
    required this.name,
    required this.price,
    required this.stock,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
      'stock': stock,
      'imageUrl': imageUrl,
    };
  }

  factory ProductCitra.fromMap(Map<String, dynamic> map) {
    return ProductCitra(
      productId: map['productId'] ?? '',
      name: map['name'] ?? '',
      price: map['price'] ?? 0,
      stock: map['stock'] ?? 0,
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}
