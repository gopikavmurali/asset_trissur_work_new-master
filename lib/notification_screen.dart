import 'package:asset_trissur_work_new/pending_list.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';
import 'login_page.dart';




class notification extends StatefulWidget {
   final String complaintController;
  const notification({Key? key, required this.complaintController}) : super(key: key);
  @override
  _notificationState createState() => _notificationState();
}

class _notificationState extends State<notification> {
  TextEditingController pendingController = TextEditingController();
  String selected = "Accept";
  String color = "Complete";
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now().add(Duration(days: 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_outlined,color: Colors.black,)),
        title:  Text("Notification",style: TextStyle(color: Colors.black),),
        actions: [
          GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
              },
              child: Icon(Icons.logout_outlined,color: Colors.black,)),
          SizedBox(width: 05,),
        ],

      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.all(20),
          //   child: Text(
          //     'Notification ',
          //     style: Theme.of(context).textTheme.headline6!.copyWith(color: Color(0xFF468c90),fontSize: 25),
          //   ),
          // ),
          SizedBox(height: 20),
          CalendarTimeline(
            showYears: true,
            initialDate: _selectedDate,
            firstDate: DateTime.now().subtract(Duration(days: 730)),
            lastDate: DateTime.now().add(Duration(days: 730)),
            onDateSelected: (date) {
              setState(() {
                _selectedDate = date!;
              });
            },
            leftMargin: 20,
            monthColor: Color(0xFF468c90),
            dayColor: Color(0xFF468c97),
            dayNameColor: Color(0xFF333A47),//Color(0xFF333A47),
            activeDayColor: Color(0xFF333A47),
            activeBackgroundDayColor: Color(0xFFe0f4f5),
            dotsColor: Color(0xFF333A47),
            //selectableDayPredicate: (date) => date.day != 23,
            //locale: 'en',
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: TextButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFF468c90))),
              child: Text('RESET', style: TextStyle(color: Colors.white)),
              onPressed: () => setState(() => _resetSelectedDate()),
            ),
          ),
          //SizedBox(height: 20),
          Divider(
            thickness: 3,
            color: Colors.black12,
          ),
         Expanded(

           child: Container(
            // height: //MediaQuery.of(context).size.height/2,
             width: MediaQuery.of(context).size.width,
             color: Colors.white,
             child: ListView.separated(itemBuilder: (ctx,index){
               return ListTile(
                 leading: Icon(Icons.notification_important_outlined),
                 title: Container(
                   child: Column(
                     children: [
                       Row(
                         children: [
                           Text("Department"),
                           SizedBox(width: 20,),
                           Text("Item Name"),
                         ],
                       ),
                       SizedBox(height: 30,),
                       Row(
                         children: [

                           Container(
                             height: 60,
                             width: 100,
                             child: Text("Not working due to technical issues")
                             //Text("${widget.complaintController}"),
                           )
                         ],
                       )
                     ],
                   ),
                 ),
                 minVerticalPadding: 10,
                 subtitle: Padding(
                   padding: const EdgeInsets.only(top:20),
                   child: Flex(
                     //crossAxisAlignment: CrossAxisAlignment.start,
                     direction: Axis.horizontal,
                     children: [
                       SizedBox(height: 20,),
                       GestureDetector(
                           onTap: () {
                             setState(() {
                               selected = 'Accepted';
                             });
                           },
                           child:
                           Container(
                               height: 40,
                               width: 60,
                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                 color: selected == 'Accept' ? Color(0xFF468c90): Colors.lightGreen,
                               ),
                               child: Center(
                                   child: Text("Accept",style  : buildTextStyle(),)
                               )
                           )
                       ),
                       SizedBox(width: 2,),
                       GestureDetector(
                           onTap: (){
                             showDialog(context: context,
                                 builder:(ctx) =>  AlertDialog(
                                   title: Text("Enter reason for pending"),

                                  content: TextField(
                                    maxLines: 3,
                                    controller: pendingController,
                                    decoration: InputDecoration(
                                    border: OutlineInputBorder(),)),
                                   actions: [
                                     Center(
                                         child:
                                         FlatButton(
                                           onPressed: () {
                                             Navigator.push(context,
                                                 MaterialPageRoute(builder: (context)=>pending_list(pendingController: pendingController.text,)));
                                           },
                                           child: Text("Add ",style: const TextStyle(fontSize: 20,
                                           color: Colors.green,fontWeight: FontWeight.w900)),
                                         )),



                                   ],

                                 ));
                           },
                           child:
                           ContainerPending(
                                 height: 40,
                                 width: 62,
                                 decoration: BoxDecoration(),
                                 child: Text("")),
                           ),
                       SizedBox(width: 2,),
                   GestureDetector(
                     onTap: () {
                       setState(() {
                         color = 'Completed';
                       });
                     },

                     child: Container(
                       height: 40,
                       width: 80,
                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                         color: color == 'Complete' ? Colors.lightGreen: Colors.black26,),
                       child: Center(child: Text("Complete",style: buildTextStyle(),)),
                     ),
                   )
                     ],

                   ),
                 ),
                 trailing: Text("12.00 am"),

               );
             },
                 separatorBuilder: (ctx,index){
                 return Divider();
                  },
                 itemCount: 10),
           ),
         )

         // Center(child: Text('Selected date is $_selectedDate', style: TextStyle(color: Colors.black)))
        ],
      ),
    );
  }
}