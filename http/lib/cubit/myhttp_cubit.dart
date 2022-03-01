import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import '../Models/foodmaster.dart';
part 'myhttp_state.dart';

class MyhttpCubit extends Cubit<MyHTTPState> {
  Future<List<FoodMaster>> fetchFoodMasterList() async {
    try {
      const url =
          'http://testt2t.easycloud.in/openbravo/org.openbravo.service.json.jsonrest/TTT_food_master?l=sai&p=welcome&_endRow=10&_sortBy=creationDate%20desc';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        var res = jsonData['response'];
        var _myRes = res['data'] as List;
        List<FoodMaster> _foodMasterList = [];
        for (var item in _myRes) {
          FoodMaster foodMasterItem = FoodMaster.fromJson(item);
          _foodMasterList.add(foodMasterItem);
        }
        // _foodMasterList
        //     .sort((a, b) => a.foodName![0].compareTo(b.foodName![0]));
        print(_foodMasterList);
        return _foodMasterList;
      } else {
        return [];
      }
    } catch (err, stack) {
      print('$err,$stack');
      return [];
    }
  }

  MyhttpCubit()
      : super(
          MyHTTPState(
            inputFoodItem: [],
          ),
        );
  void displayList() async {
    var fetchedList = await fetchFoodMasterList();
    emit(MyHTTPState(inputFoodItem: fetchedList));
  }
}
