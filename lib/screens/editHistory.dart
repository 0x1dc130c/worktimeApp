import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'color_provider.dart'; // ตรวจสอบให้แน่ใจว่า path นี้ถูกต้อง

class EditHistory extends StatefulWidget {
  final void Function(Map<String, dynamic> formData) onFormSubmit;
  final VoidCallback  onCancel;
  
  EditHistory({required this.onFormSubmit, required this.onCancel});

  @override
  _EditHistoryScreenState createState() => _EditHistoryScreenState();
}

class _EditHistoryScreenState extends State<EditHistory> {
  List<DateTime> _selectedDates = [];
  File? _image;
  bool isChecked = true;
  late TextEditingController _textFieldController;

  @override
  void initState() {
    super.initState();
    if (isChecked == true) {
      _textFieldController = TextEditingController(text: "ลางานทั้งวัน");
    } else {
      _textFieldController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  void _handleCheckboxChange(bool? value) {
    setState(() {
      isChecked = value!;
      if (isChecked == true) {
        _textFieldController.text = "ลางานทั้งวัน";
      } else {
        _textFieldController.text = "";
      }
    });
  }

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
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('ประเภทการลา: '),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    flex: 2,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: 36,
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        )),
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
                      child: Text('วันที่ลา : '),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: 36,
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(5),
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
                                    .map(
                                        (date) => date.toString().split(' ')[0])
                                    .join(', '),
                          ),
                        ),
                      ),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Checkbox(
                              value: isChecked,
                              onChanged: _handleCheckboxChange),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 36,
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            controller: _textFieldController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
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
                        maxLines: null,
                        minLines: 5,
                        decoration: InputDecoration(
                          hintText: 'เขียนรายละเอียดที่นี่',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(10.0),
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
                          backgroundColor: const Color.fromARGB(255, 27, 173, 27),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                
                children : [ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 27, 173, 27),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    widget.onFormSubmit({
                      'isChecked': isChecked,
                      'reason': _textFieldController.text,
                      'dates': _selectedDates,
                      'image': _image,
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('บันทึก',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: widget.onCancel,
                  // onPressed: () {
                  //   Navigator.pop(context);
                  // },
                  child: const Text('Cancel',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                ]
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DateFormat {
  DateFormat(String s);
  
  String format(DateTime date) {
    throw UnimplementedError();
  }
}
