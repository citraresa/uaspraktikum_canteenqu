import 'package:canteenqu/models/productKt.dart';
import 'package:canteenqu/providers/cart_provider.dart';
import 'package:canteenqu/screens/product/add_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../cart/cartScreen.dart';

class HomeScreenMaulina extends StatefulWidget {
  const HomeScreenMaulina({super.key});

  @override
  State<HomeScreenMaulina> createState() => _HomeScreenMaulinaState();
}

class _HomeScreenMaulinaState extends State<HomeScreenMaulina> {
  final Color kPrimaryBlue = const Color.fromARGB(255, 37, 80, 144);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProviderNazwa>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('CanteenQu Menu',
            style: TextStyle(color: Colors.white)),
        backgroundColor: kPrimaryBlue,
        actions: [
          IconButton(
            icon: const ImageIcon(
              AssetImage('assets/icons/keranjang.png'),
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreenMaulina()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Belum ada produk"));
          }

          final products = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 3 / 4,
              ),
              itemBuilder: (context, index) {
                final productDoc = products[index];
                final productData = productDoc.data() as Map<String, dynamic>;
                final product = ProductCitra(
                  productId: productDoc.id,
                  name: productData['name'] ?? '',
                  price: productData['price']?.toInt() ?? 0,
                  stock: productData['stock']?.toInt() ?? 0,
                  imageUrl: productData['imageUrl'] ?? '',
                );

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image, size: 50),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text('Rp ${product.price}'),
                            const SizedBox(height: 4),
                            Text(
                              'Stok: ${product.stock}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: product.stock > 0
                                    ? () {
                                        cartProvider.addToCartNazwa(product);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              '${product.name} ditambahkan ke keranjang',
                                            ),
                                          ),
                                        );
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kPrimaryBlue,
                                  minimumSize: const Size.fromHeight(30),
                                ),
                                child: Text(
                                  product.stock > 0 ? 'Tambah' : 'Habis',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryBlue,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddProductScreen()),
          );
        },
      ),
    );
  }
}