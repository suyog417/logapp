import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Saturday extends StatefulWidget {
  const Saturday({Key? key}) : super(key: key);

  @override
  State<Saturday> createState() => _SaturdayState();
}

class _SaturdayState extends State<Saturday> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saturday"),
        iconTheme: const IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text("Lectures",style: TextStyle(fontSize: 20),),
              const SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2),blurRadius: 5)]
                ),
                height: MediaQuery.of(context).size.height*0.4,
                child: ShowLectures(),
              ),
              const SizedBox(height: 10,),
              const Text("Practicals",style: TextStyle(fontSize: 20),),
              const SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2),blurRadius: 5)]
                ),
                height: MediaQuery.of(context).size.height*0.5,
                child: ShowPracticals(),),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
class ShowLectures extends StatelessWidget {
  final FSref = FirebaseFirestore.instance
      .collection("/Time_Table/Lectures/Saturday")
      .orderBy("start_time", descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FSref,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            reverse: false,
            primary: true,
            // controller: _controller,
            itemBuilder: (context, i) {
              QueryDocumentSnapshot x = snapshot.data!.docs[i];
              return ListTile(
                title: Column(
                  verticalDirection: VerticalDirection.up,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Time :"+x["start_time"] + " to " + x["end_time"],
                        style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),
                      ),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    )
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Faculty Name : "+x["teacher_name"]),
                    Text("Classroom : "+x["classroom"]),
                    Text("Subject : "+x["subject"])
                  ],
                ),
                // shape: Border(bottom: BorderSide(color: Colors.black87,width: 1.5)),
                onLongPress: (){
                  FirebaseFirestore.instance.collection("/Time_Table/Lectures/Monday").doc(x["start_time"]+" to "+x["end_time"]).delete();
                },
              );
            });
      },
    );
  }
}

class ShowPracticals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("/Time_Table/Practicals/Saturday")
          .orderBy("start_time", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            reverse: false,
            primary: true,
            // controller: _controller,
            itemBuilder: (context, i) {
              QueryDocumentSnapshot x = snapshot.data!.docs[i];
              return ListTile(
                title: Column(
                  verticalDirection: VerticalDirection.up,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text("Time :"+x["start_time"] + " to " + x["end_time"],
                        style: const TextStyle(fontSize: 17),
                      ),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    )
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("CM1 : "+x["FBsubject"],style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
                    Text("Lab : "+x["FBlab"]),
                    Text("Faculty Name : "+x["FBfaculty"]),
                    const SizedBox(height: 5,),
                    Text("CM2 : "+x["SBsubject"],style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
                    Text("Lab : "+x["SBlab"]),
                    Text("Faculty Name : "+x["SBfaculty"]),
                    const SizedBox(height: 5,),
                    Text("CM3 : "+x["TBsubject"],style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
                    Text("Lab : "+x["TBlab"]),
                    Text("Faculty Name : "+x["TBfaculty"]),
                  ],
                ),
                style: ListTileStyle.drawer,
                onLongPress: (){
                  FirebaseFirestore.instance.collection("/Time_Table/Practicals/Monday").doc(x["start_time"]+" to "+x["end_time"]).delete();
                },
                // shape: Border(bottom: BorderSide(color: Colors.black87,width: 1.5)),
              );
            });
      },
    );
  }

}
