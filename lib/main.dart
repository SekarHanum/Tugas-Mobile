import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter/services.dart';

// Main function to run the app
void main() {
  runApp(AbsensiApp());
}

class AbsensiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Absensi',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

// Splash Screen widget
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
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

// Home Page widget
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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Keluar Aplikasi'),
          content: Text('Apakah Anda yakin ingin keluar?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showThankYouPage(context);
              },
              child: Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  void _showThankYouPage(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.green,
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

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop(); // Tutup dialog
      SystemNavigator.pop(); // Keluar dari aplikasi
    });
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
                  String currentTime = DateFormat('HH:mm').format(DateTime.now());
                  Navigator.pop(context);
                  _showToast(context, 'Lembur selesai pukul $currentTime');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Selamat datang di aplikasi Absensi!'),
            ElevatedButton(
              onPressed: () => _showAbsensiDialog(context),
              child: Text('Absen Masuk'),
            ),
            ElevatedButton(
              onPressed: () => _showKeluarDialog(context),
              child: Text('Absen Keluar'),
            ),
            ElevatedButton(
              onPressed: () => _showMulaiLemburDialog(context),
              child: Text('Mulai Lembur'),
            ),
            ElevatedButton(
              onPressed: () => _showSelesaiLemburDialog(context),
              child: Text('Selesai Lembur'),
            ),
            ElevatedButton(
              onPressed: () => _showLogoutDialog(context),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
