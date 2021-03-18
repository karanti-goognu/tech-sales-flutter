import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/notification/model/inbox_data.dart';
import 'package:flutter_tech_sales/presentation/features/notification/model/moengage_inbox.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:moengage_inbox/inbox_message.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  MoEngageInbox _moEngageInbox;
  Future<InboxData> inboxData;
  int unReadMessageCount = 0;

  Future<int> unReadMessageCoun() async {
    int unReadMessageCount = await _moEngageInbox.getUnClickedCount();
    return unReadMessageCount;
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
                            height: 40,
                            width: 40,
                            // margin: EdgeInsets.only(top: 40, left: 40, right: 40),
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
                        bottom: 25,
                        child: Container(
                          child: Text(
                            (unReadMessageCount > 0
                                ? unReadMessageCount.toString()
                                : ""),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Colors.orangeAccent,
                                fontWeight: FontWeight.bold),
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
        floatingActionButton:
            SpeedDialFAB(speedDial: speedDial, customStyle: customStyle),
        bottomNavigationBar: BottomNavigator(),
        body: Container(
          child: notificationWidget(),
        ));
  }

  Widget notificationWidget() {
    return FutureBuilder<List<InboxMessage>>(
      future: _moEngageInbox.fetchAllInboxMessages(),
      builder:
          (BuildContext context, AsyncSnapshot<List<InboxMessage>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              padding: const EdgeInsets.only(left: 6.0, right: 6.0, bottom: 10),
              // itemExtent: 125.0,
              itemBuilder: (context, index) {
                InboxMessage inboxMessage = snapshot.data[index];
                return GestureDetector(
                  onTap: () {
                    _moEngageInbox.trackMessageClicked(inboxMessage);
                    unReadMessageCoun().then((value) => {
                      setState(() {
                        unReadMessageCount = value;
                      }),
                    });
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    borderOnForeground: true,
                    //shadowColor: colornew,
                    elevation: 6,
                    margin: EdgeInsets.all(5.0),
                    color: Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(
                          color: (inboxMessage.isClicked == true)
                              ? HexColor("#F9A61A")
                              : HexColor("#007CBF"),
                          width: 6,
                        )),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
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
                                              //fontWeight: FontWeight.normal
                                              ),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 2.0, top: 2.0, bottom: 5.0),
                                        child: Text(
                                          "${inboxMessage.textContent.message}",
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 12,
                                              fontFamily: "Muli",
                                              fontWeight: FontWeight.bold
                                              //fontWeight: FontWeight.normal
                                              ),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
