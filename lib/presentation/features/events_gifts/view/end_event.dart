import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';

class EndEvent extends StatefulWidget {
  @override
  _EndEventState createState() => _EndEventState();
}

class _EndEventState extends State<EndEvent> {
  bool _isVisible = false;
  List<String> comments = ["Testing Meet","Testing Meet2","Testing Meet3","Testing Meet4"];
  ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    //_isVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorConstants.appBarColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('EVENTS DETAILS', style: TextStyles.appBarTitleStyle),
              FlatButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0),
                    side: BorderSide(color: Colors.white)),
                color: Colors.transparent,
                child: Text(
                  'ADD LEAD',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              )
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setSp(20), bottom: ScreenUtil().setSp(5)),
              color: ColorConstants.appBarColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    onPressed: () {},
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(28.0),
                    //     side: BorderSide(color: Colors.white)),
                    color: Colors.transparent,
                    // child: Text(
                    //   'END TIME',
                    //   style: TextStyle(color: Colors.white, fontSize: 15),
                    // ),
                    child: SizedBox(),
                  ),
                  FlatButton(
                      onPressed: () {
                        //getBottomSheet();
                        //Get.toNamed(Routes.UPDATE_DLR_INF);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.edit,
                              color: ColorConstants.clearAllTextColor,
                              size: ScreenUtil().setSp(20)),
                          SizedBox(
                            width: ScreenUtil().setSp(5),
                          ),
                          Text('UPDATE DLR & INF.',
                              style: TextStyles.robotoBtn14),
                        ],
                      ))
                ],
              ),
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BackFloatingButton(),
      bottomNavigationBar: BottomNavigator(),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: ScreenUtil().setSp(10),
              right: ScreenUtil().setSp(10),
              top: ScreenUtil().setSp(20),
              bottom: ScreenUtil().setSp(20),
            ),
            child: Text(
              '24-Mar-2021 | 12 PM',
              style: TextStyles.mulliBoldBlue,
            ),
          ),
          displayInfo('Event Type', 'Mason meet'),
          displayInfo('Actual Event Type', 'Mason meet'),
          displayInfo('Dalmia Influencers', '15'),
          displayInfo('Actual Dalmia Influencers', '12'),
          displayInfo('Non-Dalmia Influencers', '15'),
          displayInfo('Actual Non-Dalmia Influencers', '10'),
          displayInfo('Total Participants', '15'),
          displayInfo('Actual Total Participants', '22'),
          // displayInfo('Venue', 'Booked'),
          displayInfo('Venue Address', 'XYZ'),
          displayChip('Dealer(s) Detail'),
          displayChip('Influencer(s) Detail'),
          displayInfo('Expected Leads', 'Mason meet'),
          displayInfo('Actual Leads', 'Mason meet'),
          displayInfo('Gift distribution', 'Mason meet'),
          displayInfo('Event location', 'Mason meet'),
          Card(
            margin: EdgeInsets.only(left: 10,right: 10,bottom: 20),
            elevation: 0,
            child: Theme(
              data: ThemeData(splashColor: Colors.transparent),
              child: ExpansionTile(
                title: Row(
                  children: [
                    Container(
                        height: 20,
                        width: 20,
                        child: Icon(Icons.insert_comment_outlined)),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Past Comments'),
                  ],
                ),
                children: [
                  (comments != null && comments.length > 0)?
                  getList(comments):Container(
                    child: Center(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('No Comments !!'),
                    ),),)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget displayInfo(String title, String value) {
    return Padding(
      padding: EdgeInsets.only(
        left: ScreenUtil().setSp(15),
        right: ScreenUtil().setSp(15),
        top: ScreenUtil().setSp(5),
        bottom: ScreenUtil().setSp(5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyles.formfieldLabelTextDark,
              ),
              Text(
                value,
                style: TextStyles.mulliBold16,
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setSp(20)),
            child: Divider(
              height: 1,
              color: ColorConstants.lightBlackBorderColor,
            ),
          )
        ],
      ),
    );
  }

  Widget displayChip(String title) {
    return Padding(
        padding: EdgeInsets.only(
          left: ScreenUtil().setSp(15),
          right: ScreenUtil().setSp(10),
          top: ScreenUtil().setSp(0),
          bottom: ScreenUtil().setSp(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyles.formfieldLabelTextDark,
            ),
            SizedBox(
              height: ScreenUtil().setSp(10),
            ),
            Container(
              height: ScreenUtil().setSp(30),
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: ['Chip1', 'Chip1Chip1']
                    // selectedRequestSubtypeObjectList
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Chip(
                            label: Text(
                              e,
                              // e.serviceRequestTypeText,
                              style: TextStyle(
                                  fontFamily: "Muli",
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14.0),
                            ),
                            backgroundColor: Colors.white,
                            // elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              side: BorderSide(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setSp(20)),
              child: Divider(
                height: 1,
                color: ColorConstants.lightBlackBorderColor,
              ),
            )
          ],
        ));
  }

  Widget getList(List<String> list) {
    //  getSortedData();
    return (list != null && list.length > 0 )
    //&& list != null)
        ? ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        controller: _scrollController,
        itemCount: list.length,
        padding: const EdgeInsets.only(left: 6.0, right: 6, bottom: 10),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {

            },
            child: Card(
              clipBehavior: Clip.antiAlias,
              borderOnForeground: true,
              elevation: 0,
              margin: EdgeInsets.all(4.0),
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                        color:
                        Colors.white,
                        width: 0,
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
                            list[index],
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Muli",
                                //fontWeight:
                                // FontWeight.bold
                                fontWeight: FontWeight.normal),
                            // ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        })
        : Container(
      child: Center(
        child: Text("No data!!"),
      ),
    );
  }

}
