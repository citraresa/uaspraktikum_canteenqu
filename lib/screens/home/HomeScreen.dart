import 'package:canteenqu/models/productKt.dart';
import 'package:flutter/material.dart';
import 'package:canteenqu/seedingMenu/menuDummy.dart';
import 'package:provider/provider.dart';
import '../cart/cartScreen.dart';
import 'package:canteenqu/providers/cart_provider.dart';

enum DataState_bersama { loading, empty, loaded, error }

class HomeScreenMaulina extends StatefulWidget {
  const HomeScreenMaulina({super.key});

  @override
  State<HomeScreenMaulina> createState() => _HomeScreenMaulinaState_bersama();
}

class _HomeScreenMaulinaState_bersama extends State<HomeScreenMaulina> {
  // STATUS DATA
  DataState_bersama _currentState_bersama = DataState_bersama.loading;
  List<ProductCitra> _menuList_bersama = [];
  final Color kPrimaryBlue = const Color.fromARGB(255, 37, 80, 144);

  @override
  void initState() {
    super.initState();
    _fetchMenu_bersama();
  }

  // FETCH DATA DENGAN LOADING INDICATOR
  Future<void> _fetchMenu_bersama() async {
    setState(() => _currentState_bersama = DataState_bersama.loading);
    try {
      await Future.delayed(const Duration(seconds: 2));
      List<ProductCitra> fetchedData = menuDummy;

      if (mounted) {
        setState(() {
          if (fetchedData.isEmpty) {
            _currentState_bersama = DataState_bersama.empty;
          } else {
            _menuList_bersama = fetchedData;
            _currentState_bersama = DataState_bersama.loaded;
          }
        });
      }
    } catch (e) {
      if (mounted) _currentState_bersama = DataState_bersama.error;
      print('Error fetching data: $e');
    }
  }

  // WIDGET KARTU PRODUK (baru _bersama)
  Widget _buildProductCard_bersama(ProductCitra product, CartProviderNazwa cartProvider) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: product.imageUrl.isNotEmpty
                ? Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Center(child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey)),
                  )
                : const Center(child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text('Rp ${product.price}', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text('Stok: ${product.stock}',
                    style: TextStyle(color: product.stock > 0 ? Colors.green.shade700 : Colors.red.shade700, fontSize: 12)),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: product.stock > 0
                        ? () {
                            cartProvider.addToCartNazwa(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${product.name} ditambahkan ke keranjang'), duration: const Duration(seconds: 1)));
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryBlue,
                      minimumSize: const Size.fromHeight(30),
                      disabledBackgroundColor: Colors.grey.shade400,
                    ),
                    child: Text(product.stock > 0 ? 'Tambah' : 'Stok Habis',
                        style: const TextStyle(fontSize: 14, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // BUILD CONTENT SESUAI STATUS
  Widget _buildContent_bersama() {
    switch (_currentState_bersama) {
      case DataState_bersama.loading:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: kPrimaryBlue),
              const SizedBox(height: 16),
              const Text("Memuat menu...", style: TextStyle(color: Colors.grey)),
            ],
          ),
        );

      case DataState_bersama.empty:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.fastfood_outlined, size: 60, color: Colors.blueGrey),
              const SizedBox(height: 16),
              const Text('Menu Kantin Kosong',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Text('Silakan periksa lagi nanti atau tambahkan menu baru.',
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: _fetchMenu_bersama,
                icon: const Icon(Icons.refresh),
                label: const Text("Coba Muat Ulang"),
              ),
            ],
          ),
        );

      case DataState_bersama.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning_amber_rounded, size: 60, color: Colors.red),
              const SizedBox(height: 16),
              const Text('Terjadi Kesalahan!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Text('Gagal mengambil data menu dari server.', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: _fetchMenu_bersama,
                icon: const Icon(Icons.refresh),
                label: const Text("Coba Lagi"),
              ),
            ],
          ),
        );

      case DataState_bersama.loaded:
        final cartProvider = Provider.of<CartProviderNazwa>(context, listen: false);
        return Scrollbar(
          child: GridView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: _menuList_bersama.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 3 / 4,
            ),
            itemBuilder: (context, index) =>
                _buildProductCard_bersama(_menuList_bersama[index], cartProvider),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CanteenQu Menu', style: TextStyle(color: Colors.white)),
        backgroundColor: kPrimaryBlue,
        actions: [
          IconButton(
            icon: const ImageIcon(AssetImage('assets/icons/keranjang.png'), color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreenMaulina()),
              );
            },
          ),
        ],
      ),
      body: _buildContent_bersama(),
    );
  }
}
