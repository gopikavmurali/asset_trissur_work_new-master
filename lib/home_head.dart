

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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'defect_reason.dart';
import 'descriptiion_page.dart';
import 'create_page_master.dart';
import 'history.dart';
import 'image_picker_two.dart';



class asset_head_home extends StatefulWidget {
  final String user_name;
  final String selectedPrivi;
  const asset_head_home({Key? key, required this.user_name, required this.selectedPrivi}) : super(key: key);


  @override
  _asset_head_homeState createState() => _asset_head_homeState();
}

class _asset_head_homeState extends State<asset_head_home> {
  String qrCode = 'Scanned Result';
  final descriptionController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController moveController = TextEditingController();
  TextEditingController assetController = TextEditingController();
  final List<String> backtostock = ["Back To Stock","Department 1","Department 2","Department 3"];
  String selectedstock = "Back To Stock";
  final List<String> outside = ["Move To Outside","Centre 1","Centre 2","Centre 3"];
  String selectedcentre = "Move To Outside";
  final List<String> department = ["Department","Dept 1","Dept  2","Dept 3"];
  String selecteddept = "Department";

  List<Exercise> reasons= [
    Exercise(name: 'Defective Product'),
    Exercise(name: 'Expired'),
    Exercise(name: 'Change in Requirement'),
  ];

