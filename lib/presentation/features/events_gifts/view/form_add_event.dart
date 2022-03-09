import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/event_type_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/save_event_form_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/addEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/saveEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/location/address_search.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/location/suggestion.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/global.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class FormAddEvent extends StatefulWidget {
  @override
  _FormAddEventState createState() => _FormAddEventState();
}

class _FormAddEventState extends State<FormAddEvent> {
  AddEventModel addEventModel;
  EventTypeController eventController = Get.find();
  SaveEventController saveEventController = Get.find();
  List<String> suggestions = [];
  final _addEventFormKey = GlobalKey<FormState>();
  var _date = 'Select Date';
  TimeOfDay _time;
  String geoTagType, timeString, dateString;
  int dealerId;

  ///textfield controllers
  TextEditingController _totalParticipantsController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _dalmiaInflController = TextEditingController();
  TextEditingController _nonDalmiaInflController = TextEditingController();
  TextEditingController _venueAddController = TextEditingController();
  TextEditingController _expectedLeadsController = TextEditingController();
  TextEditingController _giftsDistributionController = TextEditingController();
  TextEditingController _commentController = TextEditingController();

  ///DropDown Values
  int _eventTypeId;
  String _selectedVenue;
  double locatinLat;
  double locationLong;

  @override
  void initState() {
    getDropdownData();
    getEmpId();
    super.initState();
  }

