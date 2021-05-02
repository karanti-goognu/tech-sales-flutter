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
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        splashColor: Colors.transparent,
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
                            firstDate: DateTime(DateTime.now().year - 1, 1),
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
                              blurRadius: 2.0,
                            ),
                          ],
                        ),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              onChanged: (newValue) {
                                print(newValue);
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
                            ))
                        )),
              ],
            ),
            SizedBox(height: 20,),

            Flexible(
              child: Container(
                child: ListView.separated(
                  separatorBuilder: (context,index){
                    return SizedBox(height: 5,);
                  },
                    itemCount: giftController.dataForViewLog.length,
                    itemBuilder: (context,index){
                  return Card(
                    elevation: 3,
                    child: Theme(
                      data: ThemeData(splashColor: Colors.transparent),
                      child: ExpansionTile(
                        title: Text(giftController.dataForViewLog[index].giftAddDate.toString()),
                        children: [
                          Container(
                            height:200,
                            child: Flexible(
                                child:  ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              giftsCategoriesNameList[index],
                                              style: TextStyle(
                                                  fontSize: 16, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              index==0?
                                              giftController.dataForViewLog[index].giftOpeningStockQty.toString():
                                              index==1?giftController.dataForViewLog[index].giftInHandQty.toString():
                                              giftController.dataForViewLog[index].giftUtilisedQty.toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
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
                                    itemCount: 3)),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
