import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'editHistory.dart';
import 'package:provider/provider.dart';
import 'color_provider.dart';
import 'package:worktime/repository/history_repository/historyU.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

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
  List? _info;

  @override
  void initState() {
    super.initState();
    selectedMonth = morth.first;
    Get.lazyPut<infoHistory_User>(() => infoHistory_User());

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final infoleaveworker =
          await infoHistory_User.instance.createLeaveWorker();
      setState(() {
        _info = infoleaveworker;
      });
    });

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

  String formatTime(DateTime dateTime) {
    final intl.DateFormat formatter = intl.DateFormat('HH:mm:ss');
    return formatter.format(dateTime);
  }

  String formatDate(DateTime dateTime) {
    final intl.DateFormat formatter = intl.DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    var _leaveData = _info?.length;

    if (_info == null) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('History',
              style: TextStyle(fontSize: 24, color: colorProvider.textcolor)),
          backgroundColor: colorProvider.color,
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ประวัติการลา',
            style: TextStyle(fontSize: 24, color: colorProvider.textcolor)),
        backgroundColor: colorProvider.color,
      ),
      body: Visibility(
        visible: !isEditing,
        replacement: EditHistory(
          onFormSubmit: (formData) {
            setState(() {
              isEditing = false;
              editingIndex = -1;
            });
          },
          onCancel: () {
            setState(() {
              isEditing = false;
              editingIndex = -1;
            });
          },
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 220, 220, 220),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        'ประวัติการลาขเดือน',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
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
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width,
                  height: 660,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListView.builder(
                              controller: _scrollController,
                              itemCount: _leaveData! + 1,
                              itemBuilder: (context, index) {
                                if (index == _leaveData) {
                                  return const SizedBox(height: 100);
                                } else {
                                  int adjustedIndex = _leaveData - index - 1;

                                  return isEditing &&
                                          editingIndex == adjustedIndex
                                      ? _buildEditForm(adjustedIndex)
                                      : _buildHistoryItem(adjustedIndex);
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryItem(int index) {
    var leaveData = _info![index].data();
    final colorProvider = Provider.of<ColorProvider>(context);
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 255, 255, 255),
          border: Border.all(
            color: colorProvider.color, // Border color
            width: 2.0, // Border width
          ),
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
                      leaveData['LeaveType'] ?? 'ไม่ระบุประเภทการลา',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      leaveData['LeavePeriod'] ?? 'ไม่ระบุเหตุผล',
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      leaveData['Date'] ?? 'ไม่ระบุวันที่',
                      style: const TextStyle(fontSize: 15),
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
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      isEditing = true;
                      editingIndex = index;
                    });
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
    return EditHistory(
      onFormSubmit: (formData) {
        setState(() {
          isEditing = false;
          editingIndex = -1;
        });
      },
      onCancel: () {
        setState(() {
          isEditing = false;
          editingIndex = -1;
        });
      },
    );
  }
}
