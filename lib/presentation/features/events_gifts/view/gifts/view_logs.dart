import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import '../../controller/gifts_controlller.dart';


class ViewLogs extends StatelessWidget {
  final GiftController giftController;
  final giftsCategoriesNameList;

  const ViewLogs({Key key, this.giftController, this.giftsCategoriesNameList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var _currentMonth;
    giftController.getViewLogsData("${giftController.monthYear}");
    return Scaffold(
      appBar: AppBar(
        title: Text("View Logs".toUpperCase()),
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstants.appBarColor,
      ),
      bottomNavigationBar: BottomNavigator(),
      floatingActionButton: BackFloatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      padding:
                      const EdgeInsets.fromLTRB(12, 4, 4, 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(()=>Text(giftController.monthYear.toString(), style: TextStyle(fontSize: 16),),),
                            Icon(Icons.arrow_drop_down)
                          ],
                        ),
                        onPressed: (){
                          showMonthPicker(
                            context: context,
                            firstDate: DateTime(DateTime.now().year - 5, 1),
                            lastDate: DateTime(DateTime.now().year , DateTime.now().month),
                            initialDate: DateTime.now(),
                            locale: Locale("en"),
                          ).then((date) {
                            if (date != null) {
                            final DateFormat formatter = DateFormat("MMMM");
                             _currentMonth = formatter.format(date);
                            giftController.monthYear='$_currentMonth-${date.year.toString().substring(2)}';
                            print(giftController.monthYear);
                            giftController.getViewLogsData(giftController.monthYear.toString());
                            }
                          });
                        },
                      ),
                    )),
                  SizedBox(width: 20,),
                  Flexible(
                    flex: 2,
                    child: Container(
                        width: double.infinity,
                        padding:
                        const EdgeInsets.fromLTRB(12, 4, 4, 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        child: DropdownButtonHideUnderline(
                            child: GetBuilder<GiftController>(

                                  builder:(cc)=>
                                DropdownButton(
                                  onChanged: (newValue) {
                                    giftController.selectedDropdown = newValue;
                                    cc.update();
                                  },
                                  value: giftController.selectedDropdown,
                                  items: giftController.giftStockModelList
                                      .map<DropdownMenuItem>((value) {
                                    return DropdownMenuItem(
                                      value: value.giftTypeId,
                                      child: SizedBox(
                                        width: 120,
                                        child: Text(
                                          value.giftTypeText.toString(),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),),)
                        )),
              ],
            ),
            SizedBox(height: 20,),

            Obx( (){
              print(giftController.selectedDropdown.toString() + "Do Not Remove This");
              return  Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      separatorBuilder: (context,index){
                        return
                          giftController.dataForViewLog[index].giftTypeId!=giftController.selectedDropdown?Container():

                          SizedBox(height: 15,);
                      },
                      itemCount: giftController.dataForViewLog.length,
                      itemBuilder: (context,i){
                        return
                         giftController.dataForViewLog[i].giftTypeId!=giftController.selectedDropdown?Container():
                         Container(
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(4),
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.black12,
                                 blurRadius: 2
                               )
                             ]

                           ),
                           child: Theme(
                             data: ThemeData(splashColor: Colors.transparent,
                                 accentColor: Colors.amber, unselectedWidgetColor:  Colors.amber
                             ),
                             child: ExpansionTile(
                               title: Text(giftController.dataForViewLog[i].giftAddDate.toString()),
                               children: [
                                 Container(
                                   height:200,
                                   child: ListView.separated(
                                       shrinkWrap: true,
                                       physics: NeverScrollableScrollPhysics(),
                                       itemBuilder: (context, index) {
                                         return
                                           index==0?
                                           Container(
                                           ):
                                           Padding(
                                             padding: const EdgeInsets.symmetric(horizontal:18.0,vertical: 8),
                                             child: Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [

                                                 Text(
                                                   index==2?"Stock Added":giftsCategoriesNameList[index-1],
                                                   style: TextStyle(
                                                       fontSize: 16, fontWeight: FontWeight.bold),
                                                 ),
                                                 Text(
                                                   index==1?
                                                   giftController.dataForViewLog[i].giftOpeningStockQty.toString():
                                                   index==2?giftController.dataForViewLog[i].stockAddedQty.toString():
                                                   index==3?giftController.dataForViewLog[i].giftUtilisedQty.toString():null,
                                                   style: TextStyle(
                                                     fontWeight: FontWeight.bold,
                                                   ),
                                                 ),
                                               ],
                                             ),
                                           );
                                       },
                                       separatorBuilder: (context, index) {
                                         return Padding(
                                           padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                           child: Divider(),
                                         );
                                       },
                                       itemCount: 4),
                                 ),
                               ],
                             ),
                           ),
                         );
                      }),
              ); })
          ],
        ),
      ),
    );
  }
}
