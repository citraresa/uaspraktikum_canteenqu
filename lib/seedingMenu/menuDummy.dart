import '../models/productKt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService_citra {
  final FirebaseFirestore _firestore_citra = FirebaseFirestore.instance;

  Future<void> seedProducts_citra() async {
    CollectionReference productsRef = _firestore_citra.collection('products');

  List<ProductCitra> dummyProducts_citra = [
    ProductCitra(
    productId: "p1",
    name: "Nasi Goreng",
    price: 10000,
    stock: 20,
    imageUrl: "https://images.pexels.com/photos/13511060/pexels-photo-13511060.jpeg",
    category: "Makanan",
  ),
    ProductCitra(
    productId: "p2",
    name: "Pop mie",
    price: 5000,
    stock: 50,
    imageUrl: "https://images.pexels.com/photos/6605211/pexels-photo-6605211.jpeg",
    category: "Makanan",
  ),
    ProductCitra(
    productId: "p3",
    name: "Mie Ayam",
    price: 8000,
    stock: 20,
    imageUrl: "https://images.pexels.com/photos/5410408/pexels-photo-5410408.jpeg",
    category: "Makanan",
  ),
    ProductCitra(
    productId: "p4",
    name: "Sate",
    price: 12000,
    stock: 20,
    imageUrl: "https://images.pexels.com/photos/8883029/pexels-photo-8883029.jpeg",
    category: "Makanan",
  ),
  ProductCitra(
    productId: "p5",
    name: "Soto Ayam",
    price: 10000,
    stock: 15,
    imageUrl: "https://images.pexels.com/photos/12345367/pexels-photo-12345367.jpeg",
    category: "Makanan",
  ),

  ProductCitra(
    productId: "p6",
    name: "Es Teh",
    price: 3000,
    stock: 50,
    imageUrl: "https://images.pexels.com/photos/996891/pexels-photo-996891.jpeg",
    category: "Minuman",
  ),

  ProductCitra(
    productId: "p7",
    name: "Es Marimas",
    price: 2000,
    stock: 40,
    imageUrl: "https://images.pexels.com/photos/3730457/pexels-photo-3730457.jpeg",
    category: "Minuman",
  ),

  ProductCitra(
    productId: "p8",
    name: "Kopi",
    price: 4000,
    stock: 25,
    imageUrl: "https://images.pexels.com/photos/585750/pexels-photo-585750.jpeg",
    category: "Minuman",
  ),

  ProductCitra(
    productId: "p9",
    name: "Jus",
    price: 6000,
    stock: 20,
    imageUrl: "https://images.pexels.com/photos/96974/pexels-photo-96974.jpeg",
    category: "Minuman",
  ),

  ProductCitra(
    productId: "p10",
    name: "Air Mineral",
    price: 3000,
    stock: 300,
    imageUrl: "https://images.pexels.com/photos/1342357/pexels-photo-1342357.jpeg",
    category: "Minuman",
  ),
];
    for (var product in dummyProducts_citra) {
      await productsRef.doc(product.productId).set(product.toMap());
    }
    print("Products seeded successfully!");
  }
}
  