import 'dart:async';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:worktime/screens/color_provider.dart';
import 'calculate.dart';
import 'history.dart';
import 'serveice.dart';
import 'home.dart';
import 'leaveWork.dart';
import 'historyAdmin.dart';
import 'package:shared_preferences/shared_preferences.dart'; 

class BottonBar extends StatefulWidget {
  const BottonBar({super.key});

  @override
  _BottonBarState createState() => _BottonBarState();
}

class _BottonBarState extends State<BottonBar> {
  int _selectedIndex = 2; // กำหนดให้เริ่มแสดงหน้า Home ตั้งแต่เริ่มต้น
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  Timer? _timer;
  String? _roles;
  List _pageOption = [];

  @override
  Future<void> setState(VoidCallback fn) async {
    super.setState(fn);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('--------->>>> ${prefs.getString('username')}');
    print('--------->>>> ${prefs.getString('roles')}');
    _roles = prefs.getString('roles');
    _rolesCheck(); // เรียกใช้ _rolesCheck หลังจากได้รับค่า _roles
  }

  _rolesCheck() {
    if (_roles == 'admin') {
      _pageOption = [
        const LeaveWorkScreen(),
        const HistoryAdmin(),
        const Home(),  // Index 2 คือหน้า Home
        const CalculatePage(),
        const ServeicePage(),
      ];
    } else {
      _pageOption = [
        const LeaveWorkScreen(),
        const HistoryPage(),  // Index 1 คือหน้า History
        const Home(),  // Index 2 คือหน้า Home
        const CalculatePage(),
        const ServeicePage(),
      ];
    }
  }
  

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final CurvedNavigationBarState? navBarState = _bottomNavigationKey.currentState;
      navBarState?.setPage(_selectedIndex);
    });

    // ซ่อน Status Bar และ Navigation Bar หลังจาก 2 วินาที
    _timer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _rolesCheck();
    });
    final colorProvider = Provider.of<ColorProvider>(context);
    return GestureDetector(
      onDoubleTap: () {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
        ]);
        if (_timer != null) {
          _timer!.cancel();
        }
      },
      child: Scaffold(
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
