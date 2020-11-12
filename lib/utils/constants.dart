import 'dart:typed_data';

const pick_image_screen   = "Pick an Image";
const filter_screen_title = "Edit Picture";
const save_button         = "Save";
const filter_button       = "Filter";
const crop_button         = "Crop";
const save_gallery_msg    = "Are you sure you want to save this picture to gallery?";
const camera_button       = "Camera";
const gallery_button      = "Gallery";
const pick_image_msg      = "Select image using...";
const image_pick          = "Image picker";
const face_image_path     = "assets/images/face.png";

List<double> value1 = [0.95,0,0,0,0, 0,0.94,0,0,0, 0,0.88,0,0,0, 0,0,0,1,1];

List<double> value2 = [0.78,0,0,0,0, 0,0.78,0,0,0, 0,0.78,0,0,0, 0,0,0,1,0];

List<double> value3 = [0.98,0,0,0,0, 0,0.78,0,0,0, 0,0.78,0,0,0, 0,0,0,1,0];

List<double> bw = [0.25,0.5,0.25,0,0, 0.25,0.5,0.25,0,0, 0.25,0.5,0.25,0,0, 0,0,0,1,0];

List<double> darken = [0.5,0,0,0,0, 0,0.5,0,0,0, 0,0,0.5,0,0, 0,0,0,1,0];

List<double> lighten = [1.5,0,0,0,0, 0,1.5,0,0,0, 0,0,1.5,0,0, 0,0,0,1,0];

List<double> grey = [1,0,0,0,0, 1,0,0,0,0, 1,0,0,0,0, 0,0,0,1,0];