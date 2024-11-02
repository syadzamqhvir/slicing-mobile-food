import 'package:flutter/material.dart';

// HomePage adalah StatefulWidget yang merepresentasikan halaman utama aplikasi
class HomePage extends StatefulWidget {
  const HomePage({super.key}); // Constructor

  @override
  _HomePageState createState() => _HomePageState(); // Menghubungkan dengan state
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = "All"; // Menyimpan kategori yang dipilih

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Warna latar belakang putih
      appBar: AppBar(
        backgroundColor: Colors.transparent, // AppBar transparan
        elevation: 0, // Tidak ada bayangan
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black), // Icon menu
          onPressed: () {}, // Fungsi saat ditekan (kosong)
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black), // Icon akun
            onPressed: () {}, // Fungsi saat ditekan (kosong)
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Menyusun kolom dari kiri
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Padding horizontal
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ruang antara kategori
                children: [
                  // Icon untuk kategori "All"
                  CategoryIcon(
                    iconPath: "assets/burger.jpeg", // Gambar kategori
                    label: "All", // Label kategori
                    isSelected: selectedCategory == "All", // Menentukan kategori yang dipilih
                    onTap: () { // Fungsi saat kategori ditekan
                      setState(() {
                        selectedCategory = "All"; // Mengubah kategori yang dipilih
                      });
                    },
                  ),
                  // Icon untuk kategori "Makanan"
                  CategoryIcon(
                    iconPath: "assets/burger.jpeg",
                    label: "Makanan",
                    isSelected: selectedCategory == "Makanan",
                    onTap: () {
                      setState(() {
                        selectedCategory = "Makanan"; // Mengubah kategori yang dipilih
                      });
                    },
                  ),
                  // Icon untuk kategori "Minuman"
                  CategoryIcon(
                    iconPath: "assets/teh_botol.jpeg",
                    label: "Minuman",
                    isSelected: selectedCategory == "Minuman",
                    onTap: () {
                      setState(() {
                        selectedCategory = "Minuman"; // Mengubah kategori yang dipilih
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16), // Jarak vertikal
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text("All Food", style: TextStyle(color: Colors.black, fontSize: 20)), // Judul untuk daftar makanan
            ),
            const SizedBox(height: 16), // Jarak vertikal
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                shrinkWrap: true, // Menyesuaikan ukuran GridView
                physics: const NeverScrollableScrollPhysics(), // Nonaktifkan scroll
                itemCount: 4, // Jumlah item yang ditampilkan
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Jumlah kolom
                  crossAxisSpacing: 16, // Jarak antar kolom
                  mainAxisSpacing: 16, // Jarak antar baris
                  childAspectRatio: 0.75, // Rasio aspek item
                ),
                itemBuilder: (context, index) {
                  return FoodItemCard(
                    imagePath: index % 3 == 0 ? "assets/burger.jpeg" : "assets/teh_botol.jpeg", // Gambar berdasarkan index
                    title: index % 3 == 0 ? "Burger King Medium" : "Teh Botol", // Judul berdasarkan index
                    price: index % 3 == 0 ? "Rp. 50.000,00" : "Rp. 4.000,00", // Harga berdasarkan index
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // Warna latar belakang
        selectedItemColor: Colors.pink, // Warna item terpilih
        unselectedItemColor: Colors.grey, // Warna item tidak terpilih
        currentIndex: 0, // Indeks item saat ini
        onTap: (index) { // Fungsi saat item ditekan
          if (index == 1) {
            Navigator.pushNamed(context, '/cart'); // Navigasi ke halaman keranjang
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''), // Item home
          BottomNavigationBarItem(
            icon: Stack( // Item keranjang dengan badge
              children: [
                Icon(Icons.shopping_cart),
                Positioned(
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.pink, // Warna latar belakang badge
                    radius: 8, // Radius badge
                    child: Text('2', style: TextStyle(color: Colors.white, fontSize: 10)), // Jumlah item di keranjang
                  ),
                ),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: ''), // Item struk
        ],
      ),
    );
  }
}

// Kelas CategoryIcon untuk menampilkan kategori
class CategoryIcon extends StatelessWidget {
  final String iconPath; // Path gambar kategori
  final String label; // Label kategori
  final bool isSelected; // Status kategori terpilih
  final VoidCallback onTap; // Fungsi saat kategori ditekan

  const CategoryIcon({
    super.key,
    required this.iconPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Fungsi saat diklik
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue.shade100 : Colors.white, // Warna latar belakang
              borderRadius: BorderRadius.circular(16), // Membuat sudut bundar
              border: isSelected ? Border.all(color: Colors.blue, width: 2) : null, // Border jika terpilih
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 4,
                  offset: const Offset(0, 2), // Bayangan untuk efek kedalaman
                ),
              ],
            ),
            padding: const EdgeInsets.all(8), // Padding di dalam kontainer
            child: Image.asset(
              iconPath, // Gambar kategori
              width: 40, // Lebar gambar
              height: 40, // Tinggi gambar
            ),
          ),
          const SizedBox(height: 4), // Jarak vertikal
          Text(label, style: TextStyle(color: isSelected ? Colors.blue : Colors.black)), // Teks label kategori
        ],
      ),
    );
  }
}

// Kelas FoodItemCard untuk menampilkan item makanan
class FoodItemCard extends StatelessWidget {
  final String imagePath; // Path gambar makanan
  final String title; // Judul makanan
  final String price; // Harga makanan

  const FoodItemCard({super.key, required this.imagePath, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang
        borderRadius: BorderRadius.circular(16), // Sudut bundar
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Bayangan lembut
            blurRadius: 4,
            offset: const Offset(0, 2), // Offset bayangan
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Menyusun konten dari kiri
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)), // Sudut bundar atas
              child: Image.asset(
                imagePath, // Gambar makanan
                fit: BoxFit.cover, // Memenuhi ruang yang ada
                width: double.infinity, // Lebar penuh
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0), // Padding di dalam kontainer
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Menyusun teks dari kiri
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), // Judul makanan tebal
                Text(price), // Menampilkan harga
                Align(
                  alignment: Alignment.bottomRight, // Menempatkan tombol di kanan bawah
                  child: IconButton(
                    icon: const Icon(Icons.add_circle, color: Colors.green), // Tombol tambah
                    onPressed: () {}, // Fungsi saat ditekan (kosong)
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
