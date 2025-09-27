import 'package:flutter/material.dart';

// Fungsi utama untuk menjalankan aplikasi
void main() {
  runApp(const BiodataWireframeApp());
}

// =========================================================================
// WIDGET PLACEHOLDER REUSABLE
// =========================================================================

// Placeholder Teks/Label
Widget _buildTextPlaceholder({
  double width = 120,
  double height = 16,
  double radius = 4,
  Color? backgroundColor,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: backgroundColor ?? Colors.grey[300],
      borderRadius: BorderRadius.circular(radius),
    ),
  );
}

// Placeholder Tombol Navigasi (Dibuat statis di Presentation View)
Widget _buildNavButton(
  BuildContext context,
  String label,
  Widget targetScreen,
) {
  // Dalam tampilan presentasi, tombol navigasi dinonaktifkan dan hanya berfungsi sebagai placeholder visual.
  return Container(
    width: double.infinity,
    height: 40, // Dikecilkan
    margin: const EdgeInsets.only(bottom: 6), // Dikecilkan
    decoration: BoxDecoration(
      color: Colors.grey[600],
      borderRadius: BorderRadius.circular(6), // Dikecilkan
    ),
    child: Center(
      child: Text(
        label, // Teks label untuk memudahkan identifikasi
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ), // Font dikecilkan
      ),
    ),
  );
}

// Placeholder Field Input
Widget _buildInputPlaceholder({String hint = ''}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0), // Dikecilkan
    child: Container(
      height: 35, // Dikecilkan
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(6), // Dikecilkan
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0), // Dikecilkan
        child: Align(
          alignment: Alignment.centerLeft,
          child: _buildTextPlaceholder(
            width: hint.length * 5.0 + 30,
            height: 12,
            backgroundColor: Colors.grey[300],
          ), // Dikecilkan
        ),
      ),
    ),
  );
}

// Placeholder Card Konten
Widget _buildContentCard({required String title, required Widget content}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 12), // Dikecilkan
    padding: const EdgeInsets.all(10), // Dikecilkan
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey.shade200, width: 1), // Dikecilkan
      borderRadius: BorderRadius.circular(8), // Dikecilkan
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 2,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
            fontSize: 14,
          ), // Font dikecilkan
        ),
        const SizedBox(height: 8), // Dikecilkan
        content,
      ],
    ),
  );
}

// Widget Panah Aliran (Flow Arrow)
class _FlowArrow extends StatelessWidget {
  const _FlowArrow();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50, // Lebar panah
      height: 480, // Tinggi setinggi frame ponsel
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 2,
            color: Colors.grey[700], // Garis
          ),
          ClipPath(
            clipper: ArrowClipper(),
            child: Container(
              width: 15,
              height: 15,
              color: Colors.grey[700], // Kepala panah
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Clipper untuk membuat bentuk segitiga (kepala panah)
class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// Wrapper untuk Bingkai Ponsel (Frame)
class _DeviceFrameWrapper extends StatelessWidget {
  final Widget child;
  final String title;
  const _DeviceFrameWrapper({required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0), // Dikecilkan
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ), // Font dikecilkan
        ),
        Container(
          width: 250, // LEBAR UTAMA DIKECILKAN
          height: 480, // TINGGI UTAMA DIKECILKAN
          decoration: BoxDecoration(
            color: Colors.black, // Warna bingkai ponsel
            borderRadius: BorderRadius.circular(20), // Dikecilkan
            boxShadow: const [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 15, // Dikecilkan
                spreadRadius: 3, // Dikecilkan
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20), // Dikecilkan
            child: child,
          ),
        ),
      ],
    );
  }
}

