import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // ตั้งค่า status bar เป็นโปร่งใส
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    
    // หน่วงเวลา 10 วินาทีแล้วเปลี่ยนไปหน้าล็อกอิน
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  void dispose() {
    // คืนค่า status bar ให้แสดงปกติเมื่อออกจากหน้าจอนี้
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // ขยาย body ให้ครอบคลุมถึงขอบบนของหน้าจอ
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 10, 63, 209),
                  Color.fromARGB(255, 158, 60, 255),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logor2c.png',
                  width: 200,
                  height: 200,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
