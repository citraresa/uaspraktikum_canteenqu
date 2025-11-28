import '../models/productKt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Top-level menu dummy list so it can be accessed from UI files (e.g., HomeScreen)
final List<ProductCitra> menuDummy = [
    ProductCitra(
      productId: "p1",
      name: "Nasi Goreng",
      price: 10000,
      stock: 20,
      imageUrl: "https://asset.kompas.com/crops/VcgvggZKE2VHqIAUp1pyHFXXYCs=/202x66:1000x599/1200x800/data/photo/2023/05/07/6456a450d2edd.jpg",
      category: "Makanan",
    ),
    ProductCitra(
      productId: "p2",
      name: "Pop mie",
      price: 5000,
      stock: 50,
      imageUrl: "https://img.lazcdn.com/g/p/29db0dcdd6d9f73be70ce6a98431d719.jpg_720x720q80.jpg",
      category: "Makanan",
    ),
    ProductCitra(
      productId: "p3",
      name: "Mie Ayam",
      price: 8000,
      stock: 20,
      imageUrl: "https://image.idntimes.com/post/20220302/resep-mie-ayam-ala-abang-abang-mie-ayam-street-food-indonesia-9cde86371d7fc78c91ae80a6ffab250e-3d5a496980dabb250612aa5631c2882d.jpg",
      category: "Makanan",
    ),
    ProductCitra(
      productId: "p4",
      name: "Sate",
      price: 12000,
      stock: 20,
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS51VqkuzSKnKFP58H_A8Bcfqrk7ZsLzKEnTw&s",
      category: "Makanan",
    ),
    ProductCitra(
      productId: "p5",
      name: "Soto Ayam",
      price: 10000,
      stock: 15,
      imageUrl: "https://asset.kompas.com/crops/K_zJZAsinC2YWJM1n1w2TDUsBB4=/0x0:1000x667/1200x800/data/photo/2024/01/16/65a5dac64a34e.jpg",
      category: "Makanan",
    ),
    ProductCitra(
      productId: "p6",
      name: "Es Teh",
      price: 3000,
      stock: 50,
      imageUrl: "https://asset.kompas.com/crops/-EW4dZIFD3U055K4qtHqSgUg_hM=/92x67:892x600/1200x800/data/photo/2023/08/23/64e59deb79bfb.jpg",
      category: "Minuman",
    ),
    ProductCitra(
      productId: "p7",
      name: "Es Marimas",
      price: 2000,
      stock: 40,
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHSgorBvJw95FqWjfzvEArczxx2VeLRNSXsQ&s",
      category: "Minuman",
    ),
    ProductCitra(
      productId: "p8",
      name: "Kopi",
      price: 4000,
      stock: 25,
      imageUrl: "https://imgcdn.espos.id/@espos/images/2024/09/ilustrasi-kopi.jpg?quality=60",
      category: "Minuman",
    ),
    ProductCitra(
      productId: "p9",
      name: "Jus",
      price: 6000,
      stock: 20,
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDi1VkoaPLhhsmQ1R0XFXsVzkvMDQMm6U_OA&s",
      category: "Minuman",
    ),
    ProductCitra(
      productId: "p10",
      name: "Air Mineral",
      price: 3000,
      stock: 300,
      imageUrl: "https://images.tokopedia.net/img/JFrBQq/2024/7/3/76eb14c3-f86c-41c8-910f-27cdf546dcf6.jpg",
      category: "Minuman",
    ),
];

class FirebaseService_citra {
  final FirebaseFirestore _firestore_citra = FirebaseFirestore.instance;

  Future<void> seedProducts_citra() async {
    CollectionReference productsRef = _firestore_citra.collection('products');

    // Use the shared top-level dummy list for seeding
    for (var product in menuDummy) {
      await productsRef.doc(product.productId).set(product.toMap());
    }

    print("Products seeded successfully!");
  }
}
