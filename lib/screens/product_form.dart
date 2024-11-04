import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductForm(), // Mengatur layar awal aplikasi ke ProductForm
      theme: ThemeData(
        fontFamily: 'Arial', // Mengatur font aplikasi menjadi Arial
      ),
    );
  }
}

class ProductForm extends StatefulWidget {
  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  String? _selectedCategory; // Variabel untuk menyimpan kategori produk yang dipilih
  final List<String> _categories = ['Makanan', 'Minuman']; // Daftar kategori produk
  String? _selectedFileName; // Variabel untuk menyimpan nama file yang dipilih

  // Fungsi untuk membuka file picker dan memilih file
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(); // Memilih file
    if (result != null) {
      setState(() {
        _selectedFileName = result.files.single.name; // Menyimpan nama file yang dipilih
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Warna latar belakang layar
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0), // Margin horizontal form
          child: Container(
            padding: EdgeInsets.all(20.0), // Padding dalam container
            decoration: BoxDecoration(
              color: Colors.white, // Warna latar belakang form
              borderRadius: BorderRadius.circular(20), // Membuat border melingkar pada form
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1), // Warna dan transparansi bayangan
                  blurRadius: 10,
                  offset: Offset(0, 5), // Posisi bayangan
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Menyusun form sesuai dengan ukuran konten
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context), // Tombol kembali ke halaman sebelumnya
                    ),
                    IconButton(
                      icon: Icon(Icons.person, color: Colors.black),
                      onPressed: () {}, // Placeholder untuk aksi profil
                    ),
                  ],
                ),
                SizedBox(height: 16), // Jarak vertikal

                // Input untuk nama produk
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Nama Produk', // Label input
                    hintText: 'Masukan nama produk', // Petunjuk input
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10), // Border melingkar
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    filled: true,
                    fillColor: Colors.grey[300], // Warna latar belakang input
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
                SizedBox(height: 16),

                // Input untuk harga produk
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Harga', // Label input
                    hintText: 'Masukan Harga', // Petunjuk input
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    filled: true,
                    fillColor: Colors.grey[300],
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
                SizedBox(height: 16),

                // Dropdown untuk memilih kategori produk
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Kategori produk', // Label dropdown
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    filled: true,
                    fillColor: Colors.grey[300],
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                  value: _selectedCategory, // Kategori yang dipilih
                  items: _categories
                      .map((category) => DropdownMenuItem(
                            child: Text(category),
                            value: category, // Nilai kategori
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value; // Menyimpan kategori yang dipilih
                    });
                  },
                ),
                SizedBox(height: 16),

                // Input untuk memilih file gambar
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Image', // Label input
                    hintText: _selectedFileName ?? 'Choose file', // Nama file atau petunjuk
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    filled: true,
                    fillColor: Colors.grey[300],
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                  readOnly: true, // Tidak bisa diedit, hanya dapat dipilih
                  onTap: _pickFile, // Membuka file picker ketika diklik
                ),
                SizedBox(height: 24),

                // Tombol Submit
                SizedBox(
                  width: double.infinity, // Lebar tombol mengikuti lebar container
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle form submission
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Warna tombol
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Border melingkar pada tombol
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16), // Padding vertikal tombol
                    ),
                    child: Text(
                      'Submit', // Teks pada tombol
                      style: TextStyle(fontSize: 16, color: Colors.white), // Gaya teks tombol
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
