
import 'package:flutter/material.dart';

import 'login_page.dart';

class service_history extends StatefulWidget {
  final String descriptionTextController;
  const service_history({Key? key, required this.descriptionTextController}) : super(key: key);
  //const updattion({Key? key}) : super(key: key);

  @override
  _service_historyState createState() => _service_historyState();
}

class _service_historyState extends State<service_history> {
  @override
  int count = 0;

  @override
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
        title:  const Text("Service History",style: TextStyle(color: Colors.black),),
        actions: [
          GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
              },
              child: const Icon(Icons.logout_outlined,color: Colors.black,)),
          const SizedBox(width: 10,),

          //Icons.notification_important,

          //Center(child: Text("Logout  ",style: TextStyle(color: Color(0xFF468c90),fontSize: 20)))
        ],



      ),
      body: SafeArea(child: ListView.separated(
        itemBuilder: (ctx,index){
          const SizedBox(height:20);
          return  const ListTile(
            leading: Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text("12-12-2021"),
            ),
            title: Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text("Service Message",style: TextStyle(color: Colors.black),),
            ),


          );
        },
        separatorBuilder: (ctx,index){
          return const Divider();
        },
        itemCount: 3,
      ),


      ),
    );

  }
}
