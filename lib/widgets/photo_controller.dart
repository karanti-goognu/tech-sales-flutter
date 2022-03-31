import 'dart:io';
import 'package:get/get.dart';

class PhotoController extends GetxController {
  /// Add File to this list if user selects an image, and remove image if user deletes an image
  List<File?> imageList = List.empty(growable: true);

  /// set this to true if any image is coming from backend.
  bool imageFromBackend = false;

  /// call this function to add image to the imageList
  addImage(File? image ) {
    imageList.add(image);
  }

/// call this function to remove image from the imageList
  removeImage(int index) {
    imageList.removeAt(index);
  }

/// if image is coming from backend, show the list on screen
 void test(){
   if (imageFromBackend){
     // imageList.add();
   }
 }

}
