import 'dart:core';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moengage_inbox/inbox_data.dart';
import 'package:moengage_inbox/inbox_message.dart';
import 'package:moengage_inbox/moengage_inbox.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';


class NotificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late MoEngageInbox _moEngageInbox;
  Future<InboxData>? inboxData;
  int unReadMessageCount = 0;

  Future<int> unReadMessageCoun() async {
    int unReadMessageCount = await _moEngageInbox.getUnClickedCount();
    return unReadMessageCount;
  }

  String dateTime (String dateTimeString){
    final DateFormat formatter = DateFormat("yyyy-MM-dd HH:mm:ss aa");
    DateTime dateTime = DateTime.parse(dateTimeString);
    final String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  @override
  void initState() {
    _moEngageInbox = MoEngageInbox();
    WidgetsBinding.instance.addPostFrameCallback((_) => {
      unReadMessageCoun().then((value) => {
        setState(() {
          unReadMessageCount = value;
        }),
      })
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.appBarColor,
        toolbarHeight: 70,
        centerTitle: false,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Notification".toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: "Muli"),
                ),
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 5.0, right: 5),
                      child: InkResponse(
                        onTap: () {},
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            border:
                            Border.all(color: Colors.black, width: 0.0),
                            borderRadius:
                            new BorderRadius.all(Radius.circular(70)),
                          ),
                          child: Icon(
                            Icons.notifications_none_outlined,
                            color: HexColor("#FFCD00"),
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 10,
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: new BoxDecoration(
                          color: Colors.redAccent,
                          border:
                          Border.all(color: Colors.redAccent, width: 0.0),
                          borderRadius:
                          new BorderRadius.all(Radius.circular(70)),
                        ),
                        child: Text(
                          (unReadMessageCount >= 0
                              ? unReadMessageCount.toString()
                              : ""),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BackFloatingButton(),
      bottomNavigationBar: BottomNavigator(),
      body: Container(
        child: notificationWidget(),
      ),
    );
  }

  Widget notificationWidget() {
    return FutureBuilder<InboxData?>(
      future: _moEngageInbox.fetchAllMessages(),
      builder: (BuildContext context, AsyncSnapshot<InboxData?> snapshot) {
        if (snapshot.hasData) {
          if(snapshot.data!.messages.length > 0){
          return ListView.builder(
              itemCount: snapshot.data!.messages.length,
              padding: const EdgeInsets.only(left: 6.0, right: 6.0, bottom: 10,top: 8),
              itemBuilder: (context, index) {
                InboxMessage inboxMessage = snapshot.data!.messages[index];
                return GestureDetector(
                  onTap: () {
                    _moEngageInbox.trackMessageClicked(inboxMessage);
                    unReadMessageCoun().then((value) => {
                      setState(() {
                        unReadMessageCount = value;
                      }),
                    });
                  },
                  child:Card(
                    clipBehavior: Clip.antiAlias,
                    borderOnForeground: true,
                    elevation: 6,
                    margin: EdgeInsets.all(5.0),
                    color: (inboxMessage.isClicked == true)
                        ? Colors.white
                        : Colors.grey[200],
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0,top: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    "${inboxMessage.textContent.title}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.bold
                                    ),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 2.0,  bottom: 2.0, right: 2.0),
                                  child: Text(
                                    "${inboxMessage.textContent.message}",
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 13,
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.bold
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 2.0, top: 2.0, bottom: 10.0,right: 10),
                            child: Text(

                              "${dateTime(inboxMessage.receivedTime)}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 11,
                                  fontFamily: "Muli",
                                  fontWeight: FontWeight.bold
                              ),
                            )),)
                      ],
                    ),
                  ) ,
                );
              });
          }else{
            return Center(child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 5.0, right: 5),
                      child: InkResponse(
                        onTap: () {},
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: new BoxDecoration(
                            color: Colors.indigo,
                            border:
                            Border.all(color: Colors.indigo, width: 0.0),
                            borderRadius:
                            new BorderRadius.all(Radius.circular(70)),
                          ),
                          child: Icon(
                            Icons.notifications,
                            color: HexColor("#FFCD00"),
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 10,
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: new BoxDecoration(
                          color: Colors.redAccent,
                          border:
                          Border.all(color: Colors.redAccent, width: 0.0),
                          borderRadius:
                          new BorderRadius.all(Radius.circular(70)),
                        ),
                        child: Text(
                          (unReadMessageCount >= 0
                              ? unReadMessageCount.toString()
                              : ""),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  "No New Notification",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: "Muli"),
                ),
              ],
            ),);
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
