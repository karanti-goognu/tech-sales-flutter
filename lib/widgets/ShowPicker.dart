// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// void _showPicker(context) {
//   showModalBottomSheet(
//       context: context,
//       builder: (BuildContext bc) {
//         return SafeArea(
//           child: Container(
//             child: new Wrap(
//               children: <Widget>[
//                 new ListTile(
//                     leading: new Icon(Icons.photo_library),
//                     title: new Text('Photo Library'),
//                     onTap: () {
//                       _imgFromGallery();
//                       Navigator.of(context).pop();
//                     }),
//                 new ListTile(
//                   leading: new Icon(Icons.photo_camera),
//                   title: new Text('Camera'),
//                   onTap: () {
//                     _imgFromCamera();
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       });
// }
//
// _imgFromCamera() async {
//   File image = await ImagePicker.pickImage(
//       source: ImageSource.camera, imageQuality: 50);
//
//   setState(() {
//     //print(image.path);
//     if (image != null) {
//       // print(basename(image.path));
//
//       // listLeadImage.add(new ListLeadImage(photoName: basename(image.path)));
//       _imageList.add(image);
//
//       _imgDetails.add(new ImageDetails("asset", image));
//     }
//   });
// }
//
// _imgFromGallery() async {
//   File image = await ImagePicker.pickImage(
//       source: ImageSource.gallery, imageQuality: 50);
//
//   setState(() {
//     // print(image.path);
//
//     if (image != null) {
//       // listLeadImage.add(new ListLeadImage(photoName: basename(image.path)));
//       _imageList.add(image);
//
//       _imgDetails.add(new ImageDetails("asset", image));
//     }
//     // _imageList.insert(0,image);
//   });
// }
//
//
//
// class ImageDetails {
//   String from;
//   File file;
//   ImageDetails(this.from, this.file);
// }
