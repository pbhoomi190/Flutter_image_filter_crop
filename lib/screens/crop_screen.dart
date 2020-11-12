import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_image_filter/utils/constants.dart';
import 'dart:ui'as ui;

import 'package:flutter_image_filter/utils/my_painter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class CropScreen extends StatefulWidget {
  final File imageFile;
  final ColorFilter filter;

  CropScreen({this.imageFile, this.filter});

  @override
  _CropScreenState createState() => _CropScreenState();
}

class _CropScreenState extends State<CropScreen> {

  // VARIABLES
  ui.Image _image; // get in init state
  GlobalKey _repaintBoundaryKey = GlobalKey();


  // LIFE CYCLE

  @override
  void initState() {
    loadImageFromFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: appBar(context),
      body: _image != null ? Center(
        child: RepaintBoundary(
          key: _repaintBoundaryKey,
          child: FittedBox(
            child: SizedBox(
              height: _image.height.toDouble(),
              width: _image.width.toDouble(),
              child: CustomPaint(
                painter: MyPainter(image: _image, filter: widget.filter, screenSize: MediaQuery.of(context).size),
              ),
            ),
          ),
        ),
      ) : Center(child: Text("Loading image..."),),
    );
  }


  // WIDGETS

  AppBar appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text(crop_button, style: Theme.of(context).textTheme.headline6,),
      actions: [
        FlatButton.icon(onPressed: () {
          showSaveToGalleryAlert(context);
         },
            icon: Icon(Icons.save, color: Colors.brown.shade900,),
            label: Text(save_button, style: Theme.of(context).textTheme.headline6,)
        )
      ],
    );
  }


  // HELPERS

  void loadImageFromFile() async {
    final data = await widget.imageFile.readAsBytes(); // Gives Uint8List data
    var decodedImage = await decodeImageFromList(data); // Converts image as dart's Image (dart:ui)
    setState(() {
      _image = decodedImage;
    });
  }

  void saveToGallery() async {
    RenderRepaintBoundary boundary =
    _repaintBoundaryKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final result =
        await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
    print(result.toString());
  }

  void checkPermission() async {
    // NSPhotoLibraryAddUsageDescription add in info.plist
    // Add storage read write permission in manifest
    var permissionStatus = await Permission.storage.status;
    if (permissionStatus != PermissionStatus.granted) {
      var result = await Permission.storage.request();
      if (result == PermissionStatus.granted) {
        saveToGallery();
      } else {
        debugPrint("Permission not granted");
      }
    } else {
      saveToGallery();
    }

  }

  showSaveToGalleryAlert(BuildContext context) {
    showDialog(context: context,
        child: AlertDialog(
          title: Text(save_button),
          content: Text("Are you sure you want to save this image?") ,
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel",
                style: TextStyle(color:Colors.blue, letterSpacing: 1.5),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Yes",
                style: TextStyle(color: Colors.blue, letterSpacing: 1.5),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                checkPermission();
              },
            ),
          ],
        )
    );
  }
}
