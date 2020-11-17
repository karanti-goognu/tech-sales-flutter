import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/leads_filter_controller.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => new _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();

    // getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
                    },
                  ),
                ),
              ),
            ),
          ),
          new Expanded(
              child: controller.text.length >= 3 && controller.text.isNotEmpty
                  ? new Container(
                      child: Text("Length is greater"),
                    )
                  : new Container(
                      child: Text("Length is smaller"),
                    )),
        ],
      ),
    ));
  }

  onSearchTextChanged(String text) async {
    LeadsFilterController _leadsFilterController = Get.find();
    if (controller.text.length >= 3) {
      print('Hello');
      _leadsFilterController.getAccessKey(RequestIds.SEARCH_LEADS);
    }
  }
}
