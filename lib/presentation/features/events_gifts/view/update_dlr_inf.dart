import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/approved_events_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/DealerInfModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/InfDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/SaveNewInfluencerModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/SaveNewInfluencerResponse.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/UpdateDealerInfModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/AddNewLeadForm.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/global.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/button_styles.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/utils/styles/outline_input_borders.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateDlrInf extends StatefulWidget {
  int eventId;
  UpdateDlrInf(this.eventId);

  @override
  _UpdateDlrInfState createState() => _UpdateDlrInfState();
}

class _UpdateDlrInfState extends State<UpdateDlrInf> {
  DealerInfModel _dealerInfModel;
  InfDetailModel _infDetailModel;
  SaveNewInfluencerResponse _saveNewInfluencerResponse;
  EventsFilterController _eventsFilterController = Get.find();
  int dealerId, _infTypeId, _infCatId;
  bool _isUpdate = false, _isButtonDisabled = false;
  final _formKey = GlobalKey<FormState>();
  final _newFormKey = GlobalKey<FormState>();

  TextEditingController _infTypeController = TextEditingController();
  TextEditingController _infNameController = TextEditingController();
  TextEditingController _newInfNameController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _newContactController = TextEditingController();

  List<EventInfluencerModelList> selectedInfModels = [];

  @override
  void initState() {
    super.initState();
    getEmpId();
    getData();
  }

