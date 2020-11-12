import 'package:flutter/material.dart';
import 'package:flutter_image_filter/utils/constants.dart';

class AlertHelper {

  static showAlertDialog(BuildContext alertContext, {VoidCallback cameraClicked, VoidCallback galleryClicked}) {

    Widget cameraButton = FlatButton(
      child: Text(camera_button),
      onPressed: () {
        cameraClicked();
        Navigator.of(alertContext).pop();
        },
    );

    Widget galleryButton = FlatButton(
      child: Text(gallery_button),
      onPressed: () {
        galleryClicked();
        Navigator.of(alertContext).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(image_pick),
      content: Text(pick_image_msg),
      actions: [
        cameraButton,
        galleryButton
      ],
    );


    return showDialog(context: (alertContext), builder: (context) {
       return alert;
    });
  }
}