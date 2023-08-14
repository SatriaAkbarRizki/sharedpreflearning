import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StateHome(),
    );
  }
}

class StateHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateHome();
  }
}

class _StateHome extends State<StateHome> {
  int numberNow = 0;

  @override
  void initState() {
    instance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Num: ${numberNow}'),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: Text('Add NUm'),
            onPressed: () {
              setState(() {
                numberNow++;

                getNum();
              });
            },
          )
        ],
      )),
    );
  }

  Future instance() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      numberNow = pref.getInt('number') ?? 0;
    });
  }

  Future getNum() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt('number', numberNow);
  }
}
