import 'dart:collection';
import 'dart:io';

import 'package:big_brother_flutter/models/event.dart';
import 'package:big_brother_flutter/providers/event_provider/event_listener.dart';
import 'package:big_brother_flutter/providers/event_provider/event_operations.dart';
import 'package:big_brother_flutter/providers/providers_template/provider.dart';
import 'package:firebase_database/firebase_database.dart' as fb;

// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier implements Provider<Event> {
  List<Event> _events = [];
  EventListener _eventsListener;
  EventOperations _eventsOperations;
  bool _initialDataLoaded = false;

  EventProvider() {
    _eventsOperations = EventOperations();
    _eventsListener = EventListener();
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

  bool contains(Event event) {
    return _events.contains(event);
  }

  List<Event> get events => _events;

  onAdd(Event event) {
    if (!_events.contains(event)) {
      _events.add(event);
      notifyListeners();
    }
  }

  onChange(Event event) {
    print(event);
    _events.removeWhere((element) => event.id == element.id);
    _events.add(event);
    notifyListeners();
  }

  onDelete(Event event) {
    _events.removeWhere((element) => event.id == element.id);
    notifyListeners();
  }

  initListeners() {
    _eventsListener.onAddListener((fb.DataSnapshot dataSnapshot) {
      if (_initialDataLoaded) {
        Event event = Event.fromJson(dataSnapshot.value);
        onAdd(event);
      }
    });
    _eventsListener.onChangeListener((fb.DataSnapshot dataSnapshot) {
      if (_initialDataLoaded) {
        Event event = Event.fromJson(dataSnapshot.value);
        onChange(event);
      }
    });

    _eventsListener.onDeleteListener((fb.DataSnapshot dataSnapshot) {
      if (_initialDataLoaded) {
        Event event = Event.fromJson(dataSnapshot.value);
        onDelete(event);
      }
    });
  }
}
