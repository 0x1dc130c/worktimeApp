import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool isEditing = false;
  bool isAtBottom = false;
  final ScrollController _scrollController = ScrollController();
  int editingIndex = -1;
  List<String> morth = <String>[
    'มกราคม',
    'กุมภาพันธ์',
    'มีนาคม',
    'เมษายน',
    'พฤษภาคม',
    'มิถุนายน',
    'กรกฎาคม',
    'สิงหาคม',
    'กันยายน',
    'ตุลาคม',
    'พฤศจิกายน',
    'ธันวาคม'
  ];

  String? selectedMonth;
  String displayMonth = 'มกราคม';

  @override
  void initState() {
    super.initState();
    selectedMonth = morth.first;
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool isBottom = _scrollController.position.pixels == 0;
        if (isBottom != isAtBottom) {
          setState(() {
            isAtBottom = true;
          });
        } else {
          setState(() {
            isAtBottom = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('History'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        'ประวัติการลา',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )),

                SizedBox(width: 10),
                // เพิ่ม spacing ระหว่าง Text กับ Dropdown
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(top: 5, right: 10),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: DropdownButton<String>(
                          value: selectedMonth,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedMonth = newValue!;
                              displayMonth = '$selectedMonth';
                            });
                          },
                          items: morth
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      )),
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                height: 660,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 233, 102, 102),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end, // ดันกล่องขึ้นมา
                    children: [
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 233, 102, 102),
                          ),
                          child: ListView.builder(
                            controller: _scrollController,
                            reverse: true,
                            itemCount: 10 +
                                (isAtBottom
                                    ? 1
                                    : 0), // เพิ่มช่องให้กับ SizedBox ถ้าอยู่ข้างล่าง
                            itemBuilder: (context, index) {
                              if (isAtBottom && index == 0) {
                                return SizedBox(
                                    height: 100); // เพิ่ม SizedBox ที่นี่
                              } else {
                                int adjustedIndex =
                                    isAtBottom ? index - 1 : index;
                                return isEditing &&
                                        editingIndex == adjustedIndex
                                    ? _buildEditForm(adjustedIndex)
                                    : _buildHistoryItem(adjustedIndex);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildHistoryItem(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ลากิจ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'ลาไปพักผ่อนกลับครอบครัว',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'วันที่ 1 มกราคม 2564',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      isEditing = true;
                      editingIndex = index;
                    });
                    // Add your onPressed code here!
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditForm(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'ชื่อเรื่อง',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'รายละเอียด',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'วันที่',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      isEditing = false;
                      editingIndex = -1;
                    });
                  },
                  child: Text('ยกเลิก'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isEditing = false;
                      editingIndex = -1;
                    });
                    // Add your save functionality here
                  },
                  child: Text('บันทึก'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
