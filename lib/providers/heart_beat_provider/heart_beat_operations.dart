import 'package:big_brother_flutter/models/event.dart';
import 'package:big_brother_flutter/models/heartbeat.dart';
import 'package:big_brother_flutter/providers/providers_template/operations.dart';

// import 'package:firebase/firebase.dart';
import 'package:firebase_database/firebase_database.dart' as fb;

class HeartbeatOperations implements Operations<HeartBeat> {
  static const String PATH = "heartbeats";
  fb.DatabaseReference _databaseReference;

  HeartbeatOperations() {
    _databaseReference = fb.FirebaseDatabase.instance.reference().child(PATH);
  }

  Future<List<HeartBeat>> get({int limit}) async {
    List<HeartBeat> heartbeats = [];
    fb.DataSnapshot dataSnapshot;
    if (limit == null)
      dataSnapshot = await _databaseReference.orderByKey().once();
    else
      dataSnapshot =
          await _databaseReference.orderByKey().limitToLast(limit).once();

    if (dataSnapshot.value != null) {
      Map<dynamic, dynamic> map = dataSnapshot.value;

      map.forEach((key, value) {
        HeartBeat e = HeartBeat.fromJson(value);
        heartbeats.add(e);
      });
    }
    return heartbeats;
  }
}
