import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/controller/get_sr_complaint_data_controller.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/controller/save_service_request_controller.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/AddSrComplaintModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/RequestorDetailsModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/SaveServiceRequestModel.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/SiteAreaDetailsModel.dart';

class RequestCreation extends StatefulWidget {
  @override
  _RequestCreationState createState() => _RequestCreationState();
}

class _RequestCreationState extends State<RequestCreation> {
  SrComplaintModel srComplaintModel;
  RequestorDetailsModel requestorDetailsModel;
  SrFormDataController eventController = Get.find();
  SaveServiceRequestController saveRequest = Get.find();
  List<File> _imageList = List<File>();
  SaveServiceRequest saveServiceRequest;

  Future getEmpId() async {
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      empID = prefs.getString(StringConstants.employeeId);
    });
    return empID;
  }

  getDropdownData() async {
    await eventController.getAccessKey().then((value) async {
      // print(value.accessKey);
      await eventController
          .getSrComplaintFormData(value.accessKey)
          .then((data) {
        setState(() {
          srComplaintModel = data;
        });
        print(data.toJson());
      });
    });
  }

  getRequestorData(String requestorType) async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    await eventController.getAccessKey().then((value) async {
      await eventController
          .getRequestorDetails(value.accessKey, requestorType)
          .then((data) {
        if (data != null) {
          setState(() {
            requestorDetailsModel = data;
          });
          for (int i = 0;
              i < requestorDetailsModel.srComplaintRequesterList.length;
              i++) {
            setState(() {
              suggestions.add(requestorDetailsModel
                      .srComplaintRequesterList[i].requesterName +
                  " (${requestorDetailsModel.srComplaintRequesterList[i].requesterCode})");
            });
          }
        }
        _requestorName.text = '';
        _customerID.text = '';
        Get.back();
      });
    });
  }

  List<String> suggestions = [];
  final _formKey = GlobalKey<FormState>();
  TextEditingController _requestSubType = TextEditingController();
  TextEditingController _severity = TextEditingController();
  TextEditingController _siteID = TextEditingController();
  TextEditingController _customerID = TextEditingController();
  TextEditingController _requestorContact = TextEditingController();
  TextEditingController _requestorName = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _state = TextEditingController();
  TextEditingController _district = TextEditingController();
  TextEditingController _taluk = TextEditingController();
  TextEditingController _pin = TextEditingController();
  int requestDepartmentId;
  int requestId;
  String creatorType;
  bool isComplaint;

  // GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  // GlobalKey<AutoCompleteTextFieldState<String>> key1 = new GlobalKey();

  @override
  void initState() {
    getDropdownData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BackFloatingButton(),
      bottomNavigationBar: BottomNavigatorWithoutDraftsAndSearch(),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 200,
            right: 0,
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/Container.png',
                    fit: BoxFit.fitHeight,
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: srComplaintModel != null
                ? ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        height: 56,
                        child: Text(
                          'Request Creation',
                          style: TextStyle(
                              fontSize: 20,
                              color: HexColor('#006838'),
                              fontFamily: "Muli"),
                        ),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 0.3))),
                      ),
                      // SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                DropdownButtonFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      requestDepartmentId = value;
                                    });
                                  },
                                  items: srComplaintModel
                                      .serviceRequestComplaintDepartmentEntity
                                      .map((e) => DropdownMenuItem(
                                            value: e.id,
                                            child: Text(e.departmentText),
                                          ))
                                      .toList(),
                                  style: FormFieldStyle.formFieldTextStyle,
                                  decoration:
                                      FormFieldStyle.buildInputDecoration(
                                          labelText: "Department*"),
                                  validator: (value) => value == null
                                      ? 'Please select the Department'
                                      : null,
                                ),
                                SizedBox(height: 16),
                                DropdownButtonFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      selectedRequestSubtypeSeverity = [];
                                      selectedRequestSubtypeObjectList = [];
                                      selectedRequestSubtype = [];
                                      _severity.text = '';
                                      requestId = value;
                                      requestId == 2
                                          ? isComplaint = true
                                          : isComplaint = false;
                                    });
                                  },
                                  items: srComplaintModel
                                      .serviceRequestComplaintRequestEntity
                                      .map((e) => DropdownMenuItem(
                                            value: e.id,
                                            child: Text(e.requestText),
                                          ))
                                      .toList(),
                                  style: FormFieldStyle.formFieldTextStyle,
                                  decoration:
                                      FormFieldStyle.buildInputDecoration(
                                          labelText: "Request Type*"),
                                  validator: (value) => value == null
                                      ? 'Please select the Request Type'
                                      : null,
                                ),
                                SizedBox(height: 16),
                                GestureDetector(
                                  onTap: () => requestId == null
                                      ? Get.rawSnackbar(
                                          titleText: Text("Message"),
                                          messageText: Text(
                                              "Please select a Request type"),
                                          backgroundColor: Colors.white,
                                        )
                                      : getBottomSheet(),
                                  child: FormField(
                                    validator: (value) => value,
                                    builder: (state) {
                                      return InputDecorator(
                                        decoration:
                                            FormFieldStyle.buildInputDecoration(
                                          labelText: 'Request Sub-type*',
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0, horizontal: 12),
                                            child: Text(
                                              'Select',
                                              style: TextStyle(
                                                color: HexColor('#F9A61A'),
                                              ),
                                            ),
                                          ),
                                        ),
                                        child:
                                            selectedRequestSubtypeObjectList
                                                    .isEmpty
                                                ? Text('')
                                                : Container(
                                                    height: 30,
                                                    child: ListView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      children:
                                                          selectedRequestSubtypeObjectList
                                                              .map(
                                                                  (e) =>
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(horizontal: 4.0),
                                                                        child:
                                                                            Chip(
                                                                          label:
                                                                              Text(
                                                                            e.serviceRequestTypeText,
                                                                            style:
                                                                                TextStyle(fontSize: 10),
                                                                          ),
                                                                          backgroundColor: Colors
                                                                              .lightGreen
                                                                              .withOpacity(0.2),
                                                                        ),
                                                                      ))
                                                              .toList(),
                                                    ),
                                                  ),
                                      );
                                    },
                                    // controller: _requestSubType,
                                    // onTap: getBottomSheet,
                                    // style: FormFieldStyle.formFieldTextStyle,
                                    // decoration:
                                    //     FormFieldStyle.buildInputDecoration(
                                    //   labelText: "Request Sub-type*",
                                    //   suffixIcon: Padding(
                                    //     padding: const EdgeInsets.symmetric(
                                    //         vertical: 10.0, horizontal: 12),
                                    //     child: Text(
                                    //       'Select',
                                    //       style: TextStyle(
                                    //         color: HexColor('#F9A61A'),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    // readOnly: true,
                                    // validator: (value)=> value.isEmpty? 'Please select the Request subtype': null,
                                  ),
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  controller: _severity,
                                  style: FormFieldStyle.formFieldTextStyle,
                                  keyboardType: TextInputType.text,
                                  readOnly: true,
                                  decoration:
                                      FormFieldStyle.buildInputDecoration(
                                          labelText: "Severity"),
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  onChanged: (val) async {
                                    if (val.length == 6) {
                                      SiteAreaModel siteDetails =
                                          await eventController
                                              .getSiteAreaDetails(_siteID.text);
                                      siteDetails.siteAreaDetailsModel != null
                                          ? setState(() {
                                              _pin.text = siteDetails
                                                  .siteAreaDetailsModel
                                                  .sitePincode;
                                              _state.text = siteDetails
                                                  .siteAreaDetailsModel
                                                  .siteState;
                                              _taluk.text = siteDetails
                                                  .siteAreaDetailsModel
                                                  .siteTaluk;
                                              _district.text = siteDetails
                                                  .siteAreaDetailsModel
                                                  .siteDistrict;
                                            })
                                          : Get.rawSnackbar(
                                              title: "Message",
                                              message: siteDetails.respMsg);
                                    }
                                  },
                                  controller: _siteID,
                                  maxLength: 6,
                                  validator: (value) => value.isEmpty
                                      ? 'Please enter the Site ID'
                                      : null,
                                  style: FormFieldStyle.formFieldTextStyle,
                                  keyboardType: TextInputType.phone,
                                  decoration:
                                      FormFieldStyle.buildInputDecoration(
                                          labelText: "Site ID*"),
                                ),
                                SizedBox(height: 16),
                                DropdownButtonFormField(
                                  validator: (value) => value == null
                                      ? 'Please select Customer Type'
                                      : null,
                                  onChanged: (value) {
                                    setState(() {
                                      FocusScope.of(context).requestFocus(new FocusNode());
                                      creatorType = value;
                                    });
                                    getRequestorData(value);
                                  },
                                  items: [
                                    'IHB',
                                    'Dealer',
                                    'SUBDEALER',
                                    'SALESOFFICER'
                                  ]
                                      .map((e) => DropdownMenuItem(
                                            child: Text(
                                              e.toUpperCase(),
                                            ),
                                            value: e,
                                          ))
                                      .toList(),
                                  style: FormFieldStyle.formFieldTextStyle,
                                  decoration:
                                      FormFieldStyle.buildInputDecoration(
                                          labelText: "Customer Type"),
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  validator: (value) => value.isEmpty
                                      ? 'Please select the Customer ID'
                                      : null,
                                  controller: _customerID,
                                  readOnly: true,
                                  onTap: () {
                                    requestorDetailsModel == null
                                        ? Get.rawSnackbar(
                                            titleText: Text("Message"),
                                            messageText: Text(
                                                "Please select a customer type"),
                                            backgroundColor: Colors.white,
                                          )
                                        : Get.bottomSheet(requestorDetails());
                                  },
                                  style: FormFieldStyle.formFieldTextStyle,
                                  decoration:
                                      FormFieldStyle.buildInputDecoration(
                                    labelText: "Customer ID*",
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 12),
                                      child: Text(
                                        'Select',
                                        style: TextStyle(
                                          color: HexColor('#F9A61A'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                // SimpleAutoCompleteTextField(
                                //   key: key,
                                //   decoration: FormFieldStyle.buildInputDecoration(
                                //       labelText: "Customer ID*"),
                                //   controller: _customerID,
                                //   suggestions: suggestions,
                                //   // textChanged: (text) => setState(() {
                                //   //   _customerID.text = text;
                                //   // }),
                                //   clearOnSubmit: false,
                                //   textSubmitted: (text) => setState(() {
                                //     _requestorName.text = text
                                //         .replaceAll('(', '.')
                                //         .replaceAll(')', '')
                                //         .split('.')
                                //         .first;
                                //     _customerID.text = text
                                //         .replaceAll(' ', '')
                                //         .replaceAll('(', '.')
                                //         .replaceAll(')', '')
                                //         .split('.')
                                //         .last;
                                //     print(_customerID.text);
                                //   }),
                                // ),
                                // SizedBox(height: 16),
                                TextFormField(
                                  controller: _requestorContact,
                                  enableInteractiveSelection: false,
                                  style: FormFieldStyle.formFieldTextStyle,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  maxLength: 10,
                                  validator: (value) => value.isEmpty ||
                                          value.length != 10
                                      ? 'Please enter a valid Contact Number'
                                      : null,
                                  decoration:
                                      FormFieldStyle.buildInputDecoration(
                                          labelText: "Requestor Contact*"),
                                ),
                                SizedBox(height: 2),
                                TextFormField(
                                  controller: _requestorName,
                                  style: FormFieldStyle.formFieldTextStyle,
                                  readOnly: true,
                                  decoration:
                                      FormFieldStyle.buildInputDecoration(
                                          labelText: "Requestor Name"),
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  controller: _description,
                                  maxLines: 4,
                                  maxLength: 500,
                                  style: FormFieldStyle.formFieldTextStyle,
                                  keyboardType: TextInputType.text,
                                  decoration:
                                      FormFieldStyle.buildInputDecoration(
                                          labelText: "Description"),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      side: BorderSide(color: Colors.black26),
                                    ),
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 5, bottom: 10, top: 10),
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
                                      if (_imageList.length < 5) {
                                        // _showPicker(context);
                                        _imgFromCamera();
                                      } else {
                                        Get.dialog(CustomDialogs().errorDialog(
                                            "You can add only upto 5 photos"));
                                      }
                                    },
                                  ),
                                ),
                                _imageList != null
                                    ? Row(
                                        children: [
                                          Expanded(
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: _imageList.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      return showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              content:
                                                                  new Container(
                                                                // width: 500,
                                                                // height: 500,
                                                                child: Image.file(
                                                                    _imageList[
                                                                        index]),
                                                              ),
                                                            );
                                                          });
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Picture ${(index + 1)}. ",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15),
                                                            ),
                                                            Text(
                                                              "Image_${(index + 1)}.jpg",
                                                              style: TextStyle(
                                                                  color: HexColor(
                                                                      "#007CBF"),
                                                                  fontSize: 15),
                                                            ),
                                                          ],
                                                        ),
                                                        GestureDetector(
                                                          child: Icon(
                                                            Icons.delete,
                                                            color: HexColor(
                                                                "#FFCD00"),
                                                          ),
                                                          onTap: () {
                                                            setState(() {
                                                              _imageList
                                                                  .removeAt(
                                                                      index);
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
                                SizedBox(
                                  height: 16,
                                ),
                                _imageList.length != 0
                                    ? Divider(
                                        color: Colors.black26,
                                        thickness: 1,
                                      )
                                    : Container(),
                                TextFormField(
                                  controller: _state,
                                  readOnly: true,
                                  style: FormFieldStyle.formFieldTextStyle,
                                  // validator: (value)=> value.isEmpty? 'Please select the Customer ID': null,
                                  keyboardType: TextInputType.text,
                                  decoration:
                                      FormFieldStyle.buildInputDecoration(
                                          labelText: "State"),
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  controller: _district,
                                  readOnly: true,
                                  style: FormFieldStyle.formFieldTextStyle,
                                  keyboardType: TextInputType.text,
                                  decoration:
                                      FormFieldStyle.buildInputDecoration(
                                          labelText: "District"),
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  controller: _taluk,
                                  readOnly: true,
                                  style: FormFieldStyle.formFieldTextStyle,
                                  keyboardType: TextInputType.text,
                                  decoration:
                                      FormFieldStyle.buildInputDecoration(
                                          labelText: "Taluk"),
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  controller: _pin,
                                  readOnly: true,
                                  style: FormFieldStyle.formFieldTextStyle,
                                  keyboardType: TextInputType.phone,
                                  decoration:
                                      FormFieldStyle.buildInputDecoration(
                                          labelText: "Pincode"),
                                ),
                                SizedBox(height: 16),
                                RaisedButton(
                                  onPressed: () async {
                                    if (!_formKey.currentState.validate()) {
                                      print("Error");
                                      Get.dialog(CustomDialogs().errorDialog(
                                          'Please enter the mandatory details'));
                                    } else if (_severity.text == "") {
                                      Get.defaultDialog(
                                          title: "Message",
                                          middleText:
                                              "Request Sub-type and Severity cannot be empty");
                                    } else {
                                      String empId = await getEmpId();
                                      List imageDetails = List();
                                      List subTypeDetails = List();
                                      selectedRequestSubtypeObjectList
                                          .forEach((element) {
                                        setState(() {
                                          subTypeDetails.add({
                                            "createdBy": empId,
                                            "serviceRequestComplaintId": null,
                                            "serviceRequestComplaintTypeId":
                                                element.id
                                          });
                                        });
                                      });

                                      _imageList.forEach((element) {
                                        setState(() {
                                          imageDetails.add({
                                            //ToDo: Change srComplaint Id to some dynamic value
                                            'srComplaintId': null,
                                            'photoName':
                                                element.path.split('/').last,
                                            'createdBy': empId
                                          });
                                        });
                                      });
                                      SaveServiceRequest _saveServiceRequest =
                                          SaveServiceRequest.fromJson({
                                        "createdBy": empId,
                                        "creatorContactNumber":
                                            _requestorContact.text,
                                        "creatorId": _customerID.text,
                                        "creatorType": creatorType,
                                        "description": _description.text,
                                        "district": _district.text,
                                        "pincode": _pin.text,
                                        "requestDepartmentId":
                                            requestDepartmentId,
                                        "requestId": requestId,
                                        "resolutionStatusId": 1,
                                        "siteId": int.parse(_siteID.text),
                                        "severity": _severity.text,
                                        "srComplaintPhotosEntity": imageDetails,
                                        "srComplaintSubtypeMappingEntity":
                                            subTypeDetails,
                                        "state": _state.text,
                                        "taluk": _taluk.text
                                      });
                                      saveRequest.getAccessKeyAndSaveRequest(
                                          _imageList, _saveServiceRequest);
                                      // print(_saveServiceRequest);
                                    }
                                  },
                                  color: HexColor("#1C99D4"),
                                  child: Text(
                                    "SUBMIT",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        // letterSpacing: 2,
                                        fontSize: 17),
                                  ),
                                ),
                                SizedBox(height: 50),
                              ],
                            )),
                      )
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ],
      ),
    );
  }

  List<bool> checkedValues;
  List<String> selectedRequestSubtype = [];
  List<String> selectedRequestSubtypeSeverity = [];
  List<ServiceRequestComplaintTypeEntity> selectedRequestSubtypeObjectList = [];
  // List<ServiceRequestComplaintTypeEntity> dataToBeSentBack = List<ServiceRequestComplaintTypeEntity>();
  // ServiceRequestComplaintTypeEntity dataToBeSentBack;
  TextEditingController _query = TextEditingController();

  requestSubTypeBottomSheetWidget() {
    List<ServiceRequestComplaintTypeEntity> requestSubtype =
        srComplaintModel.serviceRequestComplaintTypeEntity;
    checkedValues = List.generate(
        srComplaintModel.serviceRequestComplaintTypeEntity.length,
        (index) => false);
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
                    'Request Sub-type*',
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
                    requestSubtype = srComplaintModel
                        .serviceRequestComplaintTypeEntity
                        .where((element) {
                      return element.serviceRequestTypeText
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
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemCount: requestSubtype.length,
                itemBuilder: (context, index) {
                  return requestId == requestSubtype[index].requestId
                      ? CheckboxListTile(
                          activeColor: Colors.black,
                          dense: true,
                          title: Text(
                              requestSubtype[index].serviceRequestTypeText),
                          value: selectedRequestSubtype.contains(
                              requestSubtype[index].serviceRequestTypeText),
                          onChanged: (newValue) {
                            // if (!checkedValues.contains(true) ||
                            //     checkedValues[index] == true) {
                            setState(() {
                              selectedRequestSubtype.contains(
                                      requestSubtype[index]
                                          .serviceRequestTypeText)
                                  ? selectedRequestSubtype.remove(
                                      requestSubtype[index]
                                          .serviceRequestTypeText)
                                  : selectedRequestSubtype.add(
                                      requestSubtype[index]
                                          .serviceRequestTypeText);

                              selectedRequestSubtypeObjectList
                                      .contains(requestSubtype[index])
                                  ? selectedRequestSubtypeObjectList
                                      .remove(requestSubtype[index])
                                  : selectedRequestSubtypeObjectList
                                      .add(requestSubtype[index]);

                              selectedRequestSubtypeSeverity = [];
                              selectedRequestSubtypeObjectList
                                  .forEach((element) {
                                setState(() {
                                  selectedRequestSubtypeSeverity
                                      .add(element.complaintSeverity);
                                });
                              });
                              print(selectedRequestSubtypeSeverity);

                              checkedValues[index] = newValue;
                              // dataToBeSentBack = requestSubtype[index];
                            });
                            // } else {
                            //   Get.snackbar(
                            //     'Please uncheck the previous option',
                            //     '',
                            //     snackPosition: SnackPosition.BOTTOM,
                            //   );
                            // }
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        )
                      : Container();
                },
                separatorBuilder: (context, index) {
                  return requestId == requestSubtype[index].requestId
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
                  Container(
                    width: 40,
                  ),
                  // Text(
                  //   'Clear All',
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.bold,
                  //     color: HexColor('#F6A902'),
                  //   ),
                  // ),
                  MaterialButton(
                    color: HexColor('#1C99D4'),
                    onPressed: () {
                      print(selectedRequestSubtype);
                      print(selectedRequestSubtypeSeverity);
                      if (selectedRequestSubtypeSeverity.contains('HIGH')) {
                        setState(() {
                          _severity.text = 'HIGH';
                        });
                      } else if (selectedRequestSubtypeSeverity
                          .contains('MEDIUM')) {
                        setState(() {
                          _severity.text = 'MEDIUM';
                        });
                      } else if (selectedRequestSubtypeSeverity
                          .contains('LOW')) {
                        setState(() {
                          _severity.text = 'LOW';
                        });
                      } else {
                        print('No request sub type selected');
                      }
                      // dataToBeSentBack.isEmpty
                      //     ? widget.customFunction(dataToBeSentBack)
                      //     : null;
                      // print(dataToBeSentBack);
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

  getBottomSheet() {
    Get.bottomSheet(
      requestSubTypeBottomSheetWidget(),
      // SRRequestSubTypeBottomSheet(
      //   requestID: requestId,
      //   srComplaintModel: srComplaintModel,
      //   customFunction: customFunction,
      //   isComplaint: isComplaint,
      // ),
      isScrollControlled: true,
    ).then((value) => setState(() {}));
  }

  int serviceRequestComplaintTypeId;
  // List<ServiceRequestComplaintTypeEntity> serviceRequestComplaintType;
  ServiceRequestComplaintTypeEntity serviceRequestComplaintType;
  customFunction(dataFromOtherClass) {
    setState(() {
      serviceRequestComplaintType = dataFromOtherClass;
      _requestSubType.text = serviceRequestComplaintType.serviceRequestTypeText;
      _severity.text = serviceRequestComplaintType.complaintSeverity;
      serviceRequestComplaintTypeId = serviceRequestComplaintType.id;
    });
    // serviceRequestComplaintType.map((e) {
    //   print('hi');
    // }).toList();
    print(serviceRequestComplaintTypeId);
    // print(serviceRequestComplaintType.serviceRequestTypeText);
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 10,
        maxWidth: 480,
        maxHeight: 600);
    if (image != null) {
      setState(() {
        _imageList.add(image);
      });
    }
  }


  var customer;
  requestorDetails() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) => Container(
        color: Colors.white,
        height: 300,
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              'Please select an option from the below list',
              style: TextStyles.mulliBoldYellow18,
            ),
            SizedBox(
              height: 15,
            ),
            Divider(),
            requestorDetailsModel.srComplaintRequesterList == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView(
                      children: requestorDetailsModel.srComplaintRequesterList
                          .map(
                            (e) => RadioListTile(
                                value: e,
                                title: Text(
                                    '${e.requesterName} (${e.requesterCode})'),
                                groupValue: customer,
                                onChanged: (text) {
                                  setState(() {
                                    _requestorName.text = text.requesterName;
                                    _customerID.text = text.requesterCode;
                                    customer = text;
                                  });
                                  Get.back();
                                }),
                          )
                          .toList(),
                      shrinkWrap: true,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
