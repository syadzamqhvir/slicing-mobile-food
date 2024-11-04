import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black), 
          onPressed: () {}, 
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black), 
            onPressed: () {}, 
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, 
              children: [
                // Kategori "All" (semua item)
                CategoryIcon(
                  iconPath: "assets/burger.jpeg", // Path ke gambar ikon
                  label: "All",
                  isSelected: selectedCategory == "All", // Cek apakah kategori ini yang dipilih
                  onTap: () {
                    setState(() {
                      selectedCategory = "All"; // Mengubah kategori yang dipilih
                    });
                  },
                ),
                // Kategori "Makanan"
                CategoryIcon(
                  iconPath: "assets/burger.jpeg",
                  label: "Makanan",
                  isSelected: selectedCategory == "Makanan",
                  onTap: () {
                    setState(() {
                      selectedCategory = "Makanan";
                    });
                  },
                ),
                // Kategori "Minuman"
                CategoryIcon(
                  iconPath: "assets/teh_botol.jpeg",
                  label: "Minuman",
                  isSelected: selectedCategory == "Minuman",
                  onTap: () {
                    setState(() {
                      selectedCategory = "Minuman";
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16), // Jarak vertikal
          // Teks bagian judul
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("All Food", style: TextStyle(color: Colors.black, fontSize: 20)),
          ),
          const SizedBox(height: 16), // Jarak vertikal
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              // Membuat grid untuk item makanan
              child: GridView.builder(
                itemCount: 6, // Jumlah item dalam grid
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Jumlah kolom grid
                  crossAxisSpacing: 16, // Jarak antar kolom
                  mainAxisSpacing: 16, // Jarak antar baris
                  childAspectRatio: 0.75, // Rasio aspek untuk item
                ),
                itemBuilder: (context, index) {
                  return FoodItemCard(
                    imagePath: index % 2 == 0 ? "assets/burger.jpeg" : "assets/teh_botol.jpeg",
                    title: index % 2 == 0 ? "Burger King Medium" : "Teh Botol",
                    price: index % 2 == 0 ? "Rp. 50.000,00" : "Rp. 4.000,00",
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // Warna latar bawah putih
        selectedItemColor: Colors.pink, // Warna ikon terpilih
        unselectedItemColor: Colors.grey, // Warna ikon tidak terpilih
        currentIndex: 0, // Indeks bagian yang aktif
        onTap: (index) {
          if (index == 1) { // Jika ikon cart ditekan
            Navigator.pushNamed(context, '/cart'); // Navigasi ke layar '/cart'
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''), // Ikon beranda
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart), // Ikon keranjang
                Positioned(
                  right: -1,
                  top: -1,
                  child: CircleAvatar(
                    backgroundColor: Colors.pink,
                    radius: 8,
                    child: Text('2', style: TextStyle(color: Colors.white, fontSize: 9)), // Jumlah item di keranjang
                  ),
                ),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: ''), // Ikon riwayat
        ],
      ),
    );
  }
}

// Widget untuk menampilkan ikon kategori
class CategoryIcon extends StatelessWidget {
  final String iconPath; // Path gambar
  final String label; // Label kategori
  final bool isSelected; // Status apakah kategori dipilih
  final VoidCallback onTap; // Fungsi saat ikon ditekan

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
      onTap: onTap, // Memanggil fungsi saat ditekan
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue.shade100 : Colors.white, // Warna background
              borderRadius: BorderRadius.circular(16), // Membuat tepi melengkung
              border: isSelected ? Border.all(color: Colors.blue, width: 2) : null, // Border jika terpilih
            ),
            padding: const EdgeInsets.all(8), // Padding ikon
            child: Image.asset(
              iconPath,
              width: 40,
              height: 40,
            ),
          ),
          const SizedBox(height: 4), // Jarak antar ikon dan label
          Text(label, style: TextStyle(color: isSelected ? Colors.blue : Colors.black)), // Teks label
        ],
      ),
    );
  }
}

// Widget untuk menampilkan kartu item makanan
class FoodItemCard extends StatelessWidget {
  final String imagePath; // Path gambar makanan
  final String title; // Nama makanan
  final String price; // Harga makanan

  const FoodItemCard({super.key, required this.imagePath, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Warna background putih
        borderRadius: BorderRadius.circular(16), // Tepi melengkung
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Kolom mulai dari kiri
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)), // Melengkungkan bagian atas gambar
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover, // Gambar menyesuaikan ruang yang ada
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), // Nama makanan dengan teks tebal
                Text(price), // Menampilkan harga makanan
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: const Icon(Icons.add_circle, color: Colors.green), // Ikon tambah
                    onPressed: () {}, // Fungsi saat ikon tambah ditekan (belum ditentukan)
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
