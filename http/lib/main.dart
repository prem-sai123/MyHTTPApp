import 'package:flutter/material.dart';
import 'widgets/foodmasterlist.dart';
import 'widgets/postrequest.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Http request'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Get Data'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FoodMasterList(),
                    ),
                  );
                },
              ),
              ElevatedButton(
                child: const Text('Post Data'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => postRequest(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