  Future getEmpId() async {
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      empID = prefs.getString(StringConstants.employeeId);
    });
    return empID;
  }

  getDropdownData() async {
    await eventController.getEventType().then((data) {
      setState(() {
        if (data != null) {
          addEventModel = data;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    eventController.dispose();
    saveEventController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);

    final eventDropDwn = DropdownButtonFormField(
      onChanged: (value) {
        setState(() {
          _eventTypeId = value;
        });
      },
      items: addEventModel == null
          ? []
          : addEventModel.eventTypeModels
              .map((e) => DropdownMenuItem(
                    value: e.eventTypeId,
                    child: Text(e.eventTypeText),
                  ))
              .toList(),
      style: FormFieldStyle.formFieldTextStyle,
      decoration: FormFieldStyle.buildInputDecoration(labelText: "Event Type"),
      validator: (value) =>
          value == null ? 'Please select the event type' : null,
    );

    final date = Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black26),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(child: Text(_date)),
                Icon(
                  Icons.calendar_today,
                  color: ColorConstants.clearAllTextColor,
                ),
              ],
            ),
            onPressed: () {
              _selectFromDate();
            },
          ),
        ));

    final time = Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black26),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: Text((_time != null
                        ? '${_time.hour}:${_time.minute}'
                        : 'Select time'))),
                Icon(
                  Icons.calendar_today,
                  color: ColorConstants.clearAllTextColor,
                ),
              ],
            ),
            onPressed: () {
              _startTime();
            },
          ),
        ));

    final dalmiaInfluencer = TextFormField(
      onChanged: (data) {
        if (data.length > 0) {
          setState(() {
            _totalParticipantsController.text = _dalmiaInflController.text;
            calculateTotal(
                _dalmiaInflController.text, _nonDalmiaInflController.text);
          });
        } else {
          _totalParticipantsController.text = _nonDalmiaInflController.text;
        }
      },
      controller: _dalmiaInflController,
      style: TextStyles.formfieldLabelText,
      keyboardType: TextInputType.numberWithOptions(signed: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
        TextInputFormatter.withFunction((oldValue, newValue) {
          try {
            final text = newValue.text;
            if (text.isNotEmpty) double.parse(text);
            return newValue;
          } catch (e) {}
          return oldValue;
        }),
      ],
      decoration:
          FormFieldStyle.buildInputDecoration(labelText: "Dalmia influencers"),
    );

    final nondalmia = TextFormField(
      controller: _nonDalmiaInflController,
      onChanged: (data) {
        if (data.length > 0) {
          setState(() {
            _totalParticipantsController.text = _nonDalmiaInflController.text;
            calculateTotal(
                _dalmiaInflController.text, _nonDalmiaInflController.text);
          });
        } else {
          _totalParticipantsController.text = _dalmiaInflController.text;
        }
      },
      style: TextStyles.formfieldLabelText,
      keyboardType: TextInputType.numberWithOptions(signed: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
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
          labelText: "Non-Dalmia influencers"),
    );

    final total = TextFormField(
      controller: _totalParticipantsController,
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.number,
      readOnly: true,
      decoration:
          FormFieldStyle.buildInputDecoration(labelText: "Total participants"),
    );

    final venueDropDwn = DropdownButtonFormField(
      onChanged: (value) {
        setState(() {
          _selectedVenue = value;
        });
      },
      items: ['Booked', 'Not Booked']
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
          .toList(),
      style: FormFieldStyle.formFieldTextStyle,
      decoration: FormFieldStyle.buildInputDecoration(labelText: "Venue"),
      validator: (value) => value == null ? 'Please select the venue' : null,
    );

    final venueAddress = TextFormField(
      controller: _venueAddController,
      validator: (value) {
        if (value.isEmpty && _selectedVenue == 'Booked') {
          return "Venue address can't be empty if Booked";
        }
        return null;
      },
      maxLines: null,
      style: TextStyles.formfieldLabelText,
      keyboardType: TextInputType.text,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]")),
      ],
      decoration: FormFieldStyle.buildInputDecoration(
          labelText: "Venue address (if booked)"),
    );

    final dealer = GestureDetector(
      onTap: () => getBottomSheetForDealer(),
      child: FormField(
        builder: (state) {
          return InputDecorator(
            decoration: FormFieldStyle.buildInputDecoration(
              labelText: 'Add Counter(s)',
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
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Chip(
                            label: Text(
                              e.dealerName,
                              style: TextStyle(fontSize: 10),
                            ),
                            backgroundColor: Colors.lightGreen.withOpacity(0.2),
                          ),
                        ))
                    .toList(),
              ),
            ),
          );
        },
      ),
    );

    final expectedLeads = TextFormField(
      controller: _expectedLeadsController,
      style: TextStyles.formfieldLabelText,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      keyboardType: TextInputType.numberWithOptions(signed: true),
      decoration:
          FormFieldStyle.buildInputDecoration(labelText: "Expected Leads"),
    );

    final giftDistribution = TextFormField(
      controller: _giftsDistributionController,
      style: TextStyles.formfieldLabelText,
      keyboardType: TextInputType.numberWithOptions(signed: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: FormFieldStyle.buildInputDecoration(
          labelText: "Gift distribution (proposed)"),
    );

    final comment = TextFormField(
      controller: _commentController,
      maxLines: null,
      style: TextStyles.formfieldLabelText,
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(labelText: "Comments"),
    );

    final btns = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
                side: BorderSide(color: Colors.black26)),
            backgroundColor: Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 5, bottom: 8, top: 5),
            child: Text(
              "SAVE AS DRAFT",
              style: TextStyles.btnBlue,
            ),
          ),
          onPressed: () {
            btnPresssed(7);
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: ColorConstants.btnBlue,
          ),
          child: Text(
            "SUBMIT",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15.sp),
          ),
          onPressed: () {
            btnPresssed(1);
          },
        ),
      ],
    );

    final location = TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return "Select location";
        }
        return null;
      },
      controller: _locationController,
      maxLines: null,
      onTap: () async {
        final sessionToken = Uuid().v4();
        final Suggestion result = await showSearch(
          context: context,
          delegate: AddressSearch(sessionToken),
        );

        if (result != null) {
          final placeDetails =
              await PlaceApiProvider(sessionToken).getLatLong(result.placeId);
          setState(() {
            _locationController.text = result.description;
            locatinLat = placeDetails.lat;
            locationLong = placeDetails.lng;
          });
        }
      },
      readOnly: true,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Event Location",
        suffixIcon: Icon(
          Icons.location_pin,
          color: ColorConstants.clearAllTextColor,
        ),
      ),
    );

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BackFloatingButton(),
      bottomNavigationBar: BottomNavigator(),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: addEventModel != null
                  ? ListView(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          height: 56,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Add Event',
                                style: TextStyles.titleGreenStyle,
                              ),
                              Chip(
                                shape: StadiumBorder(
                                    side:
                                        BorderSide(color: HexColor("#39B54A"))),
                                backgroundColor:
                                    HexColor("#39B54A").withOpacity(0.1),
                                label: Text('Status: Not Submitted'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Form(
                              key: _addEventFormKey,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    eventDropDwn,
                                    SizedBox(height: 16),
                                    date,
                                    SizedBox(height: 16),
                                    time,
                                    SizedBox(height: 16),
                                    Text(
                                      "Tentative Members",
                                      style: TextStyles.welcomeMsgTextStyle20,
                                    ),
                                    SizedBox(height: 16),
                                    dalmiaInfluencer,
                                    SizedBox(height: 16),
                                    nondalmia,
                                    SizedBox(height: 16),
                                    total,
                                    SizedBox(height: 16),
                                    venueDropDwn,
                                    SizedBox(height: 16),
                                    venueAddress,
                                    SizedBox(height: 16),
                                    dealer,
                                    SizedBox(height: 16),
                                    expectedLeads,
                                    SizedBox(height: 16),
                                    giftDistribution,
                                    SizedBox(height: 16),
                                    location,
                                    SizedBox(height: 16),
                                    comment,
                                    SizedBox(height: 16),
                                    btns,
                                    SizedBox(height: 16),
                                  ]),
                            )),
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future _selectFromDate() async {
    DateTime _picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now(),
        lastDate: new DateTime(2025));
    setState(() {
      _date = new DateFormat('dd-MM-yyyy').format(_picked);
      var d = DateFormat('dd-MM-yyyy HH:mm:ss').format(_picked);
      dateString = '$d';
    });
  }

  Future _startTime() async {
    (_time == null)
        ? _time = await showTimePicker(
            context: context,
            initialTime: (TimeOfDay(hour: 10, minute: 47)),
            builder: (BuildContext context, Widget child) {
              return MediaQuery(
                data: MediaQuery.of(context),
                child: child,
              );
            },
          )
        : _time = await showTimePicker(
            context: context,
            initialTime: (TimeOfDay(hour: _time.hour, minute: _time.minute)),
            builder: (BuildContext context, Widget child) {
              return MediaQuery(
                data: MediaQuery.of(context),
                child: child,
              );
            },
          );
    setState(() {
      timeString = ('$_date ${_time.hour}:${_time.minute}:00');
    });
  }

  List<bool> checkedValues;
  List<String> selectedDealer = [];
  List<DealersModels> selectedDealersModels = [];

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
                    'Counter(s) List',
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
                },
                separatorBuilder: (context, index) {
                  return dealerId.toString() == dealers[index].dealerId
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

  String total = '0';
  calculateTotal(String dalmia, String nonDalmia) {
    total = '';
    int dal = int.parse(dalmia);
    int non = int.parse(nonDalmia);

    int tot = dal + non;

    total = tot.toString();
    setState(() {
      _totalParticipantsController.text = total;
    });
  }

  getBottomSheetForDealer() {
    Get.bottomSheet(
      addDealerBottomSheetWidget(),
      isScrollControlled: true,
    ).then((value) => setState(() {}));
  }

  btnPresssed(int eventStatusId) async {
    if (_addEventFormKey.currentState.validate()) {
      _addEventFormKey.currentState.save();

      if (_date == null || _date == 'Select Date') {
        Get.snackbar("", "Select Date",
            colorText: Colors.black,
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      } else if (timeString == null) {
        Get.snackbar("", "Select Time",
            colorText: Colors.black,
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      } else {
        String empId = await getEmpId();

        timeString = ('$_date ${_time.hour}:${_time.minute}:00');

        List dealersList = List.empty(growable: true);
        selectedDealersModels.forEach((e) {
          setState(() {
            dealersList.add({
              'eventDealerId': null,
              'eventId': null,
              'dealerId': e.dealerId,
              'dealerName': e.dealerName,
              'eventStage': 'PLAN',
              'isActive': 'Y',
              'createdBy': empId,
            });
          });
        });

        if (dealersList == null ||
            dealersList == [] ||
            dealersList.length == 0) {
          Get.snackbar("", "Select Counter",
              colorText: Colors.black,
              backgroundColor: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
        } else {
          MwpeventFormRequest _mwpeventFormRequest =
              MwpeventFormRequest.fromJson({
            'dalmiaInflCount':
                int.tryParse('${_dalmiaInflController.text}') ?? 0,
            'eventComment': _commentController.text,
            'eventDate': dateString,
            'eventId': null,
            'eventLocation': _locationController.text,
            'eventLocationLat': locatinLat,
            'eventLocationLong': locationLong,
            'eventStatusId': eventStatusId,
            'eventTime': timeString,
            'eventTypeId': _eventTypeId,
            'expectedLeadsCount':
                int.tryParse('${_expectedLeadsController.text}') ?? 0,
            'giftDistributionCount':
                int.tryParse('${_giftsDistributionController.text}') ?? 0,
            'nondalmiaInflCount':
                int.tryParse('${_nonDalmiaInflController.text}') ?? 0,
            'referenceId': empId,
            'venue': _selectedVenue,
            'venueAddress': _venueAddController.text,
          });

          SaveEventFormModel _save = SaveEventFormModel.fromJson(
              {'eventDealersModelList': dealersList});
          SaveEventFormModel _saveEventFormModel = SaveEventFormModel(
              mwpeventFormRequest: _mwpeventFormRequest,
              eventDealersModelList: _save.eventDealersModelList);

          internetChecking().then((result) => {
                if (result == true)
                  {
                    saveEventController
                        .getAccessKeyAndSaveRequest(_saveEventFormModel)
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
    }
  }
}