  void addupdations() {
    FirebaseFirestore.instance.collection("masterupdation").add({
      "values": descriptionController.text,
      "date": DateTime.now()
    });

  }




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


                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>admin_user(user_name: '',)));
                },
                child: const Icon(Icons.perm_identity,color: Colors.black,)),
            title:  Text("${widget.user_name}",style: TextStyle(color: Colors.black),),
            actions: [

              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>notification(complaintController:"")));
                  },
                  child: Icon(Icons.notification_important_outlined,color: Colors.black,)),
              SizedBox(width: 10,),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>amc_notify()));
                  },
                  child: Icon(Icons.notification_important,color: Colors.black,)),
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
                (
                  child: Container(
               // height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors:  [Colors.white,Colors.white,],),
                  borderRadius:BorderRadius.circular(10),color: Colors.white,),
                child:
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Opacity(
                          opacity: 0.7,
                          child: Column(
                            children: [
                              //scan qr
                              Padding(
                                padding: const EdgeInsets.only(left:30,bottom:15,right: 30,top: 30),
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
                                padding: EdgeInsets.only(left:30,bottom:15,right: 30,),
                                child: Text("OR",style: TextStyle(color: Colors.black),),
                              ),
                              //asset id
                              Padding(
                                padding: EdgeInsets.only(left:30,bottom:15,right: 30,),
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
                                padding: EdgeInsets.only(left:30,bottom:15,right: 30,),
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
                              //create
                              Padding(
                                padding: EdgeInsets.only(left:30,bottom:15,right: 30,),
                                child:
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>create_page_head()));
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
                              //history
                              Padding(
                                padding: EdgeInsets.only(left:30,bottom:15,right: 30,),
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
                              //reallocation
                              Padding(
                                padding: EdgeInsets.only(left:30,bottom:15,right: 30,),
                                child: GestureDetector(
                                  onTap: (){
                                    reallocation_alert_box();
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


                                      child: Center(child: Text("Realloction",style:buildTextStyle()))
                                  ),
                                ),
                              ),
                              //dispose
                              Padding(
                                padding: EdgeInsets.only(left:30,bottom:15,right: 30,),
                                child: GestureDetector(
                                  onTap: (){
                                    dispose_alert_box();
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
                                      child: Center(child: Text("Dispose",style:buildTextStyle()))
                                  ),
                                ),
                              ),
                              //move to outside
                              Padding(
                                padding: EdgeInsets.only(left:30,bottom:15,right: 30,),
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
                              //back to stock
                              Padding(
                                padding: EdgeInsets.only(left:30,bottom:15,right: 30,),
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
                              //updte notes
                              Padding(
                                padding: EdgeInsets.only(left:10,bottom:15,right: 30,),
                                child: Text("Update Notes",style: headingText(),),
                              ),
                              //Complaints
                              Padding(
                                padding: EdgeInsets.only(left:30,bottom:30,right: 30,),
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
                              //update
                              Padding(
                                padding: EdgeInsets.only(left:50,bottom:30,right: 50,),
                                child:
                                GestureDetector(
                                  onTap: (){
                                    addupdations();
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
                          )
                      ),
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

  Future dispose_alert_box(){
    return  showDialog(
      context: context,
      builder: (BuildContext context) {
        int selectedRadio = -1;
        return AlertDialog(
          title:Text("Select Reason to Dispose",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,

                    children: List<Widget>.generate(reasons.length, (int index) {
                      return RadioListTile<int>(
                        title: Text(reasons[index].name),
                        activeColor:  Color(0xFF468c90),
                        value: index,
                        groupValue: selectedRadio,
                        onChanged:
                            (value) {
                          setState(() => selectedRadio = value!);
                        },
                      );
                    }),
                  );
                },
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child:InkWell(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>image_picking()));
                      },
                      child: Container(
                        height: 40,
                        // width: MediaQuery.of(context).size.width/4,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                            borderRadius: BorderRadius.circular(10),color: Color(0xFF5663ff)),
                        child:  Center(
                          child: Text('Pick Image',style: buildTextStyle(),),
                        ),
                      ),
                    ),

                  ),


                ],
              ),
            ],
          ),

          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [



                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(

                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                asset_head_home(user_name: "", selectedPrivi:"")));
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(border: Border.all(color: Color(0xFF468c90)),
                              borderRadius: BorderRadius.circular(10),

                            ),
                            child: const Center(
                              child: Text('Cancel',style: TextStyle(color:Color(0xFF468c90),fontSize: 14),),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),


                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                asset_head_home(user_name: "", selectedPrivi:"")));
                          },
                          child: Container(
                            height: 40,
                            // width: MediaQuery.of(context).size.width/4,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                                borderRadius: BorderRadius.circular(10),color: Color(0xFF5663ff)),
                            child:  Center(
                              child: Text('Confirm',style: buildTextStyle(),),
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ],
              ),
            )
          ],
        );
      },);

  }

  Future reallocation_alert_box() async{
    return await showDialog(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                return AlertDialog(

                  title: Text("Reallocate Department"),
                  content: SingleChildScrollView(
                    child:
                    Column(
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Expanded(child: Text("Current Department:",style: TextStyle(color: Colors.black54),)),
                            SizedBox(width:2,),

                            Text("Department Name",style: TextStyle(color: Colors.black),),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.only(bottom:20),
                          child: Row(
                            children: [
                              Text("Select New Department:",style: TextStyle(color: Colors.black54),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 0,),
                          child: Container(
                            width: MediaQuery.of(context).size.width*2,
                            height: 40,
                            decoration: BoxDecoration(borderRadius:BorderRadius.circular(05),
                                border:Border.all(color: Colors.black45)),
                            child:   DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                elevation: 10,
                                iconEnabledColor: Colors.black,
                                value: selecteddept,
                                onChanged: (value)
                                {
                                  setState(() {
                                    selecteddept =  value!;
                                  });
                                },
                                items: department.map<DropdownMenuItem<String>>((value){
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
                      ],
                    ),


                  ),
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(

                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                    asset_head_home(user_name: "", selectedPrivi: "")));
                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(border: Border.all(color: Color(0xFF468c90)),
                                  borderRadius: BorderRadius.circular(10),

                                ),
                                child: Center(
                                  child: Text('Cancel',style: TextStyle(color:Color(0xFF468c90),fontSize: 14),),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),


                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                    asset_head_home(user_name:"", selectedPrivi: "")));
                              },
                              child: Container(
                                height: 40,
                                // width: MediaQuery.of(context).size.width/4,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                                    borderRadius: BorderRadius.circular(10),color: Color(0xFF5663ff)),
                                child:  Center(
                                  child: Text('Confirm',style: buildTextStyle(),),
                                ),
                              ),
                            ),
                          ),


                        ],
                      ),
                    )
                  ],

                );
              }

          );});
  }



}
