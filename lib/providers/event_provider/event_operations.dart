import 'package:big_brother_flutter/models/event.dart' as event;
import 'package:big_brother_flutter/providers/providers_template/operations.dart';
// import 'package:firebase/firebase.dart';
import 'package:firebase_database/firebase_database.dart';

class EventOperations implements Operations<event.Event> {
  static const String PATH = "events";
  DatabaseReference _databaseReference;

  EventOperations() {
    _databaseReference = FirebaseDatabase.instance.reference().child(PATH);
  }

  Future<List<event.Event>> get({int limit}) async {
    List<event.Event> events = [];
    DataSnapshot dataSnapshot;
    if (limit == null)
      dataSnapshot = await _databaseReference.orderByKey().once();
    else
      dataSnapshot =
          await _databaseReference.orderByKey().limitToLast(limit).once();

    if (dataSnapshot.value != null) {
      Map<dynamic, dynamic> map = dataSnapshot.value;

      map.forEach((key, value) {
        event.Event e = event.Event.fromJson(value);
        events.add(e);
      });
    }
    return events;
  }
}
