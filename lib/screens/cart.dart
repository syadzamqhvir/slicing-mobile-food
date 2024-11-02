import 'package:flutter/material.dart';

// Fungsi utama yang menjalankan aplikasi
void main() {
  runApp(MyApp());
}

// Kelas MyApp sebagai titik awal aplikasi
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CartPage(), // Halaman yang ditampilkan adalah CartPage
    );
  }
}

// Kelas CartPage yang merupakan StatefulWidget
class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState(); // Menghubungkan ke state
}

class _CartPageState extends State<CartPage> {
  // Daftar item keranjang belanja
  final List<CartItemModel> _cartItems = [
    CartItemModel("assets/burger.jpeg", "Burger King Medium", 50000, 1),
    CartItemModel("assets/teh_botol.jpeg", "Teh botol", 4000, 2),
    CartItemModel("assets/burger.jpeg", "Burger King Small", 35000, 1),
  ];

  // Menghitung total harga
  double get totalAmount {
    double total = 0;
    for (var item in _cartItems) {
      total += item.price * item.quantity; // Menghitung total dengan mengalikan harga dan jumlah
    }
    return total;
  }

  // Fungsi untuk meningkatkan jumlah item di keranjang
  void _increaseQuantity(int index) {
    setState(() {
      _cartItems[index].quantity++; // Menambah jumlah item
    });
  }

  // Fungsi untuk mengurangi jumlah item di keranjang
  void _decreaseQuantity(int index) {
    setState(() {
      if (_cartItems[index].quantity > 1) { // Pastikan jumlah tidak kurang dari 1
        _cartItems[index].quantity--; // Mengurangi jumlah item
      }
    });
  }

  // Fungsi untuk menghapus item dari keranjang
  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index); // Menghapus item dari daftar
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Warna latar belakang
      appBar: AppBar(
        backgroundColor: Colors.transparent, // AppBar transparan
        elevation: 0, // Tanpa bayangan
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red), // Tombol kembali
          onPressed: () => Navigator.pop(context), // Kembali ke halaman sebelumnya
        ),
        title: Text("Cart", style: TextStyle(color: Colors.black)), // Judul halaman
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.black), // Tombol akun
            onPressed: () {}, // Fungsi saat ditekan (kosong)
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0), // Padding di seluruh body
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Menyusun kolom dari kiri
          children: [
            // Daftar item keranjang
            Expanded(
              child: ListView.builder(
                itemCount: _cartItems.length, // Jumlah item yang ditampilkan
                itemBuilder: (context, index) {
                  final item = _cartItems[index]; // Mendapatkan item dari daftar
                  return CartItem(
                    imagePath: item.imagePath, // Gambar item
                    title: item.title, // Judul item
                    price: "Rp ${item.price},00", // Harga item
                    quantity: item.quantity, // Jumlah item
                    onAdd: () => _increaseQuantity(index), // Fungsi tambah
                    onRemove: () => _decreaseQuantity(index), // Fungsi kurang
                    onDelete: () => _removeItem(index), // Fungsi hapus
                  );
                },
              ),
            ),
            Divider(), // Pembatas
            // Bagian ringkasan
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0), // Padding vertikal
              child: Text(
                "Ringkasan Belanja",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), // Judul ringkasan
              ),
            ),
            SummaryRow(label: "PPN 11%", value: "Rp ${totalAmount * 0.11},00"), // Menampilkan PPN
            SummaryRow(label: "Total Belanja", value: "Rp ${totalAmount},00"), // Menampilkan total belanja
            Divider(), // Pembatas
            SummaryRow(
              label: "Total Pembayaran",
              value: "Rp ${(totalAmount * 1.11).toStringAsFixed(2)},00", // Total pembayaran dengan PPN
              isBold: true, // Menebalkan teks
            ),
            SizedBox(height: 16), // Jarak vertikal
            // Tombol checkout
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {}, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, 
                  padding: EdgeInsets.symmetric(vertical: 16), // Padding tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Sudut bundar tombol
                  ),
                ),
                child: Text(
                  "Checkout",
                  style: TextStyle(color: Colors.white, fontSize: 16), // Teks tombol
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget untuk menampilkan item dalam keranjang
class CartItem extends StatelessWidget {
  final String imagePath; // Gambar item
  final String title; // Judul item
  final String price; // Harga item
  final int quantity; // Jumlah item
  final VoidCallback onAdd; // Fungsi untuk menambah jumlah
  final VoidCallback onRemove; // Fungsi untuk mengurangi jumlah
  final VoidCallback onDelete; // Fungsi untuk menghapus item

  const CartItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Padding vertikal
      child: Row(
        children: [
          // Gambar item
          ClipRRect(
            borderRadius: BorderRadius.circular(8), // Sudut bundar gambar
            child: Image.asset(
              imagePath, // Path gambar
              width: 80, // Lebar gambar
              height: 80, // Tinggi gambar
              fit: BoxFit.cover, // Memenuhi ruang yang ada
            ),
          ),
          SizedBox(width: 16), // Jarak horizontal
          // Detail item
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Menyusun kolom dari kiri
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)), // Judul item tebal
                Text(price), // Menampilkan harga
                SizedBox(height: 8), // Jarak vertikal
                Row(
                  children: [
                    // Tombol kurang
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline, color: Colors.grey), // Ikon tombol kurang
                      onPressed: onRemove, // Fungsi saat ditekan
                    ),
                    Text('$quantity'), // Menampilkan jumlah
                    // Tombol tambah
                    IconButton(
                      icon: Icon(Icons.add_circle_outline, color: Colors.grey), // Ikon tombol tambah
                      onPressed: onAdd, // Fungsi saat ditekan
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Tombol hapus
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red), // Ikon tombol hapus
            onPressed: onDelete, // Fungsi saat ditekan
          ),
        ],
      ),
    );
  }
}

// Widget untuk menampilkan ringkasan total harga
class SummaryRow extends StatelessWidget {
  final String label; // Label ringkasan
  final String value; // Nilai ringkasan
  final bool isBold; // Status tebal

  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false, // Default tidak tebal
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0), // Padding vertikal
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ruang antar elemen
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal), // Menentukan gaya teks
          ),
          Text(
            value,
            style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal), // Menentukan gaya teks
          ),
        ],
      ),
    );
  }
}

// Model class untuk item keranjang
class CartItemModel {
  final String imagePath; // Path gambar
  final String title; // Judul item
  final int price; // Harga item
  int quantity; // Jumlah item

  CartItemModel(this.imagePath, this.title, this.price, this.quantity);
}