// =========================================================================
// KELAS APLIKASI UTAMA
// =========================================================================
class BiodataWireframeApp extends StatelessWidget {
  const BiodataWireframeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wireframe Biodata',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(color: Colors.white, elevation: 0),
      ),
      // Set home ke Presentation View untuk menampilkan semua scene berjejer
      home: const WireframePresentationView(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// =========================================================================
// TAMPILAN PRESENTASI UTAMA (Menampilkan semua Scene berjejer)
// =========================================================================
class WireframePresentationView extends StatelessWidget {
  const WireframePresentationView({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftar semua Scene dan Panah Aliran
    final List<Widget> flowElements = [
      _DeviceFrameWrapper(
        title: 'Halaman 1: App Logo',
        child: const AppLogoScene(),
      ),
      const _FlowArrow(),
      _DeviceFrameWrapper(
        title: 'Halaman 2: Main Dashboard',
        child: const MainDashboardScene(),
      ),
      const _FlowArrow(),
      _DeviceFrameWrapper(
        title: 'Halaman 3: Dashboard Biodata',
        child: const ProfileSummaryScene(),
      ),
      const _FlowArrow(),
      _DeviceFrameWrapper(
        title: 'Halaman 4: Input Form',
        child: const InputFormScene(),
      ),
      const _FlowArrow(),
      _DeviceFrameWrapper(
        title: 'Halaman 5: Output Biodata',
        child: const OutputBiodataScene(),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[200], // Background yang kontras
      // APPBAR DIHAPUS SESUAI PERMINTAAN
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Memungkinkan scroll horizontal
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: flowElements
              .map(
                (element) => Padding(
                  padding: const EdgeInsets.only(
                    right: 5.0,
                  ), // Jarak antar elemen
                  child: element,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

// Placeholder Status Bar (Digunakan di setiap Scene)
PreferredSizeWidget _buildStatusBar() {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTextPlaceholder(
          width: 30,
          height: 8,
          backgroundColor: Colors.grey[700],
        ), // Dikecilkan
        _buildTextPlaceholder(
          width: 60,
          height: 8,
          backgroundColor: Colors.grey[700],
        ), // Dikecilkan
      ],
    ),
    toolbarHeight: 25, // Dikecilkan
    backgroundColor: Colors.white,
    elevation: 0,
  );
}

// =========================================================================
// HALAMAN 1: APP LOGO (Splash Screen)
// =========================================================================
class AppLogoScene extends StatelessWidget {
  const AppLogoScene({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildStatusBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0), // Dikecilkan
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder Logo Besar
            Container(
              width: 100, // Dikecilkan
              height: 100, // Dikecilkan
              decoration: BoxDecoration(
                color: Colors.grey[400],
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 20), // Dikecilkan
            // Placeholder Nama Aplikasi
            _buildTextPlaceholder(
              width: 150,
              height: 25,
              backgroundColor: Colors.grey[700],
            ), // Dikecilkan
            const SizedBox(height: 50), // Dikecilkan
            // Tombol "Mulai"
            Container(
              height: 40, // Dikecilkan
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(6), // Dikecilkan
              ),
              child: const Center(
                child: Text(
                  'MULAI',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ), // Font dikecilkan
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================================================================
// HALAMAN 2: MAIN DASHBOARD (Menu Utama)
// =========================================================================
class MainDashboardScene extends StatelessWidget {
  const MainDashboardScene({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildStatusBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0), // Dikecilkan
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Header / App Bar Sebenarnya
            AppBar(
              automaticallyImplyLeading: false,
              title: _buildTextPlaceholder(
                width: 120,
                height: 16,
                backgroundColor: Colors.grey[600],
              ), // Dikecilkan
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0), // Dikecilkan
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey[500],
                      shape: BoxShape.circle,
                    ),
                  ), // Dikecilkan
                ),
              ],
            ),
            const SizedBox(height: 15), // Dikecilkan
            // Menu Utama: Biodata Diri
            _buildContentCard(
              title: 'Biodata Diri Saya',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextPlaceholder(
                    width: double.infinity,
                    height: 40,
                    backgroundColor: Colors.grey[300],
                  ), // Dikecilkan
                  const SizedBox(height: 8), // Dikecilkan
                  // Tombol menuju Dashboard Biodata Diri (Scene 3)
                  _buildNavButton(
                    context,
                    'Dashboard Biodata (Scene 3)',
                    const ProfileSummaryScene(),
                  ),
                ],
              ),
            ),

            // Menu Utama: Menu Lain
            _buildContentCard(
              title: 'Menu Lainnya',
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.grey[200],
                  ), // Pengaturan
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.grey[200],
                  ), // Bantuan
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.grey[200],
                  ), // Tentang Aplikasi
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================================================================
// HALAMAN 3: DASHBOARD BIODATA DIRI (Ringkasan/View Data)
// =========================================================================
class ProfileSummaryScene extends StatelessWidget {
  const ProfileSummaryScene({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildStatusBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0), // Dikecilkan
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // AppBar Sebenarnya
            AppBar(
              automaticallyImplyLeading: false,
              title: _buildTextPlaceholder(
                width: 140,
                height: 16,
                backgroundColor: Colors.grey[600],
              ), // Dikecilkan
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
                // Tombol Edit
                Padding(
                  padding: const EdgeInsets.only(right: 10.0), // Dikecilkan
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.red[300],
                      shape: BoxShape.circle,
                    ),
                  ), // Dikecilkan
                ),
              ],
            ),
            const SizedBox(height: 15), // Dikecilkan
            // Card Profil Atas (Foto & Nama)
            _buildContentCard(
              title: 'Informasi Ringkas',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      shape: BoxShape.circle,
                    ),
                  ), // Dikecilkan
                  const SizedBox(height: 8), // Dikecilkan
                  _buildTextPlaceholder(
                    width: 120,
                    height: 14,
                    backgroundColor: Colors.grey[700],
                  ), // Nama
                  const SizedBox(height: 4),
                  _buildTextPlaceholder(width: 80, height: 12), // Pekerjaan
                ],
              ),
            ),

            // Tombol untuk Edit / Input Form (Scene 4)
            _buildNavButton(
              context,
              'EDIT BIODATA (Scene 4)',
              const InputFormScene(),
            ),
            const SizedBox(height: 5), // Dikecilkan
            // Tombol untuk Lihat Output Detail (Scene 5)
            _buildNavButton(
              context,
              'LIHAT OUTPUT LENGKAP (Scene 5)',
              const OutputBiodataScene(),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================================================================
// HALAMAN 4: INPUT FORM BIODATA DIRI
// =========================================================================
class InputFormScene extends StatelessWidget {
  const InputFormScene({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildStatusBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0), // Dikecilkan
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // AppBar Sebenarnya
            AppBar(
              automaticallyImplyLeading: false,
              title: _buildTextPlaceholder(
                width: 120,
                height: 16,
                backgroundColor: Colors.grey[600],
              ), // Dikecilkan
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            const SizedBox(height: 15), // Dikecilkan
            // Card Formulir Utama
            _buildContentCard(
              title: 'Data Diri',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextPlaceholder(
                    width: 80,
                    height: 12,
                    radius: 2,
                  ), // Label Nama
                  _buildInputPlaceholder(),
                  _buildTextPlaceholder(
                    width: 80,
                    height: 12,
                    radius: 2,
                  ), // Label Email
                  _buildInputPlaceholder(),
                  _buildTextPlaceholder(
                    width: 80,
                    height: 12,
                    radius: 2,
                  ), // Label Telepon
                  _buildInputPlaceholder(),
                  _buildTextPlaceholder(
                    width: 80,
                    height: 12,
                    radius: 2,
                  ), // Label Pekerjaan
                  _buildInputPlaceholder(),
                ],
              ),
            ),

            // Card Alamat
            _buildContentCard(
              title: 'Alamat dan Lokasi',
              content: _buildInputPlaceholder(hint: 'Alamat lengkap'),
            ),

            // Tombol Simpan
            Container(
              height: 40, // Dikecilkan
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green[600], // Tombol Simpan dibuat warna berbeda
                borderRadius: BorderRadius.circular(6), // Dikecilkan
              ),
              child: const Center(
                child: Text(
                  'SIMPAN BIODATA',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ), // Font dikecilkan
              ),
            ),
            const SizedBox(height: 10), // Dikecilkan
          ],
        ),
      ),
    );
  }
}

