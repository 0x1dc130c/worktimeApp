import 'package:flutter/material.dart';

class ServeicePage extends StatefulWidget {
  const ServeicePage({Key? key}) : super(key: key);

  @override
  _ServeicePageState createState() => _ServeicePageState();
}

class _ServeicePageState extends State<ServeicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Serveice Page'),
      ),
      body: Container(
        width: double.infinity,
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 188, 55, 240)),
        child: Column(
          children: const [
            SizedBox(height: 10),
            ExpandableButton(
              icon: Icons.settings,
              text: 'ตั้งค่าบัญชีผู้ใช้งาน',
            ),
            SizedBox(height: 10),
            ExpandableButton(
              icon: Icons.logout,
              text: 'ปฎิทินวันหยุดของบริษัท',
            ),
            SizedBox(height: 10),
            ExpandableButton(
              icon: Icons.exit_to_app,
              text: 'ออกจากระบบ',
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

  const ExpandableButton({
    Key? key,
    required this.icon,
    required this.text,
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
    return GestureDetector(
      onTapDown: (_) => _increaseSize(),
      onTapUp: (_) => _decreaseSize(),
      onTapCancel: () => _decreaseSize(),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
      child:
      Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5, right: 15, left: 15),
              child: Icon(
                widget.icon,
                size: 30,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 13, bottom: 13, right: 15),
              child: Text(
                widget.text,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    ),
    onTap: () {
      print(' Click =' + widget.text);
    },);
  }
}
