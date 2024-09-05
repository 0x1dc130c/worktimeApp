import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login.dart';
import 'package:worktime/features/models/users_model.dart';
import 'package:worktime/repository/user_repository/user_repository.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _fname = TextEditingController();
  final TextEditingController _lname = TextEditingController();
  final TextEditingController _position = TextEditingController();

  void _buttonPressed1() {
  if (_username.text.isEmpty || _password.text.isEmpty || _email.text.isEmpty ||
      _phone.text.isEmpty || _fname.text.isEmpty || _lname.text.isEmpty) {
    _showDialog('กรุณากรอกข้อมูลให้ครบถ้วน');
    return;
  }

  final user = UserModel(
    username: _username.text.trim(),
    password: _password.text.trim(),
    email: _email.text.trim(),
    phonenumber: _phone.text.trim(),
    firstname: _fname.text.trim(),
    lastname: _lname.text.trim(),
    roles: _position.text.trim(),
    position: 'User',
  );

  try {
    UserRepository.instance.createUser(user);
    _showDialog('สร้างบัญชีผู้ใช้สำเร็จ', success: true);
  } catch (e) {
    _showDialog('เกิดข้อผิดพลาดในการสร้างบัญชีผู้ใช้');
  }
}

void _buttonPressed() {
  if (_username.text.isEmpty || _password.text.isEmpty || _email.text.isEmpty ||
      _phone.text.isEmpty || _fname.text.isEmpty || _lname.text.isEmpty) {
    _showDialog('กรุณากรอกข้อมูลให้ครบถ้วน');
    return; // ไม่ทำอะไรต่อเมื่อข้อมูลไม่ครบถ้วน
  }

  final user = UserModel(
    username: _username.text.trim(),
    password: _password.text.trim(),
    email: _email.text.trim(),
    phonenumber: _phone.text.trim(),
    firstname: _fname.text.trim(),
    lastname: _lname.text.trim(),
    roles: _position.text.trim(),
    position: 'User',
  );

  try {
    UserRepository.instance.createUser(user);
    _showDialog('สร้างบัญชีผู้ใช้สำเร็จ', success: true);
  } catch (e) {
    _showDialog('เกิดข้อผิดพลาดในการสร้างบัญชีผู้ใช้');
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
    if (success) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/login');
      });
    }
  });

  if (success) {
    Future.delayed(Duration(seconds: 2), () {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    });
  }
}


  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 160, 56, 251),
                    Colors.blueAccent
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 5.0, right: 5.0, bottom: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: const EdgeInsets.all(20),
                            width: 500,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(138, 185, 185, 185),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(50, 0, 0, 0),
                                  offset: Offset(0, 3),
                                  blurRadius: 6,
                                  spreadRadius: 1.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 15, bottom: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      'สมัครสมาชิก',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'ชื่อ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                                 SizedBox(
                                  height: 36,
                                  child: TextField(
                                    controller: _fname,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40.0)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 100, 100, 100)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 225, 225, 225)),
                                      ),
                                      fillColor:
                                          Color.fromARGB(255, 236, 236, 236),
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    'นามสกุล',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 36,
                                  child: TextField(
                                    controller: _lname,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 100, 100, 100)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 225, 225, 225)),
                                      ),
                                      fillColor:
                                          Color.fromARGB(255, 236, 236, 236),
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 6.0, horizontal: 6.0),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    'ตำแหน่ง',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 36,
                                  child: TextField(
                                    controller: _position,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 225, 225, 225)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 100, 100, 100)),
                                      ),
                                      fillColor:
                                          Color.fromARGB(255, 236, 236, 236),
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 6.0, horizontal: 6.0),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    'อีเมลล์',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 36,
                                  child: TextField(
                                    controller: _email,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 225, 225, 225)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 100, 100, 100)),
                                      ),
                                      fillColor:
                                          Color.fromARGB(255, 236, 236, 236),
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 6.0, horizontal: 6.0),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    'เบอร์โทรศัพท์',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 36,
                                  child: TextField(
                                    controller: _phone,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 100, 100, 100)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 225, 225, 225)),
                                      ),
                                      fillColor:
                                          Color.fromARGB(255, 236, 236, 236),
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 6.0, horizontal: 6.0),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    'Username',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 36,
                                  child: TextField(
                                    controller: _username,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 225, 225, 225)),
                                      ),
                                      fillColor:
                                          Color.fromARGB(255, 236, 236, 236),
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 6.0, horizontal: 6.0),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    'Password',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 36,
                                  child: TextField(
                                    controller: _password,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 225, 225, 225)),
                                      ),
                                      fillColor:
                                          Color.fromARGB(255, 236, 236, 236),
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 6.0, horizontal: 6.0),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                      child: ElevatedButton(
                                          onPressed: _buttonPressed,
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor:
                                                const Color.fromARGB(
                                                    255, 14, 159, 14),
                                            backgroundColor:
                                                Colors.green,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            shadowColor: Colors.green,
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Text('สมัครสมาชิก',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          )),
                                    ),
                                  ),
                                
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  }
  
  
}
