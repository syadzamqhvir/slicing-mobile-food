import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  // Constructor untuk screen ini
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil argumen dari Navigator yang berisi daftar item di keranjang belanja
    final List<Map<String, dynamic>> cartItems = ModalRoute.of(context)!.settings.arguments as List<Map<String, dynamic>>;

    // Mengambil lebar layar
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          // Tombol back untuk kembali ke layar sebelumnya
          icon: const Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Checkout', // Teks pada AppBar
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white, // Warna latar belakang AppBar
        elevation: 0, // Menghilangkan bayangan pada AppBar
        actions: [
          IconButton(
            // Tombol profil di kanan AppBar
            icon: const Icon(Icons.person_outline, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Tombol Add Data untuk menambahkan produk baru
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton.icon(
                onPressed: () {
                   Navigator.pushNamed(context, '/product_form'); // Navigasi ke halaman form produk
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text('Add Data', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Warna tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Membuat tombol melingkar
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
            ),
            const SizedBox(height: 16), // Jarak vertikal

            // Header tabel produk
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: const Text('Foto', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 3,
                    child: const Text('Nama Produk', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 2,
                    child: const Text('Harga', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 1,
                    child: const Text('Aksi', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const Divider(), // Garis pembatas header dan isi

            // Daftar Produk di dalam ListView
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length, // Jumlah item dalam keranjang
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return _buildProductItem(
                    item['title'], // Nama produk
                    'Rp.${item['price'].toString()},00', // Harga produk
                    item['imagePath'], // Path gambar produk
                    screenWidth, // Lebar layar
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget item produk untuk ditampilkan dalam daftar
  Widget _buildProductItem(String name, String price, String imagePath, double screenWidth) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)), // Garis bawah pada item
      ),
      child: Row(
        children: [
          // Gambar Produk
          Expanded(
            flex: 2,
            child: Container(
              width: 60,
              height: 60,
              child: Image.asset(
                imagePath, // Menampilkan gambar dari file lokal
                fit: BoxFit.cover, // Menyesuaikan ukuran gambar
              ),
            ),
          ),
          const SizedBox(width: 16), // Jarak horizontal

          // Nama Produk
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: const TextStyle(fontSize: 16),
            ),
          ),

          // Harga Produk
          Expanded(
            flex: 2,
            child: Text(
              price,
              style: const TextStyle(fontSize: 16),
            ),
          ),

          // Tombol Hapus
          Expanded(
            flex: 1,
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {}, // Tempat untuk logika penghapusan item
            ),
          ),
        ],
      ),
    );
  }
}
