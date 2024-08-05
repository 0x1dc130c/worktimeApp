import 'package:flutter/material.dart';
import 'setting.dart';
import 'login.dart';
import 'calendar.dart';

class ServeicePage extends StatefulWidget {
  const ServeicePage({Key? key}) : super(key: key);

  @override
  _ServeicePageState createState() => _ServeicePageState();
}

class _ServeicePageState extends State<ServeicePage> {
  bool nextPage = false;
  Widget? selectedPage;

  void _navigateToPage(Widget page) {
    if (page is! Login) { // Check if the page is not Login page
      setState(() {
        nextPage = true;
        selectedPage = page;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Serveice Page'),
      ),
      body: nextPage
          ? selectedPage
          : Container(
              width: double.infinity,
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 188, 55, 240)),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  ExpandableButton(
                    icon: Icons.settings,
                    text: 'ตั้งค่าบัญชีผู้ใช้งาน',
                    path: SettingAccount(),
                    onNavigate: _navigateToPage,
                  ),
                  const SizedBox(height: 10),
                  ExpandableButton(
                    icon: Icons.logout,
                    text: 'ปฎิทินวันหยุดของบริษัท',
                    path: CalendarPage(),
                    onNavigate: _navigateToPage,
                  ),
                  const SizedBox(height: 10),
                  ExpandableButton(
                    icon: Icons.exit_to_app,
                    text: 'ออกจากระบบ',
                    path: Login(),
                    onNavigate: (page) {
                      // Directly navigate to Login page without updating nextPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => page),
                      );
                    },
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
  final Widget? path;
  final Function(Widget) onNavigate;

  const ExpandableButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.path,
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

  void _navigateToPage() {
    if (widget.path != null) {
      widget.onNavigate(widget.path!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navigateToPage,
      onTapDown: (_) => _increaseSize(),
      onTapUp: (_) => _decreaseSize(),
      onTapCancel: () => _decreaseSize(),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.blue,
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
