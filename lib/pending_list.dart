
import 'package:asset_trissur_work_new/pending_model.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'login_page.dart';

class pending_list extends StatefulWidget {

  final pendingController;

   pending_list({Key? key, this.pendingController}) : super(key: key);

  @override
  _pending_listState createState() => _pending_listState();
}

class _pending_listState extends State<pending_list> {
  static List<String> item_name= [
    'item name1','item name2',
    'item name3','item name4','item name5',
    'item name6','item name7','item name8','item name9','item name10'
  ];

  static List<String> department = [
    'department 1','department 2',
    'department 3','department 4','department 5',
    'department 6','department 7','department 8','department 9','department 10'];

  final List<pending_model> notification_data= List.generate(
      item_name.length, (index) => pending_model(
    false,
    '${item_name[index]}',
    '${department[index]}',

  ));


  bool isSelected = false;
  String done = "Done";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_outlined,color: Colors.black,)),
        title:  Text("Pending List",style: TextStyle(color: Colors.black),),
        actions: [
          GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
              },
              child: Icon(Icons.logout_outlined,color: Colors.black,)),
                SizedBox(width: 05,),
          //Icons.notification_important,

        ],
      ),

      body: SafeArea(child: ListView.separated(
                  itemBuilder: (ctx,index){
               SizedBox(height:20);


                return  ListTile(
                 leading: Padding(
                   padding: const EdgeInsets.only(top: 20.0),
                  child: Text(notification_data[index].department),
                  ),
                  title: Padding(
                   padding: const EdgeInsets.only(top: 30.0),
                  child:
                  Text(notification_data[index].item_name),
                  //Text("Item Name",style: TextStyle(color: Colors.black),),
                    ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text("${widget.pendingController}",style: TextStyle(color: Colors.black26,fontSize: 20),),
                      ),
                  trailing: GestureDetector(
                    onTap: (){
                      setState(() {
                        notification_data[index].isSelected=true;
                      });
                    },
                    child: Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(05),
                          //color: pending_list[index].active_color? Colors.black26:Colors.lightGreen
                          color: notification_data[index].isSelected?
                          Colors.black26:Colors.lightGreen
                      ),
                      child: Center(child: Text("Done",style: buildTextStyle(),)),
                    ),
                  )
                );
               },
                separatorBuilder: (ctx,index){
              return Divider();
             },
               itemCount:item_name.length,
    ),
    ));
  }
}
