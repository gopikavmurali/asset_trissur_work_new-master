import 'package:asset_trissur_work_new/user_home.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'login_page.dart';

class updation extends StatefulWidget {
  final String descriptionController;
  const updation({Key? key,
    required this.descriptionController}) : super(key: key);

  @override
  _updationState createState() => _updationState();
}

class _updationState extends State<updation> {
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
          title:  Text("Updations Screen",style: TextStyle(color: Colors.black),),
          actions: [
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
                },
                child: Icon(Icons.logout_outlined,color: Colors.black,)),
            SizedBox(width: 05,),




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
              child: Text("${widget.descriptionController}",style: TextStyle(color: Colors.black),),
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
