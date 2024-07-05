import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:image_picker/image_picker.dart';

import 'color_provider.dart'; // ตรวจสอบให้แน่ใจว่า path นี้ถูกต้อง

class LeaveWorkScreen extends StatefulWidget {
  const LeaveWorkScreen({super.key});

  @override
  _LeaveWorkScreenState createState() => _LeaveWorkScreenState();
}

class _LeaveWorkScreenState extends State<LeaveWorkScreen> {
  List<DateTime> _selectedDates = [];
  File? _image;

  Future<void> _pickImage() async {
    final pickFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickFile != null) {
      setState(() {
        _image = File(pickFile.path);
      });
    }
  }

  Future<void> _selectDates(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 400,
            width: 300,
            child: StatefulBuilder(
              builder: (context, setState) {
                return TableCalendar(
                  focusedDay: DateTime.now(),
                  firstDay: DateTime(2000),
                  lastDay: DateTime(2100),
                  selectedDayPredicate: (day) {
                    return _selectedDates
                        .any((selectedDay) => isSameDay(selectedDay, day));
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      if (_selectedDates
                          .any((date) => isSameDay(date, selectedDay))) {
                        _selectedDates.removeWhere(
                            (date) => isSameDay(date, selectedDay));
                      } else {
                        _selectedDates.add(selectedDay);
                      }
                    });
                  },
                  calendarStyle: const CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('ตกลง'),
            ),
          ],
        );
      },
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ลางาน'),
        backgroundColor: colorProvider.color,
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              const Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: 
                      Text('ประเภทการลา: '),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: 
                      SizedBox(
                        height: 40,
                        child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),)
                      
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('ระยะเวลาที่ลา: '),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () async {
                              await _selectDates(context);
                            },
                          ),
                          hintText: _selectedDates.isEmpty
                              ? 'Select dates'
                              : _selectedDates
                                  .map((date) => date.toString().split(' ')[0])
                                  .join(', '),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              const Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('รายละเอียด: '),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                          child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines:
                            null, // อนุญาตให้ขยายความสูงตามจำนวนบรรทัดที่พิมพ์
                        minLines: 5, // ตั้งค่าความสูงขั้นต่ำ (เช่น 5 บรรทัด)
                        decoration: InputDecoration(
                          hintText: 'เขียนรายละเอียดที่นี่',
                          border:
                              OutlineInputBorder(), // เพิ่มเส้นขอบเพื่อให้เห็นขอบเขตของ TextField ชัดเจนขึ้น
                          contentPadding:
                              EdgeInsets.all(10.0), // กำหนด padding ภายใน
                        ),
                      )),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('รูปภาพ: '),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              const Color.fromARGB(255, 27, 173, 27),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: _pickImage,
                        child: const Text('เลือกรูปภาพ',
                            style: TextStyle(
                              fontSize: 18,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              _image == null
                  ? const Text('No image selected.',
                      style: TextStyle(
                        fontSize: 16,
                      ))
                  : Padding(
                      padding: const EdgeInsets.only(left: 100.0),
                      child: SizedBox(
                        height: 250,
                        width: 250,
                        child: Image(image: FileImage(_image!)),
                      ),
                    ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 27, 173, 27),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // ส่วนนี้จะเป็นการส่งข้อมูลไปยัง API
                  },
                  child: const Text('ยืนยัน',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
