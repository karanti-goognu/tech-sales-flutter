import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/controller/update_sr_controller.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/ComplaintViewModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/UpdateSRModel.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/widgets/datepicker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestUpdateAction extends StatefulWidget {
  final dept, id, severity;
  final List<SrcResolutionEntity> resolutionStatus;
  RequestUpdateAction(
      {this.dept, this.resolutionStatus, this.id, this.severity});
  @override
  _RequestUpdateActionState createState() => _RequestUpdateActionState();
}

class _RequestUpdateActionState extends State<RequestUpdateAction> {
  UpdateSRModel _updateSRModel;
  UpdateServiceRequestController updateRequest = Get.find();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _location = TextEditingController();
  TextEditingController _noOfBags = TextEditingController();
  TextEditingController _comment = TextEditingController();
  TextEditingController _batchNo = TextEditingController();
  TextEditingController _sourcePlant = TextEditingController();
  String _productComplaint;
  String _techVan;
  String _productType;
  int _resolutionStatus;
  String _requestNature;
  TextEditingController _dateOfPurchase = TextEditingController();
  TextEditingController _nextVisitDate = TextEditingController();
  List<File> _imageList = List<File>();

  @override
  void initState() {
    print(widget.severity);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          DropdownButtonFormField(
            onChanged: (value) {
              setState(() {
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
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _location,
            style: FormFieldStyle.formFieldTextStyle,
            keyboardType: TextInputType.text,
            decoration:
                FormFieldStyle.buildInputDecoration(labelText: "Location*"),
          ),
          SizedBox(height: 16),
          Container(
            width: MediaQuery.of(context).size.width,
            child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                  side: BorderSide(color: Colors.black26),
                ),
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5, bottom: 10, top: 10),
                  child: Text(
                    "UPLOAD PHOTOS",
                    style: TextStyle(
                        color: HexColor("#1C99D4"),
                        fontWeight: FontWeight.bold,
                        // letterSpacing: 2,
                        fontSize: 17),
                  ),
                ),
                onPressed: () => _showPicker(context)),
          ),
          _imageList != null
              ? Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _imageList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                return showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: new Container(
                                          // width: 500,
                                          // height: 500,
                                          child: Image.file(_imageList[index]),
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
                                        _imageList.removeAt(index);
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
            onChanged: (val) {
              setState(() {
                _productComplaint = val;
              });
            },
          ),
          SizedBox(height: 16),
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
                  onChanged: (val) {
                    setState(() {
                      _techVan = val;
                    });
                  },
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
                      items: ['DALMIA', 'DSP', 'KONARK']
                          .map(
                            (e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _productType = val;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _batchNo,
                      decoration: FormFieldStyle.buildInputDecoration(
                        labelText: 'Batch No.',
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _dateOfPurchase,
                      readOnly: true,
                      onTap: () => PickDate.selectDate(
                              context: context, lastDate: DateTime.now())
                          .then(
                        (value) => value.isNull
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
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _noOfBags,
                      style: FormFieldStyle.formFieldTextStyle,
                      keyboardType: TextInputType.phone,
                      decoration: FormFieldStyle.buildInputDecoration(
                          labelText: "No. of Bags"),
                    ),
                    SizedBox(height: 16),
                  ],
                )
              : Container(),
          DropdownButtonFormField(
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Resolution Status*"),
            items: widget.resolutionStatus
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e.resolutionText),
                    value: e.id,
                  ),
                )
                .toList(),
            onChanged: (val) {
              _resolutionStatus = val;
            },
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
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the next visit date';
              } else {
                return null;
              }
            },
            controller: _nextVisitDate,
            onTap: () =>
                PickDate.selectDate(context: context, firstDate: DateTime.now())
                    .then((value) => value.isNull
                        ? null
                        : setState(() {
                            final DateFormat formatter =
                                DateFormat("yyyy-MM-dd");
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
          RaisedButton(
            onPressed: () async {
              if (!_formKey.currentState.validate()) {
                print("Error");
              } else {
                String empId = await getEmpId();
                List imageDetails = List();
                _imageList.forEach((element) {
                  setState(() {
                    print(element);
                    imageDetails.add({
                      //ToDo: Change srComplaint Id to some dynamic value
                      'srComplaintId': 1,
                      'photoName': element.path.split('/').last,
                    });
                  });
                });
                _updateSRModel = UpdateSRModel.fromJson({
                  "id": widget.id,
                  "severity": widget.severity,
                  "resoulutionStatus": _resolutionStatus,
                  "updatedBy": empId,
                  "srComplaintAction": [
                    {
                      "srComplaintId": widget.id,
                      "requestNature": _requestNature,
                      "locationLat": 23.123,
                      "locationLong": 123.234,
                      "productComplaint": _productComplaint,
                      "productType": _productType,
                      "techvanReqd": _techVan,
                      "purchaseDate": _dateOfPurchase.text.isEmpty?"":_dateOfPurchase.text,
                      "sourcePlant": _sourcePlant.text,
                      "productBatch": _batchNo.text.isEmpty?"":_batchNo.text,
                      "bagsCount": _noOfBags.text.isNotEmpty? int.parse(_noOfBags.text):0,
                      "resolutionStatusId": _resolutionStatus,
                      "comment": _comment.text,
                      "nextVisitDate": _nextVisitDate.text
                    }
                  ],
                  "srcActionPhotosEntity": imageDetails
                });
                updateRequest.getAccessKeyAndUpdateRequest(
                    _imageList, _updateSRModel);
              }
            },
            color: HexColor("#1C99D4"),
            child: Text(
              "UPDATE",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  // letterSpacing: 2,
                  fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    if (image != null) {
      print(1);
      setState(() {
        _imageList.add(image);
      });
    }
  }

  Future getEmpId() async {
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      empID = prefs.getString(StringConstants.employeeId);
    });
    return empID;
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
}
