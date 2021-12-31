import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/presentation/common_widgets/background_container_image.dart';
import 'package:flutter_tech_sales/presentation/common_widgets/upload_photo_bottomsheet.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/location/custom_map.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/controller/inf_controller.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/utils/constants/GlobalConstant.dart';
import 'package:flutter_tech_sales/utils/functions/get_current_location.dart';
import 'package:flutter_tech_sales/utils/functions/validation.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tech_sales/helper/draftLeadDBHelper.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/add_leads_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/AddLeadInitialModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/CommentDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/DraftLeadModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SaveLeadRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/DraftLeadListScreen.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:flutter_tech_sales/utils/constants/GlobalConstant.dart' as gv;
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
class AddNewLeadForm extends StatefulWidget {
  AddNewLeadForm({this.eventId});
  final eventId;
  @override
  _AddNewLeadFormState createState() => _AddNewLeadFormState();
}

class _AddNewLeadFormState extends State<AddNewLeadForm> {
  final db = DraftLeadDBHelper();

  final _formKeyForNewLeadForm = GlobalKey<FormState>();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  String _myActivity;
  LocationResult _pickedLocation;
  bool isSwitchedPrimary = false;
  var txt = TextEditingController();
  SiteSubTypeEntity _selectedValue;
  String _contactName;
  FocusNode myFocusNode;
  String _contactNumber;
  String _comment;
  TextEditingController _nameController = TextEditingController();
  var _siteAddress = TextEditingController();
  var _pincode = TextEditingController();
  var _state = TextEditingController();
  var _district = TextEditingController();
  var _taluk = TextEditingController();
  var _comments = TextEditingController();
  var _rera = TextEditingController();
  var _influencerNumber = TextEditingController();
  var _influencerName = TextEditingController();
  var _influencerType = TextEditingController();
  var _influencerCategory = TextEditingController();
  String geoTagType;

  var _totalBags = TextEditingController();
  var _totalMT = TextEditingController();
  List<File> _imageList = new List();
  List<ListLeadImage> listLeadImage = new List<ListLeadImage>();
  List<CommentsDetail> _commentsList = new List();
  List<CommentsDetail> _commentsListNew = new List();
  bool viewMoreActive = false;
  bool _isSubmitButtonDisabled;
  bool _isSaveButtonDisabled;

  List<String> _items = new List(); // to store comments

  final myController = TextEditingController();

  void _addComment() {
    if (myController.text.isNotEmpty) {
      // check if the comments text input is not empty
      setState(() {
        _items.add(myController.text); // add new commnet to the existing list
      });

      myController.clear(); // clear the text from the input
    }
  }

  Future<bool> internetChecking() async {
    // do something here
    bool result = await DataConnectionChecker().hasConnection;
    return result;
  }

  List<Item> _data = generateItems(1);
  List<InfluencerDetail> _listInfluencerDetail = new List();

  Position _currentPosition = new Position();
  String _currentAddress;

  List<SiteSubTypeEntity> siteSubTypeEntity = [
    new SiteSubTypeEntity(siteSubId: 1, siteSubTypeDesc: "Ground"),
    new SiteSubTypeEntity(siteSubId: 2, siteSubTypeDesc: "G+1"),
    new SiteSubTypeEntity(siteSubId: 3, siteSubTypeDesc: "Multi-Storey"),
  ];
  List<InfluencerTypeEntity> influencerTypeEntity;

  List<InfluencerCategoryEntity> influencerCategoryEntity;

  AddLeadsController _addLeadsController = Get.find();
  SaveLeadRequestDraftModel saveLeadRequestModelFromDraft =
      new SaveLeadRequestDraftModel();

  @override
  void initState() {
    super.initState();
    _isSubmitButtonDisabled = false;
    _isSaveButtonDisabled = false;
    _addLeadsController = Get.find();
    myFocusNode = FocusNode();
    getInitialData();
  }

  @override
  void dispose() {
    super.dispose();
    _formKeyForNewLeadForm.currentState != null
        ? _formKeyForNewLeadForm.currentState.dispose()
        : print("nothing happened");
    _addLeadsController.dispose();
    // _formKey.currentState.dispose();
  }

  getInitialData() {
    setState(() {
      print(gv.fromLead);
      try {
        if (gv.fromLead) {
          saveLeadRequestModelFromDraft = gv.saveLeadRequestModel;
          _contactName = saveLeadRequestModelFromDraft.contactName;
          geoTagType = saveLeadRequestModelFromDraft.geotagType;
          _contactNumber = saveLeadRequestModelFromDraft.contactNumber;
          if (saveLeadRequestModelFromDraft.leadLatitude != "null" &&
              saveLeadRequestModelFromDraft.leadLatitude != null) {
            _currentPosition = new Position(
                latitude:
                    double.parse(saveLeadRequestModelFromDraft.leadLatitude),
                longitude:
                    double.parse(saveLeadRequestModelFromDraft.leadLongitude));
          }
          _siteAddress.text = saveLeadRequestModelFromDraft.leadAddress;
          _pincode.text = saveLeadRequestModelFromDraft.leadPincode;
          _state.text = saveLeadRequestModelFromDraft.leadStateName;
          _district.text = saveLeadRequestModelFromDraft.leadDistrictName;
          _taluk.text = saveLeadRequestModelFromDraft.leadTalukName;
          _totalMT.text = saveLeadRequestModelFromDraft.leadSalesPotentialMt;
          _totalBags.text = saveLeadRequestModelFromDraft.leadBags;
          _rera.text = saveLeadRequestModelFromDraft.leadReraNumber;
          if (_totalMT.text != null &&
              _totalMT.text != "null" &&
              _totalMT.text != "") {
            _totalBags.text =
                (double.parse(_totalMT.text) * 20).round().toString();
          }

          // listLeadImage = saveLeadRequestModelFromDraft.listLeadImage;
          //print(saveLeadRequestModelFromDraft.influencerList[0].toJson());
          if (saveLeadRequestModelFromDraft.influencerList.length != 0) {
            print(saveLeadRequestModelFromDraft.influencerList[0].inflName);
            for (int i = 0;
                i < saveLeadRequestModelFromDraft.influencerList.length;
                i++) {
              /*print(23454);
            print(saveLeadRequestModelFromDraft.influencerList[i].toJson());
            print(saveLeadRequestModelFromDraft.influencerList[i].id);*/
              _listInfluencerDetail.add(new InfluencerDetail(
                  id: new TextEditingController(
                      text: saveLeadRequestModelFromDraft.influencerList[i].id),
                  inflName: new TextEditingController(
                      text: saveLeadRequestModelFromDraft
                          .influencerList[i].inflName),
                  inflContact: new TextEditingController(
                      text: saveLeadRequestModelFromDraft
                          .influencerList[i].inflContact),
                  inflTypeId: new TextEditingController(
                      text: saveLeadRequestModelFromDraft
                          .influencerList[i].inflTypeId),
                  inflTypeValue: new TextEditingController(
                      text: saveLeadRequestModelFromDraft
                          .influencerList[i].inflTypeValue),
                  inflCatId: new TextEditingController(
                      text: saveLeadRequestModelFromDraft
                          .influencerList[i].inflCatId),
                  inflCatValue: new TextEditingController(
                      text: saveLeadRequestModelFromDraft
                          .influencerList[i].inflCatValue),
                  ilpIntrested: new TextEditingController(
                      text: saveLeadRequestModelFromDraft
                          .influencerList[i].ilpIntrested),
                  isExpanded: saveLeadRequestModelFromDraft
                      .influencerList[i].isExpanded,
                  isPrimarybool: saveLeadRequestModelFromDraft
                      .influencerList[i].isPrimarybool,
                  isPrimary: saveLeadRequestModelFromDraft
                      .influencerList[i].isPrimary));
            }
          }

          if (saveLeadRequestModelFromDraft.listLeadImage.length != null) {
            for (int i = 0;
                i < saveLeadRequestModelFromDraft.listLeadImage.length;
                i++) {
              _imageList.add(new File(
                  saveLeadRequestModelFromDraft.listLeadImage[i].photoPath));
              listLeadImage.add(new ListLeadImage(
                  photoName: basename(saveLeadRequestModelFromDraft
                      .listLeadImage[i].photoPath)));
            }
          }

          // _commentsListNew = saveLeadRequestModelFromDraft.comments;
          if (saveLeadRequestModelFromDraft.comments.length != 0) {
            _comments.text =
                saveLeadRequestModelFromDraft.comments[0].commentText;
          }

          //print (saveLeadRequestModelFromDraft.comments[0].commentText);
          saveLeadRequestModelFromDraft = new SaveLeadRequestDraftModel();
          gv.saveLeadRequestModel = new SaveLeadRequestDraftModel();
        }
      } catch (_) {
        print('We are in catch :: Add New Form');
      }
    });
    internetChecking().then((result) => {
          if (result == true)
            {}
          else
            {
              Get.snackbar("No internet connection.",
                  "Make sure that your wifi or mobile data is turned on.",
                  colorText: Colors.white,
                  backgroundColor: Colors.red,
                  snackPosition: SnackPosition.BOTTOM),
              // fetchSiteList()
            }
        });
    AddLeadInitialModel addLeadInitialModel = new AddLeadInitialModel();
    AccessKeyModel accessKeyModel = new AccessKeyModel();

    internetChecking().then((result) => {
          if (result == true)
            {
              _addLeadsController.getAccessKeyOnly().then((data) async {
                accessKeyModel = data;
                print("AccessKey :: " + accessKeyModel.accessKey);
                await _addLeadsController
                    .getAddLeadsData(accessKeyModel.accessKey)
                    .then((data) {
                  addLeadInitialModel = data;
                  setState(() {
                    //siteSubTypeEntity = addLeadInitialModel.siteSubTypeEntity;
                    influencerTypeEntity =
                        addLeadInitialModel.influencerTypeEntity;
                    influencerCategoryEntity =
                        addLeadInitialModel.influencerCategoryEntity;
                    //  print(influencerCategoryEntity[0].inflCatDesc);
                  });
                });
                if (_listInfluencerDetail.length == 0) {
                  _listInfluencerDetail.add(new InfluencerDetail(
                      isExpanded: true, isPrimarybool: true));
                }
                Get.back();
                myFocusNode.requestFocus();
              })
            }
          else
            {
              Get.snackbar("No internet connection.",
                  "Make sure that your wifi or mobile data is turned on.",
                  colorText: Colors.white,
                  backgroundColor: Colors.red,
                  snackPosition: SnackPosition.BOTTOM),
              // fetchSiteList()
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);

    final name = TextFormField(
      initialValue: _contactName,
      focusNode: myFocusNode,
      validator: (value) {
        if (value.isEmpty || value.length <=0 || value == null || value == " " || value.trim().isEmpty) {
          return 'Please enter name';
        }
        return null;
      },
      onChanged: (data) {
        setState(() {
          _contactName = data;
        });
      },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[0-9.a-zA-Z ]")), ],
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Name",
      ),
    );

    final contact = TextFormField(
      initialValue: _contactNumber,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter mobile number ';
        }
        if (value.length <= 9) {
          return 'Mobile number is incorrect';
        }
        if (!Validations.isValidPhoneNumber(value)) {
          return 'Enter valid mobile number';
        }
        return null;
      },
      onChanged: (data) {
        setState(() {
          _contactNumber = data;
        });
      },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.phone,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      maxLength: 10,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Mobile Number",
      ),
    );


    return Scaffold(
//      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      floatingActionButton: BackFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar: BottomNavigator(),
      body: SingleChildScrollView(
        child: Stack(
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
                    ))),
            Form(
              key: _formKeyForNewLeadForm,
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30.0, bottom: 20, left: 5),
                      child: Text(
                        "Add a new Trade lead",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 25,
                            color: HexColor("#006838"),
                            fontFamily: "Muli"),
                      ),
                    ),
                    Container(
                      child: widget.eventId != null
                          ? Text('Event ID: ${widget.eventId}')
                          : null,
                    ),

                    SizedBox(height: 16),
                    //name,
                    TextFormField(
                      initialValue: _contactName,
                      focusNode: myFocusNode,
                      // validator: (value) {
                      //   if (value.isEmpty) {
                      //     return "Contact Name can't be empty";
                      //   }
                      //   //leagueSize = int.parse(value);
                      //   return null;
                      // },
                      onChanged: (data) {
                        setState(() {
                          _contactName = data;
                        });
                      },
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.inputBoxHintColor,
                          fontFamily: "Muli"),
                      keyboardType: TextInputType.text,
                      inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[0-9.a-zA-Z ]")), ],
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.backgroundColorBlue,
                              //color: HexColor("#0000001F"),
                              width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black26, width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        labelText: "Name",
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
                    SizedBox(height: 16),
                    TextFormField(
                      initialValue: _contactNumber,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter mobile number ';
                        }
                        if (value.length <= 9) {
                          return 'Mobile number is incorrect';
                        }
                        if (!Validations.isValidPhoneNumber(value)) {
                          return 'Enter valid mobile number';
                        }
                        return null;
                      },
                      onChanged: (data) {
                        setState(() {
                          _contactNumber = data;
                        });
                      },
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.inputBoxHintColor,
                          fontFamily: "Muli"),
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      maxLength: 10,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.backgroundColorBlue,
                              //color: HexColor("#0000001F"),
                              width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black26, width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        labelText: "Mobile Number",
                        filled: false,
                        focusColor: Colors.black,
                        labelStyle: TextStyle(
                            fontFamily: "Muli",
                            color: ColorConstants.inputBoxHintColorDark,
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0),
                        fillColor: ColorConstants.backgroundColor,
                      ),
                    ),
                    // SizedBox(height: 16),
                    Divider(
                      color: Colors.black26,
                      thickness: 1,
                    ),

                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, bottom: 20, left: 5),
                      child: Text(
                        "Geo Tag",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            // color: HexColor("#000000DE"),
                            fontFamily: "Muli"),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FlatButton.icon(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                              side: BorderSide(color: Colors.black26)),
                          color: Colors.transparent,
                          icon: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.location_searching,
                              color: HexColor("#F9A61A"),
                              size: 18,
                            ),
                          ),
                          label: Padding(
                            padding: const EdgeInsets.only(
                                right: 5, bottom: 8, top: 5),
                            child: Text(
                              "DETECT",
                              style: TextStyle(
                                  color: HexColor("#F9A61A"),
                                  fontWeight: FontWeight.bold,
                                  // letterSpacing: 2,
                                  fontSize: 17),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              geoTagType = "A";
                            });
                            Get.dialog(Center(
                              child: CircularProgressIndicator(),
                            ));
                            _getCurrentLocation();
                          },
                        ),
                        Text(
                          "Or",
                          style: TextStyle(
                              fontFamily: "Muli",
                              //color: HexColor("#F9A61A"),
                              // fontWeight: FontWeight.bold,
                              // letterSpacing: 2,
                              fontSize: 17),
                        ),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                              side: BorderSide(color: Colors.black26)),
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 5, bottom: 8, top: 5),
                            child: Text(
                              "MANUAL",
                              style: TextStyle(
                                  color: HexColor("#F9A61A"),
                                  fontWeight: FontWeight.bold,
                                  // letterSpacing: 2,
                                  fontSize: 17),
                            ),
                          ),
                          onPressed: () async {
                            var data = [];
                            data = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CustomMap()));
                            print(data);
                            print(data.runtimeType);
                            setState(() {
                              geoTagType = "M";
                            });
                            _currentPosition = new Position(
                                latitude: data[0], longitude: data[1]);
                            _getAddressFromLatLng();
//                             setState(() {
//                               geoTagType = "M";
//                             });
 //                            LocationResult result = await showLocationPicker(
