

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/utils/functions/get_current_location.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/controller/update_sr_controller.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/ComplaintViewModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/UpdateSRModel.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/widgets/datepicker.dart';
import 'package:flutter_tech_sales/widgets/upload_photo_bottomsheet.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestUpdateAction extends StatefulWidget {
  final dept, id, severity;
  final List<SrcResolutionEntity>? resolutionStatus;
  final requestType;

  RequestUpdateAction(
      {this.dept,
      this.resolutionStatus,
      this.id,
      this.severity,
      this.requestType});

  @override
  _RequestUpdateActionState createState() => _RequestUpdateActionState();
}

class _RequestUpdateActionState extends State<RequestUpdateAction> {
  UpdateServiceRequestController updateServiceRequestController = Get.find();
  UpdateSRModel? _updateSRModel;
  UpdateServiceRequestController updateRequest = Get.find();
  Position? _currentPosition;
  final _updateActionFormKey = GlobalKey<FormState>();
  TextEditingController _location = TextEditingController();
  TextEditingController _noOfBags = TextEditingController();
  TextEditingController _comment = TextEditingController();
  TextEditingController _batchNo = TextEditingController();
  TextEditingController _sourcePlant = TextEditingController();
  String? _productComplaint;
  String? _techVan;
  String? _productType;
  int? _resolutionStatus;
  String? _requestNature;
  TextEditingController _dateOfPurchase = TextEditingController();
  TextEditingController _nextVisitDate = TextEditingController();
  List<File> _imageList = List<File>.empty(growable: true);
  String? _selectedTypeOfComplain;

  var _balanceQuantity = new TextEditingController();
  var _billNo = new TextEditingController();
  var _weekNo = new TextEditingController();
  var _sampleToBeSent = new TextEditingController();
  var _detailsOfDemoConducted = new TextEditingController();
  var _bestBeforeDate = new TextEditingController();
  var _mtController = new TextEditingController();
  String? _selectedSampleCollected;
  String? _gropuSampleCollected;
  String? _groupDemoConducted;
  String? _selectedDemoConducted;

  Map<String, bool?> values = {
    'OPC': false,
    'PPC': false,
    'CC': false,
    'PSC': false,
  };

  var varietyTmpArray = [];

  getCheckboxItems() {
    values.forEach((key, value) {
      if (value == true) {
        varietyTmpArray.add(key);
      }
    });
    return varietyTmpArray;
  }

