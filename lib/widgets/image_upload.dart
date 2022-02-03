import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ImageUpload extends StatelessWidget {
  const ImageUpload({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: BorderSide(color: Colors.black26),
      ),
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(right: 5, bottom: 10, top: 10),
        child: Text(
          "UPLOAD PHOTOS",
          style: TextStyle(
              color: HexColor("#1C99D4"),
              fontWeight: FontWeight.bold,
              // letterSpacing: 2,
              fontSize: 17),
        ),
      ),
      onPressed: () async {
        _showPicker(context);
      },
    );
  }
}

_imgFromCamera() async {
  ImagePicker _picker = ImagePicker();
  XFile image = await _picker.pickImage(
      source: ImageSource.camera, imageQuality: 50);
    if (image != null) {
      print(1);
      print(basename(image.path));



      // listLeadImage.add(new ListLeadImage(photoName: basename(image.path)));
      // _imageList.add(image);

      // _imgDetails.add(new ImageDetails("asset", image));
    }
}

_imgFromGallery() async {
  ImagePicker _picker = ImagePicker();
  XFile image = await _picker.pickImage(
      source: ImageSource.gallery, imageQuality: 50);
print(image.path);
  // setState(() {
    if (image != null) {
      print(1);
      print(image.path);

    }
  //     // listLeadImage.add(new ListLeadImage(photoName: basename(image.path)));
  //     _imageList.add(image);
  //
  //     _imgDetails.add(new ImageDetails("asset", image));
  //   }
  //   // _imageList.insert(0,image);
  // });
}

void _showPicker(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      });
}
