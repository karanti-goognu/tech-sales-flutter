import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/bindings/event_binding.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/all_events_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/detail_view_event.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/detail_view_pending.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/end_event.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:get/get.dart';

class EventSearch extends StatefulWidget {
  @override
  _EventSearchState createState() => _EventSearchState();
}

class _EventSearchState extends State<EventSearch> {
  TextEditingController controller = new TextEditingController();
  AllEventController _eventController = Get.find();

  HexColor _color(int id){
    switch(id){
      case 1:return HexColor('#F9A61A');
      case 2:return HexColor('#39B54A');
      case 3:return HexColor('#B00020');
      case 4:return HexColor('#39B54A');
      case 5:return HexColor('#B00020');
      case 6:return HexColor('#000000');
      case 7:return HexColor('#808080');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new SafeArea(
          child: Column(
            children: <Widget>[
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
              new Expanded(child: eventsDetailWidget()),
            ],
          ),
        ));
  }
Widget eventsDetailWidget(){
    return Obx(()=>
     _eventController.dataForSearchResult.eventListModels==null?Container():
     ListView.builder(
       padding:  const EdgeInsets.only(
           left: 6.0, right: 6, bottom: 8),
         itemCount: _eventController.dataForSearchResult.eventListModels.length,
         itemBuilder: (context, index){
           return GestureDetector(
             onTap: (){
              if(_eventController.dataForSearchResult.eventListModels[index].eventStatusText == StringConstants.approved
               && _eventController.dataForSearchResult.eventListModels[index].eventStatusText == StringConstants.cancelled){
                Get.to(() => DetailViewEvent(_eventController.dataForSearchResult.eventListModels[index].eventId),
                    binding: EGBinding());

              }else if(_eventController.dataForSearchResult.eventListModels[index].eventStatusText == StringConstants.completed ){
                Get.to(() => EndEvent(_eventController.dataForSearchResult.eventListModels[index].eventId,2));
              }else if(_eventController.dataForSearchResult.eventListModels[index].eventStatusText == StringConstants.pendingApproval){
                Get.to(() => DetailPending(_eventController.dataForSearchResult.eventListModels[index].eventId, ColorConstants.eventPending),
                    binding: EGBinding());
              }
              else if( _eventController.dataForSearchResult.eventListModels[index].eventStatusText == StringConstants.rejected){
                Get.to(() => DetailPending(_eventController.dataForSearchResult.eventListModels[index].eventId, ColorConstants.eventRejected),
                    binding: EGBinding());
              }
              else if( _eventController.dataForSearchResult.eventListModels[index].eventStatusText == StringConstants.notSubmitted){
                Get.to(() => DetailPending(_eventController.dataForSearchResult.eventListModels[index].eventId, ColorConstants.eventNotSubmited),
                    binding: EGBinding());
              }else{}

             },
             child: Card(
               clipBehavior: Clip.antiAlias,
               borderOnForeground: true,
               elevation: 6,
               margin: EdgeInsets.all(4.0),
               color: Colors.white,
               child: Container(
                 decoration: BoxDecoration(
                   border: Border(
                       left: BorderSide(
                         color: _color(_eventController.dataForSearchResult.eventListModels[index].eventStatusId),
                         width: 6,
                       )),
                 ),
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Column(
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(
                             "${_eventController.dataForSearchResult.eventListModels[index].eventDate}",
                             style: TextStyle(
                                 fontSize: 15,
                                 fontFamily: "Muli",
                                 fontWeight: FontWeight.normal),
                           ),
                           Chip(
                             shape: StadiumBorder(
                                 side: BorderSide(color: _color(_eventController.dataForSearchResult.eventListModels[index].eventStatusId))),
                             backgroundColor: _color(_eventController.dataForSearchResult.eventListModels[index].eventStatusId).withOpacity(0.2),
                             label: Text(
                                 'Status: ${_eventController.dataForSearchResult.eventListModels[index].eventStatusText}'),
                           ),
                         ],
                       ),
                       Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                            Text(
                               "${_eventController.dataForSearchResult.eventListModels[index].eventTypeText}",
                               style: TextStyle(
                                   fontSize: 15,
                                   fontFamily: "Muli",
                                   fontWeight: FontWeight.bold),
                             ),
                             Text(
                               "Inf. Planned : ${_eventController.dataForSearchResult.eventListModels[index].actualEventInflCount}",
                               style: TextStyle(
                                   fontSize: 15,
                                   fontFamily: "Muli",
                                   fontWeight: FontWeight.normal),
                               // ),
                             ),
                           ]),
                       Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                       Flexible(
                               flex: 2,
                               child: Text(
                                 "Venue: ${_eventController.dataForSearchResult.eventListModels[index].eventVenue}",
                                 overflow: TextOverflow.ellipsis,
                                 style: TextStyle(
                                     fontSize: 15,
                                     fontFamily: "Muli",
                                     fontWeight: FontWeight.normal),
                               ),
                             ),
                             Flexible(
                               flex: 3,
                               child: Text(
                                 "Dealer(s) : ${_eventController.dataForSearchResult.eventListModels[index].dealerName}",
                                 overflow: TextOverflow.ellipsis,
                                 style: TextStyle(
                                     fontSize: 15,
                                     fontFamily: "Muli",
                                     fontWeight: FontWeight.normal),
                                 // ),
                               ),
                             ),
                           ]),
                       Padding(
                         padding:
                         const EdgeInsets.only(top: 8.0, bottom: 8.0),
                         child: Divider(
                           height: 1,
                           color: Colors.grey,
                         ),
                       ),
                       Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text(
                               "EVENT ID: ${_eventController.dataForSearchResult.eventListModels[index].eventId}",
                               style: TextStyle(
                                   fontSize: 15,
                                   fontFamily: "Muli",
                                   fontWeight: FontWeight.normal),
                             ),
                             Text(
                               "LEADS EXPECTED : ${_eventController.dataForSearchResult.eventListModels[index].expectedLeadsCount}",
                               style: TextStyle(
                                   fontSize: 15,
                                   fontFamily: "Muli",
                                   fontWeight: FontWeight.normal),
                               // ),
                             ),
                           ]),
                     ],
                   ),
                 ),
               ),
             ),
           );
         }));
}

  onSearchTextChanged(String text) async {
    AllEventController _eventController = Get.find();
    if (controller.text.length >= 2) {
      _eventController.eventSearch(text);
    }
  }
}














