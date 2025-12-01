import 'package:flutter/material.dart';
import 'package:canteenqu/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartScreenMaulina extends StatelessWidget {
  const CartScreenMaulina({super.key});

  @override
  Widget build(BuildContext context) {
    final Color kPrimaryBlue = const Color.fromARGB(255, 37, 80, 144);
    final Color kWhite = const Color.fromARGB(255, 231, 231, 241);
    final cartProvider = Provider.of<CartProviderNazwa>(context);
    final cartItems = cartProvider.cartItemsNazwa;

    Future<void> _checkout_nazwa() async {
      if (cartItems.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Keranjang kosong')),
        );
        return;
      }

      final checkoutNazwa = cartProvider.hitungCheckoutNazwa();

      // Konfirmasi Checkout
      bool lanjut = false;
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Konfirmasi Checkout"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...checkoutNazwa["totalPerBarang"].map<Widget>((item) => Text(
                    "${item['name']} x${item['qty']} = Rp ${item['subtotal']}",
                    style: const TextStyle(fontSize: 12))),
                const SizedBox(height: 6),
                Text("Total: Rp ${checkoutNazwa["total"]}"),
                const Text("Gratis Ongkir"),
                Text("Total Bayar: Rp ${checkoutNazwa["totalBayar"]}",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  lanjut = false;
                },
                child: const Text("Batal")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  lanjut = true;
                },
                child: const Text("Checkout")),
          ],
        ),
      );

      if (!lanjut) return;

      // Update stok & kosongkan keranjang
      await cartProvider.updateStokFirebaseNazwa();
      cartProvider.clearCartNazwa();

      // Notifikasi hijau centang
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green.shade600,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
          duration: const Duration(seconds: 2),
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Expanded(child: Text("Checkout berhasil!")),
            ],
          ),
        ),
      );

      // Tunggu sebentar lalu kembali ke HomeScreen
      await Future.delayed(const Duration(seconds: 2));
      Navigator.popUntil(context, (route) => route.isFirst);
    }

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
                          Text('Keranjangmu kosong',
                              style: TextStyle(fontSize: 18, color: Colors.grey)),
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    product.imageUrl,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.image, size: 50),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(product.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                      Text('Rp ${product.price}',
                                          style: const TextStyle(fontSize: 12)),
                                      Row(
                                        children: [
                                          IconButton(
                                              icon: const Icon(Icons.remove_circle),
                                              onPressed: () => cartProvider
                                                  .decreaseCartNazwa(product)),
                                          Text("${cartItem.quantity}",
                                              style: const TextStyle(fontSize: 14)),
                                          IconButton(
                                              icon: const Icon(Icons.add_circle),
                                              onPressed: () =>
                                                  cartProvider.addToCartNazwa(product)),
                                        ],
                                      ),
                                      Text(
                                          "Subtotal: Rp ${cartItem.quantity * product.price}",
                                          style: const TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () =>
                                      cartProvider.removeFromCartNazwa(product),
                                ),
                              ],
                            ),
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
                onPressed: _checkout_nazwa,
                child: const Text('Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
