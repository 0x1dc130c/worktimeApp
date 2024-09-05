import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worktime/features/models/infoleaveWorker.dart';

class infoHistory_User extends GetxController {
  static infoHistory_User get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createLeaveWorker() async {
    try {
      QuerySnapshot querySnapshot = await _db.collection('infoLeaveWorker').get();
      List<QueryDocumentSnapshot> list = querySnapshot.docs;
      
      return list;
    } catch (error) {
      Get.snackbar(
        'Error',
        'Failed to Add Leave Worker',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  // ฟังก์ชันใหม่สำหรับดึงข้อมูลจากเอกสารเฉพาะ
  Future<DocumentSnapshot?> getLeaveWorkerById(String id) async {
    try {
      DocumentSnapshot documentSnapshot = await _db.collection('infoLeaveWorker').doc(id).get();
      if (documentSnapshot.exists) {
        return documentSnapshot;
      } else {
        Get.snackbar(
          'Error',
          'Document with ID $id does not exist.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
        return null;
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'Failed to retrieve Leave Worker',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return null;
    }
  }
}
