import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Constants extends StatelessWidget {
  const Constants({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String username = "";
    String rollno = "";
    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('DriverList').snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasError) return Text('Error = ${snapshot.error}');

        if (snapshot.hasData) {
          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (_, i) {
              final data = docs[i].data();
              rollno = data["rollno"];
              username = data["username"];
              return ListTile(
                title: Text(data["username"]),
                subtitle: Text(data["rollno"]),
              );
            },
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
    return Container(

    );
  }
}

