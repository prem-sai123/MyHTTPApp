import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:httptask/cubit/myhttp_cubit.dart';

class FoodMasterList extends StatefulWidget {
  const FoodMasterList({Key? key}) : super(key: key);
  @override
  State<FoodMasterList> createState() => _FoodMasterListState();
}

class _FoodMasterListState extends State<FoodMasterList> {
  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      title: const Text('Food Master List'),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar,
      body: Column(
        children: [
          Card(
            child: BlocBuilder<MyhttpCubit, MyHTTPState>(
              builder: (context, state) {
                return SizedBox(
                  height: 647,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final myVar = state.inputFoodItem;
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          onTap: () => print(
                              'Food Item Clicked : ${myVar[index].foodName.toString()}'),
                          contentPadding:
                              const EdgeInsets.only(left: 0.0, right: 0.0),
                          leading: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: const Color(0xFF3e88ff),
                              child: Text(
                                myVar[index].foodName![0].toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            myVar[index].foodName.toString(),
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.only(top: 0, right: 0),
                            child: SizedBox(
                              width: 90,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Carbs : ${myVar[index].carbs.toString()}',
                                    style: const TextStyle(
                                      color: Colors.purple,
                                    ),
                                  ),
                                  Text(
                                    'Proteins : ${myVar[index].proteins.toString()}',
                                    style: const TextStyle(
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                  Text(
                                    'Fats : ${myVar[index].fats.toString()}',
                                    style: const TextStyle(
                                      color: Colors.pink,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: state.inputFoodItem.length,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
