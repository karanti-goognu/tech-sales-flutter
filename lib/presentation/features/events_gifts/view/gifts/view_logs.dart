

import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/GetGiftStockModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/gifts/gifts.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import '../../controller/gifts_controlller.dart';


class ViewLogs extends StatefulWidget {

  @override
  _LogsViewState createState() => _LogsViewState();
}

class _LogsViewState extends State<ViewLogs> {
  GiftController giftController = Get.find();
  final List _giftsCategoriesNameList = [
    'Opening Stock',
    'Stock In Hand',
    'Utilized'
  ];
  List _giftsCategoriesValueList = [];
  List _giftCategoriesList = [];
  var _currentMonth;
  List<GiftStockModelList>? _giftStockModelList;

  addDateForGiftsView() async {
    _giftsCategoriesValueList = [];
    _giftCategoriesList = [];
    _giftsCategoriesValueList = [
      giftController.giftStockModelList[giftController.selectedDropdown].giftOpeningStockQty,
      giftController.giftStockModelList[giftController.selectedDropdown].giftInHandQty,
      giftController.giftStockModelList[giftController.selectedDropdown].giftUtilisedQty
    ];
    for (int i = 0; i < _giftsCategoriesNameList.length; i++) {
      _giftCategoriesList.add(GiftsCategories(
          _giftsCategoriesNameList[i], _giftsCategoriesValueList[i]));
    }
    setState(() {

    });
  }

  getDetailEventsData() async {
    await giftController.getGiftStockData().then((data) {
      giftController.getViewLogsData1(giftController.giftStockModelList).then((value) => {
      setState(() {
      _giftStockModelList = giftController.giftStockModelList1;
      if(giftController.selectedDropdown ==0){
        giftController.selectedDropdown = 1;
      }
      addDateForGiftsView();
      })
      });
    });
  }


  @override
  void initState() {
    getDetailEventsData();
    giftController.getViewLogsData("${giftController.monthYear}").then((value) => {
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Logs".toUpperCase()),
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstants.appBarColor,
      ),
      bottomNavigationBar: BottomNavigator(),
      floatingActionButton: BackFloatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _giftStockModelList!=null?Padding(
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
                      child: TextButton(
                        style: TextButton.styleFrom(primary: Colors.black),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(()=>Text(giftController.monthYear.toString(), style: TextStyle(fontSize: 16),),),
                            Icon(Icons.arrow_drop_down)
                          ],
                        ),
                        onPressed: (){
                        //  print("Show picker");
                          showMonthPicker(
                            context: context,
                            firstDate: DateTime(DateTime.now().year - 5, 1),
                            lastDate: DateTime(DateTime.now().year , DateTime.now().month),
                            initialDate: DateTime.now(),
                            locale: Locale("en"),
                          ).then((date) {
                          //  print("date");
                            if (date != null) {
                            final DateFormat formatter = DateFormat("MMMM");
                             _currentMonth = formatter.format(date);
                            giftController.monthYear='$_currentMonth-${date.year.toString().substring(2)}';
                          //  print(giftController.monthYear);
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
                                  onChanged: (dynamic newValue) {
                                    giftController.selectedDropdown = newValue;
                                    cc.update();
                                    giftController.getGiftStockData().whenComplete(() => addDateForGiftsView());
                                  },
                                  value: giftController.selectedDropdown,
                                  items: _giftStockModelList!
                                      .map<DropdownMenuItem>((value) {
                                    return DropdownMenuItem(
                                      value: value.giftTypeId,
                                      child: SizedBox(
                                        width: 115,
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
           //   print(giftController.selectedDropdown.toString());
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
                                  unselectedWidgetColor:  Colors.amber,
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
                                                   index==2?"Stock Added":_giftsCategoriesNameList[index-1],
                                                   style: TextStyle(
                                                       fontSize: 16, fontWeight: FontWeight.bold),
                                                 ),
                                                 Text(
                                                   index==1?
                                                   giftController.dataForViewLog[i].giftOpeningStockQty.toString():
                                                   index==2?giftController.dataForViewLog[i].stockAddedQty.toString():
                                                   index==3?giftController.dataForViewLog[i].giftUtilisedQty.toString():"",
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
      ):Container(
    child: Center(
    child: Text("Loading data!!"),
    ),
    ));
  }
}
