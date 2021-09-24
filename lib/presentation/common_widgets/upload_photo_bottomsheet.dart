import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UploadImageBottomSheet{
  UploadImageBottomSheet._();
  static File image;

  static Future<File> showPicker(context) async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () async{
                       await imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () async{
                     await imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
    return image;
  }


   static imgFromCamera() async {
    File img = await ImagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 10,
        maxWidth: 480,
        maxHeight: 600);
    if (img != null)
      image= img;
      // imageList.add(image);
  }


  static imgFromGallery() async {
    File img = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    if (img != null)
      image= img;
    // imageList.add(image);
  }
}