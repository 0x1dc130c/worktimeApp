
import 'dart:io';

class Infoleaveworker {

  String leaveType;
  String dateLeave;
  String leavePeriod;
  String infomore;
  String image;
  String timestamp;
  String date;
  String status;
  
  Infoleaveworker({
      required this.leaveType,
      required this.dateLeave,
      required this.leavePeriod,
      required this.infomore,
      required this.image,
      required this.timestamp,
      required this.date,
      required this.status,
  });

  Map<String, dynamic> toJson() {

    
    return {
      'LeaveType': leaveType,
      'DateLeave': dateLeave,
      'LeavePeriod': leavePeriod,
      'InfoMore': infomore,
      'Image': image,
      'TimeStamp': timestamp,
      'Date': date,
      'Status': status,
    };
  }

}