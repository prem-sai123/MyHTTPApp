import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/postFoodMaster.dart';

class postRequest extends StatefulWidget {
  @override
  State<postRequest> createState() => _postRequestState();
}

class _postRequestState extends State<postRequest> {
  final TextEditingController nameEditingController = TextEditingController();

  final TextEditingController jobEditingController = TextEditingController();

  Future<PostFoodMaster?> addFooditem() async {
    const String baseUrl =
        "http://testt2t.easycloud.in:8080/openbravo/org.openbravo.service.json.jsonrest/TTT_food_master?l=sai&p=welcome";
    final response = await http.post(Uri.parse(baseUrl),
        body: jsonEncode({
          "data": {
            "name": "My Test Request",
            "fats": 5,
            "carbs": 5,
            "proteins": 5,
            "tTTFoodType": "69F3A8500CDF47D3BF9F12D8EA199135",
            "tTTFoodIngredient": "9BCE0382BF86491B80FBB03719EE8FCC"
          }
        }));
    var data = response.body;
    if (response.statusCode == 200) {
      print("SUCCESS");
      return postFoodMasterFromJson(data);
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
              onPressed: addFooditem,
              child: const Text(
                'Add user',
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
