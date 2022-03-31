import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/utils/tso_logger.dart';
import 'package:flutter_tech_sales/widgets/photo_controller.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UploadImageBottomSheet{
  UploadImageBottomSheet._();
  static File? image;
  static PhotoController photoController = Get.put(PhotoController());

  static Future<File?> showPicker(context) async {
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
                       try{
                           await imgFromGallery();
                           Navigator.of(context).pop();
                       }
                       catch(e){
                         TsoLogger.printLog(e);
                         Get.snackbar(
                             "Permission Denied.", "Make sure that you have enabled photos permission.",
                             colorText: Colors.white,
                             backgroundColor: Colors.red,
                             snackPosition: SnackPosition.BOTTOM);
                       }
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () async{
                     try{
                       await imgFromCamera();
                       Navigator.of(context).pop();
                     }
                     catch(e){
                       TsoLogger.printLog(e);
                       Get.snackbar(
                           "Permission Denied.", "Make sure that you have enabled camera permission.",
                           colorText: Colors.white,
                           backgroundColor: Colors.red,
                           snackPosition: SnackPosition.BOTTOM);}
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
     ImagePicker _picker = ImagePicker();
     XFile? img = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 10,
        maxWidth: 480,
        maxHeight: 600);
    if (img != null){
      image= File(img.path);
      photoController.imageList.add(image);
    }
  }


  static imgFromGallery() async {
    ImagePicker _picker = ImagePicker();
    XFile? img = await _picker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    if (img != null){
      image= File(img.path);
      photoController.imageList.add(image);
    }
  }

}