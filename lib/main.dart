import 'package:flutter/material.dart';
import 'package:burger/screens/home_screen.dart'; // Mengimpor halaman beranda
import 'package:burger/screens/cart.dart'; // Mengimpor halaman keranjang belanja
import 'package:burger/screens/product_form.dart';

void main() {
  runApp(const MyApp()); // Menjalankan aplikasi dengan MyApp sebagai root widget.
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Membuat aplikasi Material
      title: 'Navigasi Antar Halaman', // Judul aplikasi
      theme: ThemeData(
        primarySwatch: Colors.blue, // Menentukan tema warna utama
      ),
      initialRoute: '/', // Menentukan rute awal aplikasi
      routes: {
        '/': (context) => const HomePage(), // Rute untuk halaman beranda
        '/cart': (context) => CartPage(), // Rute untuk halaman keranjang
        '/product_form': (context) => ProductForm(),
     
        
      },
    );
  }
}
