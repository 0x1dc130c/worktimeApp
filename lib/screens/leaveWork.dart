import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:image_picker/image_picker.dart';
import 'color_provider.dart'; // ตรวจสอบให้แน่ใจว่า path นี้ถูกต้อง
import 'package:worktime/features/models/infoleaveWorker.dart';
import 'package:worktime/repository/user_repository/leaveWorker_model.dart';
import 'package:firebase_storage/firebase_storage.dart'; // ตรวจสอบให้แน่ใจว่า path นี้ถูกต้อง
import 'package:path/path.dart' as path;
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;


class LeaveWorkScreen extends StatefulWidget {
  const LeaveWorkScreen({super.key});

  @override
  _LeaveWorkScreenState createState() => _LeaveWorkScreenState();
}

class _LeaveWorkScreenState extends State<LeaveWorkScreen> {
  List<DateTime> _selectedDates = [];
  String? _selectleaveType;
  String? _selectDateLeave;
  String? _selectLeavePeriod;
  final TextEditingController _selectInfoMore = TextEditingController();

  File? _image;
  bool _imageSelected = false;
  bool _disabled = false;
  bool isChecked = true;
  bool _readOnly = true;
  FocusNode _focusNode = FocusNode();
  late TextEditingController _textFieldController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Get.put(LeaveWorkerRepository());
    if (isChecked == true) {
      _textFieldController = TextEditingController(text: "ลางานทั้งวัน");
    } else {
      _textFieldController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleCheckboxChange(bool? value) {
    setState(() {
      isChecked = value!;
      if (isChecked == true) {
        _textFieldController.text = "ลางานทั้งวัน";
        _readOnly = true;
      } else {
        _textFieldController.text = "";
        _readOnly = false;
      }
    });
  }

  Future<void> _pickImage() async {
    final pickFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickFile != null) {
      setState(() {
        _image = File(pickFile.path);
        _imageSelected = true;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _animateScroll();
      });
    }
  }

  Future<void> _cancel() async {
    setState(() {
      _image = null;
      _imageSelected = false;
      _selectDateLeave = null;
      _selectleaveType = null;
      _selectLeavePeriod = null;
      _selectInfoMore.clear();
    });
  }