  @override
  void initState() {
    varietyTmpArray = [];
    UploadImageBottomSheet.image = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateServiceRequestController>(builder: (controller) {
      return Form(
        key: _updateActionFormKey,
        child: Column(
          children: [
            DropdownButtonFormField(
              onChanged: (dynamic value) {
                setState(() {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  _requestNature = value;
                });
              },
              items: ['GENIUNE', 'NOT GENIUNE']
                  .map((e) => DropdownMenuItem(
                        child: Text(
                          e,
                        ),
                        value: e,
                      ))
                  .toList(),
              style: FormFieldStyle.formFieldTextStyle,
              decoration: FormFieldStyle.buildInputDecoration(
                  labelText: "Request Nature*"),
              validator: (dynamic value) =>
                  value == null ? 'Please select the Request Nature' : null,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _location,
              style: FormFieldStyle.formFieldTextStyle,
              keyboardType: TextInputType.text,
              decoration:
                  FormFieldStyle.buildInputDecoration(labelText: "Location"),
            ),
            SizedBox(height: 16),
            TextButton.icon(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                    side: BorderSide(color: Colors.black26)),
                backgroundColor: Colors.transparent,
              ),
              icon: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  Icons.location_searching,
                  color: HexColor("#F9A61A"),
                  size: 18,
                ),
              ),
              label: Padding(
                padding: const EdgeInsets.only(right: 5, bottom: 8, top: 5),
                child: Text(
                  "DETECT",
                  style: TextStyle(
                      color: HexColor("#F9A61A"),
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
              onPressed: () async {
                // showDialog(
                //     context: context,
                //     barrierDismissible: false,
                //     builder: (BuildContext context) {
                //       return new WillPopScope(
                //           onWillPop: (() => null) as Future<bool> Function()?,
                //           child: Center(
                //             child: CircularProgressIndicator(),
                //           ));
                //     });
                Get.rawSnackbar(title: "Message",message: StringConstants.ACCESS_LOCATION);
                LocationDetails result;
                result = await GetCurrentLocation.getCurrentLocation();
                  // Get.back();
                  _currentPosition = result.position;
                  List<String> loc = result.loc;
                  _location.text = "${loc[2]}, ${loc[3]}, ${loc[5]}";
              }
            ),
            SizedBox(
              height: 16,
              child: Divider(),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.white)),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 5, bottom: 10, top: 10),
                    child: Text(
                      "UPLOAD PHOTOS",
                      style: TextStyle(
                          color: HexColor("#1C99D4"),
                          fontWeight: FontWeight.bold,
                          // letterSpacing: 2,
                          fontSize: 17),
                    ),
                  ),
                  onPressed: () async {
                    controller.updateImageList(
                        await UploadImageBottomSheet.showPicker(context));

                    // setState(() {
                    //   _imageList = UploadImageBottomSheet.showPicker(context);
                    // });
                  }),
            ),
            controller.imageList != null
                ? Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.imageList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                   showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: new Container(
                                            // width: 500,
                                            // height: 500,
                                            child: Image.file(
                                                controller.imageList[index]),
                                          ),
                                        );
                                      });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Picture ${(index + 1)}. ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          "Image_${(index + 1)}.jpg",
                                          style: TextStyle(
                                              color: HexColor("#007CBF"),
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      child: Icon(
                                        Icons.delete,
                                        color: HexColor("#FFCD00"),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          controller
                                              .updateImageAfterDelete(index);
                                          UploadImageBottomSheet.image = null;
                                          // controller.imageList.removeAt(index);
                                        });
                                      },
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  )
                : Container(
                    color: Colors.blue,
                    height: 10,
                  ),
            widget.requestType == "Complaint".toUpperCase()
                ? Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.only(top: 5, left: 2),
                          child: Text("Type of complaint",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Muli",
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Radio(
                                    value: 'Written'.toUpperCase(),
                                    groupValue: _selectedTypeOfComplain,
                                    onChanged: (dynamic value) {
                                      setState(() {
                                        _selectedTypeOfComplain = value;
                                      });
                                    }),
                                Expanded(
                                  child: Text('Written'.toUpperCase()),
                                )
                              ],
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Radio(
                                    value: 'Verbal'.toUpperCase(),
                                    groupValue: _selectedTypeOfComplain,
                                    onChanged: (dynamic value) {
                                      setState(() {
                                        _selectedTypeOfComplain = value;
                                      });
                                    }),
                                Expanded(child: Text('Verbal'.toUpperCase()))
                              ],
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                    ],
                  )
                : Container(),
            SizedBox(height: 16),
            DropdownButtonFormField(
              style: FormFieldStyle.formFieldTextStyle,
              decoration: FormFieldStyle.buildInputDecoration(
                  labelText: "Product Complaint"),
              items: ['YES', 'NO']
                  .map(
                    (e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    ),
                  )
                  .toList(),
              onChanged: (dynamic val) {
                setState(() {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  _productComplaint = val;
                });
              },
              validator: (dynamic value) =>
                  value == null ? 'This field cannot be empty' : null,
            ),
            SizedBox(height: 16),
            widget.requestType == "Complaint".toUpperCase() &&
                    _productComplaint == "YES"
                ? Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.only(top: 5, left: 2),
                          child: Text("Variety",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Muli",
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      ),
                      Container(
                        height: 40,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: values.keys.map((String key) {
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.23,
                              child: new CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                dense: true,
                                contentPadding:
                                    EdgeInsets.only(top: 0, left: 0, right: 0),
                                title: new Text(
                                  key,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                                value: values[key],
                                checkColor: Colors.white,
                                onChanged: (bool? value) {
                                  setState(() {
                                    values[key] = value;
                                  });
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, bottom: 20, left: 5),
                            child: Text(
                              "Balance quantity",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  fontFamily: "Muli"),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: TextFormField(
                                    controller: _balanceQuantity,
                                    onChanged: (_) {
                                      setState(() {
                                        if (
                                            _balanceQuantity.text == "") {
                                          _mtController.clear();
                                        } else {
                                          _mtController.text = (int.parse(
                                                      _balanceQuantity.text) /
                                                  20)
                                              .toString();
                                        }
                                      });
                                    },
                                    style: FormFieldStyle.formFieldTextStyle,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r"[0-9.]")),
                                      TextInputFormatter.withFunction(
                                          (oldValue, newValue) {
                                        try {
                                          final text = newValue.text;
                                          if (text.isNotEmpty)
                                            double.parse(text);
                                          return newValue;
                                        } catch (e) {}
                                        return oldValue;
                                      }),
                                    ],
                                    decoration:
                                        FormFieldStyle.buildInputDecoration(
                                      labelText: "Bags",
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: TextFormField(
                                    controller: _mtController,
                                    onChanged: (value) {
                                      setState(() {
                                        if (
                                            _mtController.text == "") {
                                          _balanceQuantity.clear();
                                        } else {
                                          _balanceQuantity.text = (double.parse(
                                                      _mtController.text) *
                                                  20)
                                              .toInt()
                                              .toString();
                                        }
                                      });
                                    },
                                    style: FormFieldStyle.formFieldTextStyle,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r"[0-9.]")),
                                      TextInputFormatter.withFunction(
                                          (oldValue, newValue) {
                                        try {
                                          final text = newValue.text;
                                          if (text.isNotEmpty)
                                            double.parse(text);
                                          return newValue;
                                        } catch (e) {}
                                        return oldValue;
                                      }),
                                    ],
                                    decoration:
                                        FormFieldStyle.buildInputDecoration(
                                      labelText: "MT",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _billNo,
                        style: FormFieldStyle.formFieldTextStyle,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            try {
                              final text = newValue.text;
                              if (text.isNotEmpty) double.parse(text);
                              return newValue;
                            } catch (e) {}
                            return oldValue;
                          }),
                        ],
                        decoration: FormFieldStyle.buildInputDecoration(
                          labelText: "Bill No.",
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _weekNo,
                        style: FormFieldStyle.formFieldTextStyle,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            try {
                              final text = newValue.text;
                              if (text.isNotEmpty) double.parse(text);
                              return newValue;
                            } catch (e) {}
                            return oldValue;
                          }),
                        ],
                        decoration: FormFieldStyle.buildInputDecoration(
                          labelText: "Week No.",
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _bestBeforeDate,
                        readOnly: true,
                        onChanged: (data) {
                                              },
                        style: TextStyle(
                            fontSize: 18,
                            color: ColorConstants.inputBoxHintColor,
                            fontFamily: "Muli"),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorConstants.backgroundColorBlue,
                                width: 1.0),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black26, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black26, width: 1.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 1.0),
                          ),
                          labelText: "Best Before Date",
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.date_range_rounded,
                              size: 22,
                              color: ColorConstants.clearAllTextColor,
                            ),
                            onPressed: () async {
                              print("here");
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2001),
                                lastDate: DateTime.now(),
                              );
                              setState(() {
                                final DateFormat formatter =
                                    DateFormat("yyyy-MM-dd");
                                if (picked != null) {
                                  final String formattedDate =
                                      formatter.format(picked);
                                  _bestBeforeDate.text = formattedDate;
                                }
                              });
                            },
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
                      SizedBox(height: 10),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.only(top: 5, left: 2),
                              child: Text("Sample Collected",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Muli",
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Radio(
                                        value: 'Yes'.toUpperCase(),
                                        groupValue: _gropuSampleCollected,
                                        onChanged: (dynamic value) {
                                          setState(() {
                                            _gropuSampleCollected = value;
                                            _selectedSampleCollected = "Y";
                                          });
                                        }),
                                    Expanded(
                                      child: Text('Yes'.toUpperCase()),
                                    )
                                  ],
                                ),
                                flex: 1,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Radio(
                                        value: 'No'.toUpperCase(),
                                        groupValue: _gropuSampleCollected,
                                        onChanged: (dynamic value) {
                                          setState(() {
                                            _gropuSampleCollected = value;
                                            _selectedSampleCollected = "N";
                                          });
                                        }),
                                    Expanded(child: Text('No'.toUpperCase()))
                                  ],
                                ),
                                flex: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _sampleToBeSent,
                        maxLength: 50,
                        maxLines: 2,
                        style: FormFieldStyle.formFieldTextStyle,
                        keyboardType: TextInputType.text,
                        decoration: FormFieldStyle.buildInputDecoration(
                          labelText: "Sample to be sent",
                        ),
                      ),
                      SizedBox(height: 10),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.only(top: 5, left: 2),
                              child: Text("Demo Conducted",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Muli",
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Radio(
                                        value: 'Yes'.toUpperCase(),
                                        groupValue: _groupDemoConducted,
                                        onChanged: (dynamic value) {
                                          setState(() {
                                            _groupDemoConducted = value;
                                            _selectedDemoConducted = "Y";
                                          });
                                        }),
                                    Expanded(
                                      child: Text('Yes'.toUpperCase()),
                                    )
                                  ],
                                ),
                                flex: 1,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Radio(
                                        value: 'No'.toUpperCase(),
                                        groupValue: _groupDemoConducted,
                                        onChanged: (dynamic value) {
                                          setState(() {
                                            _groupDemoConducted = value;
                                            _selectedDemoConducted = "N";
                                          });
                                        }),
                                    Expanded(child: Text('No'.toUpperCase()))
                                  ],
                                ),
                                flex: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _detailsOfDemoConducted,
                        maxLength: 100,
                        maxLines: 3,
                        style: FormFieldStyle.formFieldTextStyle,
                        keyboardType: TextInputType.text,
                        decoration: FormFieldStyle.buildInputDecoration(
                          labelText: "Details of demo conducted",
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  )
                : Container(),
            widget.dept == 'TECHNICAL SERVICES'
                ? DropdownButtonFormField(
                    style: FormFieldStyle.formFieldTextStyle,
                    decoration: FormFieldStyle.buildInputDecoration(
                        labelText: "TechVan Required"),
                    items: ['YES', 'NO']
                        .map(
                          (e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ),
                        )
                        .toList(),
                    onChanged: (dynamic val) {
                      setState(() {
                        _techVan = val;
                      });
                    },
                    validator: (dynamic value) =>
                        value == null ? 'This field cannot be empty' : null,
                  )
                : Container(),
            widget.dept == 'TECHNICAL SERVICES'
                ? SizedBox(height: 16)
                : Container(),
            _productComplaint == 'YES'
                ? Column(
                    children: [
                      DropdownButtonFormField(
                        style: FormFieldStyle.formFieldTextStyle,
                        decoration: FormFieldStyle.buildInputDecoration(
                            labelText: "Product Type"),
                        items: ['DCFT', 'DSP', 'KONARK']
                            .map(
                              (e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ),
                            )
                            .toList(),
                        onChanged: (dynamic val) {
                          setState(() {
                            _productType = val;
                          });
                        },
                        validator: (dynamic value) =>
                            (value == null) && (_productComplaint == 'YES')
                                ? 'Please select the Product Type'
                                : null,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _batchNo,
                        decoration: FormFieldStyle.buildInputDecoration(
                          labelText: 'Batch No.',
                        ),
                        validator: (value) =>
                            (value!.isEmpty) && (_productComplaint == 'YES')
                                ? 'Please select the Product Type'
                                : null,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _dateOfPurchase,
                        readOnly: true,
                        onTap: () => PickDate.selectDate(
                                context: context, lastDate: DateTime.now())
                            .then(
                          (value) => value==null
                              ? null
                              : setState(
                                  () {
                                    final DateFormat formatter =
                                        DateFormat("yyyy-MM-dd");
                                    _dateOfPurchase.text =
                                        formatter.format(value);
                                  },
                                ),
                        ),
                        decoration: FormFieldStyle.buildInputDecoration(
                          labelText: 'Date of Purchase',
                          suffixIcon: Icon(
                            Icons.calendar_today_outlined,
                            color: HexColor('#F9A61A'),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _sourcePlant,
                        style: FormFieldStyle.formFieldTextStyle,
                        keyboardType: TextInputType.text,
                        decoration: FormFieldStyle.buildInputDecoration(
                            labelText: "Source Plant"),
                        validator: (value) =>
                            (value!.isEmpty) && (_productComplaint == 'YES')
                                ? 'Please enter the details about source plant'
                                : null,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _noOfBags,
                        style: FormFieldStyle.formFieldTextStyle,
                        keyboardType: TextInputType.phone,
                        decoration: FormFieldStyle.buildInputDecoration(
                            labelText: "No. of Bags"),
                        validator: (value) =>
                            (value!.isEmpty) && (_productComplaint == 'YES')
                                ? 'Please enter the number of bags'
                                : null,
                      ),
                      SizedBox(height: 16),
                    ],
                  )
                : Container(),
            DropdownButtonFormField(
              style: FormFieldStyle.formFieldTextStyle,
              decoration: FormFieldStyle.buildInputDecoration(
                  labelText: "Resolution Status*"),
              items: widget.resolutionStatus != null
                  ? widget.resolutionStatus!
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text(e.resolutionText!),
                          value: e.id,
                        ),
                      )
                      .toList()
                  : [],
              onChanged: (dynamic val) {
                _resolutionStatus = val;
              },
              validator: (dynamic value) =>
                  value == null ? 'Please select the Resolution Status' : null,
            ),
            SizedBox(height: 16),
            TextFormField(
              maxLines: 4,
              controller: _comment,
              maxLength: 500,
              style: FormFieldStyle.formFieldTextStyle,
              keyboardType: TextInputType.text,
              decoration:
                  FormFieldStyle.buildInputDecoration(labelText: "Comment*"),
            ),
            TextFormField(
              style: FormFieldStyle.formFieldTextStyle,
              readOnly: true,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter the next visit date' : null,
              controller: _nextVisitDate,
              onTap: () => PickDate.selectDate(
                      context: context, firstDate: DateTime.now())
                  .then((value) => value==null
                      ? null
                      : setState(() {
                          final DateFormat formatter = DateFormat("yyyy-MM-dd");
                          _nextVisitDate.text = formatter.format(value);
                        })),
              decoration: FormFieldStyle.buildInputDecoration(
                  labelText: "Next visit date*",
                  suffixIcon: Icon(
                    Icons.calendar_today_outlined,
                    color: HexColor('#F9A61A'),
                  )),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (!_updateActionFormKey.currentState!.validate()) {
                  Get.rawSnackbar(
                      message: 'All fields are mandatory',
                      title: 'Warning:',
                      backgroundColor: Colors.red);
                } else {
                  String? empId = await (getEmpId() );
                  List imageDetails = List.empty(growable: true);
                  _imageList.forEach((element) {
                    setState(() {
                      imageDetails.add({
                        //ToDo: Change srComplaint Id to some dynamic value
                        'srComplaintId': widget.id,
                        'photoName': element.path.split('/').last,
                      });
                    });
                  });

                  _updateSRModel = UpdateSRModel.fromJson({
                    "id": widget.id,
                    "severity": widget.severity,
                    "resoulutionStatus": _resolutionStatus,
                    "updatedBy": empId,
                    "coverBlockProvidedNo": updateServiceRequestController
                        .coverBlockProvidedNo.text,
                    "formwarkRemovalDate":
                        updateServiceRequestController.formwarkRemovalDate.text,
                    "srComplaintAction": [
                      {
                        "srComplaintId": widget.id,
                        "requestNature": _requestNature,
                        "locationLat": _currentPosition!.latitude,
                        "locationLong": _currentPosition!.longitude,
                        "productComplaint": _productComplaint,
                        "productType": _productType,
                        "techvanReqd": _techVan,
                        "purchaseDate": _dateOfPurchase.text,
                        "sourcePlant": _sourcePlant.text,
                        "productBatch": _batchNo.text,
                        "bagsCount": _noOfBags.text.isNotEmpty
                            ? int.parse(_noOfBags.text)
                            : 0,
                        "resolutionStatusId": _resolutionStatus,
                        "comment": _comment.text,
                        "nextVisitDate": _nextVisitDate.text,
                        "typeOfComplaint": _selectedTypeOfComplain,
                        "productVariety": getCheckboxItems().toString(),
                        "balanceQtyinBags": _balanceQuantity.text.isNotEmpty
                            ? int.parse(_balanceQuantity.text)
                            : 0,
                        "billNumber": _billNo.text,
                        "weekNo": _weekNo.text,
                        "bestBeforeDate": _bestBeforeDate.text,
                        "sampleCollected": _selectedSampleCollected,
                        "sampleTOBeSentTo": _sampleToBeSent.text,
                        "demoConducted": _selectedDemoConducted,
                        "detailsOfDemo": _detailsOfDemoConducted.text
                      }
                    ],
                    "srcActionPhotosEntity": imageDetails
                  });
                  updateRequest.getAccessKeyAndUpdateRequest(
                      _imageList, _updateSRModel);
                }
              },
              style: ElevatedButton.styleFrom(
              primary: HexColor("#1C99D4"),),
              child: Text(
                "UPDATE",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
            ),
          ],
        ),
      );
    });
  }

  Future getEmpId() async {
    String? empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      empID = prefs.getString(StringConstants.employeeId);
    });
    return empID;
  }

  @override
  void dispose() {
    updateRequest.imageList.clear();
    super.dispose();
  }
}
