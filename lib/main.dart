import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async'; // <--- Tambahkan ini untuk timer

void main() {
  runApp(AbsensiApp());
}

// Tambahkan ini! (class AbsensiApp)
class AbsensiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Absensi',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // <-- Mulai dari SplashScreen
    );
  }
}

@override
Widget build(BuildContext context) {
  return WillPopScope( // <--- Tambahkan WillPopScope
    onWillPop: () async {
      bool keluar = await _showExitPage(context); // <--- Panggil fungsi exit
      return keluar;
    },
    child: Scaffold(
      appBar: AppBar(
        title: Text('Absensi'),
        centerTitle: true,
      ),
    ),
  );
}

Future<bool> _showExitPage(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible: false, // Tidak bisa klik luar dialog
    builder: (context) {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pop(true); // Setelah 2 detik, tutup dialog
      });

      return AlertDialog(
        backgroundColor: Colors.green, // Background hijau
        content: Center(
          heightFactor: 1,
          child: Text(
            "Terima Kasih Telah Disiplin",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    },
  );

  return true; // Setelah dialog, keluar dari aplikasi
}



// SplashScreen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () { // <--- 3 detik, lalu ke HomePage
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green, // background hijau biar fresh
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selamat Datang',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Tingkatkan Kedisiplinan',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// HomePage (seperti sebelumnya)
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  DateTime? _mulaiLembur;

  void _showToast(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showAbsensiDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Absen Masuk'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_namaController.text.isNotEmpty && _emailController.text.isNotEmpty) {
                  Navigator.pop(context);
                  _showToast(context, 'Absensi Berhasil');
                  _namaController.clear();
                  _emailController.clear();
                } else {
                  _showToast(context, 'Mohon isi semua data');
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _showKeluarDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Absen Keluar'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_namaController.text.isNotEmpty && _emailController.text.isNotEmpty) {
                  Navigator.pop(context);
                  _showToast(context, 'Terimakasih telah berusaha hari ini dan hati-hati di jalan');
                  _namaController.clear();
                  _emailController.clear();
                } else {
                  _showToast(context, 'Mohon isi semua data');
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _showMulaiLemburDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Mulai Lembur'),
          content: TextField(
            controller: _namaController,
            decoration: InputDecoration(labelText: 'Nama'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_namaController.text.isNotEmpty) {
                  _mulaiLembur = DateTime.now();
                  String currentTime = DateFormat('HH:mm').format(_mulaiLembur!);
                  Navigator.pop(context);
                  _showToast(context, 'Lembur dimulai pukul $currentTime');
                  _namaController.clear();
                } else {
                  _showToast(context, 'Mohon isi nama');
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _showSelesaiLemburDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Selesai Lembur'),
          content: TextField(
            controller: _namaController,
            decoration: InputDecoration(labelText: 'Nama'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_namaController.text.isNotEmpty) {
                  if (_mulaiLembur != null) {
                    DateTime selesaiLembur = DateTime.now();
                    String mulaiJam = DateFormat('HH:mm').format(_mulaiLembur!);
                    String selesaiJam = DateFormat('HH:mm').format(selesaiLembur);

                    Duration durasi = selesaiLembur.difference(_mulaiLembur!);
                    int jam = durasi.inHours;
                    int menit = durasi.inMinutes.remainder(60);

                    Navigator.pop(context);
                    _showToast(context,
                        'Lembur dari $mulaiJam sampai $selesaiJam\nDurasi: $jam jam $menit menit');
                    _mulaiLembur = null;
                  } else {
                    _showToast(context, 'Anda belum memulai lembur!');
                  }
                  _namaController.clear();
                } else {
                  _showToast(context, 'Mohon isi nama');
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAbsensiButton(BuildContext context, String title, IconData iconData) {
    return ElevatedButton(
      onPressed: () {
        if (title == "Absen Masuk") {
          _showAbsensiDialog(context);
        } else if (title == "Absen Keluar") {
          _showKeluarDialog(context);
        } else if (title == "Mulai Lembur") {
          _showMulaiLemburDialog(context);
        } else if (title == "Selesai Lembur") {
          _showSelesaiLemburDialog(context);
        } else {
          _showToast(context, '$title diklik');
        }
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(16),
        textStyle: TextStyle(fontSize: 16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData, size: 40),
          SizedBox(height: 8),
          Text(title, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Absensi'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Selamat Pagi\nJangan lupa sarapan',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildAbsensiButton(context, "Absen Masuk", Icons.login),
                  _buildAbsensiButton(context, "Absen Keluar", Icons.logout),
                  _buildAbsensiButton(context, "Mulai Lembur", Icons.timer),
                  _buildAbsensiButton(context, "Selesai Lembur", Icons.timer_off),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