  Future<void> _confirm() async {
    Map<String, bool> fields = {
      'ประเภทการลา': _selectleaveType == null,
      'วันที่ลา': _selectedDates.isEmpty,
      'ระยะเวลาที่ลา': _selectLeavePeriod == null,
      'รายละเอียด': _selectInfoMore.text.isEmpty,
      // 'รูปภาพ': _image == null,
    };

    List<String> missingFields = fields.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    if (missingFields.isNotEmpty) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('กรุณากรอกข้อมูลให้ครบถ้วน'),
            content: Text('กรุณากรอกข้อมูลในส่วน: ${missingFields.join(', ')}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('ตกลง'),
              ),
            ],
          );
        },
      );
    }

    try {
      String? fileName;
      String? _url_image;
      if (_image == null) {
        _url_image = 'No image selected.';
      } else {
        fileName = _image?.path != null ? path.basename(_image!.path) : null;
        if (fileName == null) {
          throw Exception("File name is null");
        }
        final metadata = SettableMetadata(contentType: "image/jpeg");
        Reference storageReference =
            FirebaseStorage.instance.ref().child('uploads/$fileName');

        UploadTask uploadTask = storageReference.putFile(_image!, metadata);
        uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
          switch (taskSnapshot.state) {
            case TaskState.running:
              final progress = 100.0 *
                  (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
              print("Upload is $progress% complete.");
              break;
            case TaskState.paused:
              print("Upload is paused.");
              break;
            case TaskState.canceled:
              print("Upload was canceled");
              break;
            case TaskState.success:
              print("Upload completed successfully.");
              break;
            default:
              print("Unknown state");
          }
        });
        await uploadTask;

        _url_image = await storageReference.getDownloadURL();
      }

      Timestamp timestamp = Timestamp.now();
      DateTime date = timestamp.toDate();
      String formattedTime = formatTime(date);
      String formattedDate = formatDate(date);
      
      final infoleaveworker = Infoleaveworker(
        leaveType: _selectleaveType!,
        dateLeave: _selectedDates.toString(),
        leavePeriod: _selectLeavePeriod!,
        infomore: _selectInfoMore.text,
        image: _url_image,
        timestamp: formattedTime,
        date: formattedDate,
        status: 'รอการอนุมัติ',
      );

      LeaveWorkerRepository.instance.createLeaveWorker(infoleaveworker);

      setState(() {
        _image = null;
        _imageSelected = false;
        _selectDateLeave = null;
        _selectleaveType = null;
        _selectLeavePeriod = null;
        _selectInfoMore.clear(); // ล้างข้อมูลใน TextField
        _selectedDates = [];
        // Reset Dropdown
        _textFieldController.clear();
        isChecked = true;
        _readOnly = true;
        _textFieldController.text = "ลางานทั้งวัน";
        _focusNode.unfocus(); // รีเซ็ตข้อความใน TextField
      });
      
      return showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).pop(true);
          });;
          return AlertDialog(
            title: const Text('สำเร็จ'),
            content: const Text('บันทึกข้อมูลเรียบร้อยแล้ว'),
            
          );
        },
      );

    } catch (e, stackTrace) {
      print('Error during upload: $e');
      print('Stack Trace: $stackTrace');
    }
  }

  String formatTime(DateTime dateTime) {
      final intl.DateFormat formatter = intl.DateFormat('HH:mm:ss');
      return formatter.format(dateTime);
  }

  String formatDate(DateTime dateTime) {
      final intl.DateFormat formatter = intl.DateFormat('yyyy-MM-dd');
      return formatter.format(dateTime);
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
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
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
                  weekNumbersVisible: false,
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

  void _animateScroll() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ลางาน', 
        style: TextStyle(fontSize: 24, color: colorProvider.textcolor)),
        backgroundColor: colorProvider.color,
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        // decoration: BoxDecoration(color: Color.fromARGB(255, 255, 0, 0)),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            // decoration: BoxDecoration(color: Color.fromARGB(255, 228, 228, 228)),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('ประเภทการลา : '),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      flex: 2,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: 36,
                            child: DropdownButtonFormField<String>(
                              value: _selectleaveType,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(5),
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectleaveType =
                                      newValue; // เก็บค่าที่เลือกไว้ในตัวแปร
                                });
                              },
                              items: [
                                DropdownMenuItem(
                                  value: 'ลาป่วย',
                                  child: Text('ลาป่วย'),
                                ),
                                DropdownMenuItem(
                                  value: 'ลากิจ',
                                  child: Text('ลากิจ'),
                                ),
                                DropdownMenuItem(
                                  value: 'ลาพักร้อน',
                                  child: Text('ลาพักร้อน'),
                                ),
                              ],
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
                        alignment: Alignment.centerRight,
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
                        alignment: Alignment.centerRight,
                        child: Text('ระยะเวลาที่ลา : '),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start, // จัดชิดซ้าย
                        children: [
                          Expanded(
                            child: Container(
                              height: 36,
                              child: DropdownButtonFormField<String>(
                                value: _selectLeavePeriod != null
                                    ? 'ลางานทั้งวัน'
                                    : null, // ค่าเริ่มต้นของ Dropdown
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectLeavePeriod = newValue;
                                    _textFieldController.text = newValue!;
                                    _readOnly =
                                        isChecked; // คงค่า _readOnly ตามสถานะ isChecked
                                  });
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5),
                                  border: OutlineInputBorder(),
                                ),
        
                                items: [
                                  DropdownMenuItem(
                                    value: 'ลางานทั้งวัน',
                                    child: Text('ลางานทั้งวัน'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'ลางานครึ่งวันเช้า',
                                    child: Text('ลางานครึ่งวันเช้า'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'ลางานครึ่งวันบ่าย',
                                    child: Text('ลางานครึ่งวันบ่าย'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('รายละเอียด : '),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                            child: TextField(
                          focusNode: _focusNode,
                          controller: _selectInfoMore,
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
                        alignment: Alignment.centerRight,
                        child: Text('รูปภาพ : '),
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
                          onPressed: () {
                            _pickImage();
                          },
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
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      contentPadding: EdgeInsets.zero,
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.file(
                                            _image!,
                                            fit: BoxFit.cover,
                                          ),
                                          // TextButton(
                                          //   onPressed: () {
                                          //     Navigator.of(context)
                                          //         .pop(); // ปิด popup
                                          //   },
                                          //   child: const Text("Close"),
                                          // ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: SizedBox(
                                height: 300,
                                width: 300,
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit
                                      .cover, // ปรับภาพให้พอดีกับขนาดที่กำหนด
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 4.0, right: 2.0),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.cancel_outlined,
                                    color: Color.fromARGB(255, 125, 125, 125),
                                    size: 36,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _image = null; // ลบรูปภาพเมื่อกดปุ่ม Cancel
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                const SizedBox(height: 36.0),
                _image != null
                    ? Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor:
                                      Color.fromARGB(255, 234, 135, 23),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  _cancel();
                                },
                                child: const Text('ยกเลิก',
                                    style: TextStyle(
                                      fontSize: 18,
                                    )),
                              ),
                              SizedBox(width: 16.0),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor:
                                      const Color.fromARGB(255, 27, 173, 27),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  _confirm();
                                  // ส่วนนี้จะเป็นการส่งข้อมูลไปยัง API
                                },
                                child: const Text('ยืนยัน',
                                    style: TextStyle(
                                      fontSize: 18,
                                    )),
                              ),
                            ]),
                      )
                    : Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor:
                                const Color.fromARGB(255, 27, 173, 27),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            _confirm();
                            // ส่วนนี้จะเป็นการส่งข้อมูลไปยัง API
                          },
                          child: const Text('ยืนยัน',
                              style: TextStyle(
                                fontSize: 18,
                              )),
                        ),
                      ),
                _imageSelected == true
                    ? const SizedBox(height: 150.0)
                    : const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