  Future getEmpId() async {
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      empID = prefs.getString(StringConstants.employeeId);
    });
    return empID;
  }

  getData() async {
    await _eventsFilterController.getDealerInfList(widget.eventId).then((data) {
      setState(() {
        _dealerInfModel = data;
      });
      print('RESPONSE, ${data}');
      setData();
    });
  }

  setData() {
    if (_dealerInfModel.eventDealersModelList != null &&
        _dealerInfModel.eventDealersModelList.length != 0) {
      for (int i = 0; i < _dealerInfModel.eventDealersModelList.length; i++) {
        selectedDealersModels.add(DealersModel(
            dealerId: _dealerInfModel.eventDealersModelList[i].dealerId,
            dealerName: _dealerInfModel.eventDealersModelList[i].dealerName));

        selectedDealer.add(_dealerInfModel.eventDealersModelList[i].dealerName);
      }
    }

    if (_dealerInfModel.eventInfluencerModelList != null &&
        _dealerInfModel.eventInfluencerModelList.length != 0) {
      for (int i = 0;
      i < _dealerInfModel.eventInfluencerModelList.length;
      i++) {
        selectedInfModels.add(EventInfluencerModelList(
            inflId: _dealerInfModel.eventInfluencerModelList[i].inflId,
            inflName: _dealerInfModel.eventInfluencerModelList[i].inflName,
            inflContact: _dealerInfModel.eventInfluencerModelList[i].inflContact,
            inflTypeId: _dealerInfModel.eventInfluencerModelList[i].inflTypeId,
            eventInflId: _dealerInfModel.eventInfluencerModelList[i].eventInflId,
            eventId: _dealerInfModel.eventInfluencerModelList[i].eventId,
            isActive: _dealerInfModel.eventInfluencerModelList[i].isActive
        ));
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);

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
              // height: 30,
              child: Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: List<Widget>.generate(selectedInfModels.length,
                        (int index) {
                      return Chip(
                        label: Text(selectedInfModels[index].inflName),
                        onDeleted: () {
                          setState(() {
                            selectedInfModels.removeAt(index);
                          });
                        },
                      );
                    }),
              ),

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
              //height: 30,
              child: Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: List<Widget>.generate(selectedDealersModels.length,
                        (int index) {
                      return Chip(
                        label: Text(selectedDealersModels[index].dealerName),
                        onDeleted: () {
                          setState(() {
                            selectedDealersModels.removeAt(index);
                          });
                        },
                      );
                    }),
              ),

            ),
          );
        },
      ),
    );

    final btns = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RaisedButton(
          color: ColorConstants.btnBlue,
          child: Text(
            "UPDATE",
            style:
            //TextStyles.btnWhite,
            TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                // letterSpacing: 2,
                fontSize: ScreenUtil().setSp(15)),
          ),
          onPressed: () {
            updateBtnPressed();
          },
        ),
        RaisedButton(
          color: ColorConstants.btnBlue,
          child: Text(
            "ADD LEAD",
            style:
            //TextStyles.btnWhite,
            TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                // letterSpacing: 2,
                fontSize: ScreenUtil().setSp(15)),
          ),
          onPressed: () {
            Get.to(()=>AddNewLeadForm(eventId:widget.eventId,));
          },
        ),
      ],
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
                    padding: EdgeInsets.only(
                        left: ScreenUtil().setSp(16),
                        top: ScreenUtil().setSp(16),
                        right: ScreenUtil().setSp(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'update Dealers & Influencers',
                          style: TextStyles.titleGreenStyle,
                        ),
                        IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              if (_isUpdate == true) {
                                Get.dialog(CustomDialogs().showSaveChangesDialog(
                                    "Do you want to save changes?"));
                              } else {
                                Get.back();
                              }
                            })
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [influencer, SizedBox(height: 16), dealer]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: btns,
                  )
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
    _contactController.text = '';
    _infNameController.text = '';
    _infTypeController.text = '';
    _isUpdate = true;
    _isButtonDisabled = false;
    Get.bottomSheet(
      addInfluencerBottomSheetWidget(),
      isScrollControlled: true,
    ).then((value) => setState(() {}));
  }

  getBottomSheetInf() {
    _newContactController.text = '';
    _newInfNameController.text = '';
    Get.back();
    Get.bottomSheet(
      addNewInfluencerBottomSheetWidget(),
      isScrollControlled: true,
    ).then((value) => setState(() {}));
  }

  getBottomSheetForDealer() {
    _isUpdate = true;
    Get.bottomSheet(
      addDealerBottomSheetWidget(),
      isScrollControlled: true,
    ).then((value) => setState(() {}));
  }

  addInfluencerBottomSheetWidget() {
    List<EventInfluencerModelList> inf =
        _dealerInfModel.eventInfluencerModelList;
    return StatefulBuilder(builder: (context, StateSetter setState) {
      return Container(
        height: SizeConfig.screenHeight / 1.6,
        color: Colors.white,
        child: Form(
          key: _formKey,
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
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          _contactController.text = '';
                          _infNameController.text = '';
                          _infTypeController.text = '';
                          Get.back();
                        },
                        icon: Icon(Icons.clear))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 16, left: 16, bottom: 8, top: 12),
                child: TextFormField(
                  controller: _contactController,
                  maxLength: 10,
                  // onEditingComplete: () {
                  //   getInfluencerData(_contactController.text);
                  //   //Get.back();
                  // },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Contact Name can't be empty";
                    }
                    if (value.length != 10) {
                      return "Enter valid Contact number";
                    }
                    return null;
                  },
                  style: FormFieldStyle.formFieldTextStyle,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      focusedBorder: InputBordersDecorations.outLineInputBorderFocused,
                      enabledBorder: InputBordersDecorations.outLineInputBorderEnabled,
                      errorBorder: InputBordersDecorations.outLineInputBorderError,
                      focusedErrorBorder: InputBordersDecorations.outLineInputBorderError,
                      focusColor: Colors.black,
                      isDense: false,
                      labelStyle: TextStyles.formfieldLabelText,
                      fillColor: ColorConstants.backgroundColor,
                      hintText: 'Contact No',
                      filled: false,
                      suffixIcon: IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {
                            getInfluencerData(_contactController.text);
                          })),
                ),
              ),
              Padding(
                  padding:
                  const EdgeInsets.only(right: 16, left: 16, bottom: 8),
                  child: TextFormField(
                    controller: _infNameController,
                    style: FormFieldStyle.formFieldTextStyle,
                    readOnly: true,
                    enableInteractiveSelection: false,
                    decoration:
                    FormFieldStyle.buildInputDecoration(hintText: 'Name'),
                  )),
              Padding(
                  padding:
                  const EdgeInsets.only(right: 16, left: 16, bottom: 8),
                  child: TextFormField(
                    maxLines: null,
                    controller: _infTypeController,
                    style: FormFieldStyle.formFieldTextStyle,
                    readOnly: true,
                    enableInteractiveSelection: false,
                    decoration: FormFieldStyle.buildInputDecoration(
                        hintText: "Influencer Type"),
                  )),
              Container(
                padding:
                EdgeInsets.only(top: 16, bottom: 20, left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(

                      color: HexColor('#1C99D4'),
                      disabledColor : Colors.grey,
                      onPressed: () {
                        if(_isButtonDisabled == true) {
                          setState(() {
                            selectedInfModels.add(EventInfluencerModelList(
                                eventId: widget.eventId,
                                eventInflId: 0,
                                inflContact:
                                _infDetailModel.influencerModel.inflContact,
                                inflTypeId:
                                _infDetailModel.influencerModel.inflTypeId,
                                inflId: _infDetailModel.influencerModel.infl_id,
                                inflName:
                                _infDetailModel.influencerModel.inflName,
                                isActive: "Y"));

                            Get.back();
                            _contactController.text = '';
                            _infNameController.text = '';
                            _infTypeController.text = '';
                          });
                        }else{
                          return null;
                        }
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
            ],
          ),
        ),
      );
    });
  }

  addNewInfluencerBottomSheetWidget() {
    (_infDetailModel != null)?
    _newContactController.text = _infDetailModel.mobileNumber:"";
    return StatefulBuilder(builder: (context, StateSetter setState) {
      return Container(
        height: SizeConfig.screenHeight / 1.3,
        color: Colors.white,
        child: Form(
          key: _newFormKey,
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
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () => Get.back(), icon: Icon(Icons.clear))
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //       right: 16, left: 16, bottom: 8, top: 12),
              //   child: TextFormField(
              //     controller: _newContactController,
              //     maxLength: 10,
              //     validator: (value) {
              //       if (value.isEmpty) {
              //         return "Contact Name can't be empty";
              //       }
              //       if (value.length != 10) {
              //         return "Enter valid Contact number";
              //       }
              //       return null;
              //     },
              //     style: FormFieldStyle.formFieldTextStyle,
              //     keyboardType: TextInputType.number,
              //     decoration: FormFieldStyle.buildInputDecoration(
              //         hintText: 'Contact No.'),
              //   ),
              // ),

              Padding(
                  padding:
                  const EdgeInsets.only(right: 16, left: 16, bottom: 8),
                  child: TextFormField(
                    controller: _newContactController,
                    style: FormFieldStyle.formFieldTextStyle,
                    readOnly: true,
                    enableInteractiveSelection: false,
                    decoration:
                    FormFieldStyle.buildInputDecoration(hintText: 'Contact No'),
                  )),
              Padding(
                  padding:
                  const EdgeInsets.only(right: 16, left: 16, bottom: 8),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Name can't be empty";
                      }
                      return null;
                    },
                    controller: _newInfNameController,
                    style: TextStyles.formfieldLabelText,
                    keyboardType: TextInputType.text,
                    decoration:
                    FormFieldStyle.buildInputDecoration(labelText: "Name"),
                  )),
              Padding(
                  padding:
                  const EdgeInsets.only(right: 16, left: 16, bottom: 12),
                  child: DropdownButtonFormField(
                    onChanged: (value) {
                      setState(() {
                        _infTypeId = value;
                      });
                    },
                    items: (_infDetailModel != null && _infDetailModel.influencerTypeEntitiesList != null)?
                    _infDetailModel.influencerTypeEntitiesList
                        .map((e) => DropdownMenuItem(
                      value: e.inflTypeId,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        //250,
                        child: Text(
                          '${e.inflTypeDesc}',
                          maxLines: null,
                        ),
                      ),
                    ))
                        .toList():[],
                    style: FormFieldStyle.formFieldTextStyle,
                    decoration: FormFieldStyle.buildInputDecoration(
                        labelText: "Influencer Type"),
                    validator: (value) => value == null
                        ? 'Please select the Influencer Category'
                        : null,
                  )),

              SizedBox(height: 12),

              Container(
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
                        padding: const EdgeInsets.only(
                            right: 16, left: 16, bottom: 12),
                        child: DropdownButtonFormField(
                          onChanged: (value) {
                            setState(() {
                              _infCatId = value;
                            });
                          },
                          items: (_infDetailModel != null && _infDetailModel.influencerCategoryEntitiesList != null)?
                          _infDetailModel.influencerCategoryEntitiesList
                              .map((e) => DropdownMenuItem(
                            value: e.inflCatId,
                            child: Text(
                              e.inflCatDesc,
                              maxLines: null,
                            ),
                          ))
                              .toList():[],
                          style: FormFieldStyle.formFieldTextStyle,
                          decoration: FormFieldStyle.buildInputDecoration(
                              labelText: "Dalmia"),
                          validator: (value) => value == null
                              ? 'Please select the Influencer Category'
                              : null,
                        )),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1.0),
                                side: BorderSide(color: Colors.black)),
                            onPressed: () {
                              addNewInfluencerBtnPressed();
                            },
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
            ],
          ),
        ),
      );
    });
  }

  List<bool> checkedValues;
  List<String> selectedDealer = [];
  List<DealersModel> selectedDealersModels = [];

  TextEditingController _query = TextEditingController();

  addDealerBottomSheetWidget() {
    if (_dealerInfModel.eventDealersModelList != null &&
        _dealerInfModel.eventDealersModelList.length != 0) {
      for (int i = 0; i < _dealerInfModel.eventDealersModelList.length; i++) {
        selectedDealer.add(_dealerInfModel.eventDealersModelList[i].dealerName);
      }
    }
    List<DealersModel> dealers = _dealerInfModel.dealersModel;
    checkedValues =
        List.generate(_dealerInfModel.dealersModel.length, (index) => false);
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
                    dealers = _dealerInfModel.dealersModel.where((element) {
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
                          Text(dealers[index].dealerName),
                          Text('( ${dealers[index].dealerId} )'),
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
                        selectedDealersModels.clear();
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
                      setState(() {});
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

  getInfluencerData(String contact) async {
    if (_formKey.currentState.validate()) {
      await _eventsFilterController.getInfData(contact).then((data) {
        _infDetailModel = data;
        setState(() {
          if (data != null) {
            if (_infDetailModel.respCode == "DM1002" &&
                _infDetailModel.influencerModel != null) {
              _infNameController.text =
                  _infDetailModel.influencerModel.inflName;
              _infTypeController.text =
              '${_infDetailModel.influencerModel.influencerTypeText}';
              _isButtonDisabled = true;
            } else {
              getBottomSheetInf();
            }
          }
        });
        print("response : ");
      });
    }
  }


  updateBtnPressed() async {
    List<EventDealerRequestsList> _dealersList = new List();
    List<EventInfluencerRequestsList> _infList = new List();
    String empId = await getEmpId();
    selectedDealersModels.forEach((e) {
      setState(() {
        _dealersList.add(new EventDealerRequestsList(
            createdBy: empId,
            createdOn: '',
            dealerId: e.dealerId,
            dealerName: e.dealerName,
            eventDealerId: 0,
            eventId: widget.eventId,
            eventStage: 'COMPLETE',
            isActive: 'Y',
            modifiedBy: empId,
            modifiedOn: ''));
      });
    });

    selectedInfModels.forEach((e) {
      setState(() {
        _infList.add(new EventInfluencerRequestsList(
            eventId: widget.eventId,
            eventInflId: e.eventInflId,
            inflContact: e.inflContact,
            inflId: e.inflId,
            inflName: e.inflName,
            inflTypeId: e.inflTypeId,
            isActive: 'Y'));
      });
    });

    UpdateDealerInfModel _update = UpdateDealerInfModel.fromJson({
      'eventDealerRequestsList': _dealersList,
      'eventInfluencerRequestsList': _infList,
      'referenceID': empId
    });

    UpdateDealerInfModel _updateDealer = new UpdateDealerInfModel(
        eventDealerRequestsList: _dealersList,
        eventInfluencerRequestsList: _infList,
        referenceID: empId);


    print('DEALERS: $_dealersList');
    print('INF : $_infList');
    print('PARAMS: ${json.encode(_updateDealer)}');

    internetChecking().then((result) => {
      if (result == true)
        {_eventsFilterController.getAccessKeyAndSaveDealerInf(_updateDealer)}
      else
        {
          Get.snackbar("No internet connection.",
              "Make sure that your wifi or mobile data is turned on.",
              colorText: Colors.white,
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.BOTTOM),
        }
    });
  }

  addNewInfluencerBtnPressed() async {
    if (_newFormKey.currentState.validate()) {
      SaveNewInfluencerModel _save = SaveNewInfluencerModel(
        ilpIntrested: '',
        influencerCategoryId: _infCatId,
        influencerName: _newInfNameController.text,
        influencerTypeId: _infTypeId,
        mobileNumber: _newContactController.text,
      );

      internetChecking().then((result) => {
        if (result == true)
          {
            _eventsFilterController
                .getAccessKeyAndSaveNewInfluencer(_save)
                .then((data) {
              setState(() {
                _saveNewInfluencerResponse = data;
                print('DD: $_saveNewInfluencerResponse');
                Get.dialog(
                    successDialog(_saveNewInfluencerResponse.respMsg));
              });
            })
          }
        else
          {
            Get.snackbar("No internet connection.",
                "Make sure that your wifi or mobile data is turned on.",
                colorText: Colors.white,
                backgroundColor: Colors.red,
                snackPosition: SnackPosition.BOTTOM),
          }
      });
    }
  }

  Widget successDialog(String message) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              message,
              style: GoogleFonts.roboto(
                  fontSize: 16,
                  height: 1.4,
                  letterSpacing: .25,
                  fontStyle: FontStyle.normal,
                  color: ColorConstants.inputBoxHintColorDark),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'OK',
            style: GoogleFonts.roboto(
                fontSize: 20,
                letterSpacing: 1.25,
                fontStyle: FontStyle.normal,
                color: ColorConstants.buttonNormalColor),
          ),
          onPressed: () {
            setState(() {
              selectedInfModels.add(EventInfluencerModelList(
                  eventId: widget.eventId,
                  inflContact: _saveNewInfluencerResponse.mobileNumber,
                  inflTypeId: _saveNewInfluencerResponse.influencerTypeId,
                  inflId: _saveNewInfluencerResponse.infl_id,
                  inflName: _saveNewInfluencerResponse.influencerName,
                  eventInflId: 0));
            });

            Get.back();
            Get.back();
          },
        ),
      ],
    );
  }
}
