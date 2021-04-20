import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/event_type_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/addEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/location/address_search.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/location/suggestion.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class FormAddEvent extends StatefulWidget {
  @override
  _FormAddEventState createState() => _FormAddEventState();
}

class _FormAddEventState extends State<FormAddEvent> {
  AddEventModel addEventModel;
  EventTypeController eventController = Get.find();
  List<String> suggestions = [];
  final _addEventFormKey = GlobalKey<FormState>();

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  LocationResult _pickedLocation;
  Position _currentPosition = new Position();
  var _fromDate = 'Select Date';
  TimeOfDay _time;
  String geoTagType;
  int dealerId;

  ///textfield controllers
  TextEditingController _totalParticipantsController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _dalmiaInflController = TextEditingController();
  TextEditingController _nonDalmiaInflController = TextEditingController();
  TextEditingController _venueController = TextEditingController();

  ///DropDown Values
  int _eventTypeId;
  String _selectedValue;

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
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);

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
          child: RaisedButton(
            color: Colors.white,
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(child: Text(_fromDate)),
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
          child: RaisedButton(
            color: Colors.white,
            elevation: 0,
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
      onChanged: (data){
        int total = (int.parse('$_dalmiaInflController')) + (int.parse('$_nonDalmiaInflController'));
        _totalParticipantsController.text = total.toString();
      },
      controller: _dalmiaInflController,
      style: TextStyles.formfieldLabelText,
      keyboardType: TextInputType.number,
      decoration:
          FormFieldStyle.buildInputDecoration(labelText: "Dalmia influencers"),
    );

    final nondalmia = TextFormField(
      controller: _nonDalmiaInflController,
      onChanged: (data) {
        setState(() {
          int total = (int.parse('$_dalmiaInflController')) + (int.parse('$_nonDalmiaInflController'));
          _totalParticipantsController.text = total.toString();
        });
      },
      style: TextStyles.formfieldLabelText,
      keyboardType: TextInputType.number,
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
          _selectedValue = value;
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
      maxLines: null,
      style: TextStyles.formfieldLabelText,
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(
          labelText: "Venue address (if booked)"),
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
      style: TextStyles.formfieldLabelText,
      keyboardType: TextInputType.number,
      decoration:
          FormFieldStyle.buildInputDecoration(labelText: "Expected Leads"),
    );

    final giftDistribution = TextFormField(
      style: TextStyles.formfieldLabelText,
      keyboardType: TextInputType.number,
      decoration: FormFieldStyle.buildInputDecoration(
          labelText: "Gift distribution (proposed)"),
    );

    final comment = TextFormField(
      maxLines: null,
      style: TextStyles.formfieldLabelText,
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(labelText: "Comments"),
    );

    final btns = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
              side: BorderSide(color: Colors.black26)),
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(right: 5, bottom: 8, top: 5),
            child: Text(
              "SAVE AS DRAFT",
              style: TextStyles.btnBlue,
            ),
          ),
          onPressed: () {},
        ),
        RaisedButton(
          color: ColorConstants.btnBlue,
          child: Text(
            "SUBMIT",
            style:
                //TextStyles.btnWhite,
                TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    // letterSpacing: 2,
                    fontSize: ScreenUtil().setSp(15)),
          ),
          onPressed: () {},
        ),
      ],
    );

    final contact = Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16, top: 16),
      child: TextFormField(


        style:TextStyles.formfieldLabelText,
        keyboardType: TextInputType.number,
        decoration: FormFieldStyle.buildInputDecoration(
            labelText: "Contact No."),

      ),
    );

    final location = TextFormField(
      validator: (value){},
      controller: _locationController,
      maxLines: null,
      onTap: () async {
        final sessionToken = Uuid().v4();
        final Suggestion result = await showSearch(
          context: context,
          delegate: AddressSearch(sessionToken),
        );
        if (result != null) {
          setState(() {
            _locationController.text = result.description;
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
      body: Stack(
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
                                  side: BorderSide(color: HexColor("#39B54A"))),
                              backgroundColor:
                                  HexColor("#39B54A").withOpacity(0.1),
                              label: Text('Status: Not Submitted'),
                            ),
                          ],
                        ),
                        // decoration: BoxDecoration(
                        //     border: Border(bottom: BorderSide(width: 0.3))),
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
    );
  }

  Future _selectFromDate() async {
    DateTime _picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: DateTime(
          new DateTime.now().year,
        ),
        lastDate: new DateTime(2025));
    setState(() {
      _fromDate = new DateFormat('yyyy-MM-dd').format(_picked);
    });
  }

  Future _startTime() async {
    _time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 10, minute: 47),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
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

            // CheckboxListTile(
            //   title: Text("9939 - 0077059321"),
            //   value: false,
            //   onChanged: (newValue) {},
            //   controlAffinity:
            //       ListTileControlAffinity.leading, //  <-- leading Checkbox
            // ),
            // SizedBox(
            //   height: 20,
            // ),

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



  getBottomSheetForDealer() {
    Get.bottomSheet(
      addDealerBottomSheetWidget(),
      isScrollControlled: true,
    ).then((value) => setState(() {}));
  }
}
