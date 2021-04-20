import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/event_type_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/addEventModel.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/button_styles.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:get/get.dart';

class UpdateDlrInf extends StatefulWidget {
  @override
  _UpdateDlrInfState createState() => _UpdateDlrInfState();
}

class _UpdateDlrInfState extends State<UpdateDlrInf> {
  AddEventModel addEventModel;
  EventTypeController eventController = Get.find();
  int dealerId;
  bool _isVisible = false;

  @override
  void initState() {
    getDropdownData();
    super.initState();
  }

  getDropdownData() async {
    await eventController.getAccessKey().then((value) async {
      print(value.accessKey);
      await eventController.getEventType(value.accessKey).then((data) {
        setState(() {
          addEventModel = data;
        });
        print('RESPONSE, ${data}');
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()
      ..init(context);
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)
      ..init(context);

    final influencer = GestureDetector(
      onTap: () => getBottomSheet(),
      child: FormField(
        validator: (value) => value,
        builder: (state) {
          return InputDecorator(
            decoration: FormFieldStyle.buildInputDecoration(
              labelText: 'Add Influencer(s)',
              suffixIcon: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                child: Icon(
                  Icons.add,
                  size: 20,
                  color: HexColor('#F9A61A'),
                ),
              ),
            ),
            child: Container(
              height: 30,
              child: Text('Add Influencer(s)'),
              // ListView(
              //   scrollDirection:
              //   Axis.horizontal,
              //   children:
              //   selectedRequestSubtypeObjectList
              //       .map(
              //           (e) =>
              //           Padding(
              //             padding:
              //             const EdgeInsets.symmetric(horizontal: 4.0),
              //             child:
              //             Chip(
              //               label:
              //               Text(
              //                 e.serviceRequestTypeText,
              //                 style:
              //                 TextStyle(fontSize: 10),
              //               ),
              //               backgroundColor: Colors
              //                   .lightGreen
              //                   .withOpacity(0.2),
              //             ),
              //           )
              //   )
              //       .toList(),
              // ),
            ),
          );
        },
      ),
    );

    final dealer = GestureDetector(
      onTap: () => getBottomSheetForDealer(),
      child: FormField(
        validator: (value) => value,
        builder: (state) {
          return InputDecorator(
            decoration: FormFieldStyle.buildInputDecoration(
              labelText: 'Add Dealer(s)',
              suffixIcon: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                child: Icon(
                  Icons.add,
                  size: 20,
                  color: HexColor('#F9A61A'),
                ),
              ),
            ),
            child: Container(
              height: 30,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: selectedDealersModels
                    .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Chip(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.grey)),
                    deleteIcon: Icon(Icons.close, size: ScreenUtil().setSp(15),),
                    onDeleted: (){
                      setState(() {
                        selectedDealersModels.remove(e);
                      });

                    },
                    label: Text(
                      e.dealerName,
                      style: TextStyle(fontSize: 12),
                    ),
                    backgroundColor: Colors.white,
                  ),
                ))
                    .toList(),
              ),
            ),
          );
        },
      ),
    );


    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
              child:
              //srComplaintModel != null ?
              ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: ScreenUtil().setSp(16),
                        top: ScreenUtil().setSp(16), right: ScreenUtil().setSp(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'update Dealers & Influencers',
                          style: TextStyles.titleGreenStyle,
                        ),
                        IconButton(icon: Icon(Icons.close), onPressed: (){
                          Get.back();
                        })
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                      padding: const EdgeInsets.all(16.0),

                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              influencer,
                              SizedBox(height: 16),
                              dealer

                            ]),
                      ),
                ],
              )
            //     : Center(
            //   child: CircularProgressIndicator(),
            // ),
          ),
        ],
      ),
    );
  }

  getBottomSheet() {
    Get.bottomSheet(
      addInfluencerBottomSheetWidget(),
      isScrollControlled: true,
    ).then((value) => setState(() {}));
  }
  getBottomSheetForDealer() {
    Get.bottomSheet(
      addDealerBottomSheetWidget(),
      isScrollControlled: true,
    ).then((value) => setState(() {}));
  }

  addInfluencerBottomSheetWidget() {
    return StatefulBuilder(builder: (context, StateSetter setState) {
      return Container(
        height: SizeConfig.screenHeight / 1.3,
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 16, left: 16, bottom: 8, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Influencer',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () => Get.back(), icon: Icon(Icons.clear))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 16, left: 16, bottom: 8, top: 12),
              child: TextFormField(
                // validator: (value) {
                //   if (value.isEmpty) {
                //     return "Contact Name can't be empty";
                //   }
                //   //leagueSize = int.parse(value);
                //   return null;
                // },
                onChanged: (data) {
                  setState(() {
                    //_contactName = data;
                  });
                },
                style: TextStyle(
                    fontSize: 18,
                    color: ColorConstants.inputBoxHintColor,
                    fontFamily: "Muli"),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Contact No.',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorConstants.backgroundColorBlue,
                        //color: HexColor("#0000001F"),
                        width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26, width: 1.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                  ),
                  filled: false,
                  focusColor: Colors.black,
                  isDense: false,
                  labelStyle: TextStyle(
                      fontFamily: "Muli",
                      color: ColorConstants.inputBoxHintColorDark,
                      fontWeight: FontWeight.normal,
                      fontSize: 16.0),
                  fillColor: ColorConstants.backgroundColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, bottom: 8),
              child: TextFormField(
                // validator: (value) {
                //   if (value.isEmpty) {
                //     return "Contact Name can't be empty";
                //   }
                //   //leagueSize = int.parse(value);
                //   return null;
                // },
                onChanged: (data) {
                  setState(() {
                    //_contactName = data;
                  });
                },
                style: TextStyle(
                    fontSize: 18,
                    color: ColorConstants.inputBoxHintColor,
                    fontFamily: "Muli"),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Name',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorConstants.backgroundColorBlue,
                        //color: HexColor("#0000001F"),
                        width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26, width: 1.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                  ),
                  filled: false,
                  focusColor: Colors.black,
                  isDense: false,
                  labelStyle: TextStyle(
                      fontFamily: "Muli",
                      color: ColorConstants.inputBoxHintColorDark,
                      fontWeight: FontWeight.normal,
                      fontSize: 16.0),
                  fillColor: ColorConstants.backgroundColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, bottom: 8),
              child: DropdownButtonFormField(
                onChanged: (value) {
                  setState(() {
                    //requestDepartmentId = value;
                  });
                },
                items: [
                  'Influencer 1',
                  'Influencer 2',
                  'Influencer 3',
                  'Influencer 4'
                ]
                    .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
                    .toList(),
                style: FormFieldStyle.formFieldTextStyle,
                decoration: FormFieldStyle.buildInputDecoration(
                    labelText: "Influencer Type"),
                validator: (value) =>
                value == null ? 'Please select Influencer type ' : null,
              ),
            ),
            //SizedBox(height: 16),
            Container(
              // decoration:
              //     BoxDecoration(border: Border(top: BorderSide(width: 0.2))),
              padding: EdgeInsets.only(top: 16, bottom: 20, left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    color: HexColor('#1C99D4'),
                    onPressed: () {
                      setState(() {
                        _isVisible = true;
                      });

                    },
                    child: Text(
                      'ADD',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    width: 40,
                  ),
                ],
              ),
            ),

            Visibility(
              visible: _isVisible,
              child: Container(
                //height: 50,
                color: ColorConstants.backgroundColorGrey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 16, top: 12, bottom: 12),
                      child: Text(
                        StringConstants.influencerDoesNotExist,
                        style: TextStyles.formfieldLabelTextDark,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(right: 16, left: 16, bottom: 12),
                      child: DropdownButtonFormField(
                        onChanged: (value) {
                          setState(() {
                            //requestDepartmentId = value;
                          });
                        },
                        items: [
                          'Influencer 1',
                          'Influencer 2',
                          'Influencer 3',
                          'Influencer 4'
                        ]
                            .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                            .toList(),
                        style: FormFieldStyle.formFieldTextStyle,
                        decoration: FormFieldStyle.buildInputDecoration(
                            labelText: "Influencer Type"),
                        validator: (value) => value == null
                            ? 'Please select Influencer type '
                            : null,
                      ),
                    ),
                    SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1.0),
                                side: BorderSide(color: Colors.black)),
                            onPressed: () {},
                            child: Text(
                              'Add as a new influencer'.toUpperCase(),
                              style: ButtonStyles.buttonStyleWhite,
                            )),
                      ],
                    ),
                    SizedBox(height: 12),

                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }


  List<bool> checkedValues;
  List<String> selectedDealer = [];
  List<DealersModels> selectedDealersModels = [];

  //List<String> selectedDealerList = [];
  TextEditingController _query = TextEditingController();

  addDealerBottomSheetWidget() {
    List<DealersModels> dealers = addEventModel.dealersModels;
    checkedValues =
        List.generate(addEventModel.dealersModels.length, (index) => false);
    return StatefulBuilder(builder: (context, StateSetter setState) {
      return Container(
        height: SizeConfig.screenHeight / 1.5,
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 16, left: 16, bottom: 16, top: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dealer(s) List',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () => Get.back(), icon: Icon(Icons.clear))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: _query,
                onChanged: (value) {
                  setState(() {
                    dealers = addEventModel.dealersModels.where((element) {
                      return element.dealerName
                          .toString()
                          .toLowerCase()
                          .contains(value);
                    }).toList();
                  });
                },
                decoration: FormFieldStyle.buildInputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    labelText: 'Search'),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemCount: dealers.length,
                itemBuilder: (context, index) {
                  return
                    // dealerId == dealers[index].dealerId
                    //   ?
                    CheckboxListTile(

                      activeColor: Colors.black,
                      dense: true,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(dealers[index].dealerId),
                          Text('( ${dealers[index].dealerName} )'),
                        ],
                      ),
                      value: selectedDealer.contains(dealers[index].dealerName),
                      onChanged: (newValue) {
                        setState(() {
                          selectedDealer.contains(dealers[index].dealerName)
                              ? selectedDealer.remove(dealers[index].dealerName)
                              : selectedDealer.add(dealers[index].dealerName);

                          selectedDealersModels.contains(dealers[index])
                              ? selectedDealersModels.remove(dealers[index])
                              : selectedDealersModels.add(dealers[index]);

                          checkedValues[index] = newValue;
                          //dataToBeSentBack = requestSubtype[index];
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    );
                  //  : Container();
                },
                separatorBuilder: (context, index) {
                  return dealerId == dealers[index].dealerId
                      ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(),
                  )
                      : Container();
                },
              ),
            ),
            Container(
              decoration:
              BoxDecoration(border: Border(top: BorderSide(width: 0.2))),
              padding: EdgeInsets.only(top: 24, bottom: 9, left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDealer.clear();
                      });
                    },
                    child: Text(
                      'Clear All',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#F6A902'),
                      ),
                    ),
                  ),
                  MaterialButton(
                    color: HexColor('#1C99D4'),
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }




  }

