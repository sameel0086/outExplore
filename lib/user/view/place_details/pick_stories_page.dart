import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' show ImagePicker, ImageSource, XFile;


class MultiImagePickerPage extends StatefulWidget {
  const MultiImagePickerPage({super.key});

  @override
  State<MultiImagePickerPage> createState() => _MultiImagePickerPageState();
}

class _MultiImagePickerPageState extends State<MultiImagePickerPage> {
  final List<File> images = [];
  final ImagePicker imagePicker = ImagePicker();

  Future<void> getImage(ImageSource source) async {
    if (source == ImageSource.gallery) {
      List<XFile>? selectedImages = await imagePicker.pickMultiImage();

      if (selectedImages != null) {
        setState(() {
          images.addAll(selectedImages.map((e) => File(e.path)));
        });
      }
    } else {
      XFile? selectedImages = await imagePicker.pickImage(source: source);

      if (selectedImages != null) {
        setState(() {
          images.add(File(selectedImages.path));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 70),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              images.isEmpty
                  ? Text("NO IMAGES SELECTED")
                  : Expanded(
                  child: GridView.builder(
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8),
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Image.file(images[index], fit: BoxFit.cover);
                      })),
              ElevatedButton(
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                  child:Icon(Icons.camera_alt_outlined)),
              ElevatedButton(
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  child: Icon(Icons.add))
            ],
          ),
        ),
      ),
    );
  }
}
