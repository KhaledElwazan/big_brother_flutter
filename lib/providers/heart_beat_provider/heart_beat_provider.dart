import 'package:big_brother_flutter/models/heartbeat.dart';
import 'package:big_brother_flutter/providers/heart_beat_provider/heart_beat_listener.dart';
import 'package:big_brother_flutter/providers/heart_beat_provider/heart_beat_operations.dart';
import 'package:big_brother_flutter/providers/providers_template/provider.dart';
import 'package:firebase_database/firebase_database.dart' as fb;
import 'package:flutter/material.dart';

class HeartbeatProvider extends ChangeNotifier implements Provider<HeartBeat> {
  List<HeartBeat> _events = [];
  HeartbeatListener _eventsListener;
  HeartbeatOperations _eventsOperations;
  bool _initialDataLoaded = false;

  HeartbeatProvider() {
    _eventsOperations = HeartbeatOperations();
    _eventsListener = HeartbeatListener();
    initListeners();
    _eventsOperations.get().then((value) {
      _events = value;
      _initialDataLoaded = true;
      notifyListeners();
    });
  }

  int size() {
    return _events.length;
  }

  bool contains(HeartBeat event) {
    return _events.contains(event);
  }

  List<HeartBeat> get events => _events;

  onAdd(HeartBeat event) {
    if (!events.contains(event)) {
      _events.add(event);
      notifyListeners();
    }
  }

  onChange(HeartBeat event) {
    // print(event);
    _events.removeWhere((element) => event.id == element.id);
    _events.add(event);
    notifyListeners();
  }

  onDelete(HeartBeat event) {
    _events.removeWhere((element) => event.id == element.id);
    notifyListeners();
  }

  initListeners() {
    _eventsListener.onAddListener((fb.DataSnapshot dataSnapshot) {
      if (_initialDataLoaded) {
        HeartBeat event = HeartBeat.fromJson(dataSnapshot.value);
        onAdd(event);
      }
    });
    _eventsListener.onChangeListener((fb.DataSnapshot dataSnapshot) {
      if (_initialDataLoaded) {
        HeartBeat event = HeartBeat.fromJson(dataSnapshot.value);
        onChange(event);
      }
    });

    _eventsListener.onDeleteListener((fb.DataSnapshot dataSnapshot) {
      if (_initialDataLoaded) {
        HeartBeat event = HeartBeat.fromJson(dataSnapshot.value);
        onDelete(event);
      }
    });
  }
}
