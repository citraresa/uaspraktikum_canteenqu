import 'package:flutter/material.dart';
import 'package:canteenqu/providers/cart_provider.dart';
import '../../models/productKt.dart';
import 'package:provider/provider.dart';

class CartScreenMaulina extends StatelessWidget {
  const CartScreenMaulina({super.key});

  @override
  Widget build(BuildContext context) {
    final Color kPrimaryBlue = const Color.fromARGB(255, 37, 80, 144);
    final Color kWhite = const Color.fromARGB(255, 231, 231, 241);
    final cartProvider = Provider.of<CartProviderNazwa>(context);

    final cartItems = cartProvider.cartItemsNazwa;

    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        title: const Text('Keranjang Belanja', style: TextStyle(color: Colors.white)),
        backgroundColor: kPrimaryBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: cartItems.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.shopping_cart_outlined,
                              size: 80, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'Keranjangmu kosong',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = cartItems[index]; 
                        final product = cartItem.product;   
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12)),
                                child: Image.network(
                                  product.imageUrl,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.image, size: 50),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                                child: Text('Rp ${product.price }',
                                  style: const TextStyle(
                                      fontFamily: 'poppins', fontSize: 14),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                                  child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  Text('Jumlah: ${cartItem.quantity}', style: TextStyle(fontSize: 14)),
                                  Text('Stok: ${product.stock}', style: TextStyle(fontSize: 14)),
                                    ],
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                onPressed: () {
                                cartProvider.removeFromCartNazwa(cartItem.product);;
                                  },
                                style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text("Hapus dari Keranjang"),
                              ),
                            ),

                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryBlue,
                        foregroundColor: Colors.white,
                        
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                  onPressed: () async {
                  if (cartItems.isEmpty) {
                    // kalau keranjang kosong
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Keranjang kosong')),
                    );
                  } else {
                    // kalau keranjang ada isiny dan Panggil fungsi checkout NIM genap
                     final checkoutNazwa = cartProvider.hitungCheckoutNazwa(); 

                    // Update stok di Firebase (opsional)
                    await cartProvider.updateStokFirebaseNazwa();
                  
                    showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                    title: const Text('Checkout Berhasil!'),
                    content: Text(
                      'Total Belanja: Rp ${checkoutNazwa["total"]}\n'
                      'Ongkir: ${checkoutNazwa["ongkir"] == 0 ? "Gratis Ongkir" : "Rp${checkoutNazwa["ongkir"]}"}\n'
                      'Total Bayar: Rp ${checkoutNazwa["totalBayar"]}',
                    ),
                      actions: [
                      TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Tutup'),
                      ),
                    ],
                    ),
                    );
                    cartProvider.cartItemsNazwa.clear();
                  }
                },
              child: const Text('Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
