import 'dart:async';

import 'package:big_brother_flutter/providers/providers_template/listener.dart';
// import 'package:firebase/firebase.dart';
import 'package:firebase_database/firebase_database.dart';

import 'heart_beat_operations.dart';

class HeartbeatListener implements Listener {
  StreamSubscription _eventAdded, _eventChanged, _eventRemoved;
  DatabaseReference _databaseReference;

  HeartbeatListener() {
    _databaseReference =
        FirebaseDatabase.instance.reference().child(HeartbeatOperations.PATH);
  }

  onAddListener(Function run) {
    if (_eventAdded == null) {
      _eventAdded = _databaseReference.onChildAdded.listen((event) {
        run(event.snapshot);
      });
    }
  }

  onChangeListener(Function run) {
    if (_eventChanged == null) {
      _eventChanged = _databaseReference.onChildChanged.listen((event) {
        run(event.snapshot);
      });
    }
  }

  onDeleteListener(Function run) {
    if (_eventRemoved == null) {
      _eventRemoved = _databaseReference.onChildRemoved.listen((event) {
        run(event.snapshot);
      });
    }
  }

  removeListeners() {
    if (_eventAdded != null) _eventAdded.cancel();
    if (_eventChanged != null) _eventChanged.cancel();
    if (_eventRemoved != null) _eventRemoved.cancel();

    _eventRemoved = null;
    _eventChanged = null;
    _eventAdded = null;
  }
}
