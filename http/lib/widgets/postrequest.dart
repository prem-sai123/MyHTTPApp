import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/user.dart';

class postRequest extends StatefulWidget {
  @override
  State<postRequest> createState() => _postRequestState();
}

class _postRequestState extends State<postRequest> {
  User? _user;
  final TextEditingController nameEditingController = TextEditingController();

  final TextEditingController jobEditingController = TextEditingController();

  Future<User?> addUser(String? inputName, String? inputJob) async {
    const String baseUrl = "https://reqres.in/api/users";
    final response = await http.post(Uri.parse(baseUrl), body: {
      "name": inputName,
      "job": inputJob,
    });

    if (response.statusCode == 201) {
      print("SUCCESS");
      final String responseBody = response.body;
      return userFromJson(responseBody);
    } else {
      print("FAIL");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Request'),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: nameEditingController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: jobEditingController,
              decoration: const InputDecoration(
                labelText: 'Job',
              ),
            ),
            FlatButton(
              color: Colors.amberAccent,
              onPressed: () async {
                final inputName = nameEditingController.text;
                final inputJob = jobEditingController.text;
                final _userData = await addUser(inputName, inputJob) as User;
                setState(() {
                  _user = _userData;
                });
              },
              child: const Text(
                'Add user',
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              height: 50,
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
