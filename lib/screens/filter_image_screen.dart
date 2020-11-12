import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_image_filter/screens/crop_screen.dart';
import 'package:flutter_image_filter/utils/alert_helper.dart';
import 'package:flutter_image_filter/utils/constants.dart';
import 'package:image_picker/image_picker.dart';

class FilterImageScreen extends StatefulWidget {
  @override
  _FilterImageScreenState createState() => _FilterImageScreenState();
}

class _FilterImageScreenState extends State<FilterImageScreen> {

  // VARIABLES AND CONSTANTS
  double _screenHeight = 0.0;
  double _screenWidth = 0.0;
  File _image;
  final picker = ImagePicker();
  ColorFilter _selectedFilter;
  
  List<ColorFilter> filterList = [ColorFilter.matrix(value1),
    ColorFilter.matrix(value2),
    ColorFilter.matrix(value3),
    ColorFilter.matrix(bw),
    ColorFilter.matrix(darken),
    ColorFilter.matrix(lighten),
    ColorFilter.matrix(grey),
  ];

  // LIFE CYCLE

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        children: [
          addImageContainer(context),
          filterColorOptionContainer(context),
          imageFilterOptionContainer(context)
        ],
      ),
    );
  }

  // HELPERS

  Future getImage(ImageSource imageSource) async {
    final pickedFile = await picker.getImage(source: imageSource);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // WIDGETS
  AppBar appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text(filter_screen_title, style: Theme.of(context).textTheme.headline6,),
    );
  }


  Widget addImageContainer(BuildContext context) {
    return Container(
      height: _screenHeight * 0.5,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      color: Theme.of(context).primaryColorLight,
      child:  _image == null ? Center(
        child: IconButton(
          icon: Icon(Icons.add, size: 50, color: Theme.of(context).primaryColor,),
          onPressed: () {
            AlertHelper.showAlertDialog(context, cameraClicked: () {
                getImage(ImageSource.camera);
            }, galleryClicked: () {
              getImage(ImageSource.gallery);
            });
          },
        ),
      ) : Container(
        child: Container(
          child: _selectedFilter == null ? Image.file(File(_image.path)) : ColorFiltered(
            colorFilter: _selectedFilter,
            child: Image.file(File(_image.path),
        ),
          ),
        ),
      )
    );
  }

  Widget filterColorOptionContainer(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.all(10),
        child: ListView.builder(itemBuilder: (context, index) {
          return imageContainer(filterList[index]);
        },
          itemCount: filterList.length,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  Widget filterCropOptionsContainer(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.all(10),
      ),
    );
  }

  Widget imageFilterOptionContainer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      height: _screenHeight * 0.08,
      width: 250,
      child: OutlineButton(
        borderSide: BorderSide(width: 2, color: Theme.of(context).primaryColor),
        onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => CropScreen(imageFile: _image, filter: _selectedFilter,)));
        },
        child: Text(crop_button.toUpperCase(), style: Theme.of(context).textTheme.bodyText1,),
      ),
    );
  }
  
  Widget imageContainer(ColorFilter filter) {
    return InkWell(
      onTap: () {
        setState(() {
          print("filter change");
          _selectedFilter = filter;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 100,
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColorFiltered(
              colorFilter: filter,
                child: Image.asset(face_image_path, fit: BoxFit.contain,)
            ),
            Text("name")
          ],
        ),
      ),
    );
  }
}
