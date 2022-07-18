import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:logapp/services/storage_service.dart';
import 'package:logapp/widgets/widgets_lib.dart';
import 'package:path_provider/path_provider.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({Key? key}) : super(key: key);

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  // late var filename = "";
  Map<int, double> downloadProgress = {};
  final Storage storage = Storage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(left: 10, right: 5)),
            Expanded(
              child: FutureBuilder(
                future: storage.listfiles(),
                builder: (BuildContext context,
                    AsyncSnapshot<firebase_storage.ListResult> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Container(
                      padding: const EdgeInsets.only(left: 20,right: 5,top: 0,bottom: 0),
                      height: MediaQuery.of(context).size.height*0.8,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          double? progress = downloadProgress[index];
                          return ListTile(
                            onTap: () {


                            },
                            title: Text(snapshot.data!.items[index].name),
                            // trailing: icnbtn(Icon(Icons.download), (){
                            //   // downloadFile();
                            //   try{
                            //     final Reference filename =
                            //         FirebaseStorage.instance.ref("Assignments");
                            //     downloadFile();
                            //     ScaffoldMessenger.of(context)
                            //         .showSnackBar(SnackBar(
                            //       duration: Duration(seconds: 1),
                            //       content: Text("Downloaded ${filename}"),
                            //     ));
                            //   }on FirebaseException catch(fe){
                            //     print(fe);
                            //   }
                            // }, Colors.grey),
                          );
                        },
                        itemCount: snapshot.data!.items.length,
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.hasData) {
                    return const Center(
                      heightFactor: 100,
                      widthFactor: 100,
                      child: SizedBox(child: CircularProgressIndicator.adaptive(),
                      height : 50,
                        width: 50,
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("      Upload file from here"),
                icnbtn(const Icon(Icons.upload_outlined), () async {
                  final results = await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      type: FileType.custom,
                      allowedExtensions: [
                        'png',
                        'pdf',
                        'txt',
                        'docx',
                        'pptx',
                        'apk',
                        'zip',
                        'jpg',
                        'jpeg',
                        'svg',
                        'mkv',
                        'mp3',
                        'mp4',
                        'html',
                        'doc',
                        'exe'
                      ]);

                  if (results == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("No files selected")));
                    return null;
                  }
                  final path = results.files.single.path!;
                  final filename = results.files.single.name;
                  storage
                      .uploadFile(path, filename)
                      .then((value) => const ScaffoldMessenger(
                      child: SnackBar(
                        content: Text("File uploaded successfully"),
                      )));
                  print("Selected file :" + path);
                  print("Selected file :" + filename);
                }, Colors.black),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Future downloadFile() async {
    final ref = FirebaseStorage.instance;
    final downloadURL = await ref.ref("Assignments").getDownloadURL();

    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/${ref.ref("Assignments").name}';
    await Dio().download(downloadURL, path,
        onReceiveProgress: (received, total) {
          double progress = received / total;
          UploadTask? task;
          setState(() async {
            if(task == null) return;
            final snapshot = await task.whenComplete(() {});
            final UrlDownload = await snapshot.ref.getDownloadURL();
            print(UrlDownload);
            // downloadProgress[] = progress;
          });
        }
    );

    if (downloadURL.contains('.mp4')) {
      await GallerySaver.saveVideo(path, toDcim: true);
    }
    else if (downloadURL.contains('.jpg')) {
      await GallerySaver.saveImage(path, toDcim: true);
    } else if (downloadURL.contains('.pdf')) {

    }
  }
  }
