import 'package:flutter/material.dart';
import 'package:logapp/widgets/widgets_lib.dart';

class AddExamTimeTable extends StatefulWidget {
  const AddExamTimeTable({Key? key}) : super(key: key);

  @override
  State<AddExamTimeTable> createState() => _AddExamTimeTableState();
}

class _AddExamTimeTableState extends State<AddExamTimeTable> {
  final TextEditingController _daycontroller = TextEditingController();
  final TextEditingController _batch1controller = TextEditingController();
  final TextEditingController _facultynamecontroller = TextEditingController();
  // TextEditingController _daycontroller = new TextEditingController();
  // TextEditingController _daycontroller = new TextEditingController();
  // TextEditingController _daycontroller = new TextEditingController();
  String defvalue = "Lecture";
  var options = ["Lecture","Practical"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text("Time Table"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height*0.2, 20, 0),
        child: Column(
          children: [
            reusabletextfield("Enter day", Icons.calendar_view_day, false, _daycontroller, Colors.blueAccent.withOpacity(0.3), Colors.grey, Colors.black87),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Row(
                  children: [
                    const Icon(Icons.access_time),
                    ElevatedButton(onPressed:(){},child: const Text("Start Time"),
                    ),
                  ],
                ),
                ),
                Expanded(child: Row(
                  children: [
                    const Icon(Icons.access_time),
                    ElevatedButton(onPressed:(){},child: const Text("Start Time"),),
                  ],
                )),
              ],
            ),
            reusabletextfield("Enter Faculty Name", Icons.person, false, _facultynamecontroller, Colors.blueAccent.withOpacity(0.3), Colors.grey, Colors.black87),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.orange,),
              width: MediaQuery.of(context).size.width,
              child: DropdownButton(
                // Initial Value
                value: defvalue,
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),
                // Array list of items
                items: options.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    defvalue = newValue!;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
