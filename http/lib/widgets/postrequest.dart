import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:httptask/Models/foodmaster.dart';
import '../Models/postFoodMaster.dart';

class postRequest extends StatefulWidget {
  const postRequest({Key? key}) : super(key: key);

  @override
  State<postRequest> createState() => _postRequestState();
}

class _postRequestState extends State<postRequest> {
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController fatsEditingController = TextEditingController(text: 0.0.toString());
  final TextEditingController carbsEditingController = TextEditingController(text: 0.0.toString());
  final TextEditingController prosEditingController = TextEditingController(text: 0.0.toString());

  Future<PostFoodMaster?> addFoodItem(
      String fItemName, int fats, int carbs, int pros) async {
    const String baseUrl =
        "http://testt2t.easycloud.in:8080/openbravo/org.openbravo.service.json.jsonrest/TTT_food_master?l=sai&p=welcome";
    final response = await http.post(
      Uri.parse(baseUrl),
      body: jsonEncode(
        {
          "data": {
            "name": fItemName,
            "fats": fats,
            "carbs": carbs,
            "proteins": pros,
            "tTTFoodType": "69F3A8500CDF47D3BF9F12D8EA199135",
            "tTTFoodIngredient": "9BCE0382BF86491B80FBB03719EE8FCC"
          }
        },
      ),
    );
    var data = response.body;
    if (response.statusCode == 200) {
      return postFoodMasterFromJson(data);
    }
    return null;
  }
  PostFoodMaster? duplicateMaster1;
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
                labelText: 'Food Item Name',
              ),
            ),
            TextField(
              controller: fatsEditingController,
              decoration: const InputDecoration(
                labelText: 'Fats',
              ),
            ),
            TextField(
              controller: carbsEditingController,
              decoration: const InputDecoration(
                labelText: 'Carbs',
              ),
            ),
            TextField(
              controller: prosEditingController,
              decoration: const InputDecoration(
                labelText: 'Proteins',
              ),
            ),
            FlatButton(
              color: Colors.amberAccent,
              onPressed: () async {
                String fname = nameEditingController.text;
                int fats = int.parse(fatsEditingController.text);
                int carbs = int.parse(carbsEditingController.text);
                int pros = int.parse(prosEditingController.text);
                final fMaster =await addFoodItem(fname,fats,carbs,pros) as PostFoodMaster;
                setState(() {
                  duplicateMaster1 = fMaster;
                });
              },
              child: const Text(
                'Add Item',
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
