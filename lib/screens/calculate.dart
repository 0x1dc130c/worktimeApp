import 'package:flutter/material.dart';

class CalculatePage extends StatelessWidget {
  const CalculatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('จำนวนวันลาที่เหลือ'),
      ),
      body: Container(
        padding: EdgeInsets.all(50),
        color: Color.fromARGB(255, 223, 136, 136),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 10, top: 10, left: 20, right: 20),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 24, 59, 197),
                borderRadius: BorderRadius.circular(30),
              ),
              child:  Text('ลาป่วย', style: TextStyle(fontSize: 16, color: Colors.white),),
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.only(bottom: 10, top: 10, left: 20, right: 20),
              decoration : BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 113, 11, 11).withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text('-2/3', style: TextStyle(fontSize: 40,),),
            ),
            SizedBox(height: 20,),

            Container(
              padding: EdgeInsets.only(bottom: 10, top: 10, left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color.fromARGB(255, 24, 59, 197),
              ),
              
              child:
            Text('ลากิจ', style: TextStyle(fontSize: 16, color : Colors.white),),),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.only(bottom: 10, top: 10, left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 113, 13, 11).withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],

              ),
              child: Text('-8/5', style: TextStyle(fontSize: 40,),),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.only(bottom: 10, top: 10, left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color.fromARGB(255, 24, 59, 197),
              ),
              child:
            Text('ลาพักร้อน', style: TextStyle(fontSize: 16, color : Colors.white),),),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.only(bottom: 5, top: 5, left: 30, right: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 11, 113, 11).withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              
              ),
              child: Text('1/14', style: TextStyle(fontSize: 40,),),
            ),
          ],
        ),
      ),
    );
  }
}