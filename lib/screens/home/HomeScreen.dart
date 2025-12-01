import 'package:flutter/material.dart';
import 'package:canteenqu/seedingMenu/menuDummy.dart';
import 'package:provider/provider.dart';
import '../cart/cartScreen.dart';
import 'package:canteenqu/providers/cart_provider.dart';

class HomeScreenMaulina extends StatelessWidget {
  const HomeScreenMaulina({super.key});

  @override
  Widget build(BuildContext context) {
    final Color kPrimaryBlue = const Color.fromARGB(255, 37, 80, 144);

    final cartProvider = Provider.of<CartProviderNazwa>(context);


    return Scaffold(
      appBar: AppBar(
        title: const Text('CanteenQu Menu',style: TextStyle(color: Colors.white)),
        backgroundColor: kPrimaryBlue,
        actions: [
        IconButton(
        icon: ImageIcon(AssetImage('assets/icons/keranjang.png',), color: Colors.white),
        onPressed: () {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CartScreenMaulina()),
    );
  },
),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: menuDummy.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 kolom
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 3 / 4,
          ),
          itemBuilder: (context, index) {
            final product = menuDummy[index];
            // Widget murni untuk menampilkan produk
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
                        Text(
                          product.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Rp ${product.price}',
                          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Stok: ${product.stock}', // <-- Tambahan stok
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
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
                        SnackBar(content: Text('${product.name} ditambahkan ke keranjang')),
                        );
                     },
                    style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryBlue,
                    minimumSize: const Size.fromHeight(30),
                   ),
                   child: const Text('Tambah',
                   style: TextStyle(fontSize: 14, color: Colors.white),
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
      ),
    );
  }
}
