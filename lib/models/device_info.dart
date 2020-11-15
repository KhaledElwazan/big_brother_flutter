import 'package:flutter/foundation.dart';

class DeviceInfo {
  String deviceId;

  String deviceName;

  String notes;

  DeviceInfo({@required this.deviceId, this.deviceName, this.notes});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['products'] = json.encode(this.products);
    data['notes'] = this.notes;
    data['device_id'] = this.deviceId;
    data['device_name'] = this.deviceName;
    return data;
  }

  DeviceInfo.fromJson(Map<dynamic, dynamic> json) {
    notes = json['notes'].toString();
    this.deviceId = json['device_id'].toString();
    this.deviceName = json['device_name'].toString();
  }
}
