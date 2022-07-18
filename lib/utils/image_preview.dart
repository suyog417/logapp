import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImagePreview extends StatefulWidget {
  const ImagePreview({Key? key}) : super(key: key);

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
        iconTheme: const IconThemeData(color:Colors.black),
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
            onPressed: () async{
              final downloadURL = await FirebaseStorage.instance.ref("Assignments").getDownloadURL();
              print(downloadURL);
            },
            child: const Text("Click me "),
          ),
        ),
      ),
    );
  }
}
