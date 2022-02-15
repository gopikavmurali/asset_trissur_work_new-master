
import 'dart:io';

import 'package:asset_trissur_work_new/amc_notification.dart';
import 'package:asset_trissur_work_new/button_widget.dart';
import 'package:asset_trissur_work_new/constants.dart';
import 'package:asset_trissur_work_new/create_page_head.dart';
import 'package:asset_trissur_work_new/login_page.dart';
import 'package:asset_trissur_work_new/notification_screen.dart';
import 'package:asset_trissur_work_new/report.dart';
import 'package:asset_trissur_work_new/complaints.dart';
import 'package:asset_trissur_work_new/updation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'descriptiion_page.dart';
import 'create_page_master.dart';
import 'history.dart';



class asset_master_home extends StatefulWidget {
  final String user_name;
  final String selectedPrivi;
   const asset_master_home({Key? key, required this.user_name, required this.selectedPrivi}) : super(key: key);


  @override
  _asset_master_homeState createState() => _asset_master_homeState();
}

class _asset_master_homeState extends State<asset_master_home> {
  String qrCode = 'Scanned Result';
  final descriptionController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController moveController = TextEditingController();
  TextEditingController assetController = TextEditingController();
  final List<String> backtostock = ["Back To Stock","Department 1","Department 2","Department 3"];
  String selectedstock = "Back To Stock";
  final List<String> outside = ["Move To Outside","Centre 1","Centre 2","Centre 3"];
  String selectedcentre = "Move To Outside";





