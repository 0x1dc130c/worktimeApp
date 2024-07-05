// Scaffold(
//       body: Center(
//         child: StreamBuilder<DateTime>(
//           stream: _clockStream,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               DateTime currentTime = snapshot.data!;
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(24.0),
//                     decoration: BoxDecoration(
//                       color: Colors.green,
//                       borderRadius: BorderRadius.circular(100.0),
//                     ),
//                     child: Text(
//                       '${currentTime.hour.toString().padLeft(2, '0')}:${currentTime.minute.toString().padLeft(2, '0')}:${currentTime.second.toString().padLeft(2, '0')}',
//                       style: const TextStyle(
//                         fontSize: 64.0,
//                         color: Colors.white
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 50.0,
//                   ),
//                   SizedBox(
//                     width: 350.0,
//                     height: 350.0,
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         Pulsator(
//                           style: PulseStyle(
//                             color: Colors.green,
//                             borderColor: Color.fromARGB(255, 2, 83, 5),
//                             pulseCurve: Curves.easeInOut,
//                           ),
//                           count: 4,
//                           duration: Duration(seconds: 5),
//                           repeat: 0,
//                           startFromScratch: false,
//                           autoStart: true,
//                           fit: PulseFit.contain,
//                         ),
//                         InkWell(
//                           onTap: _onButtonPressed,
//                           borderRadius: BorderRadius.circular(50.0),
//                           child: Ink(
//                             decoration: BoxDecoration(
//                               color: Colors.green,
//                               shape: BoxShape.circle,
//                             ),
//                             width: 300.0,
//                             height: 300.0,
//                             child: Center(
//                               child: Text(
//                                 'Work in',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 34.0,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),//
//                 ],
//               );
//             } else {
//               return CircularProgressIndicator();
//             }
//           },
//         ),
//       ),
//     );

// Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Color.fromARGB(150, 170, 255, 210),
//                   Color.fromARGB(90, 5, 166, 91)
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),
//           Center(
//             child: StreamBuilder<DateTime>(
//               stream: _clockStream,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   DateTime currentTime = snapshot.data!;
//                   return Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(24.0),
//                         decoration: BoxDecoration(
//                           color: Colors.green,
//                           borderRadius: BorderRadius.circular(100.0),
//                         ),
//                         child: Text(
//                           '${currentTime.hour.toString().padLeft(2, '0')}:${currentTime.minute.toString().padLeft(2, '0')}:${currentTime.second.toString().padLeft(2, '0')}',
//                           style: const TextStyle(
//                             fontSize: 64.0,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 50.0,
//                       ),
//                       SizedBox(
//                         width: 350.0,
//                         height: 350.0,
//                         child: Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             Pulsator(
//                               style: PulseStyle(
//                                 color: Colors.green,
//                                 borderColor: Colors.green,
//                                 pulseCurve: Curves.easeInOut,
//                               ),
//                               count: 4,
//                               duration: Duration(seconds: 5),
//                               repeat: 0,
//                               startFromScratch: false,
//                               autoStart: true,
//                               fit: PulseFit.contain,
//                             ),
//                             InkWell(
//                               onTap: _onButtonPressed,
//                               borderRadius: BorderRadius.circular(50.0),
//                               child: Ink(
//                                 decoration: BoxDecoration(
//                                   color: Colors.green,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 width: 300.0,
//                                 height: 300.0,
//                                 child: Center(
//                                   child: Text(
//                                     'Work in',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 34.0,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ), //
//                     ],
//                   );
//                 } else {
//                   return CircularProgressIndicator();
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: StreamBuilder<DateTime>(
//           stream: _clockStream,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               DateTime currentTime = snapshot.data!;
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(24.0),
//                     decoration: BoxDecoration(
//                       color: Colors.green,
//                       borderRadius: BorderRadius.circular(100.0),
//                     ),
//                     child: Text(
//                       '${currentTime.hour.toString().padLeft(2, '0')}:${currentTime.minute.toString().padLeft(2, '0')}:${currentTime.second.toString().padLeft(2, '0')}',
//                       style:
//                           const TextStyle(fontSize: 64.0, color: Colors.white),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 50.0,
//                   ),
//                   SizedBox(
//                     width: 350.0,
//                     height: 350.0,
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         Pulsator(
//                           style: PulseStyle(
//                             color: Colors.green,
//                             borderColor: Color.fromARGB(255, 2, 83, 5),
//                             pulseCurve: Curves.easeInOut,
//                           ),
//                           count: 4,
//                           duration: Duration(seconds: 5),
//                           repeat: 0,
//                           startFromScratch: false,
//                           autoStart: true,
//                           fit: PulseFit.contain,
//                         ),
//                         InkWell(
//                           onTap: _onButtonPressed,
//                           borderRadius: BorderRadius.circular(50.0),
//                           child: Ink(
//                             decoration: BoxDecoration(
//                               color: Colors.green,
//                               shape: BoxShape.circle,
//                             ),
//                             width: 300.0,
//                             height: 300.0,
//                             child: Center(
//                               child: Text(
//                                 'Work in',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 34.0,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ), //
//                 ],
//               );
//             } else {
//               return CircularProgressIndicator();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
//-------------------------------------------------------------------------------
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:aura_box/aura_box.dart';
// import 'package:pulsator/pulsator.dart';
// import 'bottonbar.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   late Stream<DateTime> _clockStream;
//   Color _containerColor = const Color.fromARGB(255, 56, 82, 230);

//   @override
//   void initState() {
//     super.initState();
//     _clockStream = Stream<DateTime>.periodic(Duration(seconds: 1), (_) => DateTime.now());

//     Timer.periodic(Duration(seconds: 1), (timer) {
//       DateTime _now = DateTime.now();
//       if (_now.hour == 14 && _now.minute == 43) {
//         _changeColor('red');
//       } else {
//         _changeColor('gray');
//       }
//     });
//   }

//   void _changeColor(color_) {
//     setState(() {
//       // _containerColor =
//       //     _containerColor == const Color.fromARGB(255, 56, 82, 230)
//       //         ? const Color.fromARGB(255, 244, 67, 54)
//       //         : const Color.fromARGB(94, 105, 105, 105);
//       if (color_ == 'red') {
//         _containerColor = const Color.fromARGB(255, 244, 67, 54);
//         BottonBar(initailColor : _containerColor);
//       }else if (color_ == 'gray') {
//         _containerColor = const Color.fromARGB(94, 42, 42, 42);
//       }
//     });
//   }

//   void _onButtonPressed() {
//     var color = 'gray';
//     _changeColor(color);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: AuraBox(
//           spots: [
//             AuraSpot(
//               color: _containerColor,
//               radius: 600.0,
//               alignment: Alignment.center,
//               blurRadius: 5.0,
//               stops: const [0.0, 0.5],
//             ),
//             AuraSpot(
//               color: _containerColor,
//               radius: 400.0,
//               alignment: Alignment.bottomRight,
//               blurRadius: 30.0,
//               stops: const [0.0, 0.7],
//             ),
//             AuraSpot(
//               color: _containerColor,
//               radius: 400.0,
//               alignment: Alignment.topLeft,
//               blurRadius: 30.0,
//               stops: const [0.0, 0.7],
//             ),
//           ],
//           decoration: BoxDecoration(
//             color: Colors.transparent,
//             shape: BoxShape.rectangle,
//           ),
//           child: SizedBox(
//             height: double.infinity,
//             width: double.infinity,
//             child: Center(
//               child: StreamBuilder<DateTime>(
//                 stream: _clockStream,
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     DateTime currentTime = snapshot.data!;
//                     return Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(24.0),
//                           decoration: BoxDecoration(
//                             color: _containerColor,
//                             borderRadius: BorderRadius.circular(100.0),
//                           ),
//                           child: Text(
//                             '${currentTime.hour.toString().padLeft(2, '0')}:${currentTime.minute.toString().padLeft(2, '0')}:${currentTime.second.toString().padLeft(2, '0')}',
//                             style: const TextStyle(
//                               fontSize: 64.0,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 50.0,
//                         ),
//                         GestureDetector(
//                           onTap: _onButtonPressed,
//                           child: SizedBox(
//                             width: 330.0,
//                             height: 330.0,
//                             child: Stack(
//                               alignment: Alignment.center,
//                               children: [
//                                 // Pulsator อยู่ด้านหลัง InkWell
//                                 Positioned.fill(
//                                   child: SizedBox(
//                                     width: 330.0,
//                                     height: 330.0,
//                                     child: Pulsator(
//                                       style: PulseStyle(
//                                         color: _containerColor,
//                                         borderColor:
//                                             const Color.fromARGB(255, 9, 58, 143),
//                                         pulseCurve: Curves.easeInOut,
//                                         // ปรับขนาดเริ่มต้นให้เหมาะสม
//                                       ),
//                                       count: 3,
//                                       duration: const Duration(seconds: 5),
//                                       repeat: 0,
//                                       startFromScratch: false,
//                                       autoStart: true,
//                                       fit: PulseFit.contain,
//                                     ),
//                                   ),
//                                 ),
//                                 // InkWell อยู่ด้านหน้า Pulsator
//                                 Center(
//                                   child: InkResponse(
//                                     onTap: _onButtonPressed,
//                                     borderRadius: BorderRadius.circular(50.0),
//                                     highlightShape: BoxShape
//                                         .circle, // ป้องกันการเกิดกรอบสี่เหลี่ยม
//                                     child: Ink(
//                                       decoration: BoxDecoration(
//                                         color: _containerColor,
//                                         shape: BoxShape.circle,
//                                       ),
//                                       width: 280.0,
//                                       height: 280.0,
//                                       child: const Center(
//                                         child: Text(
//                                           'Work in',
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 52.0,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   } else {
//                     return const CircularProgressIndicator();
//                   }
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//-----------------------------------------------------------------------------------------------
// import 'package:flutter/material.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'calculate.dart';
// import 'history.dart';
// import 'serveice.dart';
// import 'home.dart';
// import 'leaveWork.dart';

// class BottonBar extends StatefulWidget {
//   final Color initailColor;
//   const BottonBar({super.key, required this.initailColor});

//   @override
//   _BottonBarState createState() => _BottonBarState();
// }

// class _BottonBarState extends State<BottonBar> {
//   int _selectedIndex = 2; // กำหนดให้เริ่มแสดงหน้า Home ตั้งแต่เริ่มต้น
//   // Color cColorBtmB = Home._containerColor;
//   GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

//   final _pageOption = [
//     const ServeicePage(),
//     const HistoryPage(),
//     const Home(),  // Index 2 คือหน้า Home
//     const LeaveWorkScreen(),
//     const CalculatePage(),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final CurvedNavigationBarState? navBarState = _bottomNavigationKey.currentState;
//       navBarState?.setPage(_selectedIndex);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 225, 233, 255),
//       body: _pageOption[_selectedIndex],
//       bottomNavigationBar: CurvedNavigationBar(
//         key: _bottomNavigationKey,
//         backgroundColor: const Color.fromARGB(255, 225, 233, 255),
//         color: const Color.fromARGB(255, 56, 82, 230),
//         animationDuration: const Duration(milliseconds: 300),
//         height: 75, // เพิ่มความสูง
//         items: [
//           _buildNavigationBarItem(Icons.add, 'ลางาน', 0),
//           _buildNavigationBarItem(Icons.history, 'ประวัติการลา', 1),
//           _buildNavigationBarItem(Icons.home, 'หน้าหลัก', 2),
//           _buildNavigationBarItem(Icons.calculate, 'คำนวนวันลา', 3),
//           _buildNavigationBarItem(Icons.room_service, 'บริการ', 4),
//         ],
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//       ),
//     );
//   }

//   Widget _buildNavigationBarItem(IconData icon, String label, int index) {
//     return Container(
//       margin: const EdgeInsets.all(4),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             margin: _selectedIndex == index
//                 ? const EdgeInsets.fromLTRB(6, 6, 6, 6)
//                 : const EdgeInsets.fromLTRB(2, 15, 2, 2),
//             child: Icon(
//               icon,
//               color: const Color.fromRGBO(255, 255, 255, 1),
//               size: _selectedIndex == index ? 37 : 30,
//             ),
//           ),
//           _selectedIndex == index
//               ? const SizedBox.shrink()
//               : Text(
//                   label,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//                   ),
//                 ),
//         ],
//       ),
//     );
//   }
// }
