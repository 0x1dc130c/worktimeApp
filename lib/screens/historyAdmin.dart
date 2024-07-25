import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'color_provider.dart';
import 'package:slidable_button/slidable_button.dart';
import 'confrimHistory.dart';
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
  SlidableButtonPosition _position = SlidableButtonPosition.start;

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ประวัติการลา'),
        backgroundColor: colorProvider.color,
      ),
      body: Visibility(
        visible: !isEditing,
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      'ประวัติการลา',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(top: 5, right: 15),
                  child: HorizontalSlidableButton(
                    buttonWidth: 150,
                    color: Color.fromARGB(255, 24, 59, 197),
                    buttonColor: Color.fromARGB(255, 24, 59, 197),
                    dismissible: false,
                    
                    onChanged: (SlidableButtonPosition value) {
                      setState(() {
                        _position = value;
                      });
                    },
                    label: Center(
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 5, right: 12, left: 12, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'อนุมัติแล้ว',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'ยังไม่อนุมัติ',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                        child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 233, 102, 102),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListView.builder(
                        controller: _scrollController,
                        reverse: true,
                        itemCount: 10 + (isAtBottom ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (isAtBottom && index == 0) {
                            return SizedBox(height: 100);
                          } else {
                            int adjustedIndex = isAtBottom ? index - 1 : index;
                            return isEditing && editingIndex == adjustedIndex
                                ? _buildEditForm(adjustedIndex)
                                : _buildHistoryItem(adjustedIndex);
                          }
                        },
                      ),
                    ))
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
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
            const Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.all(10.0),
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
    return ConfrimHistoryAdmin(
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
