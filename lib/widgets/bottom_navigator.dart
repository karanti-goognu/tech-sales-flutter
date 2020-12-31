import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:get/get.dart';

class BottomNavigator extends StatelessWidget {
  const BottomNavigator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: ColorConstants.appBarColor,
      shape: CircularNotchedRectangle(),
      notchMargin: 10,
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MaterialButton(
                  onPressed: () =>Get.toNamed(Routes.HOME_SCREEN),
                  minWidth: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.home,
                        color: Colors.white60,
                      ),
                      Text(
                        'Home',
                        style: TextStyle(
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Right Tab bar icons

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     new CupertinoPageRoute(
                    //         builder: (BuildContext context) =>
                    //             DraftLeadListScreen()));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.drafts,
                        color: Colors.white60,
                      ),
                      Text(
                        'Drafts',
                        style: TextStyle(
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    Get.toNamed(Routes.SEARCH_SCREEN);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.search,
                        color: Colors.white60,
                      ),
                      Text(
                        'Search',
                        style: TextStyle(
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
