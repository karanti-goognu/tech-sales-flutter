import 'package:flutter/material.dart';

class BackgroundContainerImage extends StatelessWidget {
  const BackgroundContainerImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 200,
      right: 0,
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/Container.png',
              fit: BoxFit.fitHeight,
            ),
          ],
        ),
      ),
    );
  }
}
