
import 'package:asset_trissur_work_new/amc_notification_model.dart';
import 'package:asset_trissur_work_new/pending_list.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'login_page.dart';

class amc_notify extends StatefulWidget {

  const amc_notify({Key? key,}) : super(key: key);

  @override
  _amc_notifyState createState() => _amc_notifyState();
}

class _amc_notifyState extends State<amc_notify> {

  late DateTime _selectedDate ;
  String selected = "Accept";
  //TextEditingController pendingController = TextEditingController();
  static List<String> product_id = [
    'product_id','product_id','product_id',
    'product_id',
    'product_id','product_id','product_id','product_id','product_id','product_id',

  ];
  static List<String> pro_name= [
    'product name','product name',
    'product name','product name','product name',
    'product name','product name','product name','product name','product name'
  ];
  static List<String> department = [
    'department 1','department 2',
    'department 3','department 4','department 5',
    'department 6','department 7','department 8','department 9','department 10'];
  static List<String> amc_date = [
    'dd-mm-yyyy','dd-mm-yyyy',
    'dd-mm-yyyy','dd-mm-yyyy','dd-mm-yyyy',
    'dd-mm-yyyy','dd-mm-yyyy','dd-mm-yyyy','dd-mm-yyyy','dd-mm-yyyy',

  ];
  static List<String> supplier_name = [
    'supplier 1',
    'supplier 2','supplier 3','supplier 4',
    'supplier 5','supplier 6','supplier 7',
    'supplier 8','supplier 9','supplier 10',

  ];
  bool isSelected = false;
  final List<notify_model> notification_data= List.generate(
      amc_date.length, (index) => notify_model
    (
      '${amc_date[index]}',false,
      '${pro_name[index]}',
      '${product_id[index]}',
      '${department[index]}',
      '${supplier_name[index]}'));

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
        title:  Text(" Amc Notification",style: TextStyle(color: Colors.black),),
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
      body: ListView.separated(
        itemCount: notification_data.length,
          itemBuilder: (context,index){
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("description").
                  doc("LXRqfrRVQEzkQz0psTNk").snapshots(),

                  builder: (context ,AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }

                    final userDoc = snapshot.data;
                    return  Text(userDoc!["asset_id"],
                      style: TextStyle(color: Colors.black),);
                  }),//Text(notification_data[index].pro_id),
              title: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Row(
                  children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("description").
                        doc("LXRqfrRVQEzkQz0psTNk").snapshots(),

                        builder: (context ,AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }

                          final userDoc = snapshot.data;
                          return  Text(userDoc!["asset_name"],
                            style: TextStyle(color: Colors.black),);
                        }),
                   //Text(notification_data[index].pro_name),
                  ],
                ),
              ),
              subtitle: Column(
                children: [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("description").
                      doc("LXRqfrRVQEzkQz0psTNk").snapshots(),

                      builder: (context ,AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }

                        final userDoc = snapshot.data;
                        return  Text(userDoc!["department"],
                          style: TextStyle(color: Colors.black),);
                      }),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("description").
                      doc("LXRqfrRVQEzkQz0psTNk").snapshots(),

                      builder: (context ,AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }

                        final userDoc = snapshot.data;
                        return  Text(userDoc!["supplier_name"],
                          style: TextStyle(color: Colors.black),);
                      }),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("description").
                      doc("LXRqfrRVQEzkQz0psTNk").snapshots(),

                      builder: (context ,AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }

                        final userDoc = snapshot.data;
                        return  Text(userDoc!["amc_end_date"],
                          style: TextStyle(color: Colors.black),);
                      }),
                  // Text(notification_data[index].department),
                  // Text(notification_data[index].supplier_name),
                  // Text(notification_data[index].amc_date),

                ],
              ),
              trailing:  GestureDetector(
                onTap: () {
                  setState(() {
                    notification_data[index].isSelected=true;
                  });
                },

                child: Container(
                  height: 40,
                  width: 70,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                    //color: color == 'Complete' ? Colors.lightGreen: Colors.black26,
                    color: notification_data[index].isSelected? Colors.black26:Colors.lightGreen
                  ),
                  child: Center(child: Text("Complete",style: buildTextStyle(),)),
                ),
              ),
              isThreeLine: true,

            ),
          );
          }, separatorBuilder: (BuildContext context, int index) {
          return Divider();
          },),
    );

  }
}


