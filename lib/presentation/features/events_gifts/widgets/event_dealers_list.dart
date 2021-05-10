import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/detail_event_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/event_type_controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/add_event__controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/DealerModel.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:get/get.dart';

class EventDealersListWidget extends StatefulWidget {
  @override
  _EventDealersListWidgetState createState() => _EventDealersListWidgetState();
}

class _EventDealersListWidgetState extends State<EventDealersListWidget> {
  DetailEventController _detailEventController = Get.find();
  TextEditingController controller = new TextEditingController();

  final _searchList = List<DealerModel>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODO: implement build
    return Container(
      height: MediaQuery.of(context).size.height * 0.70,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(0),
          topRight: const Radius.circular(0),
        ),
      ),
      child: Stack(children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              bottomSheetTop(),
              showDealerListBody(),
            ],
          ),
        ),
      ]),
    );
  }

  Widget bottomSheetTop() {
    return
      Padding(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Dealer(s) List",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18),
            ),
          ),
          Spacer(),
          Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.clear)
              )),
        ],
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        border: Border.all(color: ColorConstants.dateBorderColor),
        color: Colors.white);
  }

  Widget showDealerListBody() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
            SizedBox(
              height: 16,
            ),
            Obx(() => (
                _detailEventController.egDetailEventDaa.dealersModels ==
                //_addEventController.dealerListResponse.dealerList ==
                null)
                ? Container()
                : (_detailEventController.egDetailEventDaa.dealersModels.length ==
                0)
                ? Container()
                :_searchList.length!=0?
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _searchList.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                    padding: new EdgeInsets.all(8.0),
                    child: new Column(
                      children: <Widget>[
                        new CheckboxListTile(
                            value: _searchList[index].isSelected,
                            title: new Text(
                                '${_searchList[index].dealerName}'),
                            controlAffinity:
                            ListTileControlAffinity.leading,
                            onChanged: (bool val) {
                              itemChange1(val, _searchList[index].dealerName,index);
                            })
                      ],
                    ),
                  );
                }):ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _detailEventController
                    .dealerList.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                    padding: new EdgeInsets.all(8.0),
                    child: new Column(
                      children: <Widget>[
                        new CheckboxListTile(
                            value: _detailEventController
                                .dealerList[index].isSelected,
                            title:
                            Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(_detailEventController.dealerList[index].dealerName),
                                                      Text('( ${_detailEventController.dealerList[index].dealerId} )'),
                                                    ],),

                            // new Text(
                            //     '${_detailEventController.dealerList[index].dealerName}'),
                            controlAffinity:
                            ListTileControlAffinity.leading,
                            onChanged: (bool val) {
                              itemChange(val, index);
                            })
                      ],
                    ),
                  );
                }),


            ),
        // Container(
        //               decoration:
        //               BoxDecoration(border: Border(top: BorderSide(width: 0.2))),
        //               padding: EdgeInsets.only(top: 24, bottom: 9, left: 30, right: 30),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   GestureDetector(
        //                     onTap: () {
        //                       setState(() {
        //                         // selectedDealer.clear();
        //                         // selectedDealersModels.clear();
        //                       });
        //                     },
        //                     child: Text(
        //                       'Clear All',
        //                       style: TextStyle(
        //                         fontSize: 16,
        //                         fontWeight: FontWeight.bold,
        //                         color: HexColor('#F6A902'),
        //                       ),
        //                     ),
        //                   ),
        //                   MaterialButton(
        //                     color: HexColor('#1C99D4'),
        //                     onPressed: () {
        //                       Get.back();
        //                     },
        //                     child: Text(
        //                       'OK',
        //                       style: TextStyle(color: Colors.white),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),

          ],
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    print('Hello'+text);
    for(int i=0;i<_detailEventController.dealerList.length;i++){
      if(_detailEventController.dealerList[i].dealerName.toUpperCase().contains(text)||_detailEventController.dealerList[i].dealerName.toLowerCase().contains(text)||
          _detailEventController.dealerList[i].dealerName.contains(text)){

        setState(() {
          _searchList.add(_detailEventController.dealerList[i]);
        });
        print("FilterList-->"+_searchList.length.toString());
      }
    }

    setState(() {});

  }

  void itemChange(bool val, int index) {
    /*else{
      _addEventController.dealerListSelected.remove(index);
    }*/
    setState(() {
      _detailEventController.dealerList[index].isSelected = val;
      if (val) {
        print('true');
        _detailEventController.dealerListSelected.add(new DealerModelSelected(
            _detailEventController.dealerList[index].dealerId,
            _detailEventController.dealerList[index].dealerName));
      } else {
        print('false');
        _detailEventController.dealerListSelected.removeWhere((item) =>
        item.dealerId == _detailEventController.dealerList[index].dealerId);
      }
    });
  }

  void itemChange1(bool val, String dealerName,int index1) {
    /*else{
      _addEventController.dealerListSelected.remove(index);
    }*/
    var index;
    for(int i=0;i<_detailEventController.dealerList.length;i++){
      if(_detailEventController.dealerList[i].dealerName==dealerName) {
        index = i;
      }
    }

    setState(() {
      _detailEventController.dealerList[index].isSelected = val;
      if (val) {
        _searchList[index1].isSelected = true;
        _detailEventController.dealerListSelected.add(new DealerModelSelected(
            _detailEventController.dealerList[index].dealerId,
            _detailEventController.dealerList[index].dealerName));
      } else {
        _searchList[index1].isSelected = false;
        _detailEventController.dealerListSelected.removeWhere((item) =>
        item.dealerId == _detailEventController.dealerList[index].dealerId);
      }
    });
  }

}
