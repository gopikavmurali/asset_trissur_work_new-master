import 'package:asset_trissur_work_new/user_home.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'login_page.dart';

class complaints extends StatefulWidget {
  final String descriptionTextController;
  final String descriptionController;
  const complaints({Key? key, required this.descriptionTextController,
    required this.descriptionController}) : super(key: key);
  //const updattion({Key? key}) : super(key: key);

  @override
  _complaintsState createState() => _complaintsState();
}

class _complaintsState extends State<complaints> {
  @override
   int count = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);

            //Navigator.push(context, MaterialPageRoute(builder: (context)=>admin_user(user_name: '',)));
          },
            child: const Icon(Icons.arrow_back_outlined,color: Colors.black,)),
        title:  Text("Complaints",style: TextStyle(color: Colors.black),),
          actions: [
          GestureDetector(
          onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
              },
           child: Icon(Icons.logout_outlined,color: Colors.black,)),
          SizedBox(width: 10,),




    ]),
     body: SafeArea(child: ListView.separated(
       itemBuilder: (ctx,index){
         SizedBox(height:20);
         return  ListTile(
           leading: Padding(
             padding: const EdgeInsets.only(top: 20.0),
             child: Text("12-12-2021"),
           ),
           title: Padding(
             padding: const EdgeInsets.only(top: 20.0),
             child: Text("${widget.descriptionTextController}"
                 "${widget.descriptionController}",style: TextStyle(color: Colors.black),),
           ),

         );
       },
       separatorBuilder: (ctx,index){
         return Divider();
       },
       itemCount: 3,
     ),


     ),
    );

  }
}
