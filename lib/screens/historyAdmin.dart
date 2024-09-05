import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'color_provider.dart';
import 'confrimHistory.dart';
import 'package:get/get.dart';
import 'package:worktime/repository/history_repository/historyU.dart';
import 'editHistory.dart';

class HistoryAdmin extends StatefulWidget {
  const HistoryAdmin({super.key});

  @override
  _HistoryAdminState createState() => _HistoryAdminState();
}

class _HistoryAdminState extends State<HistoryAdmin> {
  bool isEditing = false;
  bool isAtBottom = false;
  int editingIndex = -1;
  final ScrollController _scrollController = ScrollController();
  bool _isApproved = false; // ใช้สำหรับ Switch
  List? _info;

  @override
  void initState() {
    super.initState();
    Get.lazyPut<infoHistory_User>(() => infoHistory_User());

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final infoleaveworker = await infoHistory_User.instance.createLeaveWorker();
      setState(() {
        _info = infoleaveworker;
      });
    });

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool isBottom = _scrollController.position.pixels == 0;
        if (isBottom != isAtBottom) {
          setState(() {
            isAtBottom = !isBottom;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    var _leaveData = _info?.length;

    if (_info == null) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('ประวัติการลา',
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
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      'ประวัติการลา',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 5, right: 15, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _isApproved ? 'อนุมัติแล้ว' : 'ยังไม่อนุมัติ',
                          style: TextStyle(color: Colors.white),
                        ),
                        Switch(
                          value: _isApproved,
                          onChanged: (value) {
                            setState(() {
                              _isApproved = value;
                            });
                          },
                          activeColor: Colors.green,
                          inactiveThumbColor: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _leaveData! + 1,
                  itemBuilder: (context, index) {
                    if (index == _leaveData) {
                      return const SizedBox(height: 100);
                    } else {
                      int adjustedIndex = _leaveData - index - 1;
                      return isEditing && editingIndex == adjustedIndex
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
          color: Colors.white,
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
