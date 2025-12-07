import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
import '../cart/cartScreen.dart';
import 'package:canteenqu/screens/product/add_product_screen.dart';
=======
import 'package:provider/provider.dart';
import 'package:canteenqu/models/productKt.dart';
import 'package:canteenqu/seedingMenu/menuDummy.dart';
import '../cart/cartScreen.dart';
import 'package:canteenqu/providers/cart_provider.dart';
>>>>>>> fe4441891b47dfa989f352b5491a04c38c3477f9

class HomeScreenMaulina extends StatefulWidget {
  const HomeScreenMaulina({super.key});

  @override
  State<HomeScreenMaulina> createState() => _HomeScreenMaulinaState();
}
<<<<<<< HEAD
=======

class _HomeScreenMaulinaState extends State<HomeScreenMaulina> {
  final Color kPrimaryBlue = const Color.fromARGB(255, 37, 80, 144);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProviderNazwa>(context);
>>>>>>> fe4441891b47dfa989f352b5491a04c38c3477f9

class _HomeScreenMaulinaState extends State<HomeScreenMaulina> {
  final Color kPrimaryBlue = const Color.fromARGB(255, 37, 80, 144);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: const Text('CanteenQu Menu', style: TextStyle(color: Colors.white)),
        backgroundColor: kPrimaryBlue,
        actions: [
          IconButton(
            icon: const ImageIcon(
              AssetImage('assets/icons/keranjang.png'),
=======
        title: const Text(
          'CanteenQu Menu',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kPrimaryBlue,
        actions: [
          IconButton(
            icon: ImageIcon(
              const AssetImage('assets/icons/keranjang.png'),
>>>>>>> fe4441891b47dfa989f352b5491a04c38c3477f9
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
<<<<<<< HEAD

      //otomatis mengambil data dari Firestore
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
=======
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: menuDummy.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 3 / 4,
          ),
          itemBuilder: (context, index) {
            final product = menuDummy[index];

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
>>>>>>> fe4441891b47dfa989f352b5491a04c38c3477f9
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                final name = product['name'];
                final price = product['price'];
                final stock = product['stock'];
                final imageUrl = product['imageUrl'];

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
                          imageUrl,
                          fit: BoxFit.cover,
                           errorBuilder: (context, error, stackTrace) => 
                              const Icon(Icons.image, size: 50),
                        ),
<<<<<<< HEAD
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text('Rp $price'),
                            const SizedBox(height: 4),
                            Text(
                              'Stok: $stock',
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // tombol tambah (tanpa logika)
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kPrimaryBlue,
                                  minimumSize: const Size.fromHeight(30),
                                ),
                                child: const Text(
                                  'Tambah',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
=======
                        const SizedBox(height: 4),
                        Text(
                          'Rp ${product.price}',
                          style: const TextStyle(color: Colors.black),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Stok: ${product.stock}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              cartProvider.addToCartNazwa(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${product.name} ditambahkan ke keranjang',
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryBlue,
                              minimumSize: const Size.fromHeight(30),
                            ),
                            child: const Text(
                              'Tambah',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
>>>>>>> fe4441891b47dfa989f352b5491a04c38c3477f9
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
