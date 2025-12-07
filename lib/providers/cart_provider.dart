import 'package:flutter/material.dart';
import '../models/productKt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemNazwa {
  final ProductCitra product;
  int quantity;

  CartItemNazwa({required this.product, this.quantity = 1});
}

class CartProviderNazwa with ChangeNotifier {
  List<CartItemNazwa> cartItemsNazwa = [];

  // Tambah produk
  void addToCartNazwa(ProductCitra product) {
    final index = cartItemsNazwa.indexWhere(
      (item) => item.product.productId == product.productId,
    );
    if (index >= 0) {
      if (cartItemsNazwa[index].quantity < product.stock) {
        cartItemsNazwa[index].quantity += 1;
      }
    } else {
      cartItemsNazwa.add(CartItemNazwa(product: product));
    }
    notifyListeners();
  }

  // Kurangi produk
  void decreaseCartNazwa(ProductCitra product) {
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

  // Hapus seluruh item
  void removeFromCartNazwa(ProductCitra product) {
    cartItemsNazwa.removeWhere((item) => item.product.productId == product.productId);
    notifyListeners();
  }

  // Total harga per item
  List<Map<String, dynamic>> totalPerItemNazwa() {
    return cartItemsNazwa.map((item) => {
          "name": item.product.name,
          "qty": item.quantity,
          "subtotal": item.product.price * item.quantity,
        }).toList();
  }

  // Total harga
  double totalHargaNazwa() {
    double total = 0;
    for (var item in cartItemsNazwa) {
      total += item.product.price * item.quantity;
    }
    return total;
  }

  // Checkout + Gratis Ongkir jika NIM genap
  Map<String, dynamic> hitungCheckoutNazwa() {
    double total = totalHargaNazwa();
    double ongkir = 10000; // ongkir default
    bool gratisOngkir = false;

    int nim = 362458302068; // contoh NIM
    if (nim % 2 == 0) {
      ongkir = 0;
      gratisOngkir = true;
    }

    double totalBayar = total + ongkir;

    return {
      "totalPerBarang": totalPerItemNazwa(),
      "total": total,
      "ongkir": ongkir,
      "gratisOngkir": gratisOngkir,
      "totalBayar": totalBayar,
    };
  }

  // Update stok Firebase
  Future<void> updateStokFirebaseNazwa() async {
    final db = FirebaseFirestore.instance;
    for (var cartItem in cartItemsNazwa) {
      final productRef = db.collection('products').doc(cartItem.product.productId);
      final qty = cartItem.quantity;

      await db.runTransaction((trx) async {
        final snap = await trx.get(productRef);
        if (!snap.exists) throw Exception("Produk tidak ditemukan");
        final data = snap.data() as Map<String, dynamic>;
        int stokLama = data['stock'] ?? 0;
        int stokBaru = stokLama - qty;
        if (stokBaru < 0) throw Exception("Stok tidak cukup");
        trx.update(productRef, {'stock': stokBaru});
      });
    }
  }

  // Kosongkan keranjang
  void clearCartNazwa() {
    cartItemsNazwa.clear();
    notifyListeners();
  }
}


// UPDATE
// ppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp