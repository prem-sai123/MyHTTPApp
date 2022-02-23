import 'package:flutter/material.dart';
import 'widgets/foodmasterlist.dart';
import 'widgets/postrequest.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './cubit/myhttp_cubit.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => MyhttpCubit(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('My Http request'),
          ),
          body: const MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: const Text('Get Data'),
            onPressed: () {
              BlocProvider.of<MyhttpCubit>(context).displayList();
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
                  builder: (context) => const postRequest(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
