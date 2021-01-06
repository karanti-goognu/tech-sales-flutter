import 'dart:io';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/controller/get_sr_complaint_data_controller.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/controller/save_service_request_controller.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/AddSrComplaintModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/RequestorDetailsModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/SaveServiceRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/widgets/subrequestBottomSheet.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> key1 = new GlobalKey();

  @override
  void initState() {
    getDropdownData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                ),
                                SizedBox(height: 16),
                                DropdownButtonFormField(
                                  onChanged: (value) {
                                    setState(() {
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
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  controller: _requestSubType,
                                  onTap: getBottomSheet,
                                  style: FormFieldStyle.formFieldTextStyle,
                                  decoration:
                                      FormFieldStyle.buildInputDecoration(
                                    labelText: "Request Sub-type*",
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
                                  readOnly: true,
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
                                  controller: _siteID,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter the site ID';
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: FormFieldStyle.formFieldTextStyle,
                                  keyboardType: TextInputType.phone,
                                  decoration:
                                      FormFieldStyle.buildInputDecoration(
                                          labelText: "Site ID"),
                                ),
                                SizedBox(height: 16),
                                DropdownButtonFormField(
                                  onChanged: (value) {
                                    setState(() {
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
                                  style: FormFieldStyle.formFieldTextStyle,
                                  keyboardType: TextInputType.phone,
                                  decoration:
                                      FormFieldStyle.buildInputDecoration(
                                          labelText: "Requestor Contact*"),
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  controller: _requestorName,
                                  style: FormFieldStyle.formFieldTextStyle,
                                  keyboardType: TextInputType.text,
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
                                  style: FormFieldStyle.formFieldTextStyle,
                                  keyboardType: TextInputType.text,
                                  decoration:
                                      FormFieldStyle.buildInputDecoration(
                                          labelText: "State"),
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  controller: _district,
                                  style: FormFieldStyle.formFieldTextStyle,
                                  keyboardType: TextInputType.text,
                                  decoration:
                                      FormFieldStyle.buildInputDecoration(
                                          labelText: "District"),
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  controller: _taluk,
                                  style: FormFieldStyle.formFieldTextStyle,
                                  keyboardType: TextInputType.text,
                                  decoration:
                                      FormFieldStyle.buildInputDecoration(
                                          labelText: "Taluk"),
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  controller: _pin,
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
                                    } else {
                                      String empId = await getEmpId();
                                      List imageDetails = List();
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
                                        "srComplaintSubtypeMappingEntity": [
                                          {
                                            "createdBy": empId,
                                            "serviceRequestComplaintId": null,
                                            "serviceRequestComplaintTypeId":
                                                serviceRequestComplaintTypeId
                                          }
                                        ],
                                        "state": _state.text,
                                        "taluk": _taluk.text
                                      });
                                      saveRequest.getAccessKeyAndSaveRequest(
                                          _imageList, _saveServiceRequest);
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
                                Container(
                                  child: _imageList.isNotEmpty
                                      ? Image.file(_imageList[0])
                                      : Container(),
                                )
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

  getBottomSheet() {
    Get.bottomSheet(
      SRRequestSubTypeBottomSheet(
        requestID: requestId,
        srComplaintModel: srComplaintModel,
        customFunction: customFunction,
        isComplaint: isComplaint,
      ),
      isScrollControlled: true,
    );
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
        source: ImageSource.gallery,
        imageQuality: 10,
        maxWidth: 480,
        maxHeight: 600);
    if (image != null) {
      setState(() {
        _imageList.add(image);
      });
    }
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    // print(image.path);
    // setState(() {
    if (image != null) {
      print(basename(image.path));
      setState(() {
        _imageList.add(image);
      });

      // saveServiceRequest.srComplaintPhotosEntity.add(image);

    }
    //     // listLeadImage.add(new ListLeadImage(photoName: basename(image.path)));
    //     _imageList.add(image);
    //
    //     _imgDetails.add(new ImageDetails("asset", image));
    //   }
    //   // _imageList.insert(0,image);
    // });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  String customer = '';
  Widget requestorDetails() {
    return Container(
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
              : ListView(
                  physics: ScrollPhysics(),
                  children: requestorDetailsModel.srComplaintRequesterList
                      .map(
                        (e) => RadioListTile(
                            value: e,
                            title: Text('${e.requesterName} (${e.requesterCode})'),
                            groupValue: customer,
                            onChanged: (text) {
                              print(text.requesterName);
                              setState(() {
                                _requestorName.text=text.requesterName;
                                _customerID.text = text.requesterCode;
                                customer='${text.requesterName} (${text.requesterCode})';
                              });
                            }),
                      )
                      .toList(),
                  shrinkWrap: true,
                ),
        ],
      ),
    );
  }
}
