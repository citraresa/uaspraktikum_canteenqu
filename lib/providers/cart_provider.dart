import 'package:flutter/material.dart';
import '../models/productKt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemNazwa {
  final ProductCitra product;
  int quantity;

  CartItemNazwa({required this.product, this.quantity = 1});
}

class CartProviderNazwa with ChangeNotifier {
  // State Keranjang
  List<CartItemNazwa> cartItemsNazwa = [];

  // Tambah produk ke keranjang
  void addToCartNazwa(ProductCitra product) {
    final index = cartItemsNazwa.indexWhere(
      (item) => item.product.productId == product.productId,
    );

    if (index >= 0) {
      // Cek stok sebelum tambah
      if (cartItemsNazwa[index].quantity < product.stock) {
        cartItemsNazwa[index].quantity += 1;
      }
    } else {
      cartItemsNazwa.add(CartItemNazwa(product: product, quantity: 1));
    }

    notifyListeners();
  }

  // Hapus produk dari keranjang
  void removeFromCartNazwa(ProductCitra product) {
    final index = cartItemsNazwa.indexWhere(
      (item) => item.product.productId == product.productId,
    );

    if (index >= 0) {
      cartItemsNazwa[index].quantity -= 1;

      if (cartItemsNazwa[index].quantity <= 0) {
        cartItemsNazwa.removeAt(index);
      }

      notifyListeners();
    }
  }

  // Total harga
  double totalHargaNazwa() {
    double total = 0;
    for (var item in cartItemsNazwa) {
      total += item.product.price * item.quantity;
    }
    return total;
  }

  // Checkout + Diskon NIM genap
  Map<String, dynamic> hitungCheckoutNazwa() {
    double total = totalHargaNazwa();
    double ongkir = 0;

    double totalBayar = total + ongkir;

    return {
      "total": total,
      "ongkir": ongkir,
      "totalBayar": totalBayar,
    };
  }

  // Update stok di Firebase
  Future<void> updateStokFirebaseNazwa() async {
    final db = FirebaseFirestore.instance;

    for (var cartItem in cartItemsNazwa) {
      final productRef = db
          .collection('products')
          .doc(cartItem.product.productId);
      final qty = cartItem.quantity;

      await db.runTransaction((trx) async {
        final snap = await trx.get(productRef);
        if (!snap.exists) throw Exception("Produk tidak ditemukan");

        final data = snap.data() as Map<String, dynamic>;
        int stokLama = data['stock'] ?? 0; // sesuai Citra
        int stokBaru = stokLama - qty;

        if (stokBaru < 0) throw Exception("Stok tidak cukup");

        trx.update(productRef, {'stock': stokBaru}); // sesuai Citra
      });
    }
  }

  // Clear keranjang
  void clearCartNazwa() {
    cartItemsNazwa.clear();
    notifyListeners();
  }
}
