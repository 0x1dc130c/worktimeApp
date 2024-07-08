import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool isEditing = false;
  int editingIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('History'),
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 233, 102, 102),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 660,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 233, 102, 102),
                  ),
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return isEditing && editingIndex == index
                          ? _buildEditForm(index)
                          : _buildHistoryItem(index);
                    },
                  )
                ),
              ],
            ),
          ),
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
