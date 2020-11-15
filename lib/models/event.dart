import 'dart:convert';

import 'package:big_brother_flutter/models/device_info.dart';
import 'package:flutter/foundation.dart';

class Event {
  DeviceInfo deviceInfo;

  String notes;

  int progress;

  int toFinish;

  String projectName;

  String id;

  Event(
      {this.deviceInfo,
      this.notes,
      this.progress,
      this.projectName,
      this.toFinish,
      @required this.id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['products'] = json.encode(this.products);
    data['device_info'] = this.deviceInfo.toJson();
    data['notes'] = this.notes;
    data['project_name'] = this.projectName;
    data['to_finish'] = this.toFinish;
    data['progress'] = this.progress;
    data['id']=this.id;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Event &&
          runtimeType == other.runtimeType &&
          deviceInfo == other.deviceInfo &&
          projectName == other.projectName &&
          id == other.id;

  @override
  int get hashCode => deviceInfo.hashCode ^ projectName.hashCode ^ id.hashCode;

  Event.fromJson(Map<dynamic, dynamic> json) {
    this.deviceInfo = DeviceInfo.fromJson(json['device_info']);
    this.notes = json['notes'];
    this.projectName = json['project_name'];
    this.toFinish = json['to_finish'];
    this.progress = json['progress'];
    this.id = json['id'];
  }

  @override
  String toString() {
    return 'Event{deviceInfo: $deviceInfo, notes: $notes, progress: $progress, toFinish: $toFinish, projectName: $projectName}';
  }
}
