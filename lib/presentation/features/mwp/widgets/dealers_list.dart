import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/add_event__controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/DealerModel.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:get/get.dart';

class DealersListWidget extends StatefulWidget {
  @override
  _DealersListWidgetState createState() => _DealersListWidgetState();
}

class _DealersListWidgetState extends State<DealersListWidget> {
  AddEventController _addEventController = Get.find();
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
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Choose Dealers",
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
                child: Icon(
                  Icons.cancel,
                  size: 24,
                ),
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
      /*height: SizeConfig.safeBlockVertical * 50,
      width: SizeConfig.screenWidth,*/
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
            Obx(() => (_addEventController.dealerListResponse.dealerList ==
                    null)
                ? Container()
                : (_addEventController.dealerListResponse.dealerList.length ==
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
                itemCount: _addEventController
                    .dealerList.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                    padding: new EdgeInsets.all(8.0),
                    child: new Column(
                      children: <Widget>[
                        new CheckboxListTile(
                            value: _addEventController
                                .dealerList[index].isSelected,
                            title: new Text(
                                '${_addEventController.dealerList[index].dealerName}'),
                            controlAffinity:
                            ListTileControlAffinity.leading,
                            onChanged: (bool val) {
                              itemChange(val, index);
                            })
                      ],
                    ),
                  );
                })),
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
      for(int i=0;i<_addEventController.dealerList.length;i++){
        if(_addEventController.dealerList[i].dealerName.toUpperCase().contains(text)||_addEventController.dealerList[i].dealerName.toLowerCase().contains(text)||
            _addEventController.dealerList[i].dealerName.contains(text)){

          setState(() {
            _searchList.add(_addEventController.dealerList[i]);
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
      _addEventController.dealerList[index].isSelected = val;
      if (val) {
        print('true');
        _addEventController.dealerListSelected.add(new DealerModelSelected(
            _addEventController.dealerList[index].dealerId,
            _addEventController.dealerList[index].dealerName));
      } else {
        print('false');
        _addEventController.dealerListSelected.removeWhere((item) =>
            item.dealerId == _addEventController.dealerList[index].dealerId);
      }
    });
  }

  void itemChange1(bool val, String dealerName,int index1) {
    /*else{
      _addEventController.dealerListSelected.remove(index);
    }*/
    var index;
    for(int i=0;i<_addEventController.dealerList.length;i++){
      if(_addEventController.dealerList[i].dealerName==dealerName) {
         index = i;
      }
    }

    setState(() {
      _addEventController.dealerList[index].isSelected = val;
      if (val) {
        _searchList[index1].isSelected = true;
        _addEventController.dealerListSelected.add(new DealerModelSelected(
            _addEventController.dealerList[index].dealerId,
            _addEventController.dealerList[index].dealerName));
      } else {
        _searchList[index1].isSelected = false;
        _addEventController.dealerListSelected.removeWhere((item) =>
        item.dealerId == _addEventController.dealerList[index].dealerId);
      }
    });
  }

}
