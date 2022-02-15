import 'dart:io';

import'package:flutter/material.dart';
import 'package:asset_trissur_work_new/constants.dart';
import 'package:flutter/cupertino.dart';

import 'login_page.dart';
class create_item extends StatefulWidget {
  // const user_log({Key? key}) : super(key: key);
  @override
  _create_itemState createState() => _create_itemState();
}

class _create_itemState extends State<create_item> {

  TextEditingController itemController = TextEditingController();
  var item ;
  int index =0;



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
        //leading: const Icon(Icons.person,color: Colors.black,),
        title: Text("Create Item",style: TextStyle(color: Colors.black,fontSize: 25),),
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
                    child: Text("Item Name",style: buildFontlink(),),
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
                        controller: itemController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:180.0,left: 120),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          item =itemController.text;
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
                    child: Text("List of Items",style: buildFontlink(),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 350.0,left: 40,right: 40),
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width*2,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black45)),
                      child:
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0,left: 8),
                        child: Text("$index. $item",style: headingText(),),
                      ),
                    ),
                  )

                ],
              ),
            ) )],
        ),
      ),
    );
  }
}
