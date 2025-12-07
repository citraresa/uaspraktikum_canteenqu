import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  // Controller
  final TextEditingController nameC = TextEditingController();
  final TextEditingController priceC = TextEditingController();
  final TextEditingController stockC = TextEditingController();
  final TextEditingController imageC = TextEditingController();

  bool isLoading = false;

  // Fungsi Simpan
  Future<void> saveProduct() async {
    if (nameC.text.isEmpty ||
        priceC.text.isEmpty ||
        stockC.text.isEmpty ||
        imageC.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Semua field wajib diisi")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final newProduct = {
        'name': nameC.text,
        'price': double.tryParse(priceC.text) ?? 0,
        'stock': int.tryParse(stockC.text) ?? 0,
        'imageUrl': imageC.text,
        'created_at': Timestamp.now(),
      };

      await FirebaseFirestore.instance
          .collection('products')
          .add(newProduct);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Produk berhasil ditambahkan!")),
      );

      Navigator.pop(context); // kembali tanpa membawa data
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menyimpan: $e")),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Produk"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            // Nama Produk
            TextField(
              controller: nameC,
              decoration: const InputDecoration(
                labelText: "Nama Produk",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Harga
            TextField(
              controller: priceC,
              decoration: const InputDecoration(
                labelText: "Harga",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // Stok
            TextField(
              controller: stockC,
              decoration: const InputDecoration(
                labelText: "Stok",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // URL Gambar
            TextField(
              controller: imageC,
              decoration: const InputDecoration(
                labelText: "URL Gambar Produk",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            // Tombol Simpan
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : saveProduct,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Simpan"),
              ),
            )
          ],
        ),
      ),
    );
  }
}