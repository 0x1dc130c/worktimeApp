import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'color_provider.dart';

class ConfrimHistoryAdmin extends StatefulWidget {
  const ConfrimHistoryAdmin({super.key, required this.onFormSubmit, required this.onCancel});
  final void Function(Map<String, dynamic> formData) onFormSubmit;
  final void Function() onCancel;
  @override
  _HistoryAdminState createState() => _HistoryAdminState();

}

class _HistoryAdminState extends State<ConfrimHistoryAdmin>{
  bool isEditing = false;
  bool isAtBottom = false;
  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ประวัติการลา'),
        backgroundColor: colorProvider.color,
      ),
      body: Visibility (
        visible: !isEditing, 
        child: Column(children: [
          Row(children: [
            const Expanded(flex: 1,
            child: Padding(padding: EdgeInsets.only(left: 10, top:5),
            child: Text('ประวัติการลา', style: TextStyle(fontSize: 20),),
            ),
            
            ),
            
          ],)
        ],),
      ),
    );
  }
}