//                               context,
//                               StringConstants.API_Key,
//                               initialCenter: LatLng(28.644800, 77.216721),
//                               automaticallyAnimateToCurrentLocation: true,
// //                      mapStylePath: 'assets/mapStyle.json',
//                               myLocationButtonEnabled: true,
//                               // requiredGPS: true,
//                               layersButtonEnabled: false,
//                               // countries: ['AE', 'NG']
//
// //                      resultCardAlignment: Alignment.bottomCenter,
//                               // desiredAccuracy: LocationAccuracy.best,
//                             );
//                             print("result = $result");
//                             setState(() {
//                               _pickedLocation = result;
//                               _currentPosition = new Position(
//                                   latitude: _pickedLocation.latLng.latitude,
//                                   longitude: _pickedLocation.latLng.longitude);
// //                              print(_currentPosition);
//                               _getAddressFromLatLng();
//                             });
                          },
                        ),
                      ],
                    ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         RaisedButton(
//                           onPressed: () async {
//                             LocationResult result = await showLocationPicker(
//                                 context,
//                                 "AIzaSyBEMGF1RVNoYyxMaYE8v2isPlmeCuHDMlc",
//                                 initialCenter: LatLng(31.1975844, 29.9598339),
//                                 automaticallyAnimateToCurrentLocation: true,
// //                      mapStylePath: 'assets/mapStyle.json',
//                                 myLocationButtonEnabled: true,
//                                 // requiredGPS: true,
//                                 layersButtonEnabled: true,
//                                 countries: ['AE', 'NG']
//
// //                      resultCardAlignment: Alignment.bottomCenter,
//                                 // desiredAccuracy: LocationAccuracy.best,
//                                 );
//                             print("result = $result");
//                             setState(() => _pickedLocation = result);
//                           },
//                        //   child: Text('Pick location'),
//                         ),
//                         Text(_pickedLocation.toString()),
//                       ],
//                     ),
//                     Container(
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).canvasColor,
//                         ),
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                         child: Column(children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               Icon(Icons.location_on),
//                               SizedBox(
//                                 width: 8,
//                               ),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Text(
//                                       'Location',
//                                       style:
//                                           Theme.of(context).textTheme.caption,
//                                     ),
//                                     if (_currentPosition != null &&
//                                         _currentAddress != null)
//                                       Text(_currentAddress,
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyText2),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 8,
//                               ),
//                             ],
//                           ),
//                         ])),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _siteAddress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Address ';
                        }

                        return null;
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
                              //color: HexColor("#0000001F"),
                              width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xFF000000).withOpacity(0.4),
                              width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        labelText: "Address",
                        filled: false,
                        focusColor: Colors.black,
                        labelStyle: TextStyle(
                            fontFamily: "Muli",
                            color: ColorConstants.inputBoxHintColorDark,
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0),
                        fillColor: ColorConstants.backgroundColor,

                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      //initialValue: _pincode.toString(),
                      maxLength: 6,
                      controller: _pincode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Pincode ';
                        }
                        if (value.length <= 6) {
                          return 'Pincode is incorrect';
                        }
                        if (!Validations.isValidPincode(value)) {
                          return "Enter valid pincode";
                        }

                        return null;
                      },
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.inputBoxHintColor,
                          fontFamily: "Muli"),
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      //  maxLength: 6,
                      decoration: FormFieldStyle.buildInputDecoration(
                        labelText: "Pincode",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Mandatory",
                        style: TextStyle(
                          fontFamily: "Muli",
                          color: ColorConstants.inputBoxHintColorDark,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                        controller: _state,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter State ';
                          }

                          return null;
                        },
                        style: TextStyle(
                            fontSize: 18,
                            color: ColorConstants.inputBoxHintColor,
                            fontFamily: "Muli"),
                        keyboardType: TextInputType.text,
                        inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")), ],
                        decoration: FormFieldStyle.buildInputDecoration(
                            labelText: "State")),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Mandatory",
                        style: TextStyle(
                          fontFamily: "Muli",
                          color: ColorConstants.inputBoxHintColorDark,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _district,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter District ';
                        }

                        return null;
                      },
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.inputBoxHintColor,
                          fontFamily: "Muli"),
                      keyboardType: TextInputType.text,
                      inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")), ],
                      decoration: FormFieldStyle.buildInputDecoration(
                          labelText: "District"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Mandatory",
                        style: TextStyle(
                          fontFamily: "Muli",
                          color: ColorConstants.inputBoxHintColorDark,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    TextFormField(
                      controller: _taluk,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Taluk ';
                        }

                        return null;
                      },
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.inputBoxHintColor,
                          fontFamily: "Muli"),
                      keyboardType: TextInputType.text,
                      inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")), ],
                      decoration: FormFieldStyle.buildInputDecoration(
                          labelText: "Taluk"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Mandatory",
                        style: TextStyle(
                          fontFamily: "Muli",
                          color: ColorConstants.inputBoxHintColorDark,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                            side: BorderSide(color: Colors.black26)),
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
                            _showPicker(context);
                          } else {
                            Get.dialog(CustomDialogs()
                                .errorDialog("You can add only upto 5 photos"));
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
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          return showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content: new Container(
                                                    // width: 500,
                                                    // height: 500,
                                                    child: Image.file(
                                                        _imageList[index]),
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  "Image_${(index + 1)}.jpg",
                                                  style: TextStyle(
                                                      color:
                                                          HexColor("#007CBF"),
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
                        : Container(),

                    SizedBox(height: 16),
                    Divider(
                      color: Colors.black26,
                      thickness: 1,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, bottom: 20, left: 5),
                      child: Text(
                        "Influencer Details",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            // color: HexColor("#000000DE"),
                            fontFamily: "Muli"),
                      ),
                    ),
                    // Container(
                    //   child: _buildPanel(),
                    // ),
                    Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _listInfluencerDetail.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (!_listInfluencerDetail[index].isExpanded) {
                                  return Column(
                                    // mainAxisAlignment:
                                    // MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // (index == 0)
                                          //     ? Text(
                                          //         "Influencer Details",
                                          //         style: TextStyle(
                                          //             fontWeight:
                                          //                 FontWeight.bold,
                                          //             fontSize: 18),
                                          //       )
                                          //     :
                                          Text(
                                            "Influencer Details ${(index + 1)} ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Switch(
                                            onChanged: (value) {
                                              setState(() {
                                                if (value) {
                                                  for (int i = 0;
                                                      i <
                                                          _listInfluencerDetail
                                                              .length;
                                                      i++) {
                                                    if (i == index) {
                                                      _listInfluencerDetail[i]
                                                              .isPrimarybool =
                                                          value;
                                                    } else {
                                                      _listInfluencerDetail[i]
                                                              .isPrimarybool =
                                                          !value;
                                                    }
                                                  }
                                                } else {
                                                  Get.dialog(CustomDialogs()
                                                      .errorDialog(
                                                          "There should be one Primary Influencer . Please select other influencer to make this influencer secondary"));
                                                }
                                              });
                                            },
                                            value: _listInfluencerDetail[index]
                                                .isPrimarybool,
                                            activeColor: HexColor("#009688"),
                                            activeTrackColor:
                                                HexColor("#009688")
                                                    .withOpacity(0.5),
                                            inactiveThumbColor:
                                                HexColor("#F1F1F1"),
                                            inactiveTrackColor: Colors.black26,
                                          ),
                                          _listInfluencerDetail[index]
                                                  .isExpanded
                                              ? FlatButton.icon(
                                                  // shape: RoundedRectangleBorder(
                                                  //     borderRadius: BorderRadius.circular(0),
                                                  //     side: BorderSide(color: Colors.black26)),
                                                  color: Colors.transparent,
                                                  icon: Icon(
                                                    Icons.remove,
                                                    color: HexColor("#F9A61A"),
                                                    size: 18,
                                                  ),
                                                  label: Text(
                                                    "COLLAPSE",
                                                    style: TextStyle(
                                                        color:
                                                            HexColor("#F9A61A"),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        // letterSpacing: 2,
                                                        fontSize: 17),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _listInfluencerDetail[
                                                                  index]
                                                              .isExpanded =
                                                          !_listInfluencerDetail[
                                                                  index]
                                                              .isExpanded;
                                                    });
                                                    // _getCurrentLocation();
                                                  },
                                                )
                                              : FlatButton.icon(
                                                  // shape: RoundedRectangleBorder(
                                                  //     borderRadius: BorderRadius.circular(0),
                                                  //     side: BorderSide(color: Colors.black26)),
                                                  color: Colors.transparent,
                                                  icon: Icon(
                                                    Icons.add,
                                                    color: HexColor("#F9A61A"),
                                                    size: 18,
                                                  ),
                                                  label: Text(
                                                    "EXPAND",
                                                    style: TextStyle(
                                                        color:
                                                            HexColor("#F9A61A"),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        // letterSpacing: 2,
                                                        fontSize: 17),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _listInfluencerDetail[
                                                                  index]
                                                              .isExpanded =
                                                          !_listInfluencerDetail[
                                                                  index]
                                                              .isExpanded;
                                                    });
                                                    // _getCurrentLocation();
                                                  },
                                                ),
                                        ],
                                      ),
                                    ],
                                  );
                                } else {
                                  return Column(
                                    // mainAxisAlignment:
                                    // MainAxisAlignment.spaceBetween,
                                    children: [
                                      FittedBox(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            (index == 0)
                                                ? Text(
                                                    "Influencer Details",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  )
                                                : Text(
                                                    "Influencer Details ${(index + 1)} ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                            _listInfluencerDetail[index]
                                                    .isExpanded
                                                ? FlatButton.icon(
                                                    // shape: RoundedRectangleBorder(
                                                    //     borderRadius: BorderRadius.circular(0),
                                                    //     side: BorderSide(color: Colors.black26)),
                                                    color: Colors.transparent,
                                                    icon: Icon(
                                                      Icons.remove,
                                                      color:
                                                          HexColor("#F9A61A"),
                                                      size: 18,
                                                    ),
                                                    label: Text(
                                                      "COLLAPSE",
                                                      style: TextStyle(
                                                          color: HexColor(
                                                              "#F9A61A"),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          // letterSpacing: 2,
                                                          fontSize: 17),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _listInfluencerDetail[
                                                                    index]
                                                                .isExpanded =
                                                            !_listInfluencerDetail[
                                                                    index]
                                                                .isExpanded;
                                                      });
                                                      // _getCurrentLocation();
                                                    },
                                                  )
                                                : FlatButton.icon(
                                                    // shape: RoundedRectangleBorder(
                                                    //     borderRadius: BorderRadius.circular(0),
                                                    //     side: BorderSide(color: Colors.black26)),
                                                    color: Colors.transparent,
                                                    icon: Icon(
                                                      Icons.add,
                                                      color:
                                                          HexColor("#F9A61A"),
                                                      size: 18,
                                                    ),
                                                    label: Text(
                                                      "EXPAND",
                                                      style: TextStyle(
                                                          color: HexColor(
                                                              "#F9A61A"),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          // letterSpacing: 2,
                                                          fontSize: 17),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _listInfluencerDetail[
                                                                    index]
                                                                .isExpanded =
                                                            !_listInfluencerDetail[
                                                                    index]
                                                                .isExpanded;
                                                      });
                                                      // _getCurrentLocation();
                                                    },
                                                  ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Secondary",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                // color: HexColor("#000000DE"),
                                                fontFamily: "Muli"),
                                          ),
                                          Switch(
                                            onChanged: (value) {
                                              setState(() {
                                                if (value) {
                                                  for (int i = 0;
                                                      i <
                                                          _listInfluencerDetail
                                                              .length;
                                                      i++) {
                                                    if (i == index) {
                                                      _listInfluencerDetail[i]
                                                              .isPrimarybool =
                                                          value;
                                                    } else {
                                                      _listInfluencerDetail[i]
                                                              .isPrimarybool =
                                                          !value;
                                                    }
                                                  }
                                                } else {
                                                  Get.dialog(CustomDialogs()
                                                      .errorDialog(
                                                          "There should be one Primary Influencer . Please select other influencer to make this influencer secondary"));
                                                }
                                              });
                                            },
                                            value: _listInfluencerDetail[index]
                                                .isPrimarybool,
                                            activeColor: HexColor("#009688"),
                                            activeTrackColor:
                                                HexColor("#009688")
                                                    .withOpacity(0.5),
                                            inactiveThumbColor:
                                                HexColor("#F1F1F1"),
                                            inactiveTrackColor: Colors.black26,
                                          ),
                                          Text(
                                            "Primary",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color:
                                                    _listInfluencerDetail[index]
                                                            .isPrimarybool
                                                        ? HexColor("#009688")
                                                        : Colors.black,
                                                // color: HexColor("#000000DE"),
                                                fontFamily: "Muli"),
                                          ),
                                        ],
                                      ),
                                      TextFormField(
                                        controller: _listInfluencerDetail[index]
                                            .inflContact,
                                        maxLength: 10,
                                        onChanged: (value) async {
                                          bool match = false;
                                          if (value.length < 10) {
                                            // _listInfluencerDetail[
                                            // index]
                                            //     .inflContact
                                            //     .clear();
                                            if (_listInfluencerDetail[index]
                                                    .inflName !=
                                                null) {
                                              _listInfluencerDetail[index]
                                                  .inflName
                                                  .clear();
                                              _listInfluencerDetail[index]
                                                  .inflTypeValue
                                                  .clear();
                                              _listInfluencerDetail[index]
                                                  .inflCatValue
                                                  .clear();
                                            }
                                          } else if (value.length == 10) {
                                            var bodyEncrypted = {
                                              //"reference-id": "IqEAFdXco54HTrBkH+sWOw==",
                                              "inflContact": value
                                            };

                                            if (_listInfluencerDetail.length !=
                                                0) {
                                              for (int i = 0;
                                                  i <
                                                      _listInfluencerDetail
                                                              .length -
                                                          1;
                                                  i++) {
                                                if (value ==
                                                    _listInfluencerDetail[i]
                                                        .inflContact
                                                        .text) {
                                                  match = true;
                                                  break;
                                                }
                                              }
                                            }

                                            if (match) {
                                              Get.dialog(CustomDialogs()
                                                  .errorDialog(
                                                      "Already added influencer : " +
                                                          value));
                                            } else {
                                              String empId;
                                              String mobileNumber;
                                              String name;
                                              Future<SharedPreferences> _prefs =
                                                  SharedPreferences
                                                      .getInstance();
                                              await _prefs.then(
                                                  (SharedPreferences prefs) {
                                                empId = prefs.getString(
                                                        StringConstants
                                                            .employeeId) ??
                                                    "empty";
                                                mobileNumber = prefs.getString(
                                                        StringConstants
                                                            .mobileNumber) ??
                                                    "empty";
                                                name = prefs.getString(
                                                        StringConstants
                                                            .employeeName) ??
                                                    "empty";
                                                print(_comments.text);
                                              });
                                              AddLeadsController
                                                  _addLeadsController =
                                                  Get.find();
                                              _addLeadsController.phoneNumber =
                                                  value;
                                              AccessKeyModel accessKeyModel =
                                                  new AccessKeyModel();
                                              await _addLeadsController
                                                  .getAccessKeyOnly()
                                                  .then((data) async {
                                                accessKeyModel = data;
                                                print("AccessKey :: " +
                                                    accessKeyModel.accessKey);
                                                await _addLeadsController
                                                    .getInfNewData(accessKeyModel
                                                    .accessKey)
                                                    .then((data) {
                                                  InfluencerDetailModel _infDetailModel = data;
                                                  if(_infDetailModel.respCode=="DM1002") {
                                                    InfluencerModel inflDetail = _infDetailModel
                                                        .influencerModel;

                                                    if (inflDetail
                                                        .inflName !=
                                                        "null") {
                                                      setState(() {
                                                        _listInfluencerDetail[
                                                        index]
                                                            .inflContact =
                                                        new TextEditingController();
                                                        _listInfluencerDetail[
                                                        index]
                                                            .inflName =
                                                        new TextEditingController();
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                        //  print(inflDetail.inflName.text);
                                                        _listInfluencerDetail[
                                                        index]
                                                            .inflTypeId =
                                                        new TextEditingController();
                                                        _listInfluencerDetail[
                                                        index]
                                                            .inflCatId =
                                                        new TextEditingController();
                                                        _listInfluencerDetail[
                                                        index]
                                                            .inflTypeValue =
                                                        new TextEditingController();
                                                        _listInfluencerDetail[
                                                        index]
                                                            .inflCatValue =
                                                        new TextEditingController();
                                                        _listInfluencerDetail[index]
                                                            .id =
                                                        new TextEditingController();
                                                        _listInfluencerDetail[index]
                                                            .ilpIntrested =
                                                        new TextEditingController();

                                                        print(
                                                            inflDetail
                                                                .inflName);

                                                        _listInfluencerDetail[
                                                        index]
                                                            .inflContact.text =
                                                            inflDetail
                                                                .inflContact;
                                                        _listInfluencerDetail[
                                                        index]
                                                            .inflName.text =
                                                            inflDetail.inflName;
                                                        _listInfluencerDetail[
                                                        index]
                                                            .id.text =
                                                            inflDetail.inflId
                                                                .toString();
                                                        _listInfluencerDetail[
                                                        index]
                                                            .ilpIntrested.text =
                                                            inflDetail
                                                                .ilpRegFlag;
                                                        // _listInfluencerDetail[
                                                        //             index]
                                                        //         .createdOn =
                                                        //     inflDetail.createdOn;
                                                        _listInfluencerDetail[
                                                        index]
                                                            .inflTypeValue
                                                            .text =
                                                            inflDetail
                                                                .influencerTypeText;
                                                        _listInfluencerDetail[
                                                        index]
                                                            .inflCatValue.text =
                                                            inflDetail
                                                                .influencerCategoryText;
                                                        _listInfluencerDetail[
                                                        index]
                                                            .createdBy = empId;
                                                        print(
                                                            _listInfluencerDetail[
                                                            index]
                                                                .inflName);

                                                        for (int i = 0;
                                                        i <
                                                            influencerTypeEntity
                                                                .length;
                                                        i++) {
                                                          if (influencerTypeEntity[
                                                          i]
                                                              .inflTypeId
                                                              .toString() ==
                                                              inflDetail
                                                                  .inflTypeId
                                                                  .toString()) {
                                                            _listInfluencerDetail[
                                                            index]
                                                                .inflTypeId
                                                                .text =
                                                                inflDetail
                                                                    .inflTypeId
                                                                    .toString();
                                                            //   print(influencerTypeEntity[influencerTypeEntity[i].inflTypeId].inflTypeDesc);
                                                            _listInfluencerDetail[
                                                            index]
                                                                .inflTypeValue
                                                                .text =
                                                                influencerTypeEntity[
                                                                influencerTypeEntity[
                                                                i]
                                                                    .inflTypeId -
                                                                    1]
                                                                    .inflTypeDesc;
                                                            break;
                                                          } else {
                                                            // _listInfluencerDetail[
                                                            // index]
                                                            //     .inflContact
                                                            //     .clear();
                                                            // _listInfluencerDetail[
                                                            // index]
                                                            //     .inflName
                                                            //     .clear();
                                                            _listInfluencerDetail[
                                                            index]
                                                                .inflTypeId
                                                                .clear();
                                                            _listInfluencerDetail[
                                                            index]
                                                                .inflTypeValue
                                                                .clear();
                                                          }
                                                        }
                                                        print(
                                                            _listInfluencerDetail[
                                                            index]
                                                                .inflName);
                                                        // _influencerType.text = influencerTypeEntity[inflDetail.inflTypeId].inflTypeDesc;

                                                        for (int i = 0;
                                                        i <
                                                            influencerCategoryEntity
                                                                .length;
                                                        i++) {
                                                          if (influencerCategoryEntity[
                                                          i]
                                                              .inflCatId
                                                              .toString() ==
                                                              inflDetail
                                                                  .inflCatId
                                                                  .toString()) {
                                                            _listInfluencerDetail[
                                                            index]
                                                                .inflCatId
                                                                .text =
                                                                inflDetail
                                                                    .inflCatId
                                                                    .toString();
                                                            //   print(influencerTypeEntity[influencerTypeEntity[i].inflTypeId].inflTypeDesc);
                                                            _listInfluencerDetail[
                                                            index]
                                                                .inflCatValue
                                                                .text =
                                                                influencerCategoryEntity[
                                                                influencerCategoryEntity[
                                                                i]
                                                                    .inflCatId -
                                                                    1]
                                                                    .inflCatDesc;
                                                            break;
                                                          } else {
                                                            _listInfluencerDetail[
                                                            index]
                                                                .inflCatId
                                                                .clear();
                                                            _listInfluencerDetail[
                                                            index]
                                                                .inflCatValue
                                                                .clear();
                                                          }
                                                        }
                                                      });
                                                    } else {
                                                      if (_listInfluencerDetail[
                                                      index]
                                                          .inflContact !=
                                                          null) {
                                                        setState(() {
                                                          _listInfluencerDetail[
                                                          index]
                                                              .inflContact
                                                              .clear();
                                                          _listInfluencerDetail[
                                                          index]
                                                              .inflName
                                                              .clear();
                                                        });
                                                      }
                                                      return Get.dialog(
                                                          CustomDialogs()
                                                              .showDialog(
                                                              "No influencer registered with this number"));
                                                    }
                                                  }else{
                                                    if (_listInfluencerDetail[index]
                                                        .inflContact !=
                                                        null) {
                                                      _listInfluencerDetail[index]
                                                          .inflContact
                                                          .clear();
                                                      _listInfluencerDetail[index]
                                                          .inflName
                                                          .clear();
                                                    }
                                                    return Get.dialog(
                                                        CustomDialogs()
                                                            .showDialog(_infDetailModel.respMsg));
                                                  }
                                                  Get.back();
                                                });
                                              });
                                            }
                                          }
                                          // setState(() {
                                          //   _totalBags = value as int;
                                          // });
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter Influencer Number ';
                                          }
                                          if(!Validations.isValidPhoneNumber(value)){
                                            return "Enter valid Contact number";
                                          }

                                          return null;
                                        },
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: ColorConstants
                                                .inputBoxHintColor,
                                            fontFamily: "Muli"),
                                        keyboardType: TextInputType.phone,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstants
                                                    .backgroundColorBlue,
                                                //color: HexColor("#0000001F"),
                                                width: 1.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xFF000000)
                                                    .withOpacity(0.4),
                                                width: 1.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 1.0),
                                          ),
                                          labelText: "Mobile Number",
                                          filled: false,
                                          focusColor: Colors.black,
                                          labelStyle: TextStyle(
                                              fontFamily: "Muli",
                                              color: ColorConstants
                                                  .inputBoxHintColorDark,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16.0),
                                          fillColor:
                                              ColorConstants.backgroundColor,
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      TextFormField(
                                        //  initialValue: _listInfluencerDetail[index].inflName,
                                        controller: _listInfluencerDetail[index]
                                            .inflName,

                                        // validator: (value) {
                                        //   if (value.isEmpty) {
                                        //     return 'Please enter Influencer Number ';
                                        //   }
                                        //
                                        //   return null;
                                        // },
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: ColorConstants
                                                .inputBoxHintColor,
                                            fontFamily: "Muli"),
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstants
                                                    .backgroundColorBlue,
                                                //color: HexColor("#0000001F"),
                                                width: 1.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xFF000000)
                                                    .withOpacity(0.4),
                                                width: 1.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 1.0),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xFF000000)
                                                    .withOpacity(0.4),
                                                width: 1.0),
                                          ),
                                          labelText: "Name",
                                          enabled: false,
                                          filled: false,
                                          focusColor: Colors.black,
                                          labelStyle: TextStyle(
                                              fontFamily: "Muli",
                                              color: ColorConstants
                                                  .inputBoxHintColorDark,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16.0),
                                          fillColor:
                                              ColorConstants.backgroundColor,
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      TextFormField(
                                        controller: _listInfluencerDetail[index]
                                            .inflTypeValue,
                                        // validator: (value) {
                                        //   if (value.isEmpty) {
                                        //     return 'Please enter Influencer Number ';
                                        //   }
                                        //
                                        //   return null;
                                        // },
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: ColorConstants
                                                .inputBoxHintColor,
                                            fontFamily: "Muli"),
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstants
                                                    .backgroundColorBlue,
                                                //color: HexColor("#0000001F"),
                                                width: 1.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xFF000000)
                                                    .withOpacity(0.4),
                                                width: 1.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 1.0),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xFF000000)
                                                    .withOpacity(0.4),
                                                width: 1.0),
                                          ),
                                          enabled: false,
                                          labelText: "Type",
                                          filled: false,
                                          focusColor: Colors.black,
                                          labelStyle: TextStyle(
                                              fontFamily: "Muli",
                                              color: ColorConstants
                                                  .inputBoxHintColorDark,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16.0),
                                          fillColor:
                                              ColorConstants.backgroundColor,
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      TextFormField(
                                        controller: _listInfluencerDetail[index]
                                            .inflCatValue,
                                        // validator: (value) {
                                        //   if (value.isEmpty) {
                                        //     return 'Please enter Influencer Number ';
                                        //   }
                                        //
                                        //   return null;
                                        // },
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: ColorConstants
                                                .inputBoxHintColor,
                                            fontFamily: "Muli"),
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstants
                                                    .backgroundColorBlue,
                                                //color: HexColor("#0000001F"),
                                                width: 1.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xFF000000)
                                                    .withOpacity(0.4),
                                                width: 1.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 1.0),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xFF000000)
                                                    .withOpacity(0.4),
                                                width: 1.0),
                                          ),
                                          enabled: false,
                                          labelText: "Category",
                                          filled: false,
                                          focusColor: Colors.black,
                                          labelStyle: TextStyle(
                                              fontFamily: "Muli",
                                              color: ColorConstants
                                                  .inputBoxHintColorDark,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16.0),
                                          fillColor:
                                              ColorConstants.backgroundColor,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    Center(
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                            side: BorderSide(color: Colors.black26)),
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 5, bottom: 8, top: 5),
                          child: Text(
                            "ADD MORE INFLUENCER",
                            style: TextStyle(
                                color: HexColor("#1C99D4"),
                                fontWeight: FontWeight.bold,
                                // letterSpacing: 2,
                                fontSize: 17),
                          ),
                        ),
                        onPressed: () async {
                          // //  print(_listInfluencerDetail[
                          //   _listInfluencerDetail.length - 1]
                          //       .inflName);
                          if (_listInfluencerDetail[
                                          _listInfluencerDetail.length - 1]
                                      .inflName !=
                                  null &&
                              _listInfluencerDetail[
                                          _listInfluencerDetail.length - 1]
                                      .inflName !=
                                  "null" &&
                              !_listInfluencerDetail[
                                      _listInfluencerDetail.length - 1]
                                  .inflName
                                  .text
                                  .isNullOrBlank) {
                            InfluencerDetail infl = new InfluencerDetail(
                                isExpanded: true, isPrimarybool: false);

                            // Item item = new Item(
                            //     headerValue: "agx ", expandedValue: "dnxcx");
                            setState(() {
                              // _data.add(item);
                              _listInfluencerDetail[
                                      _listInfluencerDetail.length - 1]
                                  .isExpanded = false;
                              _listInfluencerDetail.add(infl);
                            });
                          } else {
                            print(
                                "Error : Please fill previous influencer first");
                            Get.dialog(CustomDialogs().errorDialog(
                                "Please fill previous influencer first"));
                          }
                        },
                      ),
                    ),

                    Divider(
                      color: Colors.black26,
                      thickness: 1,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, bottom: 20, left: 5),
                      child: Text(
                        "Total Site Potential",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            // color: HexColor("#000000DE"),
                            fontFamily: "Muli"),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: TextFormField(
                              // initialValue: _totalBags.toString(),
                              controller: _totalBags,
                              onChanged: (value) {
                                setState(() {
                                  // _totalBags.text = value ;
                                  if (_totalBags.text == null ||
                                      _totalBags.text == "") {
                                    _totalMT.clear();
                                  } else {
                                    _totalMT.text =
                                        (int.parse(_totalBags.text) / 20)
                                            .toString();
                                  }
                                });
                              },
                              keyboardType: TextInputType.phone,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter Bags ';
                                }

                                return null;
                              },

                              style: TextStyle(
                                  fontSize: 18,
                                  color: ColorConstants.inputBoxHintColor,
                                  fontFamily: "Muli"),
                              // keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorConstants.backgroundColorBlue,
                                      //color: HexColor("#0000001F"),
                                      width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.4),
                                      width: 1.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.0),
                                ),
                                labelText: "Bags",
                                filled: false,
                                focusColor: Colors.black,
                                labelStyle: TextStyle(
                                    fontFamily: "Muli",
                                    color: ColorConstants.inputBoxHintColorDark,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16.0),
                                fillColor: ColorConstants.backgroundColor,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextFormField(
                              controller: _totalMT,
                              onChanged: (value) {
                                setState(() {
                                  // _totalBags.text = value ;
                                  if (_totalMT.text == null ||
                                      _totalMT.text == "") {
                                    _totalBags.clear();
                                  } else {
                                    _totalBags.text = (double.parse(_totalMT.text) * 20).toInt().toString();
                                  }
                                });
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter MT ';
                                }

                                return null;
                              },
                              style: TextStyle(
                                  fontSize: 18,
                                  color: ColorConstants.inputBoxHintColor,
                                  fontFamily: "Muli"),
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: false),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorConstants.backgroundColorBlue,
                                      //color: HexColor("#0000001F"),
                                      width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.4),
                                      width: 1.0),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.4),
                                      width: 1.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.0),
                                ),
                                labelText: "MT",
                                filled: false,
                                //enabled: false,
                                focusColor: Colors.black,
                                labelStyle: TextStyle(
                                    fontFamily: "Muli",
                                    color: ColorConstants.inputBoxHintColorDark,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16.0),
                                fillColor: ColorConstants.backgroundColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    Divider(
                      color: Colors.black26,
                      thickness: 1,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _rera,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter RERA Number ';
                        }

                        return null;
                      },
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.inputBoxHintColor,
                          fontFamily: "Muli"),
                      keyboardType: TextInputType.text,
                      inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]")), ],
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.backgroundColorBlue,
                              //color: HexColor("#0000001F"),
                              width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xFF000000).withOpacity(0.4),
                              width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        labelText: "RERA Number",
                        filled: false,
                        focusColor: Colors.black,
                        labelStyle: TextStyle(
                            fontFamily: "Muli",
                            color: ColorConstants.inputBoxHintColorDark,
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0),
                        fillColor: ColorConstants.backgroundColor,
                      ),
                    ),
                    SizedBox(height: 16),

                    TextFormField(
                      maxLines: 4,
                      maxLength: 500,
                      // initialValue: _comments.text,
                      controller: _comments,

                      // validator: (value) {
                      //   if (value.isEmpty) {
                      //     return 'Please enter RERA Number ';
                      //   }
                      //
                      //   return null;
                      // },
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.inputBoxHintColor,
                          fontFamily: "Muli"),
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        print(_comments.text);
                        // setState(() {
                        //   _comments.text = value;
                        // });
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.backgroundColorBlue,
                              //color: HexColor("#0000001F"),
                              width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xFF000000).withOpacity(0.4),
                              width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        labelText: "Comment",
                        filled: false,
                        focusColor: Colors.black,
                        labelStyle: TextStyle(
                            fontFamily: "Muli",
                            color: ColorConstants.inputBoxHintColorDark,
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0),
                        fillColor: ColorConstants.backgroundColor,
                      ),
                    ),
                    SizedBox(height: 16),

                    // Center(
                    //   child: FlatButton(
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(0),
                    //         side: BorderSide(color: Colors.black26)),
                    //     color: Colors.transparent,
                    //     child: Padding(
                    //       padding: const EdgeInsets.only(
                    //           right: 5, bottom: 8, top: 5),
                    //       child: Text(
                    //         "ADD COMMENT",
                    //         style: TextStyle(
                    //             color: HexColor("#1C99D4"),
                    //             fontWeight: FontWeight.bold,
                    //             // letterSpacing: 2,
                    //             fontSize: 17),
                    //       ),
                    //     ),
                    //     onPressed: () async {
                    //       if (_comments.value.text != null &&
                    //           _comments.value.text != '') {
                    //         print("here");
                    //         setState(() {
                    //           _commentsList.add(
                    //             new CommentsDetail(
                    //                 commentedBy: "XYZNAME",
                    //                 comment: _comments.value.text,
                    //                 commentedAt: DateTime.now()),
                    //           );
                    //           _comments.clear();
                    //         });
                    //       }
                    //       SystemChannels.textInput
                    //           .invokeMethod('TextInput.hide');
                    //     },
                    //   ),
                    // ),
                    _commentsList != null && _commentsList.length != 0
                        ? viewMoreActive
                            ? Row(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        reverse: true,
                                        shrinkWrap: true,
                                        itemCount: _commentsList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _commentsList[index]
                                                        .creatorName,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25),
                                                  ),
                                                  Text(
                                                    _commentsList[index]
                                                        .commentText,
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        fontSize: 25),
                                                  ),
                                                  Text(
                                                    _commentsList[index]
                                                        .commentedAt
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              )
                                            ],
                                          );
                                        }),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        _commentsList[_commentsList.length - 1]
                                            .creatorName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                      Text(
                                        _commentsList[_commentsList.length - 1]
                                            .commentText,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontSize: 25),
                                      ),
                                      Text(
                                        _commentsList[_commentsList.length - 1]
                                            .commentedAt
                                            .toString(),
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              )
                        : Container(),
                    // Padding(
                    //   padding:
                    //       const EdgeInsets.only(top: 10.0, bottom: 10, left: 5),
                    //   child: Text(
                    //     "XYZ Kumar",
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 25,
                    //         // color: HexColor("#000000DE"),
                    //         fontFamily: "Muli"),
                    //   ),
                    // ),
                    // Padding(
                    //   padding:
                    //       const EdgeInsets.only(top: 5.0, bottom: 20, left: 5),
                    //   child: Text(
                    //     "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    //     style: TextStyle(
                    //         //fontWeight: FontWeight.bold,
                    //         fontSize: 20,
                    //         // color: HexColor("#000000DE"),
                    //         fontFamily: "Muli"),
                    //   ),
                    // ),
                    Center(
                      child: FlatButton(
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(0),
                        //     side: BorderSide(color: Colors.black26)),
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 5, bottom: 8, top: 5),
                          child: !viewMoreActive
                              ? Text(
                                  "VIEW MORE COMMENT (" +
                                      _commentsList.length.toString() +
                                      ")",
                                  style: TextStyle(
                                      color: HexColor("##F9A61A"),
                                      fontWeight: FontWeight.bold,
                                      // letterSpacing: 2,
                                      fontSize: 17),
                                )
                              : Text(
                                  "VIEW LESS COMMENT (" +
                                      _commentsList.length.toString() +
                                      ")",
                                  style: TextStyle(
                                      color: HexColor("##F9A61A"),
                                      fontWeight: FontWeight.bold,
                                      // letterSpacing: 2,
                                      fontSize: 17),
                                ),
                        ),
                        onPressed: () async {
                          setState(() {
                            viewMoreActive = !viewMoreActive;
                          });
                        },
                      ),
                    ),

                    SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                              side: BorderSide(color: Colors.black26)),
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 5, bottom: 8, top: 5),
                            child: Text(
                              "SAVE AND CLOSE",
                              style: TextStyle(
                                  color: HexColor("#1C99D4"),
                                  fontWeight: FontWeight.bold,
                                  // letterSpacing: 2,
                                  fontSize: 17),
                            ),
                          ),
                          onPressed: () async {
                            // print(_comments.text);
                            if (!_isSaveButtonDisabled) {
                              _isSaveButtonDisabled = true;
                              _isSubmitButtonDisabled = false;

                              if (_contactNumber != null &&
                                  _contactNumber != '' &&
                                  _contactNumber.length == 10) {
                                print("here");
                                setState(() {
                                  String empId;
                                  String mobileNumber;
                                  String name;
                                  Future<SharedPreferences> _prefs =
                                      SharedPreferences.getInstance();
                                  _prefs.then((SharedPreferences prefs) async {
                                    empId = prefs.getString(
                                            StringConstants.employeeId) ??
                                        "empty";
                                    mobileNumber = prefs.getString(
                                            StringConstants.mobileNumber) ??
                                        "empty";
                                    name = prefs.getString(
                                            StringConstants.employeeName) ??
                                        "empty";
                                    print("DHAWAM ::::" + _comments.text);

                                    if (_comments.text != null &&
                                        _comments.text != '') {
                                      await _commentsListNew.add(
                                        new CommentsDetail(
                                            createdBy: empId,
                                            commentText: _comments.text,
                                            // commentedAt: DateTime.now(),
                                            creatorName: name),
                                      );
                                    }

                                    // print("DHAWAM " + _commentsListNew[0].commentText);

                                    if (_listInfluencerDetail.length != 0) {
                                      if (_listInfluencerDetail[
                                                      _listInfluencerDetail
                                                              .length -
                                                          1]
                                                  .inflName ==
                                              null ||
                                          _listInfluencerDetail[
                                                      _listInfluencerDetail
                                                              .length -
                                                          1]
                                                  .inflName ==
                                              "null" ||
                                          _listInfluencerDetail[
                                                  _listInfluencerDetail.length -
                                                      1]
                                              .inflName
                                              .text
                                              .isNullOrBlank) {
                                        print("here1234");
                                        _listInfluencerDetail.removeAt(
                                            _listInfluencerDetail.length - 1);
                                      }
                                    }

                                    List<InfluencerDetailDraft>
                                        influencerDetailDraft = new List();
                                    for (int i = 0;
                                        i < _listInfluencerDetail.length;
                                        i++) {
                                      influencerDetailDraft.add(
                                          new InfluencerDetailDraft(
                                              id: _listInfluencerDetail[i]
                                                  .id
                                                  .text,
                                              inflName: _listInfluencerDetail[i]
                                                  .inflName
                                                  .text,
                                              inflContact: _listInfluencerDetail[i]
                                                  .inflContact
                                                  .text,
                                              inflTypeId:
                                                  _listInfluencerDetail[i]
                                                      .inflTypeId
                                                      .text,
                                              inflTypeValue:
                                                  _listInfluencerDetail[i]
                                                      .inflTypeValue
                                                      .text,
                                              inflCatId: _listInfluencerDetail[i]
                                                  .inflCatId
                                                  .text,
                                              inflCatValue:
                                                  _listInfluencerDetail[i]
                                                      .inflCatValue
                                                      .text,
                                              ilpIntrested:
                                                  _listInfluencerDetail[i]
                                                      .ilpIntrested
                                                      .text,
                                              isExpanded:
                                                  _listInfluencerDetail[i]
                                                      .isExpanded,
                                              isPrimarybool:
                                                  _listInfluencerDetail[i]
                                                      .isPrimarybool,
                                              isPrimary:
                                                  _listInfluencerDetail[i]
                                                      .isPrimary));
                                    }

                                    List<ListLeadImageDraft>
                                        listLeadImageDraft = new List();

                                    for (int i = 0;
                                        i < _imageList.length;
                                        i++) {
                                      listLeadImageDraft.add(
                                          new ListLeadImageDraft(
                                              photoPath: _imageList[i].path));
                                    }

                                    final DateFormat formatter =
                                        DateFormat("dd-MM-yyyy");

                                    SaveLeadRequestDraftModel
                                        saveLeadRequestDraftModel =
                                        new SaveLeadRequestDraftModel(
                                            siteSubTypeId: "2",
                                            contactName: _contactName,
                                            contactNumber: _contactNumber,
                                            geotagType: geoTagType,
                                            leadLatitude:
                                                _currentPosition
                                                    .latitude
                                                    .toString(),
                                            leadLongitude: _currentPosition
                                                .longitude
                                                .toString(),
                                            leadAddress: _siteAddress.text,
                                            leadPincode: _pincode.text,
                                            leadStateName: _state.text,
                                            leadDistrictName: _district.text,
                                            leadTalukName: _taluk.text,
                                            leadSalesPotentialMt:
                                                _totalMT.text ?? "0",
                                            leadBags: _totalBags.text,
                                            leadReraNumber: _rera.text,
                                            isStatus: "false",
                                            // listLeadImage: new List(),
                                            //  influencerList: new List(),
                                            // comments: new List(),
                                            listLeadImage: listLeadImageDraft,
                                            influencerList:
                                                influencerDetailDraft,
                                            comments: _commentsListNew,
                                            assignDate: formatter
                                                .format(DateTime.now()));

//
//                                   SaveLeadRequestModel saveLeadRequestModel1 = json.decode(draftLeadModelforDB.leadModel);

                                    print(saveLeadRequestDraftModel.toJson());
                                    print(gv.fromLead);
                                    if (!gv.fromLead) {
                                      DraftLeadModelforDB draftLeadModelforDB =
                                          new DraftLeadModelforDB(
                                              null,
                                              json.encode(
                                                  saveLeadRequestDraftModel));
                                      print(draftLeadModelforDB.leadModel);
                                      await db
                                          .addLeadInDraft(draftLeadModelforDB);
                                    } else {
                                      print(json
                                          .encode(saveLeadRequestDraftModel));
                                      DraftLeadModelforDB draftLeadModelforDB =
                                          new DraftLeadModelforDB(
                                              gv.draftID,
                                              json.encode(
                                                  saveLeadRequestDraftModel));

                                      await db.updateLeadInDraft(
                                          draftLeadModelforDB);
                                    }

                                    gv.fromLead = false;
                                    gv.saveLeadRequestModel =
                                        new SaveLeadRequestDraftModel();
                                    Navigator.pushReplacement(
                                        context,
                                        new CupertinoPageRoute(
                                            builder: (BuildContext context) =>
                                                DraftLeadListScreen()));
                                  });

                                  //  _comments.clear();
                                });
                              } else {
                                Get.dialog(CustomDialogs().errorDialog(
                                    "Please fill atleast a contact number"));
                              }
                            }
                          },
                        ),
                        RaisedButton(
                          color: HexColor("#1C99D4"),
                          child: Text(
                            "SUBMIT",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                // letterSpacing: 2,
                                fontSize: 17),
                          ),
                          onPressed: () async {
                            //print(_comments.text);
                            if (!_isSubmitButtonDisabled) {
                              _isSubmitButtonDisabled = true;
                              _isSaveButtonDisabled = false;
                              if (_contactNumber != null &&
                                      _contactNumber.length == 10 &&
                                      _contactNumber != '' &&
                                      _currentPosition.latitude != null &&
                                      _currentPosition.latitude != '' &&
                                      _pincode.text != null &&
                                      _pincode.text != ''
                                  //&&
                                  // _listInfluencerDetail.length != 0
                                  ) {
                                // print(_comments.text);
                                print("here");
                                setState(() {
                                  String empId;
                                  String mobileNumber;
                                  String name;
                                  Future<SharedPreferences> _prefs =
                                      SharedPreferences.getInstance();
                                  _prefs.then((SharedPreferences prefs) async {
                                    empId = prefs.getString(
                                            StringConstants.employeeId) ??
                                        "empty";
                                    mobileNumber = prefs.getString(
                                            StringConstants.mobileNumber) ??
                                        "empty";
                                    name = prefs.getString(
                                            StringConstants.employeeName) ??
                                        "empty";
                                    //   print("DHAWAM " + _comments.text);
                                    if (_comments.text == "" ||
                                        _comments.text == "null" ||
                                        _comments.text == null) {
                                      _comments.text = "Added New Lead";
                                    }
                                    await _commentsListNew.add(
                                      new CommentsDetail(
                                          createdBy: empId,
                                          commentText: _comments.text,
                                          // commentedAt: DateTime.now(),
                                          creatorName: name),
                                    );
                                    // print("DHAWAM " + _commentsListNew[0].commentText);

                                    if (_listInfluencerDetail.length != 0 &&
                                        (_listInfluencerDetail[
                                                        _listInfluencerDetail
                                                                .length -
                                                            1]
                                                    .inflName ==
                                                null ||
                                            _listInfluencerDetail[
                                                        _listInfluencerDetail
                                                                .length -
                                                            1]
                                                    .inflName ==
                                                "null" ||
                                            _listInfluencerDetail[
                                                    _listInfluencerDetail
                                                            .length -
                                                        1]
                                                .inflName
                                                .text
                                                .isNullOrBlank)) {
                                      print("here1234");
                                      _listInfluencerDetail.removeAt(
                                          _listInfluencerDetail.length - 1);
                                    }
                                    //  print(22112);
                                    // print(_listInfluencerDetail[1].toJson());
                                    SaveLeadRequestModel saveLeadRequestModel =
                                        new SaveLeadRequestModel(
                                            eventId: widget.eventId,
                                            siteSubTypeId: "2",
                                            contactName: _contactName,
                                            contactNumber: _contactNumber,
                                            geotagType: geoTagType,
                                            leadLatitude:
                                                (_currentPosition != null)
                                                    ? _currentPosition.latitude
                                                        .toString()
                                                    : "0",
                                            leadLongitude: (_currentPosition !=
                                                    null)
                                                ? _currentPosition.longitude
                                                    .toString()
                                                : "0",
                                            leadAddress: _siteAddress.text,
                                            leadPincode: _pincode.text,
                                            leadStateName: _state.text,
                                            leadDistrictName: _district.text,
                                            leadTalukName: _taluk.text,
                                            leadSalesPotentialMt: _totalMT.text,
                                            leadReraNumber: _rera.text,
                                            isStatus: "false",
                                            listLeadImage: listLeadImage,
                                            influencerList:
                                                _listInfluencerDetail,
                                            comments: _commentsListNew);

                                    if (!gv.fromLead) {
                                      gv.draftID = 0;
                                    }

                                    internetChecking().then((result) => {
                                          if (result == true)
                                            {
                                              _addLeadsController
                                                  .getAccessKeyAndSaveLead(
                                                      saveLeadRequestModel,
                                                      _imageList,
                                                      context),
                                              _commentsListNew = new List()
                                            }
                                          else
                                            {
                                              Get.snackbar(
                                                  "No internet connection.",
                                                  "Make sure that your wifi or mobile data is turned on.",
                                                  colorText: Colors.white,
                                                  backgroundColor: Colors.red,
                                                  snackPosition:
                                                      SnackPosition.BOTTOM),
                                              // fetchSiteList()
                                            }
                                        });
                                  });

                                  //  _comments.clear();
                                });
                              } else {
                                _isSubmitButtonDisabled = false;
                                Get.dialog(CustomDialogs().errorDialog(
                                    "Please fill the mandotary fields. i.e. Contact Number , Address  . "));
                              }
                            }
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      //print(image.path);
      if (image != null) {
        // print(basename(image.path));

        listLeadImage.add(new ListLeadImage(photoName: basename(image.path)));
        _imageList.add(image);
      }
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      // print(image.path);
      if (image != null) {
        listLeadImage.add(new ListLeadImage(photoName: basename(image.path)));
        _imageList.add(image);
      }
      // _imageList.insert(0,image);
    });
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

  _getCurrentLocation() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      Get.back();
      Get.dialog(CustomDialogs().errorDialog(
          "Please enable your location service from device settings"));
    } else {
      geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) {
        setState(() {
          _currentPosition = position;
        });

        _getAddressFromLatLng();
        Get.back();
      }).catchError((e) {
        Get.back();
        Get.dialog(
            CustomDialogs().errorDialog("Access to location data denied "));
        print(e);
      });
    }
  }

  _getAddressFromLatLng() async {
    try {
      print(
          "from lat long ${await geolocator.placemarkFromCoordinates(_currentPosition.latitude, _currentPosition.longitude)}");
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];
      setState(() {
        _siteAddress.text =
            place.name + "," + place.thoroughfare + "," + place.subLocality;
        _district.text = place.subAdministrativeArea;
        _state.text = place.administrativeArea;
        _pincode.text = place.postalCode;
        _taluk.text = place.locality;
        //txt.text = place.postalCode;
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
        print(
            "........ selected ${place.name}, ${place.isoCountryCode}, ${place.country},${place.postalCode}, "
            "${place.administrativeArea}, ${place.subAdministrativeArea},${place.locality}, ${place.subLocality}, "
            "${place.thoroughfare}, ${place.subThoroughfare}, ${place.position}");
      });
    } catch (e) {
      print("ex.....   $e");
    }
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
              title: Text(item.expandedValue),
              subtitle: Text('To delete this panel, tap the trash can icon'),
              trailing: Icon(Icons.delete),
              onTap: () {
                setState(() {
                  _data.removeWhere((currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  void toggleSwitchforPrimary(bool value) {
    setState(() {
      isSwitchedPrimary = value;
    });
  }
}

class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Influencer Details ',
      expandedValue: 'This is item number $index',
    );
  });
}

