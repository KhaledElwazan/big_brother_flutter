import 'package:big_brother_flutter/models/device_info.dart';

import 'package:flutter/foundation.dart';

class HeartBeat {
  DeviceInfo deviceInfo;
  String id;
  int timestamp;

  HeartBeat({@required this.deviceInfo, @required this.id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['products'] = json.encode(this.products);
    data['device_info'] = this.deviceInfo.toJson();
    data['id'] = this.id;
    data['timestamp']=this.timestamp;
    return data;
  }

  HeartBeat.fromJson(Map<dynamic, dynamic> json) {
    this.deviceInfo = DeviceInfo.fromJson(json['device_info']);
    this.id = json['id'];
    this.timestamp = json['timestamp'];
  }
}
