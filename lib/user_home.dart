
import 'dart:io';
import 'package:asset_trissur_work_new/button_widget.dart';
import 'package:asset_trissur_work_new/constants.dart';
import 'package:asset_trissur_work_new/login_page.dart';
import 'package:asset_trissur_work_new/report.dart';
import 'package:asset_trissur_work_new/complaints.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'descriptiion_page.dart';
import 'create_page_master.dart';



class user_home extends StatefulWidget {
  final String user_name;
  const user_home({Key? key, required this.user_name}) : super(key: key);


  @override
  _user_homeState createState() => _user_homeState();
}

class _user_homeState extends State<user_home> {
  String qrCode = 'Scanned Result';
  TextEditingController complaintController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController moveController = TextEditingController();
  TextEditingController assetController = TextEditingController();



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
                 Navigator.of(context, rootNavigator: true).pop();



                //Navigator.push(context, MaterialPageRoute(builder: (context)=>admin_user(user_name: '',)));
              },
              child: const Icon(Icons.perm_identity,color: Colors.black,)),
          title:  Text("${widget.user_name}",style: TextStyle(color: Colors.black),),
          actions: [
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
                },
                child: Icon(Icons.logout_outlined,color: Colors.black,)),
            SizedBox(width: 10,),

            //Icons.notification_important,

            //Center(child: Text("Logout  ",style: TextStyle(color: Color(0xFF468c90),fontSize: 20)))
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




                  //scan qr code
                    Padding(
                      padding: const EdgeInsets.only(top:20.0,left: 50,right: 50),
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
                      padding: EdgeInsets.only(top:70.0,left: 200),
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
                    // ->
                    //back to stock
                    //history
                    //create
                    //update notes box
                    Padding(
                      padding: const EdgeInsets.only(top:320,left: 50,right: 50),
                      child: Container(
                        height: 250,
                        width: 320,
                        //decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                        child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            //labelText: "Update Notes"
                          ),
                          maxLines: 50,
                          controller: complaintController,
                        ),
                      ),
                    ),
                    //complaint caption
                    Padding(
                      padding: const EdgeInsets.only(top:280.0,left:100),
                      child: Text("Enter your Complaints",style: headingText(),),
                    ),
                    //update button
                    Padding(
                      padding: const EdgeInsets.only(top:600.0,left: 50,right: 50),
                      child:
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=> complaints(descriptionTextController: complaintController.text,
                                descriptionController: '',)));
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


                            child: Center(child: Text("Send",style:buildTextStyle()))
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
