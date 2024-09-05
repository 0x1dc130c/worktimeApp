import 'package:flutter/material.dart';
import 'dart:async';
import 'package:aura_box/aura_box.dart';
import 'package:pulsator/pulsator.dart';
import 'package:provider/provider.dart';
import 'color_provider.dart';
import 'bottonBar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Stream<DateTime> _clockStream;

  @override
  void initState() {
    super.initState();
    _clockStream =
        Stream<DateTime>.periodic(Duration(seconds: 1), (_) => DateTime.now());

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!mounted) return; // ตรวจสอบว่า State ยังอยู่ใน tree หรือไม่
      DateTime _now = DateTime.now();
      if (_now.hour == 16 && _now.minute == 29) {
        _changeColor('red');
      }
    });
  }

  void _changeColor(String color) {
  // เรียก Provider นอก setState
  final colorProvider = Provider.of<ColorProvider>(context, listen: false);

  setState(() {
    if (color == 'red') {
      colorProvider.changeColor(
        const Color.fromARGB(255, 244, 67, 54)
      );
      colorProvider.changeTextColor(
        const Color.fromARGB(255, 255, 255, 255),
      );
    } else if (color == 'gray') {
      colorProvider.changeColor(
        const Color.fromARGB(255, 42, 42, 42) 
      );
      colorProvider.changeTextColor(
        const Color.fromARGB(255, 255, 255, 255),
      );
    }
  });
}

  void _onButtonPressed() {
    _changeColor('gray');
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);

    return Scaffold(
      body: Container(
        child: AuraBox(
          spots: [
            AuraSpot(
              color: colorProvider.color,
              radius: 600.0,
              alignment: Alignment.center,
              blurRadius: 5.0,
              stops: const [0.0, 0.5],
            ),
            AuraSpot(
              color: colorProvider.color,
              radius: 400.0,
              alignment: Alignment.bottomRight,
              blurRadius: 30.0,
              stops: const [0.0, 0.7],
            ),
            AuraSpot(
              color: colorProvider.color,
              radius: 400.0,
              alignment: Alignment.topLeft,
              blurRadius: 30.0,
              stops: const [0.0, 0.7],
            ),
          ],
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.rectangle,
          ),
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Center(
              child: StreamBuilder<DateTime>(
                stream: _clockStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    DateTime currentTime = snapshot.data!;

                    return Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                              color: colorProvider.color,
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            child: Text(
                              '${currentTime.hour.toString().padLeft(2, '0')}:${currentTime.minute.toString().padLeft(2, '0')}:${currentTime.second.toString().padLeft(2, '0')}',
                              style: const TextStyle(
                                fontSize: 64.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                          GestureDetector(
                            onTap: _onButtonPressed,
                            child: SizedBox(
                              width: 330.0,
                              height: 330.0,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Pulsator อยู่ด้านหลัง InkWell
                                  Positioned.fill(
                                    child: SizedBox(
                                      width: 330.0,
                                      height: 330.0,
                                      child: Pulsator(
                                        style: PulseStyle(
                                          color: colorProvider.color,
                                          borderColor: const Color.fromARGB(
                                              255, 9, 58, 143),
                                          pulseCurve: Curves.easeInOut,
                                          // ปรับขนาดเริ่มต้นให้เหมาะสม
                                        ),
                                        count: 3,
                                        duration: const Duration(seconds: 5),
                                        repeat: 0,
                                        startFromScratch: false,
                                        autoStart: true,
                                        fit: PulseFit.contain,
                                      ),
                                    ),
                                  ),
                                  // InkWell อยู่ด้านหน้า Pulsator
                                  Center(
                                    child: InkResponse(
                                      onTap: _onButtonPressed,
                                      borderRadius: BorderRadius.circular(50.0),
                                      highlightShape: BoxShape
                                          .circle, // ป้องกันการเกิดกรอบสี่เหลี่ยม
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          color: colorProvider.color,
                                          shape: BoxShape.circle,
                                        ),
                                        width: 280.0,
                                        height: 280.0,
                                        child: const Center(
                                          child: Text(
                                            'Work in',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 52.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
