import 'package:flutter/material.dart';

void main() {
  runApp(const MenuMakananApp());
}

class MenuMakananApp extends StatelessWidget {
  const MenuMakananApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MenuMakanan(),
    );
  }
}

class MenuMakanan extends StatefulWidget {
  const MenuMakanan({super.key});

  @override
  State<MenuMakanan> createState() => _MenuMakananState();
}

class _MenuMakananState extends State<MenuMakanan> {
  final TextEditingController sotoController = TextEditingController(text: '0');

  final TextEditingController rawonController =
      TextEditingController(text: '0');

  int hargaSoto = 12000;
  int hargaRawon = 20000;

  int total = 0;

  void hitungTotal() {
    int jumlahSoto = int.tryParse(sotoController.text) ?? 0;
    int jumlahRawon = int.tryParse(rawonController.text) ?? 0;

    setState(() {
      total = (jumlahSoto * hargaSoto) + (jumlahRawon * hargaRawon);
    });
  }

  @override
  void initState() {
    super.initState();

    sotoController.addListener(hitungTotal);
    rawonController.addListener(hitungTotal);
  }

  @override
  void dispose() {
    sotoController.dispose();
    rawonController.dispose();
    super.dispose();
  }

  String rupiah(int angka) {
    return 'Rp${angka.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]}.',
        )}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF102A43),
        centerTitle: true,
        title: const Text(
          'MENU MAKANAN',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Pilih Menu Terbaikmu',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xFF102A43),
              ),
            ),

            const SizedBox(height: 20),

            // SOTO
            menuMakanan(
              gambar: 'assets/sotow.jpg',
              nama: 'Soto',
              harga: hargaSoto,
              controller: sotoController,
            ),

            const SizedBox(height: 18),

            // RAWON
            menuMakanan(
              gambar: 'assets/rawonn.jpg',
              nama: 'Rawon',
              harga: hargaRawon,
              controller: rawonController,
            ),

            const SizedBox(height: 25),

            // TOTAL
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF102A43),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'TOTAL',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    rupiah(total),
                    style: const TextStyle(
                      color: Color(0xFFFFB74D),
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // TOMBOL PESAN
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Pesanan berhasil dibuat!',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF168AAD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'PESAN SEKARANG',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menuMakanan({
    required String gambar,
    required String nama,
    required int harga,
    required TextEditingController controller,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // GAMBAR
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              gambar,
              width: 115,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 15),

          // INFORMASI MENU
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF102A43),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  rupiah(harga),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF168AAD),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text(
                      'Porsi:',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 65,
                      height: 40,
                      child: TextField(
                        controller: controller,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF168AAD),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