  @override
  Widget build(BuildContext context) {
    var text;
    return WillPopScope(

      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
              onTap: (){
                //Navigator.pop(context);

                //Navigator.push(context, MaterialPageRoute(builder: (context)=>admin_user(user_name: '',)));
              },
              child: const Icon(Icons.perm_identity,color: Colors.black,)),
          title:  Text("${widget.user_name}",style: TextStyle(color: Colors.black),),
            actions: [
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>amc_notify()));

                  },
                  child: Icon(Icons.notification_important_outlined,color: Colors.black,)),
              SizedBox(width: 10,),
               GestureDetector(
                   onTap: (){
                     Navigator.push(context, MaterialPageRoute(
                         builder: (context)=>notification(complaintController:"")));
                   },
                   child: Icon(Icons.notification_important_outlined,color: Colors.black,)),
              SizedBox(width: 10,),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
                  },
                  child: Icon(Icons.logout_outlined,color: Colors.black,)),
              SizedBox(width: 010,),
            ]


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




                    //scan qr
                    Padding(
                      padding: const EdgeInsets.only(top:30.0,left: 50,right: 50),
                      child:
                      GestureDetector(
                        onTap: scanQRCode,

                        child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width*2,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                                borderRadius: BorderRadius.circular(10),color: Color(0xFF5663ff)),


                            child: Center(child: Text("Scan QR Code",style:buildTextStyle()))
                        ),
                      ),

                    ),
                    //or
                    Padding(
                      padding: EdgeInsets.only(top:80.0,left: 200),
                      child: Text("OR",style: TextStyle(color: Colors.black),),
                    ),
                    //asset id
                    Padding(
                      padding: const EdgeInsets.only(top:100.0,left: 50,right: 50),
                      child:
                      Container(
                        height: 40,
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
                          controller: nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Asset Id",
                          ),
                        ),
                      ),
                    ),
                    //scanned result
                    Padding(
                      padding: const EdgeInsets.only(top:160.0,left: 50,right: 50),
                      child:
                      Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width*2,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(05),
                              border: Border.all(color: Colors.black26,)
                          ),


                          child: Center(child: Text(qrCode))
                      ),
                    ),
                    //move to outside
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50,220,50,10),
                      child: Container(
                        width: MediaQuery.of(context).size.width*2,
                        height: 40,
                        decoration: BoxDecoration(borderRadius:BorderRadius.circular(05),
                            border:Border.all(color: Colors.black45)),
                        child:   DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            // isDense: true,
                            // isExpanded: false,
                            elevation: 10,
                            iconEnabledColor: Colors.black,
                            value: selectedcentre,
                            onChanged: (value)
                            {
                              setState(() {
                                selectedcentre = value!;
                              });
                            },

                            items: outside.map<DropdownMenuItem<String>>((value){
                              return DropdownMenuItem(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
                                  child: Text(value,style: TextStyle(color:Colors.black45 ),),
                                ),
                                value: value,
                              );
                            }
                            ).toList(),
                          ),
                        ),
                      ),
                    ),

                    // ->
                    // Padding(
                    //   padding: const EdgeInsets.only(top:220.0,left: 280),
                    //   child:
                    //   GestureDetector(
                    //     //onTap: scanQRCode,
                    //
                    //     child: Container(
                    //         height: 40,
                    //         width: 40,
                    //         decoration: BoxDecoration(
                    //             gradient: const LinearGradient(
                    //               begin: Alignment.topLeft,
                    //               end: Alignment.bottomRight,
                    //               colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),
                    //
                    //             borderRadius: BorderRadius.circular(10),color: Color(0xFF5663ff)),
                    //
                    //
                    //         child: Center(child: Text("➞",style:buildTextStyle()))
                    //     ),
                    //   ),
                    //
                    // ),
                     //back to stock
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50,275,50,10),
                      child: Container(
                        width: MediaQuery.of(context).size.width*2,
                        height: 40,
                        decoration: BoxDecoration(borderRadius:BorderRadius.circular(05),
                            border:Border.all(color: Colors.black45)),
                        child:   DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            // isDense: true,
                            // isExpanded: false,
                            elevation: 10,
                            iconEnabledColor: Colors.black,
                            value: selectedstock,
                            onChanged: (value)
                            {
                              setState(() {
                                selectedstock = value!;
                              });
                            },

                            items: backtostock.map<DropdownMenuItem<String>>((value){
                              return DropdownMenuItem(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
                                  child: Text(value,style: TextStyle(color:Colors.black45 ),),
                                ),
                                value: value,
                              );
                            }
                            ).toList(),
                          ),
                        ),
                      ),
                    ),
                          //history
                    Padding(
                      padding: const EdgeInsets.only(top:330.0,left: 50,right: 50),
                      child:
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>history()));
                        },
                        child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width*2,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                                borderRadius: BorderRadius.circular(10),color: Color(0xFF5663ff)),


                            child: Center(
                                child:
                                //Text(qrCode.toString())
                                Text("History",style:buildTextStyle())
                            )
                        ),
                      ),
                    ),
                    //create
                    Padding(
                      padding: const EdgeInsets.only(top:385.0,left: 50,right: 50),
                      child:
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>create_page()));
                          // if (widget.selectedPrivi =="AssetMaster")
                          // {
                          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>create_page()));
                          // }
                          // else if (widget.selectedPrivi == "AssetHead")
                          // {
                          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>create_page_head()));
                          // }

                        },
                        child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width*2,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                                borderRadius: BorderRadius.circular(10),color: Color(0xFF5663ff)),


                            child: Center(child: Text("Create",style:buildTextStyle()))
                        ),
                      ),
                    ),
                    //Complaints
                    Padding(
                      padding: const EdgeInsets.only(top:475,left: 50,right: 50),
                      child: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width*2,
                        decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                        child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            //labelText: "Update Notes"
                          ),
                          maxLines: 90,
                          controller: descriptionController,
                        ),
                      ),
                    ),
                    //updte notes
                    Padding(
                      padding: const EdgeInsets.only(top:440.0,left: 50,right: 50),
                      child: Text("Update Notes",style: headingText(),),
                    ),
                    //update
                    Padding(
                      padding: const EdgeInsets.only(top:700.0,left: 50,right: 50),
                      child:
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>updation(descriptionController: descriptionController.text,)));
                        },
                        child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width*2,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                              borderRadius: BorderRadius.circular(10),color: Color(0xFF5663ff),),
                            child: Center(child: Text("Update",style:buildTextStyle()))
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
