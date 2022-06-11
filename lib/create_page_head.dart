
import 'package:flutter/material.dart';

import 'descriptiion_page.dart';
import 'constants.dart';
import 'create_item.dart';
import 'login_page.dart';

class create_page_head extends StatefulWidget {
  const create_page_head({Key? key}) : super(key: key);

  @override
  _create_page_headState createState() => _create_page_headState();
}

class _create_page_headState extends State<create_page_head> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);

              },
              child: const Icon(Icons.arrow_back_outlined,color: Colors.black,)),
          backgroundColor: Colors.white,
          elevation: 0,

          title: const Text("Create Page",style: TextStyle(color: Colors.black,fontSize: 25),),
          actions: [
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
                },
                child: const Icon(Icons.logout_outlined,color: Colors.black,)),
            const SizedBox(width: 10,),

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
                            decoration: const BoxDecoration(color: Colors.white),
                            //child: Text(qrCode)
                          )
                      ),

                    ),

                    const SizedBox(height: 20,),
                    //create asset head

                    //create servie centre

                    //create departments

                    //create items
                    Padding(
                      padding: const EdgeInsets.only(top:220.0,left: 100),
                      child:
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>create_item()));
                        },
                        child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                              borderRadius: BorderRadius.circular(10),color: const Color(0xFF5663ff),),


                            child: Center(child: Text("Create Items",style:buildTextStyle()))
                        ),
                      ),
                    ),
                    //create user
                    // Padding(
                    //   padding: const EdgeInsets.only(top:400.0,left: 100),
                    //   child:
                    //   GestureDetector(
                    //     onTap: (){
                    //       Navigator.push(context, MaterialPageRoute(builder: (context)=>create_user(user_name: '',)));
                    //     },
                    //     child: Container(
                    //         height: 50,
                    //         width: 200,
                    //         decoration: BoxDecoration(
                    //           gradient: const LinearGradient(
                    //             begin: Alignment.topLeft,
                    //             end: Alignment.bottomRight,
                    //             colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),
                    //
                    //           borderRadius: BorderRadius.circular(10),color: Color(0xFF5663ff),),
                    //
                    //
                    //         child: Center(child: Text("Create User",style:buildTextStyle()))
                    //     ),
                    //   ),
                    // ),
                    //crete institution
                    //description
                    Padding(
                      padding: const EdgeInsets.only(top:300.0,left: 100),
                      child:
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const admin_log_2()));
                        },
                        child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                              borderRadius: BorderRadius.circular(10),color: const Color(0xFF5663ff),),


                            child: Center(child: Text("Description Page",style:buildTextStyle()))
                        ),
                      ),
                    ),
                  ],
                ),
              ) )],
          ),
        ),
      ),
    );
  }
}

