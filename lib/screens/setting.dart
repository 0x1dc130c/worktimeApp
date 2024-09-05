import 'package:flutter/material.dart';

class SettingAccount extends StatefulWidget {
  const SettingAccount({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<SettingAccount> {
  bool _editUsername = false;
  bool _editPassword = false;
  bool _editEmail = false;

  // ย้ายการสร้าง TextEditingController มาที่นี่
  final TextEditingController _usernameController = TextEditingController(text: 'jakkrit');
  final TextEditingController _passwordController = TextEditingController(text: '123456');
  final TextEditingController _emailController = TextEditingController(text: 'jakkid.ca@gmail.com');

  @override
  void dispose() {
    // ทำการ dispose เมื่อไม่ใช้แล้ว
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 228, 228, 228),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  color: Color.fromARGB(255, 31, 46, 148),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(14),
                                  child: Text(
                                    'โปรไฟล์',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: const [
                                  SizedBox(width: 20),
                                  Text('ชื่อ', style: TextStyle(fontSize: 16)),
                                  SizedBox(width: 10),
                                  Text('จักรกฤษ', style: TextStyle(fontSize: 16)),
                                ],
                              ),
                              const SizedBox(height: 5),
                              const Divider(color: Colors.grey),
                              const SizedBox(height: 5),
                              Row(
                                children: const [
                                  SizedBox(width: 20),
                                  Text('นามสกุล', style: TextStyle(fontSize: 16)),
                                  SizedBox(width: 10),
                                  Text('คณะพันธ์', style: TextStyle(fontSize: 16)),
                                ],
                              ),
                              const SizedBox(height: 5),
                              const Divider(color: Colors.grey),
                              const SizedBox(height: 5),
                              Row(
                                children: const [
                                  SizedBox(width: 20),
                                  Text('ตำแหน่ง', style: TextStyle(fontSize: 16)),
                                  SizedBox(width: 10),
                                  Text('นักวิชาการ', style: TextStyle(fontSize: 16)),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50),
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
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 31, 46, 148),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    'บัญชีผู้ใช้งาน',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const SizedBox(width: 20),
                                  const Text('ชื่อผู้ใช้งาน', style: TextStyle(fontSize: 16)),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      controller: _usernameController, // ใช้ controller จาก State
                                      style: const TextStyle(fontSize: 16),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'ชื่อผู้ใช้งาน',
                                      ),
                                      enabled: _editUsername, 
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        // ทำอะไรสักอย่าง
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              const Divider(color: Colors.grey),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const SizedBox(width: 20),
                                  const Text('รหัสผ่าน', style: TextStyle(fontSize: 16)),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      controller: _passwordController, // ใช้ controller จาก State
                                      style: const TextStyle(fontSize: 16),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'รหัสผ่าน',
                                      ),
                                      enabled: _editPassword,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        // ทำอะไรสักอย่าง
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              const Divider(color: Colors.grey),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const SizedBox(width: 20),
                                  const Text('อีเมล', style: TextStyle(fontSize: 16)),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      controller: _emailController, // ใช้ controller จาก State
                                      style: const TextStyle(fontSize: 16),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'อีเมล',
                                      ),
                                      enabled: _editEmail,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        // ทำอะไรสักอย่าง
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
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
