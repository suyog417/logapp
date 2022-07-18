import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logapp/widgets/widgets_lib.dart';
import 'package:intl/intl.dart';

class AddPractical extends StatefulWidget {
  const AddPractical({Key? key}) : super(key: key);

  @override
  State<AddPractical> createState() => _AddPracticalState();
}

final ctime = DateTime.now();
final currenttime = DateFormat('jm').format(ctime);

class _AddPracticalState extends State<AddPractical> {
  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];
  String dropdownvalue = "Monday";
  final storemessages = FirebaseFirestore.instance;
  final TextEditingController _lab1controller = TextEditingController();
  final TextEditingController _lab2controller = TextEditingController();
  final TextEditingController _lab3controller = TextEditingController();
  final TextEditingController _faculty1controller = TextEditingController();
  // TextEditingController _starttimecontroller = new TextEditingController();
  // TextEditingController _endtimecontroller = new TextEditingController();
  // TextEditingController _classroomcontroller = new TextEditingController();
  final TextEditingController _batch1controller = TextEditingController();
  final TextEditingController _batch2controller = TextEditingController();
  final TextEditingController _batch3controller = TextEditingController();
  final TextEditingController _faculty2controller = TextEditingController();
  final TextEditingController _faculty3controller = TextEditingController();

  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  String formstartTime = "";
  String formendTime = "";

  _startTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: startTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != startTime) {
      setState(() {
        final localizations = MaterialLocalizations.of(context);
        final formattedTimeOfDay = localizations.formatTimeOfDay(timeOfDay);
        formstartTime = formattedTimeOfDay;
      });
    }
  }

  _endTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: endTime,
      confirmText: "Ok",
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != endTime) {
      setState(() {
        final localizations = MaterialLocalizations.of(context);
        final formattedTimeOfDay = localizations.formatTimeOfDay(timeOfDay);
        formendTime = formattedTimeOfDay;
        // DateFormat("jm").format();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Add Practical",
          style: TextStyle(color: Colors.black87),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1)),
              Container(
                padding: const EdgeInsets.only(top: 5, left: 20),
                decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(30)),
                width: MediaQuery.of(context).size.width * 0.9,
                child: DropdownButton(
                  items: days.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                  value: dropdownvalue,
                  icon: const Icon(null),
                ),
              ),
              // SizedBox(height: 20,),
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueAccent.withOpacity(0.4)),
                            shadowColor: MaterialStateProperty.all(Colors.transparent),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                          ),
                          ),
                          onPressed: () {
                            _startTime(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [ Icon(Icons.timer),Text("Start Time    "),],
                          )),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueAccent.withOpacity(0.4)),
                          shadowColor: MaterialStateProperty.all(Colors.transparent),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                            ),
                          ),
                          onPressed: () {
                            _endTime(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [ Icon(Icons.timer),Text("End Time    "),],
                          )),
                    )
                    // Container(
                    //   width: 70,
                    //   child: icnbtn(Icon(Icons.timer,size: 30), (){
                    //     _startTime(context);
                    //   }, Colors.grey),
                    // ),
                    // Container(width: 70,child: Text(formstartTime != null ? " $formstartTime " : " Select time ")),
                    // Container(
                    //   width: 70,
                    //   child: icnbtn(Icon(Icons.timer,size: 30), (){
                    //     _endTime(context);
                    //   }, Colors.grey),
                    // ),
                    // Container(width: 70,child: Text(formendTime == null ? " $currenttime " : " $formendTime ")),
                    // Container(
                    //   width: 110,
                    //   child: ElevatedButton(onPressed: (){
                    //     _endTime(context);
                    //   }, child: Text("Ending time ")),
                    // ),
                  ],
                ),
              ),
              // userinfotype(
              //     "Starting Time",
              //     Icons.access_time,
              //     false,
              //     _starttimecontroller,
              //     Colors.blueAccent.withOpacity(0.3),
              //     Colors.grey,
              //     Colors.black87,
              //     TextInputType.datetime),
              // SizedBox(
              //   height: 20,
              // ),
              // userinfotype(
              //     "End Time",
              //     Icons.access_time,
              //     false,
              //     _endtimecontroller,
              //     Colors.blueAccent.withOpacity(0.3),
              //     Colors.grey,
              //     Colors.black87,
              //     TextInputType.datetime),
              // SizedBox(
              //   height: 20,
              // ),
              reusabletextfield(
                  "Faculty Name for First Batch",
                  Icons.calendar_view_day,
                  false,
                  _faculty1controller,
                  Colors.blueAccent.withOpacity(0.3),
                  Colors.grey,
                  Colors.black87),
              const SizedBox(
                height: 20,
              ),
              userinfotype(
                  "Subject for First Batch",
                  Icons.home_outlined,
                  false,
                  _batch1controller,
                  Colors.blueAccent.withOpacity(0.3),
                  Colors.grey,
                  Colors.black87,
                  TextInputType.name),
              const SizedBox(
                height: 20,
              ),
              userinfotype(
                  "Lab for First Batch",
                  Icons.access_time,
                  false,
                  _lab1controller,
                  Colors.blueAccent.withOpacity(0.3),
                  Colors.grey,
                  Colors.black87,
                  TextInputType.name),
              const SizedBox(
                height: 20,
              ),
              reusabletextfield(
                  "Faculty Name for Second Batch",
                  Icons.person,
                  false,
                  _faculty2controller,
                  Colors.blueAccent.withOpacity(0.3),
                  Colors.grey,
                  Colors.black87),
              const SizedBox(
                height: 20,
              ),
              userinfotype(
                  "Subject for Second Batch",
                  Icons.access_time,
                  false,
                  _batch2controller,
                  Colors.blueAccent.withOpacity(0.3),
                  Colors.grey,
                  Colors.black87,
                  TextInputType.name),
              const SizedBox(
                height: 20,
              ),
              reusabletextfield(
                  "Lab for Second Batch",
                  Icons.person,
                  false,
                  _lab2controller,
                  Colors.blueAccent.withOpacity(0.3),
                  Colors.grey,
                  Colors.black87),
              const SizedBox(
                height: 20,
              ),
              userinfotype(
                  "Faculty Name for Third Batch",
                  Icons.access_time,
                  false,
                  _faculty3controller,
                  Colors.blueAccent.withOpacity(0.3),
                  Colors.grey,
                  Colors.black87,
                  TextInputType.name),
              const SizedBox(
                height: 20,
              ),
              userinfotype(
                  "Subject for Third Batch",
                  Icons.access_time,
                  false,
                  _batch3controller,
                  Colors.blueAccent.withOpacity(0.3),
                  Colors.grey,
                  Colors.black87,
                  TextInputType.name),
              const SizedBox(
                height: 20,
              ),
              userinfotype(
                  "Lab for Third Batch",
                  Icons.access_time,
                  false,
                  _lab3controller,
                  Colors.blueAccent.withOpacity(0.3),
                  Colors.grey,
                  Colors.black87,
                  TextInputType.name),
              const SizedBox(
                height: 20,
              ),
              resetpassbutton(context, () {
                try {
                  if (_lab3controller.text.isNotEmpty &&
                      _batch1controller.text.isNotEmpty &&
                      _faculty3controller.text.isNotEmpty &&
                      formendTime.isNotEmpty&& formstartTime.isNotEmpty
                  ) {
                    storemessages
                        .collection("/Time_Table/Practicals/$dropdownvalue")
                        .doc(formstartTime +" to " + formendTime)
                        .set({
                      "isPractical":true,
                      "start_time": formstartTime,
                      "end_time": formendTime,
                      "FBlab": _lab1controller.text.trim(),
                      "FBfaculty": _faculty1controller.text.trim(),
                      "FBsubject": _batch1controller.text.trim(),
                      "SBlab": _lab2controller.text.trim(),
                      "SBfaculty": _faculty2controller.text.trim(),
                      "SBsubject": _batch2controller.text.trim(),
                      "TBlab": _lab3controller.text.trim(),
                      "TBfaculty": _faculty3controller.text.trim(),
                      "TBsubject": _batch3controller.text.trim(),
                    });
                    // _starttimecontroller.clear();
                    // _endtimecontroller.clear();
                    _lab1controller.clear();
                    _lab2controller.clear();
                    _lab3controller.clear();
                    _batch1controller.clear();
                    _batch2controller.clear();
                    _batch3controller.clear();
                    _faculty1controller.clear();
                    _faculty2controller.clear();
                    _faculty3controller.clear();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text(
                          "Record's added successfully"),
                    ));
                    // _controller.animateTo(_controller.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
                    // ShowNotification(),
                  }
                } catch (e) {
                  ErrorBox(context, "Something went wrong", "Error");
                }
              }, "Add Lecture"),
            ],
          ),
        ),
      ),
    );
  }


  void ErrorBox(context, e, title) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // dismiss dialog
                  },
                  child: const Text("Ok"))
            ],
            title: Text(title),
            content: Text(e.toString()),
          );
        });
  }
}
