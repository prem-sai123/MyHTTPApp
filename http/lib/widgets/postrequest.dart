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
  final TextEditingController fatsEditingController =
      TextEditingController(text: 0.toString());
  final TextEditingController carbsEditingController =
      TextEditingController(text: 0.toString());
  final TextEditingController prosEditingController =
      TextEditingController(text: 0.toString());
  List<FoodMaster> _resList = [];
  Future<PostFoodMaster?> addFoodItem(
      String fItemName, int fats, int carbs, int pros) async {
    try {
      const String baseUrl =
          "http://192.168.1.14:8080/ttot/org.openbravo.service.json.jsonrest/TTT_food_master?l=sai&p=welcome";
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
        // await Future.delayed(const Duration(seconds: 2));
        // Navigator.of(context).pop();
        var json = await jsonDecode(response.body) as Map<String, dynamic>;
        print(json);
        var jsonRes = json['response'];
        var _myRes = (jsonRes['data']);
        print(_myRes);
        return PostFoodMaster.fromJson(_myRes[0] as Map<String, dynamic>);
      }
    } catch (err, stack) {
      print('$err,\n,$stack');
    }
    return null;
  }

  PostFoodMaster? _duplicateMaster1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Request'),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: nameEditingController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Food Item Name',
              ),
            ),
            TextField(
              controller: fatsEditingController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Fats',
              ),
            ),
            TextField(
              controller: carbsEditingController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Carbs',
              ),
            ),
            TextField(
              controller: prosEditingController,
              keyboardType: TextInputType.number,
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
                print(fname);
                final fMaster = await addFoodItem(fname, fats, carbs, pros)
                    as PostFoodMaster;
                setState(() {
                  _duplicateMaster1 = fMaster;
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
            _duplicateMaster1 != null
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DataTable(
                          columns: const [
                            DataColumn(
                              label: Text(
                                'Food Item Name',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Prots',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Carbs',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text(_duplicateMaster1!.name!)),
                              DataCell(Text(
                                  _duplicateMaster1!.proteins!.toString())),
                              DataCell(
                                  Text(_duplicateMaster1!.carbs!.toString())),
                            ]),
                          ],
                          headingRowHeight: 50,
                          columnSpacing: 2,
                        ),
                      ],
                    ),
                  )
                : const Text('NO DATA')
          ],
        ),
      ),
    );
  }
}
