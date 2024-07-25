import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:worktime/screens/color_provider.dart';
import 'package:flutter/services.dart';
import 'calculate.dart';
import 'history.dart';
import 'serveice.dart';
import 'home.dart';
import 'leaveWork.dart';
import 'historyAdmin.dart';

class BottonBar extends StatefulWidget {
  const BottonBar({super.key});

  @override
  _BottonBarState createState() => _BottonBarState();
}

class _BottonBarState extends State<BottonBar> {
  int _selectedIndex = 2; // กำหนดให้เริ่มแสดงหน้า Home ตั้งแต่เริ่มต้น
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final _pageOption = [
    const LeaveWorkScreen(),
    const HistoryAdmin(),
    const Home(),  // Index 2 คือหน้า Home
    const CalculatePage(),
    const ServeicePage(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final CurvedNavigationBarState? navBarState = _bottomNavigationKey.currentState;
      navBarState?.setPage(_selectedIndex);
    });
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 233, 255),
      resizeToAvoidBottomInset: false, 
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height, // ความสูงเท่ากับหน้าจอ
            width: MediaQuery.of(context).size.width, // ความกว้างเท่ากับหน้าจอ
            color: Colors.transparent, // ให้มีสีเป็นโปร่งใส
            child: _pageOption[_selectedIndex],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CurvedNavigationBar(
              key: _bottomNavigationKey,
              backgroundColor: Colors.transparent, // ให้มีสีเป็นโปร่งใส
              color: colorProvider.color,
              animationDuration: const Duration(milliseconds: 300),
              height: 75, // ความสูงของ bottomNavigationBar
              items: [
                _buildNavigationBarItem(Icons.add, 'ลางาน', 0),
                _buildNavigationBarItem(Icons.history, 'ประวัติการลา', 1),
                _buildNavigationBarItem(Icons.home, 'หน้าหลัก', 2),
                _buildNavigationBarItem(Icons.calculate, 'คำนวนวันลา', 3),
                _buildNavigationBarItem(Icons.room_service, 'บริการ', 4),
              ],
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationBarItem(IconData icon, String label, int index) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: _selectedIndex == index
                ? const EdgeInsets.fromLTRB(6, 6, 6, 6)
                : const EdgeInsets.fromLTRB(2, 15, 2, 2),
            child: Icon(
              icon,
              color: const Color.fromRGBO(255, 255, 255, 1),
              size: _selectedIndex == index ? 37 : 30,
            ),
          ),
          _selectedIndex == index
              ? const SizedBox.shrink()
              : Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
        ],
      ),
    );
  }
}
