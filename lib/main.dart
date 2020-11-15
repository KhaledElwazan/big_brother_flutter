import 'package:big_brother_flutter/providers/event_provider/event_provider.dart';
import 'package:big_brother_flutter/providers/heart_beat_provider/heart_beat_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // FirebaseApp.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EventProvider>(
          create: (_) => EventProvider(),
        ),
        ChangeNotifierProvider<HeartbeatProvider>(
          create: (_) => HeartbeatProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeApp(),
      ),
    );
  }
}

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  int newTime = 0;
  final int refreshRate = 1;

  Future<void> count() async {
    while (true) {
      await Future.delayed(Duration(minutes: refreshRate));
      // print('yes!');
      setState(() {
        newTime = DateTime.now().millisecondsSinceEpoch;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newTime = DateTime.now().millisecondsSinceEpoch;
    count();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Big Brother Sees All!'),
            centerTitle: true,
            backgroundColor: Colors.black,
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.favorite),
                  text: 'Device Status',
                ),
                Tab(
                  icon: Icon(Icons.notes),
                  text: 'Progress',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Consumer<HeartbeatProvider>(
                builder: (context, heartbeat, _) => ListView(
                    children: heartbeat.events.map((e) {
                  bool isAlive = e.timestamp >= newTime ? true : false;

                  Color c = !isAlive ? Colors.black : Colors.red;
                  return ListTile(
                    title: Text(e.deviceInfo.deviceName),
                    subtitle: Text(e.deviceInfo.deviceId),
                    leading: Icon(
                      Icons.favorite,
                      color: c,
                    ),
                  );
                }).toList()),
              ),
              Consumer<EventProvider>(
                builder: (context, events, _) => ListView(
                    children: events.events.map((e) {
                  double percent = 1.0 * e.progress / e.toFinish * 100;
                  percent = percent.ceil() * 1.0;
                  return ListTile(
                    title: Text(e.projectName),
                    trailing: Text('$percent %'),
                    onTap: () {
                      print('show information about');
                    },
                  );
                }).toList()),
              ),
            ],
          )),
    );
  }
}
