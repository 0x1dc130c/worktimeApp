import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'register.dart';
import 'package:worktime/screens/bottonBar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }

  @override
  Widget build(BuildContext context) {
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
                        const Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: SizedBox(
                            height: 36,
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                border: OutlineInputBorder(),
                                fillColor: Color.fromARGB(255, 236, 236, 236),
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
                        const Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: SizedBox(
                            height: 36,
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(top: 20, bottom: 20),
                                border: OutlineInputBorder(),
                                fillColor: Color.fromARGB(255, 236, 236, 236),
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
                                  foregroundColor:
                                      const Color.fromARGB(255, 27, 173, 27),
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(
                                      color: Color.fromARGB(255, 27, 173, 27)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
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
                                backgroundColor:
                                    const Color.fromARGB(255, 27, 173, 27),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                 Navigator.pushReplacementNamed(context, '/bottombar');
                              },
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
}
