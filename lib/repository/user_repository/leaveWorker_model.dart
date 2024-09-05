
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worktime/features/models/infoleaveWorker.dart';

class LeaveWorkerRepository extends GetxController {
  static LeaveWorkerRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createLeaveWorker(Infoleaveworker leaveWorker) async {
    print('================== Leave Worker: ${leaveWorker.toJson()}');
    try {
      await _db.collection('infoLeaveWorker').add(leaveWorker.toJson());
      Get.snackbar(
        'Success',
        'Leave Worker Added Successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );
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
}