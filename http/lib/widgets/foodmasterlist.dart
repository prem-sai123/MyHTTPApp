import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:httptask/main.dart';
import '../Models/foodmaster.dart';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';

class FoodMasterList extends StatefulWidget {
  const FoodMasterList({Key? key}) : super(key: key);
  @override
  State<FoodMasterList> createState() => _FoodMasterListState();
}

class _FoodMasterListState extends State<FoodMasterList> {
  String _status = "Checking";
  Color? _statusColor;
  final Connectivity _connectivity = Connectivity();
  bool hasInternet = false;
  void _checkNetworkConnectivty() async {
    var _connectionResponse = await _connectivity.checkConnectivity();
    if (_connectionResponse == ConnectivityResult.mobile) {
      _status = "You are connected to Mobile Data";
      hasInternet = true;
      //showOverLay(context);
      fetchPosts();
    } else if (_connectionResponse == ConnectivityResult.wifi) {
      _status = "You are connected to Wifi";
      _statusColor = Colors.orange;
      //showOverLay(context);
      hasInternet = true;
      fetchPosts();
    } else {
      _status = "Please Check Your Internet Connection";
      _statusColor = Colors.red;
    }
    setState(() {});
  }

  showOverLay(BuildContext context) async {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
      return Text(
        _status.toString(),
        style: TextStyle(
          fontSize: 20,
          color: _statusColor,
        ),
      );
    });
    overlayState?.insert(overlayEntry);
    await Future.delayed(const Duration(seconds: 2));
    overlayEntry.remove();
  }

  final url =
      'http://testt2t.easycloud.in:8080/openbravo/org.openbravo.service.json.jsonrest/TTT_food_master?l=sai&p=welcome';
  Future fetchPosts() async {
    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      var res = jsonData['response'];
      List _myRes = res['data'] as List;
      List<FoodMaster> _foodMasterList = [];
      for (var item in _myRes) {
        FoodMaster foodMasterItem = FoodMaster.fromJson(item);
        _foodMasterList.add(foodMasterItem);
      }
      _foodMasterList.sort((a, b) => a.foodName![0].compareTo(b.foodName![0]));
      return _foodMasterList;
    } catch (err, stack) {
      print(stack);
    }
  }

  @override
  void initState() {
    super.initState();
    _checkNetworkConnectivty();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Food Master List'),
      ),
      body: !hasInternet
          ? Card(
              child: FutureBuilder(
                future: fetchPosts(),
                builder: ((context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 80,
                            width: 60,
                            child: CircularProgressIndicator(
                              color: Colors.orangeAccent,
                              strokeWidth: 5,
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text(
                            'Food Master List is Fetching...',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            _status.toString(),
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SingleChildScrollView(
                          child: Card(
                            elevation: 10,
                            color: const Color(0XFFF2EFEA),
                            child: ListTile(
                              onTap: () => print(
                                  'Food Item Clicked : ${snapshot.data[index].foodName.toString()}'),
                              contentPadding:
                                  const EdgeInsets.only(left: 0.0, right: 0.0),
                              leading: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: const Color(0xFF3e88ff),
                                  child: Text(
                                    snapshot.data[index].foodName[0].toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                snapshot.data[index].foodName.toString(),
                              ),
                              trailing: Padding(
                                padding:
                                    const EdgeInsets.only(top: 0, right: 0),
                                child: SizedBox(
                                  width: 80,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Carbs : ${snapshot.data[index].carbs.toString()}',
                                        style: const TextStyle(
                                          color: Colors.purple,
                                        ),
                                      ),
                                      Text(
                                        'Proteins : ${snapshot.data[index].proteins.toString()}',
                                        style: const TextStyle(
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                      Text(
                                        'Fats : ${snapshot.data[index].fats.toString()}',
                                        style: const TextStyle(
                                          color: Colors.pink,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Card(
                    child: Text(
                      'You are not Connected to Internet',
                    ),
                    color: Colors.cyan,
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => MyApp()),
                  //     );
                  //   },
                  //   child: const Text('Home Page'),
                  // )
                ],
              ),
            ),
    );
  }
}
