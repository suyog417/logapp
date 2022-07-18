import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logapp/widgets/widgets_lib.dart';

class TimeTableInput extends StatefulWidget {
  const TimeTableInput({Key? key}) : super(key: key);

  @override
  State<TimeTableInput> createState() => _TimeTableInputState();
}

class _TimeTableInputState extends State<TimeTableInput> {
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
  final TextEditingController _subjectcontroller = TextEditingController();
  final TextEditingController _facultynamecontroller = TextEditingController();
  final TextEditingController _starttimecontroller = TextEditingController();
  final TextEditingController _endtimecontroller = TextEditingController();
  final TextEditingController _classroomcontroller = TextEditingController();

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
          "Add Lecture",
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
              // const CategorySelector(),
              // SizedBox(height: 20,),
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
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.blueAccent.withOpacity(0.4)),
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                          ),
                          onPressed: () {
                            _startTime(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(Icons.timer),
                              Text("Start Time    "),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.blueAccent.withOpacity(0.4)),
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                          ),
                          onPressed: () {
                            _endTime(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(Icons.timer),
                              Text("End Time    "),
                            ],
                          )),
                    )
                  ],
                ),
              ),
              userinfotype(
                  "Subject",
                  Icons.calendar_view_day,
                  false,
                  _subjectcontroller,
                  Colors.blueAccent.withOpacity(0.3),
                  Colors.grey,
                  Colors.black87,
                  TextInputType.name),
              const SizedBox(
                height: 20,
              ),
              userinfotype(
                  "Faculty Name",
                  Icons.person,
                  false,
                  _facultynamecontroller,
                  Colors.blueAccent.withOpacity(0.3),
                  Colors.grey,
                  Colors.black87,
                  TextInputType.name),
              // SizedBox(
              //   height: 20,
              // ),
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
              const SizedBox(
                height: 20,
              ),
              userinfotype(
                  "Classroom",
                  Icons.home_outlined,
                  false,
                  _classroomcontroller,
                  Colors.blueAccent.withOpacity(0.3),
                  Colors.grey,
                  Colors.black87,
                  TextInputType.name),
              const SizedBox(
                height: 20,
              ),
              resetpassbutton(context, () {
                try {
                  if (_subjectcontroller.text.isNotEmpty &&
                      _classroomcontroller.text.isNotEmpty &&
                      _facultynamecontroller.text.isNotEmpty &&
                      formendTime.isNotEmpty &&
                      formstartTime.isNotEmpty) {
                    storemessages
                        .collection("/Time_Table/Lectures/$dropdownvalue")
                        .doc(formstartTime +" to " + formendTime)
                        .set({
                      "classroom": _classroomcontroller.text.trim(),
                      "end_time": formendTime,
                      "start_time": formstartTime,
                      "teacher_name": _facultynamecontroller.text.trim(),
                      "subject": _subjectcontroller.text.trim(),
                    });
                    _classroomcontroller.clear();
                    _subjectcontroller.clear();
                    _facultynamecontroller.clear();
                    // _starttimecontroller.clear();
                    // _endtimecontroller.clear();
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
