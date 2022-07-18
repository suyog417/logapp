import 'dart:io';

// import 'package:document_file_save/document_file_save.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile (String filePath, String fileName,) async{
    File file = File(filePath);

    try{
      await storage.ref('Assignments/$fileName').putFile(file);
    }on firebase_storage.FirebaseException catch(e){
      print(e);
    }
}
  Future<firebase_storage.ListResult> listfiles() async{
    firebase_storage.ListResult results = await storage.ref('Assignments').listAll();
    
    for (var ref in results.items) { print("Found file : $ref"); }
    return results;
  }

  Future<String> downloadURL(String imageName) async{
    String downloadURL = await storage.ref('Assignments/$imageName').getDownloadURL();

    return downloadURL;
  }

  Future<String> filename() async{
    final Reference ref = storage.ref("Assignment");
    String name = ref.name.toString();
    return name;
  }
  }

  // class FirebaseFile{
  // final Reference ref;
  // final
  // }
