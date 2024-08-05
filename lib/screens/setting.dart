import 'package:flutter/material.dart';

class SettingAccount extends StatefulWidget {
  const SettingAccount({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<SettingAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 129, 94, 143)),
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                color: Color.fromARGB(255, 31, 46, 148)),
                            child: Padding(
                              padding: EdgeInsets.all(14),
                              child: Text(
                                'โปรไฟล์',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            )),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Text('ชื่อ'),
                            SizedBox(width: 10),
                            Text('จักรกฤษ'),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Text('นามสกุล'),
                            SizedBox(width: 10),
                            Text('คณะพันธ์'),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Text('ตำแหน่ง'),
                            SizedBox(width: 10),
                            Text('นักวิชาการ'),
                          ],
                        ),
                      ],
                    )),
                SizedBox(height: 10),
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 31, 46, 148),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              'บัญชีผู้ใช้งาน',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Text('ชื่อผู้ใช้งาน'),
                            SizedBox(width: 10),
                            Text(
                              'jakkrit',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.grey, // สีของเส้น
                                decorationThickness: 2.0, // ความหนาของเส้น
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Text('รหัสผ่าน'),
                            SizedBox(width: 10),
                            Text('123456'),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Text('อีเมล'),
                            SizedBox(width: 10),
                            Text('jakkid.ca@gmail.com'),
                          ],
                        )
                      ],
                    )),
                SizedBox(height: 10),
              ],
            )),
      ),
    );
  }
}
