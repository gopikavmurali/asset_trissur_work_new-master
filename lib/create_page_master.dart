import 'dart:io';
import 'package:asset_trissur_work_new/descriptiion_page.dart';
import 'package:asset_trissur_work_new/button_widget.dart';
import 'package:asset_trissur_work_new/constants.dart';
import 'package:asset_trissur_work_new/create_asset_head.dart';
import 'package:asset_trissur_work_new/create_dept.dart';
import 'package:asset_trissur_work_new/create_institution.dart';
import 'package:asset_trissur_work_new/create_item.dart';
import 'package:asset_trissur_work_new/create_user.dart';
import 'package:asset_trissur_work_new/report.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'create_service_center.dart';
import 'login_page.dart';



class create_page extends StatefulWidget {
  // const user_log({Key? key}) : super(key: key);


  @override
  _create_pageState createState() => _create_pageState();
}

class _create_pageState extends State<create_page> {
  String qrCode = 'Unknown';
  final descriptionTextController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController assetController = TextEditingController();


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
                   //leading: const Icon(Icons.person,color: Colors.black,),
          title: Text("Create Page",style: TextStyle(color: Colors.black,fontSize: 25),),
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
                    //create asset head
                    Padding(
                      padding: const EdgeInsets.only(top:100.0,left: 100),
                      child:
                      GestureDetector(
                        onTap: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>asset_head()));
                        },
                        child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                              borderRadius: BorderRadius.circular(10),color: Color(0xFF5663ff),),


                            child: Center(child: Text("Create Asset Head",style:buildTextStyle()))
                        ),
                      ),
                    ),
                    //create servie centre
                    Padding(
                      padding: const EdgeInsets.only(top:280.0,left: 100),
                      child:
                      GestureDetector(
                        onTap: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>create_service()));
                        },
                        child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                              borderRadius: BorderRadius.circular(10),color: Color(0xFF5663ff),),


                            child: Center(child: Text("Create Service Centre",style:buildTextStyle()))
                        ),
                      ),
                    ),
                    //create departments
                    Padding(
                      padding: const EdgeInsets.only(top:160.0,left: 100),
                      child:
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>create_dep()));
                        },
                        child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                              borderRadius: BorderRadius.circular(10),color: Color(0xFF5663ff),),


                            child: Center(child: Text("Create Departments",style:buildTextStyle()))
                        ),
                      ),
                    ),
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

                              borderRadius: BorderRadius.circular(10),color: Color(0xFF5663ff),),


                            child: Center(child: Text("Create Items",style:buildTextStyle()))
                        ),
                      ),
                    ),
                    //create user
                    Padding(
                      padding: const EdgeInsets.only(top:340.0,left: 100),
                      child:
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>create_user(user_name: '',)));
                        },
                        child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                              borderRadius: BorderRadius.circular(10),color: Color(0xFF5663ff),),


                            child: Center(child: Text("Create User",style:buildTextStyle()))
                        ),
                      ),
                    ),
                        //create description
                    Padding(
                      padding: const EdgeInsets.only(top:400.0,left: 100),
                      child:
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>admin_log_2()));
                        },
                        child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                              borderRadius: BorderRadius.circular(10),color: Color(0xFF5663ff),),


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
  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }


}