// =========================================================================
// HALAMAN 5: OUTPUT BIODATA DIRI (Tampilan Data Lengkap)
// =========================================================================
class OutputBiodataScene extends StatelessWidget {
  const OutputBiodataScene({super.key});

  // Fungsi untuk baris detail data
  Widget _buildDataRow(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0), // Dikecilkan
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextPlaceholder(
            width: 80,
            height: 12,
            backgroundColor: Colors.grey[400],
          ), // Label
          const SizedBox(height: 2), // Dikecilkan
          _buildTextPlaceholder(
            width: double.infinity,
            height: 14,
            backgroundColor: Colors.grey[200],
          ), // Nilai Data
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildStatusBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0), // Dikecilkan
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // AppBar Sebenarnya
            AppBar(
              automaticallyImplyLeading: false,
              title: _buildTextPlaceholder(
                width: 140,
                height: 16,
                backgroundColor: Colors.grey[600],
              ), // Dikecilkan
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            const SizedBox(height: 15), // Dikecilkan
            // Card Output Data Utama
            _buildContentCard(
              title: 'Data Pribadi',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDataRow('Nama'),
                  _buildDataRow('Alamat'),
                  _buildDataRow('Pekerjaan'),
                  _buildDataRow('Kontak (Email)'),
                  _buildDataRow('Kontak (Telepon)'),
                ],
              ),
            ),

            // Tombol Edit dan Hapus Data
            _buildNavButton(
              context,
              'EDIT DATA (Scene 4)',
              const InputFormScene(),
            ),
            Container(
              height: 40, // Dikecilkan
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.red[600],
                borderRadius: BorderRadius.circular(6), // Dikecilkan
              ),
              child: const Center(
                child: Text(
                  'HAPUS DATA',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ), // Font dikecilkan
              ),
            ),
          ],
        ),
      ),
    );
  }
}
