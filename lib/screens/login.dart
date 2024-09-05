import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'register.dart';
import 'package:worktime/screens/bottonBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart'; // เพิ่มการนำเข้า shared_preferences
import 'dart:async';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    _checkLoginStatus(); // เพิ่มการตรวจสอบสถานะการเข้าสู่ระบบเมื่อเริ่มต้นแอป
  }

  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showDialog('กรุณากรอกชื่อผู้ใช้และรหัสผ่าน');
      return;
    }
    try {
      final _result = await checkCredentials(username, password);
      final resultMap = _result as Map<String, dynamic>;
      bool isValid = resultMap['isValid'];
      String roles =
          resultMap['roles'] ?? 'defaultRole'; // เพิ่มการตรวจสอบค่า null

      if (isValid) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('username', username);
        await prefs.setString('roles', roles);

        _showDialog('เข้าสู่ระบบสำเร็จ', success: true);
      } else {
        _showDialog('ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง');
      }
    } catch (e) {
      print('Error: $e');
      _showDialog('Error: $e');
    }
  }

  Future<Object> checkCredentials(String username, String password) async {
    try {
      String? _roles;
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      final QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('Users')
          .where('Username', isEqualTo: username)
          .where('Password', isEqualTo: password)
          .get();

      bool isValid = snapshot.docs.isNotEmpty;
      if (snapshot.docs.isNotEmpty) {
        // Loop through the documents
        for (var doc in snapshot.docs) {
          // Access the data in each document
          Map<String, dynamic> userData = doc.data();
          // Access specific fields
          _roles = userData['Roles'];
          // Do something with the data
        }
      } else {
        print('No matching documents found.');
      }
      return {'isValid': isValid, 'roles': _roles};
    } catch (e) {
      print('-------------------------- Error: $e');
      return false;
    }
  }

  void _showDialog(String message, {bool success = false}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Row(
            children: [
              Icon(
                success ? Icons.check_circle : Icons.error,
                color: success ? Colors.green : Colors.red,
              ),
              SizedBox(width: 10),
              Text(
                success ? 'สำเร็จ' : 'ข้อผิดพลาด',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: success ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
          content: Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        );
      },
    ).then((_) {
      // This is called after the dialog is dismissed
      if (success) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(context, '/bottombar');
        });
      }
    });

    // Close the dialog after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    });
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/bottombar');
    }
  }

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Error'),
              ),
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              extendBodyBehindAppBar: true,
              body: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
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
                      children: [
                        const SizedBox(height: 50),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(180, 185, 185, 185),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(50, 0, 0, 0),
                                  spreadRadius: 5.0,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'เข้าสู่ระบบ',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 5, left: 20, right: 20),
                                  child: Text(
                                    'ชื่อผู้ใช้งาน',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: SizedBox(
                                    height: 36,
                                    child: TextField(
                                      controller: _usernameController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(5),
                                        border: OutlineInputBorder(),
                                        fillColor:
                                            Color.fromARGB(255, 236, 236, 236),
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 5, left: 20, right: 20),
                                  child: Text(
                                    'รหัสผ่าน',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: SizedBox(
                                    height: 36,
                                    child: TextField(
                                      controller: _passwordController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(5),
                                        border: OutlineInputBorder(),
                                        fillColor:
                                            Color.fromARGB(255, 236, 236, 236),
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: const Color.fromARGB(
                                              255, 27, 173, 27),
                                          backgroundColor: Colors.white,
                                          side: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 27, 173, 27)),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const RegisterPage()));
                                        },
                                        child: const Text(
                                          'สมัครสมาชิก',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: const Color.fromARGB(
                                            255, 27, 173, 27),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: _login,
                                      child: const Text(
                                        'เข้าสู่ระบบ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
