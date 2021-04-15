import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/controller/dashboard_controller.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/view/view_site_detail_screen.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:get/get.dart';

class VolumeConvertedTable extends StatefulWidget {
  @override
  _VolumeConvertedTableState createState() => _VolumeConvertedTableState();
}

class _VolumeConvertedTableState extends State<VolumeConvertedTable> {
  DashboardController _dashboardController = Get.find();

  @override
  void initState() {
    _dashboardController.getDashboardMtdConvertedVolumeList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.appBarColor,
        toolbarHeight: SizeConfig.screenHeight*.10,
        centerTitle: false,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Volume Converted".toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: "Muli"),
                  ),
                ),
              ],
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigator(),
      floatingActionButton: BackFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left:16.0, top: 16, bottom: 8),
            child: Text(
              'MTD Vol. Converted',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:16.0, bottom: 16),
            child: Obx(()=>
            _dashboardController.mtdConvertedVolumeList.volumeEntity==null?Container():
                Text('Total Count-${ _dashboardController.mtdConvertedVolumeList.volumeEntity.length}'),),
          ),
          Container(
            height: SizeConfig.screenHeight / 16,
            color: HexColor('707070'),
            child: Row(
              children: [
                Expanded(
                  flex:2,
                  child: Text(
                    "Site ID​",
                    style: TextStyle(
                        color: HexColor('FFFFFF'),
                        fontSize:
                        SizeConfig.blockSizeHorizontal * 3),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex:2,
                  child: Text("Current Stage​",
                      style: TextStyle(
                          color: HexColor('FFFFFF'),
                          fontSize:
                          SizeConfig.blockSizeHorizontal *
                              3),
                      textAlign: TextAlign.center),
                ),
                Expanded(
                  flex:2,
                  child: Text("Brand​",
                      style: TextStyle(
                          color: HexColor('FFFFFF'),
                          fontSize:
                          SizeConfig.blockSizeHorizontal *
                              3),
                      textAlign: TextAlign.center),
                ),
                Expanded(
                  flex:2,
                  child: Text("Qty",
                      style: TextStyle(
                          color: HexColor('FFFFFF'),
                          fontSize:
                          SizeConfig.blockSizeHorizontal *
                              3),
                      textAlign: TextAlign.center),
                ),
                Expanded(
                  flex:2,
                  child: Text("Supply Date",
                      style: TextStyle(
                          color: HexColor('FFFFFF'),
                          fontSize:
                          SizeConfig.blockSizeHorizontal *
                              3),
                      textAlign: TextAlign.center),
                ),
                Expanded(
                  child: Container(),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              child :
              Obx(()=>

              _dashboardController.mtdConvertedVolumeList.volumeEntity==null?
                  Center(child: CircularProgressIndicator(),)

                  :ListView.separated(
                itemCount: _dashboardController.mtdConvertedVolumeList.volumeEntity.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          new CupertinoPageRoute(
                              builder: (BuildContext context) =>
                                  ViewSiteScreen(siteId: _dashboardController.mtdConvertedVolumeList.volumeEntity[index].siteId,tabIndex: 3,)));
                    },
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex:2,
                                  child: Text(
                                    "${_dashboardController.mtdConvertedVolumeList.volumeEntity[index].siteId}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize:
                                    SizeConfig.blockSizeHorizontal * 3),
                                  ),
                                ),
                                Expanded(
                                  flex:2,
                                  child: Text(
                                      "${_dashboardController.mtdConvertedVolumeList.volumeEntity[index].constructionStageText}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize:
                                      SizeConfig.blockSizeHorizontal * 3)
                                  ),
                                ),
                                Expanded(
                                  flex:2,
                                  child: Text(
                                      "${_dashboardController.mtdConvertedVolumeList.volumeEntity[index].brandName}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize:
                                      SizeConfig.blockSizeHorizontal * 3)
                                  ),
                                ),
                                Expanded(
                                  flex:2,
                                  child: Text(
                                      "${_dashboardController.mtdConvertedVolumeList.volumeEntity[index].supplyQty} bg",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize:
                                      SizeConfig.blockSizeHorizontal * 3)
                                  ),
                                ),
                                Expanded(
                                  flex:2,
                                  child: Text(
                                      "${_dashboardController.mtdConvertedVolumeList.volumeEntity[index].supplyDate}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize:
                                      SizeConfig.blockSizeHorizontal * 3)
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: HexColor('F9A61A')),
                                        padding: EdgeInsets.all(4),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 14,
                                        )))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => Divider(),
              ),)
            ),
          ),
        ],
      ),
    );
  }
}