//
// List<Item> addItems(Item item){
//   _data.add
//   return List.
// }



import 'dart:convert';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/presentation/common_widgets/upload_photo_bottomsheet.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/location/custom_map.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/utils/functions/validation.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tech_sales/helper/draftLeadDBHelper.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/add_leads_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/AddLeadInitialModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/CommentDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/DraftLeadModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SaveLeadRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/DraftLeadListScreen.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:flutter_tech_sales/utils/constants/GlobalConstant.dart' as gv;
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
*/
class AddNewLeadForm extends StatefulWidget {
  AddNewLeadForm({this.eventId});
  final eventId;
  @override
  _AddNewLeadFormState createState() => _AddNewLeadFormState();
}

class _AddNewLeadFormState extends State<AddNewLeadForm> {
  final db = DraftLeadDBHelper();

  final _formKeyForNewLeadForm = GlobalKey<FormState>();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  String _myActivity;
  LocationResult _pickedLocation;
  bool isSwitchedPrimary = false;
  var txt = TextEditingController();
  SiteSubTypeEntity _selectedValue;
  String _contactName;
  FocusNode myFocusNode;
  String _contactNumber;
  String _comment;
  String leadSource;
  TextEditingController _nameController = TextEditingController();
  var _siteAddress = TextEditingController();
  var _pincode = TextEditingController();
  var _state = TextEditingController();
  var _district = TextEditingController();
  var _taluk = TextEditingController();
  var _comments = TextEditingController();
  var _rera = TextEditingController();
  var _influencerNumber = TextEditingController();
  var _influencerName = TextEditingController();
  var _influencerType = TextEditingController();
  var _influencerCategory = TextEditingController();
  var _other = TextEditingController();
  var sourceMobile = TextEditingController();
  String geoTagType;

