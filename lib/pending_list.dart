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
  final List<String> pending_list =["hello","ok bye","how r u"];
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
                  child: Text("Department"),
                  ),
                  title: Padding(
                   padding: const EdgeInsets.only(top: 30.0),
                  child:
                  Text("Item Name",style: TextStyle(color: Colors.black),),
                    ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text("${widget.pendingController}",style: TextStyle(color: Colors.black26,fontSize: 20),),
                      ),
                  trailing: GestureDetector(
                    onTap: (){
                      setState(() {
                       // pending_list[index].active_color =true;
                        done = "donee";
                      });
                    },
                    child: Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(05),
                          //color: pending_list[index].active_color? Colors.black26:Colors.lightGreen
                        color: done == 'Done' ? Colors.lightGreen: Colors.black26,
                      ),
                      child: Center(child: Text("Done",style: buildTextStyle(),)),
                    ),
                  )
                );
               },
                separatorBuilder: (ctx,index){
              return Divider();
             },
               itemCount:3,
    ),
    ));
  }
}

//
// color: _allDevices[index].isSelected
// ? Colors.green
//     : Colors.blue,
// onPressed: () {
// setState(() {
// if (_allDevices[index].isSelected) {
// _allDevices[index].isSelected = false;
// } else{
// _allDevices[index].isSelected = true;
// }
// });
// },
