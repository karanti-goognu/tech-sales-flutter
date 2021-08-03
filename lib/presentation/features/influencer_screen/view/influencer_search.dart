import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/controller/inf_controller.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:get/get.dart';

class EventSearch extends StatefulWidget {
  @override
  _EventSearchState createState() => _EventSearchState();
}

class _EventSearchState extends State<EventSearch> {
  TextEditingController controller = new TextEditingController();
  InfController _infController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: BackFloatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigatorWithoutDraftsAndSearch(),
        body: new SafeArea(
          child: Column(
            children: <Widget>[
              new Container(
                color: Colors.transparent,
                child: new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Card(
                    elevation: 8,
                    child: new ListTile(
                      leading: new Icon(Icons.search),
                      title: new TextField(
                        controller: controller,
                        decoration: new InputDecoration(
                            hintText: 'Search', border: InputBorder.none),
                        onChanged: onSearchTextChanged,
                      ),
                      trailing: new IconButton(
                        icon: new Icon(Icons.cancel),
                        onPressed: () {
                          controller.clear();
                          onSearchTextChanged('');
                          //_eventController.dataForSearchResult.eventListModels = null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
              new Expanded(child: InfluencerDetailWidget()),
            ],
          ),
        ));
  }

  Widget InfluencerDetailWidget(){

  }

  @override
  void dispose() {
    //_eventController.dataForSearchResult.eventListModels = null;
    super.dispose();
  }

  onSearchTextChanged(String text) async {
    if (controller.text.length >= 2) {
      _infController.getInfluencerList();
    }
  }
}