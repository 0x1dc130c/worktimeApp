import 'package:flutter/material.dart';
import 'color_provider.dart';
import 'setting.dart';
import 'login.dart';
import 'calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';


class ServeicePage extends StatefulWidget {
  const ServeicePage({Key? key}) : super(key: key);

  @override
  _ServeicePageState createState() => _ServeicePageState();
}

class _ServeicePageState extends State<ServeicePage> {
  bool nextPage = false;
  Widget? selectedPage;

  void _navigateToPage(Widget page) {
    setState(() {
      nextPage = true;
      selectedPage = page;
    });
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('บริการ',
        style: TextStyle(fontSize: 24, color: colorProvider.textcolor)),
        backgroundColor: colorProvider.color,
        ),
      body: nextPage
          ? selectedPage
          : Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Color.fromARGB(255, 228, 228, 228)),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  ExpandableButton(
                    icon: Icons.settings,
                    text: 'ตั้งค่าบัญชีผู้ใช้งาน',
                    onNavigate: () => _navigateToPage(SettingAccount()),
                  ),
                  const SizedBox(height: 10),
                  ExpandableButton(
                    icon: Icons.calendar_today,
                    text: 'ปฎิทินวันหยุดของบริษัท',
                    onNavigate: () => _navigateToPage(CalendarPage()),
                  ),
                  const SizedBox(height: 10),
                  ExpandableButton(
                    icon: Icons.exit_to_app,
                    text: 'ออกจากระบบ',
                    onNavigate: _logout,
                  ),
                ],
              ),
            ),
    );
  }
}

class ExpandableButton extends StatefulWidget {
  final IconData icon;
  final String text;
  final VoidCallback onNavigate;

  const ExpandableButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onNavigate,
  }) : super(key: key);

  @override
  _ExpandableButtonState createState() => _ExpandableButtonState();
}

class _ExpandableButtonState extends State<ExpandableButton> {
  double _width = 300;
  double _height = 50;

  void _increaseSize() {
    setState(() {
      _width = 250;
      _height = 75;
    });
  }

  void _decreaseSize() {
    setState(() {
      _width = 200;
      _height = 50;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context); // Add this line to create an instance of ColorProvider
    return GestureDetector(
      onTap: widget.onNavigate,
      onTapDown: (_) => _increaseSize(),
      onTapUp: (_) => _decreaseSize(),
      onTapCancel: () => _decreaseSize(),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: colorProvider.color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5, right: 15, left: 15),
                child: Icon(
                  widget.icon,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 13, bottom: 13, right: 15),
                child: Text(
                  widget.text,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}