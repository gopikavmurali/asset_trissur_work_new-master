
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import'package:flutter/material.dart';
import 'package:asset_trissur_work_new/constants.dart';
import 'package:flutter/cupertino.dart';

import 'login_page.dart';
class create_dep extends StatefulWidget {
  // const user_log({Key? key}) : super(key: key);
  @override
  _create_depState createState() => _create_depState();
}

class _create_depState extends State<create_dep> {


  int index =0;
  var department;

  TextEditingController depController = TextEditingController();

  // void adddepartments() async{
  //
  //  await  FirebaseFirestore.instance.collection("departments").add({
  //     "values": depController.text,
  //   });


  void adddepartments(){
    FirebaseFirestore.instance.collection("departments").add({
      "values": depController.text,
    });
  }
  void cleartext(){
    depController.clear();
  }


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
        //leading: const Icon(Icons.person,color: Colors.black,),
        title: Text("Create Department",style: TextStyle(color: Colors.black,fontSize: 25),),
        actions: [
          GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
              },
              child: Icon(Icons.logout_outlined,color: Colors.black,)),
          SizedBox(width: 10,),

        ],



      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form
              (child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors:  [Colors.white,Colors.white,],),
                borderRadius:BorderRadius.circular(10),color: Colors.white,),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Opacity(
                        opacity: 0.7,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.white),
                          //child: Text(qrCode)
                        )
                    ),

                  ),


                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(top:70.0,left: 40),
                    child: Text("Department",style: buildFontlink(),),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:100.0,left: 40,right: 40),
                    child:
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width*2,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors:[ Colors.white,Colors.white]

                            //colors: [Color(0xFF64C9CF), Color(0xFF468c90),],
                          ),

                          borderRadius: BorderRadius.circular(10),color: Color(0xFF5663ff)),


                      child: TextField(
                        controller: depController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                         // labelText: '',
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:180.0,left: 120),
                    child: GestureDetector(
                       onTap: (){
                         adddepartments();
                         cleartext();
                      setState(() {
                        department = depController.text;
                        index++;
                      });
                       },
                      child: Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF64C9CF),  Color(0xFF468c90),],),

                              borderRadius: BorderRadius.circular(5),color: Color(0xFF5663ff)),
                          child: Center(child: Text("Add",style:buildTextStyle()))

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 300,left: 40),
                    child: Text("List of Departments",style: buildFontlink(),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 350,left: 20),
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("departments").snapshots(),
                        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot)
                        {
                          if (!snapshot.hasData)
                          {
                            return CircularProgressIndicator();
                          }
                          else
                          {

                            return  Expanded(
                              child: ListView(
                                children: snapshot.data!.docs.map((document) {
                                  final dynamic data = document.data();
                                  return Dismissible(
                                    key: Key(document.id),
                                    onDismissed: (direction){
                                      //onDelete(document.id);
                                    },
                                    background: Container(
                                      color: Colors.red,
                                      child: Icon(Icons.delete),
                                    ),
                                    child: ListTile(
                                      title: Text(data["values"].toString()),
                                      leading:Icon(Icons.arrow_right)
                                    ),
                                  );
                                }).toList(),

                              ),
                            );
                          }
                        }

                    ),
                  )
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 350.0,left: 40,right: 40),
                  //   child: Container(
                  //     height: 100,
                  //     width: MediaQuery.of(context).size.width*2,
                  //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                  //         border: Border.all(color: Colors.black45)),
                  //     child:
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 8.0,left: 8),
                  //       child: Text("$index. $department",style: headingText(),),
                  //     ),
                  //   ),
                  // )

                ],
              ),
            ) )],
        ),
      ),
    );
  }
}