  var _totalBags = TextEditingController();
  var _totalMT = TextEditingController();
  List<File> _imageList = new List();
  List<ListLeadImage> listLeadImage = new List<ListLeadImage>();
  List<CommentsDetail> _commentsList = new List();
  List<CommentsDetail> _commentsListNew = new List();
  bool viewMoreActive = false;
  bool _isSubmitButtonDisabled;
  bool _isSaveButtonDisabled;
  bool _isDropdownVisible = false;
  bool _isInfTextfieldVisible = false;
  bool _isOtherTextfieldVisible = false;

  List<String> _items = new List(); // to store comments

  final myController = TextEditingController();

  void _addComment() {
    if (myController.text.isNotEmpty) {
      // check if the comments text input is not empty
      setState(() {
        _items.add(myController.text); // add new commnet to the existing list
      });

      myController.clear(); // clear the text from the input
    }
  }

  Future<bool> internetChecking() async {
    // do something here
    bool result = await DataConnectionChecker().hasConnection;
    return result;
  }

  List<Item> _data = generateItems(1);
  List<InfluencerDetail> _listInfluencerDetail = new List();

  Position _currentPosition = new Position();
  String _currentAddress;

  List<SiteSubTypeEntity> siteSubTypeEntity = [
    new SiteSubTypeEntity(siteSubId: 1, siteSubTypeDesc: "Ground"),
    new SiteSubTypeEntity(siteSubId: 2, siteSubTypeDesc: "G+1"),
    new SiteSubTypeEntity(siteSubId: 3, siteSubTypeDesc: "Multi-Storey"),
  ];
  List<InfluencerTypeEntity> influencerTypeEntity;

  List<InfluencerCategoryEntity> influencerCategoryEntity;
  List<DealerList> dealerList;
  List<SubDealerList> subDealerList;
  List<SalesOfficerList> salesOfficerList;
  List<EventList> eventList;
  List<LeadSourceList> sourceList;

  String _dealerId, _subDealerId, _salesOfficerId, _eventId, _leadSourceUser;

  AddLeadsController _addLeadsController = Get.find();
  SaveLeadRequestDraftModel saveLeadRequestModelFromDraft =
      new SaveLeadRequestDraftModel();

  final List<String> sourceItems = <String>[
    "SELF",
    "DEALER",
    "SUB-DEALER",
    "SALES OFFICER",
    "INFLUENCER",
    "EVENT",
    "OTHER"
  ];
  String selectedItem = 'SELF';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isSubmitButtonDisabled = false;
    _isSaveButtonDisabled = false;
    _addLeadsController = Get.find();
    myFocusNode = FocusNode();
    getInitialData();
  }

  @override
  void dispose() {
    super.dispose();
    _formKeyForNewLeadForm.currentState != null
        ? _formKeyForNewLeadForm.currentState.dispose()
        : print("nothing happened");
    //_addLeadsController.dispose();
    // _formKey.currentState.dispose();
  }

  getInitialData() {
    setState(() {
      print(gv.fromLead);
      try {
        if (gv.fromLead) {
          saveLeadRequestModelFromDraft = gv.saveLeadRequestModel;
          _contactName = saveLeadRequestModelFromDraft.contactName;
          geoTagType = saveLeadRequestModelFromDraft.geotagType;
          _contactNumber = saveLeadRequestModelFromDraft.contactNumber;
          if (saveLeadRequestModelFromDraft.leadLatitude != "null" &&
              saveLeadRequestModelFromDraft.leadLatitude != null) {
            _currentPosition = new Position(
                latitude:
                    double.parse(saveLeadRequestModelFromDraft.leadLatitude),
                longitude:
                    double.parse(saveLeadRequestModelFromDraft.leadLongitude));
          }
          _siteAddress.text = saveLeadRequestModelFromDraft.leadAddress;
          _pincode.text = saveLeadRequestModelFromDraft.leadPincode;
          _state.text = saveLeadRequestModelFromDraft.leadStateName;
          _district.text = saveLeadRequestModelFromDraft.leadDistrictName;
          _taluk.text = saveLeadRequestModelFromDraft.leadTalukName;
          _totalMT.text = saveLeadRequestModelFromDraft.leadSalesPotentialMt;
          _totalBags.text = saveLeadRequestModelFromDraft.leadBags;
          _rera.text = saveLeadRequestModelFromDraft.leadReraNumber;
          if (_totalMT.text != null &&
              _totalMT.text != "null" &&
              _totalMT.text != "") {
            _totalBags.text =
                (double.parse(_totalMT.text) * 20).round().toString();
          }

          leadSource = saveLeadRequestModelFromDraft.leadSource;
          _leadSourceUser = saveLeadRequestModelFromDraft.leadSourceUser;
          print("{{{{{{{{{");
          print(leadSource.runtimeType);
          print(_leadSourceUser);
          displayLeadSourceUserForDraft();
          // print("=======$leadSource");
          //print("=======${saveLeadRequestModelFromDraft.leadSourceUser}");

          // listLeadImage = saveLeadRequestModelFromDraft.listLeadImage;
          //print(saveLeadRequestModelFromDraft.influencerList[0].toJson());
          if (saveLeadRequestModelFromDraft.influencerList.length != 0) {
            print(saveLeadRequestModelFromDraft.influencerList[0].inflName);
            for (int i = 0;
                i < saveLeadRequestModelFromDraft.influencerList.length;
                i++) {
              /*print(23454);
            print(saveLeadRequestModelFromDraft.influencerList[i].toJson());
            print(saveLeadRequestModelFromDraft.influencerList[i].id);*/
              _listInfluencerDetail.add(new InfluencerDetail(
                  id: new TextEditingController(
                      text: saveLeadRequestModelFromDraft.influencerList[i].id),
                  inflName: new TextEditingController(
                      text: saveLeadRequestModelFromDraft
                          .influencerList[i].inflName),
                  inflContact: new TextEditingController(
                      text: saveLeadRequestModelFromDraft
                          .influencerList[i].inflContact),
                  inflTypeId: new TextEditingController(
                      text: saveLeadRequestModelFromDraft
                          .influencerList[i].inflTypeId),
                  inflTypeValue: new TextEditingController(
                      text: saveLeadRequestModelFromDraft
                          .influencerList[i].inflTypeValue),
                  inflCatId: new TextEditingController(
                      text: saveLeadRequestModelFromDraft
                          .influencerList[i].inflCatId),
                  inflCatValue: new TextEditingController(
                      text: saveLeadRequestModelFromDraft
                          .influencerList[i].inflCatValue),
                  ilpIntrested: new TextEditingController(
                      text: saveLeadRequestModelFromDraft
                          .influencerList[i].ilpIntrested),
                  isExpanded: saveLeadRequestModelFromDraft
                      .influencerList[i].isExpanded,
                  isPrimarybool: saveLeadRequestModelFromDraft
                      .influencerList[i].isPrimarybool,
                  isPrimary: saveLeadRequestModelFromDraft
                      .influencerList[i].isPrimary));
            }
          }

          if (saveLeadRequestModelFromDraft.listLeadImage.length != null) {
            for (int i = 0;
                i < saveLeadRequestModelFromDraft.listLeadImage.length;
                i++) {
              _imageList.add(new File(
                  saveLeadRequestModelFromDraft.listLeadImage[i].photoPath));

              listLeadImage.add(new ListLeadImage(
                  photoName: basename(saveLeadRequestModelFromDraft
                      .listLeadImage[i].photoPath)));
            }
          }

          // _commentsListNew = saveLeadRequestModelFromDraft.comments;
          if (saveLeadRequestModelFromDraft.comments.length != 0) {
            _comments.text =
                saveLeadRequestModelFromDraft.comments[0].commentText;
          }

          //print (saveLeadRequestModelFromDraft.comments[0].commentText);
          saveLeadRequestModelFromDraft = new SaveLeadRequestDraftModel();
          gv.saveLeadRequestModel = new SaveLeadRequestDraftModel();
        }
      } catch (_) {
        print('We are in catch :: Add New Form');
      }
    });
    internetChecking().then((result) => {
          if (result == true)
            {}
          else
            {
              Get.snackbar("No internet connection.",
                  "Make sure that your wifi or mobile data is turned on.",
                  colorText: Colors.white,
                  backgroundColor: Colors.red,
                  snackPosition: SnackPosition.BOTTOM),
              // fetchSiteList()
            }
        });
    AddLeadInitialModel addLeadInitialModel = new AddLeadInitialModel();
    AccessKeyModel accessKeyModel = new AccessKeyModel();

    internetChecking().then((result) => {
          if (result == true)
            {
              _addLeadsController.getAccessKeyOnly().then((data) async {
                accessKeyModel = data;
                print("AccessKey :: " + accessKeyModel.accessKey);
                await _addLeadsController
                    .getAddLeadsData(accessKeyModel.accessKey)
                    .then((data) {
                  addLeadInitialModel = data;
                  setState(() {
                    //siteSubTypeEntity = addLeadInitialModel.siteSubTypeEntity;
                    influencerTypeEntity =
                        addLeadInitialModel.influencerTypeEntity;
                    influencerCategoryEntity =
                        addLeadInitialModel.influencerCategoryEntity;
                    //  print(influencerCategoryEntity[0].inflCatDesc);
                    dealerList = addLeadInitialModel.dealerList;
                    subDealerList = addLeadInitialModel.subDealerList;
                    eventList = addLeadInitialModel.eventList;
                    salesOfficerList = addLeadInitialModel.salesOfficerList;
                    sourceList = addLeadInitialModel.leadSourceList;
                  });
                });
                if (_listInfluencerDetail.length == 0) {
                  _listInfluencerDetail.add(new InfluencerDetail(
                      isExpanded: true, isPrimarybool: true));
                }
                Get.back();
                myFocusNode.requestFocus();
              })
            }
          else
            {
              Get.snackbar("No internet connection.",
                  "Make sure that your wifi or mobile data is turned on.",
                  colorText: Colors.white,
                  backgroundColor: Colors.red,
                  snackPosition: SnackPosition.BOTTOM),
              // fetchSiteList()
            }
        });
  }

  displayLeadSourceUserForDraft() {
    if (leadSource == "DEALER") {
      _dealerId = _leadSourceUser;
      _isDropdownVisible = true;
      _isInfTextfieldVisible = false;
      _isOtherTextfieldVisible = false;
    } else if (leadSource == "SUB-DEALER") {
      _subDealerId = _leadSourceUser;
      _isDropdownVisible = true;
      _isInfTextfieldVisible = false;
      _isOtherTextfieldVisible = false;
    } else if (leadSource == "SALES OFFICER") {
      _salesOfficerId = _leadSourceUser;
      _isDropdownVisible = true;
      _isInfTextfieldVisible = false;
      _isOtherTextfieldVisible = false;
    } else if (leadSource == "INFLUENCER") {
      sourceMobile.text = _leadSourceUser;
      _isInfTextfieldVisible = true;
      _isDropdownVisible = false;
      _isOtherTextfieldVisible = false;
    } else if (leadSource == "EVENT") {
      _eventId = _leadSourceUser;
      _isDropdownVisible = true;
      _isInfTextfieldVisible = false;
      _isOtherTextfieldVisible = false;
    } else if (leadSource == "OTHER") {
      _other.text = _leadSourceUser;
      _isOtherTextfieldVisible = true;
      _isDropdownVisible = false;
      _isInfTextfieldVisible = false;
    } else if (leadSource == "SPOTTER") {
      _other.text = _leadSourceUser;
      _isOtherTextfieldVisible = true;
      _isDropdownVisible = false;
      _isInfTextfieldVisible = false;
    } else if (leadSource == "TECH VAN") {
      _other.text = _leadSourceUser;
      _isOtherTextfieldVisible = true;
      _isDropdownVisible = false;
      _isInfTextfieldVisible = false;
    }else {
      _isDropdownVisible = false;
      _isInfTextfieldVisible = false;
      _isOtherTextfieldVisible = false;
    }
  }

  displayLeadSourceUser() {
    if (leadSource == "DEALER") {
      //_dealerId = _leadSourceUser;
      _isDropdownVisible = true;
      _isInfTextfieldVisible = false;
      _isOtherTextfieldVisible = false;
    } else if (leadSource == "SUB-DEALER") {
      //_subDealerId = _leadSourceUser;
      _isDropdownVisible = true;
      _isInfTextfieldVisible = false;
      _isOtherTextfieldVisible = false;
    } else if (leadSource == "SALES OFFICER") {
      //_salesOfficerId = _leadSourceUser;
      _isDropdownVisible = true;
      _isInfTextfieldVisible = false;
      _isOtherTextfieldVisible = false;
    } else if (leadSource == "INFLUENCER") {
      //sourceMobile.text = _leadSourceUser;
      _isInfTextfieldVisible = true;
      _isDropdownVisible = false;
      _isOtherTextfieldVisible = false;
    } else if (leadSource == "EVENT") {
      //_eventId = _leadSourceUser;
      _isDropdownVisible = true;
      _isInfTextfieldVisible = false;
      _isOtherTextfieldVisible = false;
    } else if (leadSource == "OTHER") {
      //_other.text = _leadSourceUser;
      _isOtherTextfieldVisible = true;
      _isDropdownVisible = false;
      _isInfTextfieldVisible = false;
    } else if (leadSource == "SPOTTER") {
      //_other.text = _leadSourceUser;
      _isOtherTextfieldVisible = true;
      _isDropdownVisible = false;
      _isInfTextfieldVisible = false;
    }else if (leadSource == "TECH VAN") {
      //_other.text = _leadSourceUser;
      _isOtherTextfieldVisible = true;
      _isDropdownVisible = false;
      _isInfTextfieldVisible = false;
    } else {
      _isDropdownVisible = false;
      _isInfTextfieldVisible = false;
      _isOtherTextfieldVisible = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);
    double _height = ScreenUtil().setSp(15);

    final leadSourceDropDwn = DropdownButtonFormField(
      value: (leadSource != null) ? leadSource : selectedItem,
      onChanged: (_) {
        setState(() {
          leadSource = _;
          print("DROPDOWN : $leadSource");
          // _dealerId = null;
          // _subDealerId = null;
          // _eventId = null;
          // _salesOfficerId = null;
          // sourceMobile.text = null;
          // _other.text = null;
          _leadSourceUser = null;
          displayLeadSourceUser();
        });
      },
      items: sourceList == null
          ? []
          : sourceList
              .map((e) => DropdownMenuItem(
                    child: Text(e.name),
                    value: e.name,
                  ))
              .toList(),
      style: FormFieldStyle.formFieldTextStyle,
      decoration: FormFieldStyle.buildInputDecoration(labelText: "Lead Source"),
      selectedItemBuilder: (BuildContext context) {
        return sourceList == null
            ? []
            : sourceList.map<Widget>((item) {
              print(item.name);
                return Text(item.name);
              }).toList();
      },
    );

    // DropdownButtonFormField(
    //   onChanged: (value) {
    //     setState(() {
    //       leadSource = value;
    //
    //       print("DROPDOWN : $leadSource");
    //       // _dealerId = null;
    //       // _subDealerId = null;
    //       // _eventId = null;
    //       // _salesOfficerId = null;
    //       // sourceMobile.text = null;
    //       // _other.text = null;
    //       _leadSourceUser = null;
    //       displayLeadSourceUser();
    //     });
    //   },
    //   selectedItemBuilder: (BuildContext context) {
    //     return sourceItems.map<Widget>((String item) {
    //       return Text(item);
    //     }).toList();
    //   },
    //   value: (leadSource != null) ? leadSource : selectedItem,
    //   items: sourceItems
    //       .map((e) => DropdownMenuItem(
    //             value: e != null ? e : null,
    //             child: Container(
    //                 width: MediaQuery.of(context).size.width / 1.5,
    //                 child: Text(e)),
    //           ))
    //       .toList(),
    //   style: FormFieldStyle.formFieldTextStyle,
    //   decoration: FormFieldStyle.buildInputDecoration(labelText: "Lead Source"),
    //   //validator: (value) => value == null ? 'Please select member type' : null,
    // );

    final dealerDropDwn = DropdownButtonFormField(
      onChanged: (value) {
        setState(() {
          print("DROPDOWN1 : $leadSource");
          print("DEALER : $value");

          _dealerId = value;
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return dealerList == null
            ? []
            : dealerList.map<Widget>((item) {
                return Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text(item.dealerName));
              }).toList();
      },
      value: _dealerId,
      items: dealerList == null
          ? []
          : dealerList
              .map((e) => DropdownMenuItem(
                    value: e.dealerId != null ? e.dealerId : null,
                    child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Text(e.dealerName)),
                  ))
              .toList(),
      style: FormFieldStyle.formFieldTextStyle,
      decoration:
          FormFieldStyle.buildInputDecoration(labelText: "Select Dealer"),
      validator: (value) => value == null ? 'Please select dealer' : null,
    );

    final subDealerDropDwn = DropdownButtonFormField(
      onChanged: (value) {
        setState(() {
          _subDealerId = value;
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return subDealerList == null
            ? []
            : subDealerList.map<Widget>((item) {
                return Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text(item.dealerName));
              }).toList();
      },
      value: _subDealerId,
      items: subDealerList == null
          ? []
          : subDealerList
              .map((e) => DropdownMenuItem(
                    value: e.dealerId != null ? e.dealerId : null,
                    child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Text(e.dealerName)),
                  ))
              .toList(),
      style: FormFieldStyle.formFieldTextStyle,
      decoration:
          FormFieldStyle.buildInputDecoration(labelText: "Select Subdealer"),
      validator: (value) => value == null ? 'Please select subdealer' : null,
    );

    final eventDropDwn = DropdownButtonFormField(
      onChanged: (value) {
        setState(() {
          _eventId = value;
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return eventList == null
            ? []
            : eventList.map<Widget>((item) {
                return Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text(item.eventId));
              }).toList();
      },
      value: _eventId,
      items: eventList == null
          ? []
          : eventList
              .map((e) => DropdownMenuItem(
                    value: e.eventId != null ? e.eventId : null,
                    child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Text(e.eventId)),
                  ))
              .toList(),
      style: FormFieldStyle.formFieldTextStyle,
      decoration:
          FormFieldStyle.buildInputDecoration(labelText: "Select Event"),
      validator: (value) => value == null ? 'Please select event' : null,
    );

    final salesOfficerDropDwn = DropdownButtonFormField(
      onChanged: (value) {
        setState(() {
          _salesOfficerId = value;
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return (salesOfficerList == null)
            ? []
            : salesOfficerList.map<Widget>((item) {
                return Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text(item.salesOfficerName));
              }).toList();
      },
      value: _salesOfficerId,
      items: (salesOfficerList == null)
          ? []
          : salesOfficerList
              .map((e) => DropdownMenuItem(
                    value: e.salesOfficerId,
                    child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Text(e.salesOfficerName)),
                  ))
              .toList(),
      style: FormFieldStyle.formFieldTextStyle,
      decoration: FormFieldStyle.buildInputDecoration(
          labelText: "Select Sales Officer"),
      validator: (value) => value == null ? 'Please select Sales Office' : null,
    );

    final sourceMobileNumber = TextFormField(
        controller: sourceMobile,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter mobile number ';
          } else if (value.length != 10) {
            return 'Mobile number must be of 10 digit';
          }
          if (!Validations.isValidPhoneNumber(value)) {
            return 'Enter valid mobile number';
          }
          return null;
        },
        style: FormFieldStyle.formFieldTextStyle,
        keyboardType: TextInputType.phone,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        maxLength: 10,
        //maxLengthEnforced: true,
        decoration: FormFieldStyle.buildInputDecoration(
          labelText: "Influencer Mobile number*",
        ),
        onChanged: (value) async {
          if (value.length == 10) {
            _addLeadsController.phoneNumber = value;
            AccessKeyModel accessKeyModel = new AccessKeyModel();
            await _addLeadsController.getAccessKeyOnly().then((data) async {
              accessKeyModel = data;
              _addLeadsController
                  .getInfNewData(accessKeyModel.accessKey)
                  .then((data) {
                InfluencerDetailModel _infDetailModel = data;
                if (data.respCode == "NUM404") {
                  sourceMobile.text = "";
                  Get.dialog(CustomDialogs()
                      .showDialog("No influencer registered with this number"));
                } else if (data.respCode == "DM1002") {
                  sourceMobile.text = value;
                  Get.back();
                }
              });
            });
          }
        });

    final otherTxt = TextFormField(
      controller: _other,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter lead source user';
        }
        return null;
      },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]")),
      ],
      decoration: FormFieldStyle.buildInputDecoration(
          labelText: "Enter your source user"),
    );

    final name = TextFormField(
      initialValue: _contactName,
      //focusNode: myFocusNode,
      validator: (value) {
        if (value.isEmpty ||
            value.length <= 0 ||
            value == null ||
            value == " " ||
            value.trim().isEmpty) {
          return 'Please enter name';
        }
        return null;
      },
      onChanged: (data) {
        setState(() {
          _contactName = data;
        });
      },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[0-9.a-zA-Z ]")),
      ],
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Name",
      ),
    );

    final contact = TextFormField(
      initialValue: _contactNumber,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter mobile number ';
        }
        if (value.length <= 9) {
          return 'Mobile number is incorrect';
        }
        if (!Validations.isValidPhoneNumber(value)) {
          return 'Enter valid mobile number';
        }
        return null;
      },
      onChanged: (data) {
        setState(() {
          _contactNumber = data;
        });
      },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.phone,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      maxLength: 10,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Mobile Number",
      ),
    );

    final siteAddress = TextFormField(
      controller: _siteAddress,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter Address ';
        }

        return null;
      },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Address",
      ),
    );

    final pincode = TextFormField(
      maxLength: 6,
      controller: _pincode,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter Pincode ';
        }
        if (value.length <= 6) {
          return 'Pincode is incorrect';
        }
        if (!Validations.isValidPincode(value)) {
          return "Enter valid pincode";
        }

        return null;
      },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.phone,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      //  maxLength: 6,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Pincode",
      ),
    );

    final state = TextFormField(
        controller: _state,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter State ';
          }

          return null;
        },
        style: FormFieldStyle.formFieldTextStyle,
        keyboardType: TextInputType.text,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
        ],
        decoration: FormFieldStyle.buildInputDecoration(labelText: "State"));

    final district = TextFormField(
      controller: _district,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter District ';
        }

        return null;
      },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
      ],
      decoration: FormFieldStyle.buildInputDecoration(labelText: "District"),
    );

    final taluk = TextFormField(
      controller: _taluk,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter Taluk ';
        }

        return null;
      },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
      ],
      decoration: FormFieldStyle.buildInputDecoration(labelText: "Taluk"),
    );

    final txtMandatory = Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Text(
        "Mandatory",
        style: TextStyle(
          fontFamily: "Muli",
          color: ColorConstants.inputBoxHintColorDark,
          fontWeight: FontWeight.normal,
        ),
      ),
    );

    return Scaffold(
//      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      floatingActionButton: BackFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar: BottomNavigator(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            BackgroundContainerImage(),
            GetBuilder<AddLeadsController>(
              builder: (controller) {
                return Form(
                  key: _formKeyForNewLeadForm,
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 30.0, bottom: 20, left: 5),
                          child: Text(
                            "Add a new Trade lead",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 25,
                                color: HexColor("#006838"),
                                fontFamily: "Muli"),
                          ),
                        ),
                        Container(
                          child: widget.eventId != null
                              ? Text('Event ID: ${widget.eventId}')
                              : null,
                        ),
                        SizedBox(height: _height),

                        leadSourceDropDwn,
                        SizedBox(height: _height),
                        Visibility(
                            visible: _isDropdownVisible,
                            child: Column(
                              children: [
                                (leadSource == "DEALER")
                                    ? dealerDropDwn
                                    : (leadSource == "SUB-DEALER")
                                        ? subDealerDropDwn
                                        : (leadSource == "SALES OFFICER")
                                            ? salesOfficerDropDwn
                                            : (leadSource == "EVENT")
                                                ? eventDropDwn
                                                : SizedBox(
                                                    height: 0,
                                                  ),
                                SizedBox(height: _height),
                              ],
                            )),
                        Visibility(
                            visible: _isInfTextfieldVisible,
                            child: Column(
                              children: [
                                sourceMobileNumber,
                                SizedBox(height: _height),
                              ],
                            )),
                        Visibility(
                            visible: _isOtherTextfieldVisible,
                            child: Column(
                              children: [otherTxt, SizedBox(height: _height)],
                            )),

                        name,
                        SizedBox(height: _height),
                        contact,
                        Divider(
                          color: Colors.black26,
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 20, left: 5),
                          child: Text(
                            "Geo Tag",
                            style: TextStyles.muliBold25,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FlatButton.icon(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  side: BorderSide(color: Colors.black26)),
                              color: Colors.transparent,
                              icon: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.location_searching,
                                  color: ColorConstants.btnOrange,
                                  size: 18,
                                ),
                              ),
                              label: Padding(
                                padding: const EdgeInsets.only(
                                    right: 5, bottom: 8, top: 5),
                                child: Text(
                                  "DETECT",
                                  style: TextStyles.btnOrange,
                                ),
                              ),
                              onPressed: () async {
                                setState(() {
                                  geoTagType = "A";
                                });
                                Get.dialog(Center(
                                  child: CircularProgressIndicator(),
                                ));
                                List result;
                                result = await GetCurrentLocation
                                    .getCurrentLocation();
                                _currentPosition = result[1];
                                List<String> loc = result[0];
                                print("ADD: ${result[0]}");
                                _siteAddress.text =
                                    "${loc[7]}, ${loc[6]}, ${loc[4]}";
                                _district.text = "${loc[2]}";
                                _state.text = "${loc[1]}";
                                _pincode.text = "${loc[5]}";
                                _taluk.text = "${loc[3]}";
                                _currentAddress =
                                    "${loc[3]}, ${loc[5]}, ${loc[1]}";
                              },
                            ),
                            Text(
                              "Or",
                              style:
                                  TextStyle(fontFamily: "Muli", fontSize: 17),
                            ),
                            FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  side: BorderSide(color: Colors.black26)),
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 5, bottom: 8, top: 5),
                                child: Text(
                                  "MANUAL",
                                  style: TextStyles.btnOrange,
                                ),
                              ),
                              onPressed: () async {
                                var data = [];
                                data = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CustomMap()));
                                print(data);
                                print(data.runtimeType);
                                setState(() {
                                  geoTagType = "M";
                                });
                                _currentPosition = new Position(
                                    latitude: data[0], longitude: data[1]);
                                _getAddressFromLatLng();
                              },
                            ),
                          ],
                        ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         RaisedButton(
//                           onPressed: () async {
//                             LocationResult result = await showLocationPicker(
//                                 context,
//                                 "AIzaSyBEMGF1RVNoYyxMaYE8v2isPlmeCuHDMlc",
//                                 initialCenter: LatLng(31.1975844, 29.9598339),
//                                 automaticallyAnimateToCurrentLocation: true,
// //                      mapStylePath: 'assets/mapStyle.json',
//                                 myLocationButtonEnabled: true,
//                                 // requiredGPS: true,
//                                 layersButtonEnabled: true,
//                                 countries: ['AE', 'NG']
//
// //                      resultCardAlignment: Alignment.bottomCenter,
//                                 // desiredAccuracy: LocationAccuracy.best,
//                                 );
//                             print("result = $result");
//                             setState(() => _pickedLocation = result);
//                           },
//                        //   child: Text('Pick location'),
//                         ),
//                         Text(_pickedLocation.toString()),
//                       ],
//                     ),
//                     Container(
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).canvasColor,
//                         ),
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                         child: Column(children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               Icon(Icons.location_on),
//                               SizedBox(
//                                 width: 8,
//                               ),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Text(
//                                       'Location',
//                                       style:
//                                           Theme.of(context).textTheme.caption,
//                                     ),
//                                     if (_currentPosition != null &&
//                                         _currentAddress != null)
//                                       Text(_currentAddress,
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyText2),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 8,
//                               ),
//                             ],
//                           ),
//                         ])),
                        SizedBox(height: _height),
                        siteAddress,
                        SizedBox(height: _height),
                        pincode,
                        txtMandatory,
                        SizedBox(height: _height),
                        state,
                        txtMandatory,
                        SizedBox(height: _height),
                        district,
                        txtMandatory,
                        SizedBox(height: _height),

                        taluk,
                        txtMandatory,
                        SizedBox(height: _height),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                                side: BorderSide(color: Colors.black26)),
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
                              if (controller.imageList.length < 5) {
                                /*when user create a new lead that time user selected the image by camera or gallery  only*/
                                controller.updateImageList(
                                    await UploadImageBottomSheet.showPicker(
                                        context),
                                    userSelectedImageStatus
                                );
                              } else {
                                Get.dialog(CustomDialogs().errorDialog(
                                    "You can add only upto 5 photos"));
                              }
                            },
                          ),
                        ),

                        controller.imageList != null
                            ? Row(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: controller.imageList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                            onTap: () {
                                              return showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      content: new Container(
                                                        // width: 500,
                                                        // height: 500,
                                                        child: Image.file(
                                                            controller
                                                                    .imageList[
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
                                                              FontWeight.bold,
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
                                                    color: HexColor("#FFCD00"),
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      UploadImageBottomSheet
                                                          .image = null;
                                                      controller
                                                          .updateImageAfterDelete(
                                                              index);

                                                      // controller.imageList
                                                      //     .removeAt(index);
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
                            : Container(),

                        //SizedBox(height: 16),
                        Divider(
                          color: Colors.black26,
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 0.0, left: 5),
                          child: Text(
                            "Influencer Details",
                            style: TextStyles.muliBold25,
                          ),
                        ),
                        // Container(
                        //   child: _buildPanel(),
                        // ),
                        influencer(),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: influencer(),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: 16),

                        // Center(
                        //   child: FlatButton(
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(0),
                        //         side: BorderSide(color: Colors.black26)),
                        //     color: Colors.transparent,
                        //     child: Padding(
                        //       padding: const EdgeInsets.only(
                        //           right: 5, bottom: 8, top: 5),
                        //       child: Text(
                        //         "ADD MORE INFLUENCER",
                        //         style: TextStyle(
                        //             color: HexColor("#1C99D4"),
                        //             fontWeight: FontWeight.bold,
                        //             // letterSpacing: 2,
                        //             fontSize: 17),
                        //       ),
                        //     ),
                        //     onPressed: () async {
                        //       // //  print(_listInfluencerDetail[
                        //       //   _listInfluencerDetail.length - 1]
                        //       //       .inflName);
                        //       if (_listInfluencerDetail[
                        //       _listInfluencerDetail.length - 1]
                        //           .inflName !=
                        //           null &&
                        //           _listInfluencerDetail[
                        //           _listInfluencerDetail.length - 1]
                        //               .inflName !=
                        //               "null" &&
                        //           !_listInfluencerDetail[
                        //           _listInfluencerDetail.length - 1]
                        //               .inflName
                        //               .text
                        //               .isNullOrBlank) {
                        //         InfluencerDetail infl = new InfluencerDetail(
                        //             isExpanded: true, isPrimarybool: false);
                        //
                        //         // Item item = new Item(
                        //         //     headerValue: "agx ", expandedValue: "dnxcx");
                        //         setState(() {
                        //           // _data.add(item);
                        //           _listInfluencerDetail[
                        //           _listInfluencerDetail.length - 1]
                        //               .isExpanded = false;
                        //           _listInfluencerDetail.add(infl);
                        //         });
                        //       } else {
                        //         print(
                        //             "Error : Please fill previous influencer first");
                        //         Get.dialog(CustomDialogs().errorDialog(
                        //             "Please fill previous influencer first"));
                        //       }
                        //     },
                        //   ),
                        // ),

                        Divider(
                          color: Colors.black26,
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 20, left: 5),
                          child: Text(
                            "Total Site Potential",
                            style: TextStyles.muliBold25,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: TextFormField(
                                    controller: _totalBags,
                                    onChanged: (value) {
                                      setState(() {
                                        // _totalBags.text = value ;
                                        if (_totalBags.text == null ||
                                            _totalBags.text == "") {
                                          _totalMT.clear();
                                        } else {
                                          _totalMT.text =
                                              (int.parse(_totalBags.text) / 20)
                                                  .toString();
                                        }
                                      });
                                    },
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter Bags ';
                                      }

                                      return null;
                                    },
                                    style: FormFieldStyle.formFieldTextStyle,
                                    decoration:
                                        FormFieldStyle.buildInputDecoration(
                                      labelText: "Bags",
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: TextFormField(
                                  controller: _totalMT,
                                  onChanged: (value) {
                                    setState(() {
                                      // _totalBags.text = value ;
                                      if (_totalMT.text == null ||
                                          _totalMT.text == "") {
                                        _totalBags.clear();
                                      } else {
                                        _totalBags.text =
                                            (double.parse(_totalMT.text) * 20)
                                                .toInt()
                                                .toString();
                                      }
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter MT ';
                                    }

                                    return null;
                                  },
                                  style: FormFieldStyle.formFieldTextStyle,
                                  decoration:
                                      FormFieldStyle.buildInputDecoration(
                                    labelText: "MT",
                                  ),
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: false),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 16),
                        Divider(
                          color: Colors.black26,
                          thickness: 1,
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _rera,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter RERA Number ';
                            }

                            return null;
                          },
                          style: FormFieldStyle.formFieldTextStyle,
                          decoration: FormFieldStyle.buildInputDecoration(
                            labelText: "RERA Number",
                          ),
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[0-9a-zA-Z ]")),
                          ],
                        ),
                        SizedBox(height: 16),

                        TextFormField(
                          maxLines: 4,
                          maxLength: 500,
                          // initialValue: _comments.text,
                          controller: _comments,

                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return 'Please enter RERA Number ';
                          //   }
                          //
                          //   return null;
                          // },
                          style: FormFieldStyle.formFieldTextStyle,
                          decoration: FormFieldStyle.buildInputDecoration(
                            labelText: "Comment",
                          ),
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            print(_comments.text);
                            // setState(() {
                            //   _comments.text = value;
                            // });
                          },
                        ),
                        SizedBox(height: 16),

                        _commentsList != null && _commentsList.length != 0
                            ? viewMoreActive
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            reverse: true,
                                            shrinkWrap: true,
                                            itemCount: _commentsList.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        _commentsList[index]
                                                            .creatorName,
                                                        style: TextStyles
                                                            .muliBold25,
                                                      ),
                                                      Text(
                                                        _commentsList[index]
                                                            .commentText,
                                                        style: TextStyle(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.5),
                                                            fontSize: 25),
                                                      ),
                                                      Text(
                                                        _commentsList[index]
                                                            .commentedAt
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.5),
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  )
                                                ],
                                              );
                                            }),
                                      ),
                                    ],
                                  )
                                : Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            _commentsList[
                                                    _commentsList.length - 1]
                                                .creatorName,
                                            style: TextStyles.muliBold25,
                                          ),
                                          Text(
                                            _commentsList[
                                                    _commentsList.length - 1]
                                                .commentText,
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                fontSize: 25),
                                          ),
                                          Text(
                                            _commentsList[
                                                    _commentsList.length - 1]
                                                .commentedAt
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      )
                                    ],
                                  )
                            : Container(),
                        // Padding(
                        //   padding:
                        //       const EdgeInsets.only(top: 10.0, bottom: 10, left: 5),
                        //   child: Text(
                        //     "XYZ Kumar",
                        //     style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 25,
                        //         // color: HexColor("#000000DE"),
                        //         fontFamily: "Muli"),
                        //   ),
                        // ),
                        // Padding(
                        //   padding:
                        //       const EdgeInsets.only(top: 5.0, bottom: 20, left: 5),
                        //   child: Text(
                        //     "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                        //     style: TextStyle(
                        //         //fontWeight: FontWeight.bold,
                        //         fontSize: 20,
                        //         // color: HexColor("#000000DE"),
                        //         fontFamily: "Muli"),
                        //   ),
                        // ),
                        Center(
                          child: FlatButton(
                            // shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(0),
                            //     side: BorderSide(color: Colors.black26)),
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 5, bottom: 8, top: 5),
                              child: !viewMoreActive
                                  ? Text(
                                      "VIEW MORE COMMENT (" +
                                          _commentsList.length.toString() +
                                          ")",
                                      style: TextStyles.muliBoldOrange17,
                                    )
                                  : Text(
                                      "VIEW LESS COMMENT (" +
                                          _commentsList.length.toString() +
                                          ")",
                                      style: TextStyles.muliBoldOrange17,
                                    ),
                            ),
                            onPressed: () async {
                              setState(() {
                                viewMoreActive = !viewMoreActive;
                              });
                            },
                          ),
                        ),

                        SizedBox(height: 35),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  side: BorderSide(color: Colors.black26)),
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 5, bottom: 8, top: 5),
                                child: Text(
                                  "SAVE AND CLOSE",
                                  style: TextStyle(
                                      color: HexColor("#1C99D4"),
                                      fontWeight: FontWeight.bold,
                                      // letterSpacing: 2,
                                      fontSize: 17),
                                ),
                              ),
                              onPressed: () async {
                                // print(_comments.text);
                                if (!_isSaveButtonDisabled) {
                                  _isSaveButtonDisabled = true;
                                  _isSubmitButtonDisabled = false;

                                  if (_contactNumber != null &&
                                      _contactNumber != '' &&
                                      _contactNumber.length == 10) {
                                    print("here");
                                    setState(() {
                                      String empId;
                                      String mobileNumber;
                                      String name;
                                      Future<SharedPreferences> _prefs =
                                          SharedPreferences.getInstance();
                                      _prefs.then(
                                          (SharedPreferences prefs) async {
                                        empId = prefs.getString(
                                                StringConstants.employeeId) ??
                                            "empty";
                                        mobileNumber = prefs.getString(
                                                StringConstants.mobileNumber) ??
                                            "empty";
                                        name = prefs.getString(
                                                StringConstants.employeeName) ??
                                            "empty";

                                        if (_comments.text != null &&
                                            _comments.text != '') {
                                          await _commentsListNew.add(
                                            new CommentsDetail(
                                                createdBy: empId,
                                                commentText: _comments.text,
                                                // commentedAt: DateTime.now(),
                                                creatorName: name),
                                          );
                                        }

                                        if (_listInfluencerDetail.length != 0) {
                                          if (_listInfluencerDetail[
                                                          _listInfluencerDetail
                                                                  .length -
                                                              1]
                                                      .inflName ==
                                                  null ||
                                              _listInfluencerDetail[
                                                          _listInfluencerDetail
                                                                  .length -
                                                              1]
                                                      .inflName ==
                                                  "null" ||
                                              _listInfluencerDetail[
                                                      _listInfluencerDetail
                                                              .length -
                                                          1]
                                                  .inflName
                                                  .text
                                                  .isNullOrBlank) {
                                            print("here1234");
                                            _listInfluencerDetail.removeAt(
                                                _listInfluencerDetail.length -
                                                    1);
                                          }
                                        }

                                        List<InfluencerDetailDraft>
                                            influencerDetailDraft = new List();
                                        for (int i = 0;
                                            i < _listInfluencerDetail.length;
                                            i++) {
                                          influencerDetailDraft.add(new InfluencerDetailDraft(
                                              id: _listInfluencerDetail[i]
                                                  .id
                                                  .text,
                                              inflName: _listInfluencerDetail[i]
                                                  .inflName
                                                  .text,
                                              inflContact: _listInfluencerDetail[i]
                                                  .inflContact
                                                  .text,
                                              inflTypeId:
                                                  _listInfluencerDetail[i]
                                                      .inflTypeId
                                                      .text,
                                              inflTypeValue:
                                                  _listInfluencerDetail[i]
                                                      .inflTypeValue
                                                      .text,
                                              inflCatId: _listInfluencerDetail[i]
                                                  .inflCatId
                                                  .text,
                                              inflCatValue:
                                                  _listInfluencerDetail[i]
                                                      .inflCatValue
                                                      .text,
                                              ilpIntrested:
                                                  _listInfluencerDetail[i]
                                                      .ilpIntrested
                                                      .text,
                                              isExpanded:
                                                  _listInfluencerDetail[i]
                                                      .isExpanded,
                                              isPrimarybool:
                                                  _listInfluencerDetail[i]
                                                      .isPrimarybool,
                                              isPrimary:
                                                  _listInfluencerDetail[i]
                                                      .isPrimary));
                                        }

                                        List<ListLeadImageDraft>
                                            listLeadImageDraft = new List();

                                        for (int i = 0;
                                            i < controller.imageList.length;
                                            i++) {
                                          listLeadImageDraft.add(
                                              new ListLeadImageDraft(
                                                  photoPath: controller
                                                      .imageList[i].path));
                                        }

                                        final DateFormat formatter =
                                            DateFormat("dd-MM-yyyy");

                                        String leadSourceUser;
                                        if (leadSource == "SELF") {
                                          leadSourceUser = empId;
                                        } else if (leadSource == "DEALER") {
                                          leadSourceUser = _dealerId;
                                        } else if (leadSource == "SUB-DEALER") {
                                          leadSourceUser = _subDealerId;
                                        } else if (leadSource ==
                                            "SALES OFFICER") {
                                          leadSourceUser = _salesOfficerId;
                                        } else if (leadSource == "EVENT") {
                                          leadSourceUser = _eventId;
                                        } else if (leadSource == "INFLUENCER") {
                                          leadSourceUser = sourceMobile.text;
                                        } else if (leadSource == "OTHER") {
                                          leadSourceUser = _other.text;
                                        } else if (leadSource == "SPOTTER") {
                                          leadSourceUser = _other.text;
                                        } else if (leadSource == "TECH VAN") {
                                          leadSourceUser = _other.text;
                                        } else {
                                          leadSource = "SELF";
                                          leadSourceUser = empId;
                                        }

                                        SaveLeadRequestDraftModel
                                            saveLeadRequestDraftModel =
                                            new SaveLeadRequestDraftModel(
                                          siteSubTypeId: "2",
                                          contactName: _contactName,
                                          contactNumber: _contactNumber,
                                          geotagType: geoTagType,
                                          leadLatitude: _currentPosition
                                              .latitude
                                              .toString(),
                                          leadLongitude: _currentPosition
                                              .longitude
                                              .toString(),
                                          leadAddress: _siteAddress.text,
                                          leadPincode: _pincode.text,
                                          leadStateName: _state.text,
                                          leadDistrictName: _district.text,
                                          leadTalukName: _taluk.text,
                                          leadSalesPotentialMt:
                                              _totalMT.text ?? "0",
                                          leadBags: _totalBags.text,
                                          leadReraNumber: _rera.text,
                                          isStatus: "false",
                                          // listLeadImage: new List(),
                                          //  influencerList: new List(),
                                          // comments: new List(),
                                          listLeadImage: listLeadImageDraft,
                                          influencerList: influencerDetailDraft,
                                          comments: _commentsListNew,
                                          assignDate:
                                              formatter.format(DateTime.now()),
                                          leadSource: leadSource,
                                          leadSourceUser: leadSourceUser,
                                          leadSourcePlatform: "TSO",
                                          isIhbCommercial: null,
                                        );

//
//                                   SaveLeadRequestModel saveLeadRequestModel1 = json.decode(draftLeadModelforDB.leadModel);

                                        print(
                                            saveLeadRequestDraftModel.toJson());
                                        print(gv.fromLead);
                                        if (!gv.fromLead) {
                                          DraftLeadModelforDB
                                              draftLeadModelforDB =
                                              new DraftLeadModelforDB(
                                                  null,
                                                  json.encode(
                                                      saveLeadRequestDraftModel));
                                          print(draftLeadModelforDB.leadModel);
                                          await db.addLeadInDraft(
                                              draftLeadModelforDB);
                                        } else {
                                          print(json.encode(
                                              saveLeadRequestDraftModel));
                                          DraftLeadModelforDB
                                              draftLeadModelforDB =
                                              new DraftLeadModelforDB(
                                                  gv.draftID,
                                                  json.encode(
                                                      saveLeadRequestDraftModel));

                                          await db.updateLeadInDraft(
                                              draftLeadModelforDB);
                                        }

                                        gv.fromLead = false;
                                        gv.saveLeadRequestModel =
                                            new SaveLeadRequestDraftModel();
                                        Navigator.pushReplacement(
                                            context,
                                            new CupertinoPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        DraftLeadListScreen()));
                                      });

                                      //  _comments.clear();
                                    });
                                  } else {
                                    Get.dialog(CustomDialogs().errorDialog(
                                        "Please fill atleast a contact number"));
                                  }
                                }
                              },
                            ),
                            RaisedButton(
                              color: HexColor("#1C99D4"),
                              child: Text(
                                "SUBMIT",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    // letterSpacing: 2,
                                    fontSize: 17),
                              ),
                              onPressed: () async {
                                //print(_comments.text);
                                if (!_isSubmitButtonDisabled) {
                                  _isSubmitButtonDisabled = true;
                                  _isSaveButtonDisabled = false;
                                  if (_contactNumber != null &&
                                          _contactNumber.length == 10 &&
                                          _contactNumber != '' &&
                                          _currentPosition.latitude != null &&
                                          _currentPosition.latitude != '' &&
                                          _pincode.text != null &&
                                          _pincode.text != ''
                                      //&&
                                      // _listInfluencerDetail.length != 0
                                      ) {
                                    // print(_comments.text);
                                    print("here");
                                    setState(() {
                                      String empId;
                                      String mobileNumber;
                                      String name;
                                      Future<SharedPreferences> _prefs =
                                          SharedPreferences.getInstance();
                                      _prefs.then(
                                          (SharedPreferences prefs) async {
                                        empId = prefs.getString(
                                                StringConstants.employeeId) ??
                                            "empty";
                                        mobileNumber = prefs.getString(
                                                StringConstants.mobileNumber) ??
                                            "empty";
                                        name = prefs.getString(
                                                StringConstants.employeeName) ??
                                            "empty";
                                        //   print("DHAWAM " + _comments.text);
                                        if (_comments.text == "" ||
                                            _comments.text == "null" ||
                                            _comments.text == null) {
                                          _comments.text = "Added New Lead";
                                        }
                                        await _commentsListNew.add(
                                          new CommentsDetail(
                                              createdBy: empId,
                                              commentText: _comments.text,
                                              // commentedAt: DateTime.now(),
                                              creatorName: name),
                                        );
                                        // print("DHAWAM " + _commentsListNew[0].commentText);

                                        if (_listInfluencerDetail.length != 0 &&
                                            (_listInfluencerDetail[
                                                            _listInfluencerDetail
                                                                    .length -
                                                                1]
                                                        .inflName ==
                                                    null ||
                                                _listInfluencerDetail[
                                                            _listInfluencerDetail
                                                                    .length -
                                                                1]
                                                        .inflName ==
                                                    "null" ||
                                                _listInfluencerDetail[
                                                        _listInfluencerDetail
                                                                .length -
                                                            1]
                                                    .inflName
                                                    .text
                                                    .isNullOrBlank)) {
                                          print("here1234");
                                          _listInfluencerDetail.removeAt(
                                              _listInfluencerDetail.length - 1);
                                        }
                                        String leadSourceUser;
                                        if (leadSource == "SELF" ||
                                            leadSource == null) {
                                          leadSource = "SELF";
                                          leadSourceUser = empId;
                                        } else if (leadSource == "DEALER") {
                                          leadSourceUser = _dealerId;
                                        } else if (leadSource == "SUB-DEALER") {
                                          leadSourceUser = _subDealerId;
                                        } else if (leadSource ==
                                            "SALES OFFICER") {
                                          leadSourceUser = _salesOfficerId;
                                        } else if (leadSource == "EVENT") {
                                          leadSourceUser = _eventId;
                                        } else if (leadSource == "INFLUENCER") {
                                          leadSourceUser = sourceMobile.text;
                                        } else if (leadSource == "OTHER") {
                                          leadSourceUser = _other.text;
                                        } else if (leadSource == "SPOTTER") {
                                          leadSourceUser = _other.text;
                                        } else if (leadSource == "TECH VAN") {
                                          leadSourceUser = _other.text;
                                        } else {
                                          leadSource = "SELF";
                                          leadSourceUser = empId;
                                        }
                                        //  print(22112);
                                        // print(_listIC:\Projects\Flutter\tech-sales-flutter\android\app\Users\neosoft\Documents\Development\jks\dalmiadigitaltso.jksnfluencerDetail[1].toJson());
                                        SaveLeadRequestModel
                                            saveLeadRequestModel =
                                            new SaveLeadRequestModel(
                                                eventId: widget.eventId,
                                                siteSubTypeId: "2",
                                                contactName: _contactName,
                                                contactNumber: _contactNumber,
                                                geotagType: geoTagType,
                                                leadLatitude:
                                                    (_currentPosition != null)
                                                        ? _currentPosition
                                                            .latitude
                                                            .toString()
                                                        : "0",
                                                leadLongitude:
                                                    (_currentPosition != null)
                                                        ? _currentPosition
                                                            .longitude
                                                            .toString()
                                                        : "0",
                                                leadAddress: _siteAddress.text,
                                                leadPincode: _pincode.text,
                                                leadStateName: _state.text,
                                                leadDistrictName:
                                                    _district.text,
                                                leadTalukName: _taluk.text,
                                                leadSalesPotentialMt:
                                                    _totalMT.text,
                                                leadReraNumber: _rera.text,
                                                isStatus: "false",
                                                listLeadImage: listLeadImage,
                                                influencerList:
                                                    _listInfluencerDetail,
                                                comments: _commentsListNew,
                                                leadSource: leadSource,
                                                leadSourceUser: leadSourceUser,
                                                leadSourcePlatform: "TSO",
                                                isIhbCommercial: null);

                                        if (!gv.fromLead) {
                                          gv.draftID = 0;
                                        }

                                        internetChecking().then((result) => {
                                              if (result == true)
                                                {
                                                  _addLeadsController
                                                      .getAccessKeyAndSaveLead(
                                                          saveLeadRequestModel,
                                                          controller.imageList,
                                                          context),
                                                  _commentsListNew = new List()
                                                }
                                              else
                                                {
                                                  Get.snackbar(
                                                      "No internet connection.",
                                                      "Make sure that your wifi or mobile data is turned on.",
                                                      colorText: Colors.white,
                                                      backgroundColor:
                                                          Colors.red,
                                                      snackPosition:
                                                          SnackPosition.BOTTOM),
                                                  // fetchSiteList()
                                                }
                                            });
                                      });

                                      //  _comments.clear();
                                    });
                                  } else {
                                    _isSubmitButtonDisabled = false;
                                    Get.dialog(CustomDialogs().errorDialog(
                                        "Please fill the mandotary fields. i.e. Contact Number , Address  . "));
                                  }
                                }
                              },
                            ),
                          ],
                        ),

                        SizedBox(height: 70),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget influencer() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _listInfluencerDetail.length,
        itemBuilder: (BuildContext context, int index) {
          // if (!_listInfluencerDetail[index].isExpanded) {
          //   return Column(
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             "Influencer Details ${(index + 1)} ",
          //             style: TextStyles.mulliBold18,
          //           ),
          //           Switch(
          //             onChanged: (value) {
          //               setState(() {
          //                 if (value) {
          //                   for (int i = 0;
          //                   i < _listInfluencerDetail.length;
          //                   i++) {
          //                     if (i == index) {
          //                       _listInfluencerDetail[i].isPrimarybool = value;
          //                     } else {
          //                       _listInfluencerDetail[i].isPrimarybool = !value;
          //                     }
          //                   }
          //                 } else {
          //                   Get.dialog(CustomDialogs().errorDialog(
          //                       "There should be one Primary Influencer . Please select other influencer to make this influencer secondary"));
          //                 }
          //               });
          //             },
          //             value: _listInfluencerDetail[index].isPrimarybool,
          //             activeColor: HexColor("#009688"),
          //             activeTrackColor: HexColor("#009688").withOpacity(0.5),
          //             inactiveThumbColor: HexColor("#F1F1F1"),
          //             inactiveTrackColor: Colors.black26,
          //           ),
          //           _listInfluencerDetail[index].isExpanded
          //               ? FlatButton.icon(
          //             color: Colors.transparent,
          //             icon: Icon(
          //               Icons.remove,
          //               color: ColorConstants.btnOrange,
          //               size: 18,
          //             ),
          //             label: Text(
          //               "COLLAPSE",
          //               style: TextStyles.muliBoldOrange17,
          //             ),
          //             onPressed: () {
          //               setState(() {
          //                 _listInfluencerDetail[index].isExpanded =
          //                 !_listInfluencerDetail[index].isExpanded;
          //               });
          //             },
          //           )
          //               : FlatButton.icon(
          //             color: Colors.transparent,
          //             icon: Icon(
          //               Icons.add,
          //               color: ColorConstants.btnOrange,
          //               size: 18,
          //             ),
          //             label: Text(
          //               "EXPAND",
          //               style: TextStyles.muliBoldOrange17,
          //             ),
          //             onPressed: () {
          //               setState(() {
          //                 _listInfluencerDetail[index].isExpanded =
          //                 !_listInfluencerDetail[index].isExpanded;
          //               });
          //             },
          //           ),
          //         ],
          //       ),
          //     ],
          //   );
          // } else {
          return Column(
            children: [
              // FittedBox(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              // (index == 0)
              //     ?
              // Text(
              //   "Influencer Details",
              //   style: TextStyle(
              //       fontWeight: FontWeight.bold, fontSize: 18),
              // ),
              //     : Text(
              //   "Influencer Details ${(index + 1)} ",
              //   style: TextStyle(
              //       fontWeight: FontWeight.bold, fontSize: 18),
              // ),
              // _listInfluencerDetail[index].isExpanded
              //     ? FlatButton.icon(
              //   color: Colors.transparent,
              //   icon: Icon(
              //     Icons.remove,
              //     color: ColorConstants.btnOrange,
              //     size: 18,
              //   ),
              //   label: Text(
              //     "COLLAPSE",
              //     style: TextStyles.muliBoldOrange17,
              //   ),
              //   onPressed: () {
              //     setState(() {
              //       _listInfluencerDetail[index].isExpanded =
              //       !_listInfluencerDetail[index].isExpanded;
              //     });
              //   },
              // )
              //     : FlatButton.icon(
              //   color: Colors.transparent,
              //   icon: Icon(
              //     Icons.add,
              //     color: ColorConstants.btnOrange,
              //     size: 18,
              //   ),
              //   label: Text(
              //     "EXPAND",
              //     style: TextStyles.muliBoldOrange17,
              //   ),
              //   onPressed: () {
              //     setState(() {
              //       _listInfluencerDetail[index].isExpanded =
              //       !_listInfluencerDetail[index].isExpanded;
              //     });
              //   },
              // ),
              //    ],
              //  ),
              // ),
              // SizedBox(height: 10),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       "Secondary",
              //       style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 18,
              //           // color: HexColor("#000000DE"),
              //           fontFamily: "Muli"),
              //     ),
              //     Switch(
              //       onChanged: (value) {
              //         setState(() {
              //           if (value) {
              //             for (int i = 0;
              //             i < _listInfluencerDetail.length;
              //             i++) {
              //               if (i == index) {
              //                 _listInfluencerDetail[i].isPrimarybool = value;
              //               } else {
              //                 _listInfluencerDetail[i].isPrimarybool = !value;
              //               }
              //             }
              //           } else {
              //             Get.dialog(CustomDialogs().errorDialog(
              //                 "There should be one Primary Influencer . Please select other influencer to make this influencer secondary"));
              //           }
              //         });
              //       },
              //       value: _listInfluencerDetail[index].isPrimarybool,
              //       activeColor: HexColor("#009688"),
              //       activeTrackColor: HexColor("#009688").withOpacity(0.5),
              //       inactiveThumbColor: HexColor("#F1F1F1"),
              //       inactiveTrackColor: Colors.black26,
              //     ),
              //     Text(
              //       "Primary",
              //       style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 18,
              //           color: _listInfluencerDetail[index].isPrimarybool
              //               ? HexColor("#009688")
              //               : Colors.black,
              //           fontFamily: "Muli"),
              //     ),
              //   ],
              // ),
              TextFormField(
                controller: _listInfluencerDetail[index].inflContact,
                maxLength: 10,
                onChanged: (value) async {
                  bool match = false;
                  if (value.length < 10) {
                    if (_listInfluencerDetail[index].inflName != null) {
                      _listInfluencerDetail[index].inflName.clear();
                      _listInfluencerDetail[index].inflTypeValue.clear();
                      _listInfluencerDetail[index].inflCatValue.clear();
                    }
                  } else if (value.length == 10) {
                    var bodyEncrypted = {
                      //"reference-id": "IqEAFdXco54HTrBkH+sWOw==",
                      "inflContact": value
                    };

                    if (_listInfluencerDetail.length != 0) {
                      for (int i = 0;
                          i < _listInfluencerDetail.length - 1;
                          i++) {
                        if (value ==
                            _listInfluencerDetail[i].inflContact.text) {
                          match = true;
                          break;
                        }
                      }
                    }

                    if (match) {
                      Get.dialog(CustomDialogs()
                          .errorDialog("Already added influencer : " + value));
                    } else {
                      apiCallForGetInf(value, index, context);
                    }
                  }
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Influencer Number ';
                  }
                  if (!Validations.isValidPhoneNumber(value)) {
                    return "Enter valid Contact number";
                  }

                  return null;
                },
                style: FormFieldStyle.formFieldTextStyle,
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: FormFieldStyle.buildInputDecoration(
                  labelText: "Mobile Number",
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _listInfluencerDetail[index].inflName,
                readOnly: true,
                style: FormFieldStyle.formFieldTextStyle,
                keyboardType: TextInputType.text,
                decoration: FormFieldStyle.buildInputDecoration(
                  labelText: "Name",
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _listInfluencerDetail[index].inflTypeValue,
                readOnly: true,
                style: FormFieldStyle.formFieldTextStyle,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z. ]")),
                ],
                decoration: FormFieldStyle.buildInputDecoration(
                  labelText: "Type",
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _listInfluencerDetail[index].inflCatValue,
                readOnly: true,
                style: FormFieldStyle.formFieldTextStyle,
                keyboardType: TextInputType.text,
                decoration: FormFieldStyle.buildInputDecoration(
                  labelText: "Category",
                ),
              ),
            ],
          );
          // }
        });
  }

  apiCallForGetInf(String value, int index, BuildContext context) async {
    String empId;
    String mobileNumber;
    String name;
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      mobileNumber = prefs.getString(StringConstants.mobileNumber) ?? "empty";
      name = prefs.getString(StringConstants.employeeName) ?? "empty";
      print(_comments.text);
    });
    AddLeadsController _addLeadsController = Get.find();
    _addLeadsController.phoneNumber = value;
    AccessKeyModel accessKeyModel = new AccessKeyModel();
    await _addLeadsController.getAccessKeyOnly().then((data) async {
      accessKeyModel = data;
      print("AccessKey :: " + accessKeyModel.accessKey);
      await _addLeadsController
          .getInfNewData(accessKeyModel.accessKey)
          .then((data) {
        InfluencerDetailModel _infDetailModel = data;
        if (_infDetailModel.respCode == "DM1002") {
          InfluencerModel inflDetail = _infDetailModel.influencerModel;

          if (inflDetail.inflName != "null") {
            setState(() {
              _listInfluencerDetail[index].inflContact =
                  new TextEditingController();
              _listInfluencerDetail[index].inflName =
                  new TextEditingController();
              FocusScope.of(context).unfocus();
              //  print(inflDetail.inflName.text);
              _listInfluencerDetail[index].inflTypeId =
                  new TextEditingController();
              _listInfluencerDetail[index].inflCatId =
                  new TextEditingController();
              _listInfluencerDetail[index].inflTypeValue =
                  new TextEditingController();
              _listInfluencerDetail[index].inflCatValue =
                  new TextEditingController();
              _listInfluencerDetail[index].id = new TextEditingController();
              _listInfluencerDetail[index].ilpIntrested =
                  new TextEditingController();

              print(inflDetail.inflName);
              print("inflTypeValue : ${inflDetail.influencerTypeText}");

              _listInfluencerDetail[index].inflContact.text =
                  inflDetail.inflContact;
              _listInfluencerDetail[index].inflName.text = inflDetail.inflName;
              _listInfluencerDetail[index].inflTypeValue.text =
                  inflDetail.influencerTypeText;
              _listInfluencerDetail[index].id.text =
                  inflDetail.inflId.toString();
              _listInfluencerDetail[index].ilpIntrested.text =
                  inflDetail.ilpRegFlag;
              // _listInfluencerDetail[
              //             index]
              //         .createdOn =
              //     inflDetail.createdOn;

              _listInfluencerDetail[index].inflCatValue.text =
                  inflDetail.influencerCategoryText;
              _listInfluencerDetail[index].createdBy = empId;
              print(_listInfluencerDetail[index].inflName);

              //print("influencerTypeEntity : ${json.encode(influencerTypeEntity)}");
              for (int i = 0; i < influencerTypeEntity.length; i++) {
                // print("influencerTypeEntity[i].inflTypeId : ${influencerTypeEntity[i].inflTypeId}");
                // print("inflDetail.inflTypeId : ${inflDetail.inflTypeId}");
                if (influencerTypeEntity[i].inflTypeId.toString() ==
                    inflDetail.inflTypeId.toString()) {
                  _listInfluencerDetail[index].inflTypeId.text =
                      inflDetail.inflTypeId.toString();
                  _listInfluencerDetail[index].inflTypeValue.text =
                      inflDetail.influencerTypeText.toString();
                  break;
                } else {
                  _listInfluencerDetail[index].inflTypeId.clear();
                  _listInfluencerDetail[index].inflTypeValue.clear();
                }
              }
              // print(_listInfluencerDetail[index].inflName);
              // _influencerType.text = influencerTypeEntity[inflDetail.inflTypeId].inflTypeDesc;

              for (int i = 0; i < influencerCategoryEntity.length; i++) {
                if (influencerCategoryEntity[i].inflCatId.toString() ==
                    inflDetail.inflCatId.toString()) {
                  _listInfluencerDetail[index].inflCatId.text =
                      inflDetail.inflCatId.toString();
                  //   print(influencerTypeEntity[influencerTypeEntity[i].inflTypeId].inflTypeDesc);
                  _listInfluencerDetail[index].inflCatValue.text =
                      influencerCategoryEntity[
                              influencerCategoryEntity[i].inflCatId - 1]
                          .inflCatDesc;
                  break;
                } else {
                  _listInfluencerDetail[index].inflCatId.clear();
                  _listInfluencerDetail[index].inflCatValue.clear();
                }
              }
            });
          } else {
            if (_listInfluencerDetail[index].inflContact != null) {
              setState(() {
                _listInfluencerDetail[index].inflContact.clear();
                _listInfluencerDetail[index].inflName.clear();
              });
            }
            return Get.dialog(CustomDialogs()
                .showDialog("No influencer registered with this number"));
          }
        } else {
          if (_listInfluencerDetail[index].inflContact != null) {
            _listInfluencerDetail[index].inflContact.clear();
            _listInfluencerDetail[index].inflName.clear();
          }
          return Get.dialog(
              CustomDialogs().showDialog(_infDetailModel.respMsg));
        }
        Get.back();
      });
    });
  }

  // _imgFromCamera() async {
  //   File image = await ImagePicker.pickImage(
  //       source: ImageSource.camera, imageQuality: 50);
  //
  //   setState(() {
  //     //print(image.path);
  //     if (image != null) {
  //       // print(basename(image.path));
  //
  //       listLeadImage.add(new ListLeadImage(photoName: basename(image.path)));
  //       _imageList.add(image);
  //     }
  //   });
  // }
  //
  // _imgFromGallery() async {
  //   File image = await ImagePicker.pickImage(
  //       source: ImageSource.gallery, imageQuality: 50);
  //
  //   setState(() {
  //     // print(image.path);
  //     if (image != null) {
  //       listLeadImage.add(new ListLeadImage(photoName: basename(image.path)));
  //       _imageList.add(image);
  //     }
  //     // _imageList.insert(0,image);
  //   });
  // }
  //
  // void _showPicker(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return SafeArea(
  //           child: Container(
  //             child: new Wrap(
  //               children: <Widget>[
  //                 new ListTile(
  //                     leading: new Icon(Icons.photo_library),
  //                     title: new Text('Photo Library'),
  //                     onTap: () {
  //                       _imgFromGallery();
  //                       Navigator.of(context).pop();
  //                     }),
  //                 new ListTile(
  //                   leading: new Icon(Icons.photo_camera),
  //                   title: new Text('Camera'),
  //                   onTap: () {
  //                     _imgFromCamera();
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  _getAddressFromLatLng() async {
    try {
      print(
          "from lat long ${await geolocator.placemarkFromCoordinates(_currentPosition.latitude, _currentPosition.longitude)}");
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];
      setState(() {
        _siteAddress.text =
            place.name + "," + place.thoroughfare + "," + place.subLocality;
        _district.text = place.subAdministrativeArea;
        _state.text = place.administrativeArea;
        _pincode.text = place.postalCode;
        _taluk.text = place.locality;
        //txt.text = place.postalCode;
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
        print(
            "........ selected ${place.name}, ${place.isoCountryCode}, ${place.country},${place.postalCode}, "
            "${place.administrativeArea}, ${place.subAdministrativeArea},${place.locality}, ${place.subLocality}, "
            "${place.thoroughfare}, ${place.subThoroughfare}, ${place.position}");
      });
    } catch (e) {
      print("ex.....   $e");
    }
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
              title: Text(item.expandedValue),
              subtitle: Text('To delete this panel, tap the trash can icon'),
              trailing: Icon(Icons.delete),
              onTap: () {
                setState(() {
                  _data.removeWhere((currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  void toggleSwitchforPrimary(bool value) {
    setState(() {
      isSwitchedPrimary = value;
    });
  }
}

class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Influencer Details ',
      expandedValue: 'This is item number $index',
    );
  });
}
