

import 'package:asset_trissur_work_new/constants.dart';
import 'package:asset_trissur_work_new/report.dart';
import 'package:asset_trissur_work_new/service_history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

import 'image_picker_two.dart';
import 'login_page.dart';

class history extends StatefulWidget {
  final String asset_type;

  final String qrcode;
  const history({Key? key,
    required this.asset_type,

    required this.qrcode}) : super(key: key);


  //const admin_log_2({Key? key}) : super(key: key);

  @override
  _historyState createState() => _historyState();
}

class _historyState extends State<history> {
  final List<String> subjects = ["Asset Head", "BioMedical", "Electrical & maintenance","IT","Housekeeping"];
  String selectedSubject = "Asset Head";
  final List<String> depatmnt = ["Department", "BioMedical", "Electrical & maintenance","IT","Housekeeping"];
  String selecteddepatmnt = "Department";
  final List<String> itemname = ["Item Name", "Computer", "Laptop","Fan","Fridge","Chair","Table"];
  String selecteditem = "Item Name";
  final List<String> asset_types = ["Asset Types", "Current Assets", "Fixed Assets","Tangible Assets","Intangible Assets",
    "Operating Assets","Non Operating Assets"];
  String selectedtype = "Asset Types";
  late int count =0;
  late int number=0;

  TextEditingController idController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController depController = TextEditingController();
  TextEditingController orderController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController serialController = TextEditingController();
  TextEditingController expController = TextEditingController();
  TextEditingController warController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController headController = TextEditingController();
  TextEditingController supController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController configController = TextEditingController();
  final dateController = TextEditingController();
  final dateIssueController = TextEditingController();
  final amc_start_Controller = TextEditingController();
  final amc_end_Controller = TextEditingController();


  @override

  dynamic countofasset(){
    if (selectedSubject== "BioMedical")
    {
      int number = count+1;
      return
        Navigator.push(context, MaterialPageRoute(builder: (context)=>report_page(number1: number.toString(),text2: '',)));
    }

  }
  void alert(){
    showDialog(
        barrierDismissible: false,
        context: context, builder:(ctx) => Container(

      child: AlertDialog(
        //shape: BoxShape.rectangle,

        title: Row(
          children: [
            const Text("Asset ID:",style: TextStyle(color: Colors.black26),),
            Text(idController.text,style: const TextStyle(color: Colors.black26)),
          ],
        ),
        content:  Container(
          height: 100,
          width: 200,
          decoration: BoxDecoration(border: Border.all(color: Colors.white)),
          child:  BarcodeWidget(
            barcode: Barcode.qrCode(),
            color: Colors.black,
            data: idController.text,
            width: 200,
            height: 200,
          ),

        ),
        actions: [
          Row(
            children: [
              Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color:  const Color(0xFF468c90)),
                  child: Center(child: Text("Print QR code",style: buildTextStyle(),)),
                ),

              const SizedBox(width: 10,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const history(asset_type: '', qrcode: '', )));
                },

                child:Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.lightGreen),
                    child: Center(child: Text("Complete",style: buildTextStyle(),)),
                  ),
              )
            ],
          )
        ],
      ),
    )
    );
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    dateController.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        elevation: 0,
        title: Text("History", style: buildheading()),
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.black,)),
        actions: [
          const Icon(Icons.download, color: Colors.black,),
          const SizedBox(width: 10,),
          PopupMenuButton(
              icon: const Icon(Icons.menu_outlined, color: Colors.black,),
              itemBuilder: (context) =>
              [
                PopupMenuItem(
                  child: InkWell(
                    onTap: (){  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        const history(asset_type: '', qrcode: '', )));},
                      child: Text("Edit",style: dropStyle())),
                  value: 2,),
                PopupMenuItem(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
                      },
                        child: Text("Logout",style: dropStyle())))
              ]),
          const SizedBox(width: 10,)
          //Center(child: Text("Logout  ",style: TextStyle(color: Color(0xFF468c90),fontSize: 20)))
        ],
      ),


      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(width: 50,),
                ListTile(
                  minLeadingWidth : 01,
                  minVerticalPadding: 10,
                  horizontalTitleGap: 08,

                  title: Text("Asset id",style: buildFontlink(),),
                  leading: const Icon(Icons.arrow_right),
                  trailing: SizedBox(
                    width: 210,
                    height: 35,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("description").doc("5MepDMRTcSk49pMB2n5w").
                            snapshots(),

                        builder: (context ,AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }

                          final userDoc = snapshot.data;
                          return  Center(child: Text(userDoc!["asset_id"]));
                        }),
                    // child: TextField(
                    //
                    //
                    //   style: const TextStyle(color: Colors.black),
                    //   controller: idController,
                    //   decoration: const InputDecoration(
                    //       border: OutlineInputBorder(),
                    //       labelText: 'Asset Id',labelStyle: TextStyle(color: Colors.black26)
                    //     //hintStyle: TextStyle(color: Colors.red)
                    //   ),
                    // ),
                  ),
                ),
                // ListTile(
                //   minLeadingWidth : 01,
                //   minVerticalPadding: 10,
                //   horizontalTitleGap: 08,
                //
                //   title: Text("Asset id",style: buildFontlink(),),
                //   leading: const Icon(Icons.arrow_right),
                //   trailing: Container(
                //     width: 210,
                //     height: 35,
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //
                //       child: StreamBuilder(
                //           stream: FirebaseFirestore.instance.collection("description").
                //           doc("5MepDMRTcSk49pMB2n5w").snapshots(),
                //
                //           builder: (context ,AsyncSnapshot snapshot) {
                //             if (!snapshot.hasData) {
                //               return CircularProgressIndicator();
                //             }
                //
                //             final userDoc = snapshot.data;
                //             return  Text(userDoc!["asset_id"]);
                //           })
                //     ),
                //     // child: TextField(
                //     //
                //     //
                //     //   style: const TextStyle(color: Colors.black),
                //     //   controller: idController,
                //     //   decoration: const InputDecoration(
                //     //       border: OutlineInputBorder(),
                //     //       labelText: 'Asset Id',labelStyle: TextStyle(color: Colors.black26)
                //     //     //hintStyle: TextStyle(color: Colors.red)
                //     //   ),
                //     // ),
                //   ),
                // ),
                ListTile(
                   minLeadingWidth : 01,
                   minVerticalPadding: 10,
                   horizontalTitleGap: 05,

                  title: Text("Item Name",style: buildFontlink(),),
                  leading: const Icon(Icons.arrow_right),
                  trailing: SizedBox(
                    height: 35,
                  width: 210,
                  // width: 35,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("description").
                            where("asset_id" , isEqualTo: widget.qrcode).
                        //doc("5MepDMRTcSk49pMB2n5w")
                            snapshots(),

                        builder: (context ,AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }

                          final userDoc = snapshot.data;
                          return  Center(child: Text(userDoc!["asset_name"]));

                        }),
                  ),
                  // trailing: Container(
                  //   width: 210,
                  //   height: 35,
                  //   decoration: BoxDecoration(
                  //       border: Border.all(color: Colors.black26),
                  //       borderRadius: BorderRadius.circular(5)),
                  //
                  //   child:  DropdownButtonHideUnderline(
                  //
                  //
                  //     child: DropdownButton<String>(
                  //       // isDense: true,
                  //       // isExpanded: false,
                  //
                  //       elevation: 10,
                  //
                  //       iconEnabledColor: Colors.black,
                  //       value: selecteditem,
                  //       onChanged: (value){
                  //         setState(() {
                  //           selecteditem= value!;
                  //         });
                  //       },
                  //
                  //       items: itemname.map<DropdownMenuItem<String>>((value){
                  //
                  //         return DropdownMenuItem(
                  //
                  //           child: Padding(
                  //             padding: const EdgeInsets.only(left: 10.0),
                  //             child: Text(    value),
                  //           ),
                  //           value: value,
                  //
                  //         );
                  //       }).toList(),
                  //     ),
                  //   ),
                  //   // child: TextField(
                  //   //   style: TextStyle(color: Colors.red),
                  //   //   controller: idController,
                  //   //   decoration: InputDecoration(
                  //   //     border: OutlineInputBorder(),
                  //   //     //labelText: 'User Name',
                  //   //   ),
                  //   // ),
                  // ),
                ),
                ListTile(
                  minLeadingWidth : 01,
                  minVerticalPadding: 10,
                  horizontalTitleGap: 06,

                  title: Text("Department",style: buildFontlink(),),
                  leading: const Icon(Icons.arrow_right),
                  trailing: SizedBox(
                    height: 35,
                    width: 210,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("description").
                        doc("5MepDMRTcSk49pMB2n5w").snapshots(),

                        builder: (context ,AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }

                          final userDoc = snapshot.data;
                          return  Center(child: Text(userDoc!["department"],
                            style: const TextStyle(color: Colors.black),));
                        }),
                  ),
                  // trailing: Container(
                  //   width: 212,
                  //   height: 35,
                  //   decoration: BoxDecoration(
                  //       border: Border.all(color: Colors.black26),
                  //       borderRadius: BorderRadius.circular(5)),
                  //
                  //   child:  DropdownButtonHideUnderline(
                  //
                  //
                  //     child: DropdownButton<String>(
                  //       // isDense: true,
                  //       // isExpanded: false,
                  //
                  //       elevation: 10,
                  //
                  //       iconEnabledColor: Colors.black,
                  //       value: selecteddepatmnt,
                  //       onChanged: (value){
                  //         setState(() {
                  //           selecteddepatmnt = value!;
                  //         });
                  //       },
                  //
                  //       items: depatmnt.map<DropdownMenuItem<String>>((value){
                  //
                  //         return DropdownMenuItem(
                  //
                  //           child: Padding(
                  //             padding: const EdgeInsets.only(left: 10.0),
                  //             child: Text(    value),
                  //           ),
                  //           value: value,
                  //
                  //         );
                  //       }).toList(),
                  //     ),
                  //   ),
                  //   // child: TextField(
                  //   //   style: TextStyle(color: Colors.red),
                  //   //   controller: idController,
                  //   //   decoration: InputDecoration(
                  //   //     border: OutlineInputBorder(),
                  //   //     //labelText: 'User Name',
                  //   //   ),
                  //   // ),
                  // ),
                ),
                ListTile(
                  minLeadingWidth : 01,
                  minVerticalPadding: 10,
                  horizontalTitleGap: 08,

                  title: Text("AMC Start Date",style: buildFontlink(),),
                  leading: const Icon(Icons.arrow_right),
                  trailing: SizedBox(
                    height: 35,
                    width: 210,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("description").
                        doc("5MepDMRTcSk49pMB2n5w").snapshots(),

                        builder: (context ,AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }

                          final userDoc = snapshot.data;
                          return  Center(child: Text(userDoc!["amc_start_date"]));
                        }),
                  ),
                  // trailing: Container(
                  //   width: 210,
                  //   height: 35,
                  //   child: Container(
                  //     width: 210,
                  //     height: 35,
                  //     child: TextField(
                  //       readOnly: true,
                  //       style: const TextStyle(color: Colors.black),
                  //       controller: amc_start_Controller,
                  //       decoration: const InputDecoration(
                  //           border: OutlineInputBorder(),
                  //           labelText: 'yyyy-mm-dd',labelStyle: TextStyle(color: Colors.black26)
                  //       ),
                  //       onTap: () async {
                  //         var date =  await showDatePicker(
                  //             context: context,
                  //             initialDate:DateTime.now(),
                  //             firstDate:DateTime(1900),
                  //             lastDate: DateTime(2100));
                  //         amc_start_Controller.text = date.toString().substring(0,10);
                  //       },
                  //     ),
                  //   ),
                  // ),
                ),
                ListTile(
                  minLeadingWidth : 01,
                  minVerticalPadding: 10,
                  horizontalTitleGap: 08,

                  title: Text("AMC End Date",style: buildFontlink(),),
                  leading: const Icon(Icons.arrow_right),
                  trailing: SizedBox(
                    height: 35,
                    width: 210,

                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("description").
                        doc("5MepDMRTcSk49pMB2n5w").snapshots(),

                        builder: (context ,AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }

                          final userDoc = snapshot.data;
                          return  Center(child: Text(userDoc!["amc_end_date"]));
                        }),
                  ),
                  // trailing: Container(
                  //   width: 210,
                  //   height: 35,
                  //   child: Container(
                  //     width: 210,
                  //     height: 35,
                  //     child: TextField(
                  //       readOnly: true,
                  //       style: const TextStyle(color: Colors.black),
                  //       controller: amc_start_Controller,
                  //       decoration: const InputDecoration(
                  //           border: OutlineInputBorder(),
                  //           labelText: 'yyyy-mm-dd',labelStyle: TextStyle(color: Colors.black26)
                  //       ),
                  //       onTap: () async {
                  //         var date =  await showDatePicker(
                  //             context: context,
                  //             initialDate:DateTime.now(),
                  //             firstDate:DateTime(1900),
                  //             lastDate: DateTime(2100));
                  //         amc_start_Controller.text = date.toString().substring(0,10);
                  //       },
                  //     ),
                  //   ),
                  // ),
                ),
                ListTile(
                  minLeadingWidth : 01,
                  minVerticalPadding: 10,
                  horizontalTitleGap: 08,

                  title: Text("Purchase Order No",style: buildFontlink(),),
                  leading: const Icon(Icons.arrow_right),
                  trailing: SizedBox(
                    height: 35,
                    width: 219,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("description").
                        doc("5MepDMRTcSk49pMB2n5w").snapshots(),

                        builder: (context ,AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }

                          final userDoc = snapshot.data;
                          return  Center(child: Text(userDoc!["purchase_no"]));
                        }),
                  ),
                  // trailing: Container(
                  //   width: 210,
                  //   height: 35,
                  //   child: TextField(
                  //     style: const TextStyle(color: Colors.black),
                  //     controller: orderController,
                  //     decoration: const InputDecoration(
                  //         border: OutlineInputBorder(),
                  //         labelText: 'Order No',labelStyle: TextStyle(color: Colors.black26)
                  //     ),
                  //   ),
                  // ),
                ),
                ListTile(
                  minLeadingWidth : 01,
                  minVerticalPadding: 10,
                  horizontalTitleGap: 08,

                  title: Text("Brand Name/Model No",style: buildFontlink(),),
                  leading: const Icon(Icons.arrow_right),
                  trailing: SizedBox(
                    height: 35,
                    width: 210,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("description").
                        doc("5MepDMRTcSk49pMB2n5w").snapshots(),

                        builder: (context ,AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }

                          final userDoc = snapshot.data;
                          return  Center(child: Text(userDoc!["brand_name"]));
                        }),
                  ),
                  // trailing: Container(
                  //   width: 210,
                  //   height: 35,
                  //   child: TextField(
                  //     style: const TextStyle(color: Colors.black),
                  //     controller: brandController,
                  //     decoration: const InputDecoration(
                  //         border: OutlineInputBorder(),
                  //         labelText: 'Brand Name',labelStyle: TextStyle(color: Colors.black26)
                  //     ),
                  //   ),
                  // ),
                ),
                ListTile(
                  minLeadingWidth : 01,
                  minVerticalPadding: 10,
                  horizontalTitleGap: 08,

                  title: Text("Serial No/Service Tag",style: buildFontlink(),),
                  leading: const Icon(Icons.arrow_right),
                  trailing: SizedBox(
                    height: 35,
                    width: 210,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("description").
                        doc("5MepDMRTcSk49pMB2n5w").snapshots(),

                        builder: (context ,AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }

                          final userDoc = snapshot.data;
                          return  Center(child: Text(userDoc!["serial_no"]));
                        }),
                  ),
                  // trailing: Container(
                  //   width: 210,
                  //   height: 35,
                  //   child: TextField(
                  //     style: TextStyle(color: Colors.black),
                  //     controller: serialController,
                  //     decoration: const InputDecoration(
                  //         border: OutlineInputBorder(),
                  //         labelText: 'Serial No',labelStyle: TextStyle(color: Colors.black26)
                  //     ),
                  //   ),
                  // ),
                ),
                ListTile(
                  minLeadingWidth : 01,
                  minVerticalPadding: 10,
                  horizontalTitleGap: 08,

                  title: Text("Warranty Expire Date",style: buildFontlink(),),
                  leading: const Icon(Icons.arrow_right),
                  trailing: SizedBox(
                    width: 210,
                      height: 35,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("description").
                        doc("5MepDMRTcSk49pMB2n5w").snapshots(),

                        builder: (context ,AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }

                          final userDoc = snapshot.data;
                          return  Center(child: Text(userDoc!["warranty"]));
                        }),
                  ),
                  // trailing: Container(
                  //   width: 210,
                  //   height: 35,
                  //   child: Container(
                  //     width: 210,
                  //     height: 35,
                  //     child: TextField(
                  //       readOnly: true,
                  //       style: const TextStyle(color: Colors.black),
                  //       controller: dateController,
                  //       decoration: const InputDecoration(
                  //           border: OutlineInputBorder(),
                  //           labelText: 'yyyy-mm-dd',labelStyle: TextStyle(color: Colors.black26)
                  //       ),
                  //       onTap: () async {
                  //         var date =  await showDatePicker(
                  //
                  //             context: context,
                  //             initialDate:DateTime.now(),
                  //             firstDate:DateTime(1900),
                  //             lastDate: DateTime(2100));
                  //         dateController.text = date.toString().substring(0,10);
                  //       },
                  //     ),
                  //   ),
                  // ),
                ),
                //asset type
                ListTile(
                    minLeadingWidth : 01,
                    minVerticalPadding: 10,
                    horizontalTitleGap: 06,

                    title: Text("Asset Types",style: buildFontlink(),),
                    leading: const Icon(Icons.arrow_right),
                    trailing: SizedBox(
                      width: 210,
                      height: 35,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance.collection("description").
                          doc("5MepDMRTcSk49pMB2n5w").snapshots(),

                          builder: (context ,AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }

                            final userDoc = snapshot.data;
                            return  Center(child: Text(userDoc!["asset_types"]));
                          }),)
                  // trailing: Container(
                  //   width: 212,
                  //   height: 35,
                  //   decoration: BoxDecoration(
                  //       border: Border.all(color: Colors.black26),
                  //       borderRadius: BorderRadius.circular(5)),
                  //
                  //   child:  DropdownButtonHideUnderline(
                  //
                  //
                  //     child: DropdownButton<String>(
                  //       // isDense: true,
                  //       // isExpanded: false,
                  //
                  //       elevation: 10,
                  //
                  //       iconEnabledColor: Colors.black,
                  //       value: selectedSubject,
                  //       onChanged: (value){
                  //         setState(() {
                  //           selectedSubject = value!;
                  //         });
                  //       },
                  //
                  //       items: subjects.map<DropdownMenuItem<String>>((value){
                  //
                  //         return DropdownMenuItem(
                  //
                  //           child: Padding(
                  //             padding: const EdgeInsets.only(left: 10.0),
                  //             child: Text(    value),
                  //           ),
                  //           value: value,
                  //
                  //         );
                  //       }).toList(),
                  //     ),
                  //   ),
                  //   // child: TextField(
                  //   //   style: TextStyle(color: Colors.red),
                  //   //   controller: idController,
                  //   //   decoration: InputDecoration(
                  //   //     border: OutlineInputBorder(),
                  //   //     //labelText: 'User Name',
                  //   //   ),
                  //   // ),
                  // ),
                ),
                ListTile(
                  minLeadingWidth : 01,
                  minVerticalPadding: 10,
                  horizontalTitleGap: 06,

                  title: Text("Asset Head",style: buildFontlink(),),
                  leading: const Icon(Icons.arrow_right),
                  trailing: SizedBox(
                    width: 210,
                    height: 35,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("description").
                        doc("5MepDMRTcSk49pMB2n5w").snapshots(),

                        builder: (context ,AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }

                          final userDoc = snapshot.data;
                          return  Center(child: Text(userDoc!["asset_head"]));
                        }),)
                  // trailing: Container(
                  //   width: 212,
                  //   height: 35,
                  //   decoration: BoxDecoration(
                  //       border: Border.all(color: Colors.black26),
                  //       borderRadius: BorderRadius.circular(5)),
                  //
                  //   child:  DropdownButtonHideUnderline(
                  //
                  //
                  //     child: DropdownButton<String>(
                  //       // isDense: true,
                  //       // isExpanded: false,
                  //
                  //       elevation: 10,
                  //
                  //       iconEnabledColor: Colors.black,
                  //       value: selectedSubject,
                  //       onChanged: (value){
                  //         setState(() {
                  //           selectedSubject = value!;
                  //         });
                  //       },
                  //
                  //       items: subjects.map<DropdownMenuItem<String>>((value){
                  //
                  //         return DropdownMenuItem(
                  //
                  //           child: Padding(
                  //             padding: const EdgeInsets.only(left: 10.0),
                  //             child: Text(    value),
                  //           ),
                  //           value: value,
                  //
                  //         );
                  //       }).toList(),
                  //     ),
                  //   ),
                  //   // child: TextField(
                  //   //   style: TextStyle(color: Colors.red),
                  //   //   controller: idController,
                  //   //   decoration: InputDecoration(
                  //   //     border: OutlineInputBorder(),
                  //   //     //labelText: 'User Name',
                  //   //   ),
                  //   // ),
                  // ),
                ),
                ListTile(
                  minLeadingWidth : 01,
                  minVerticalPadding: 10,
                  horizontalTitleGap: 08,

                  title: Text("Supplier Name",style: buildFontlink(),),
                  leading: const Icon(Icons.arrow_right),
                  trailing: SizedBox(
                    width: 210,
                    height: 35,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("description").
                        doc("5MepDMRTcSk49pMB2n5w").snapshots(),

                        builder: (context ,AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }

                          final userDoc = snapshot.data;
                          return  Center(child: Text(userDoc!["supplier_name"]));
                        }),)
                  // trailing: Container(
                  //   width: 210,
                  //   height: 35,
                  //   child: TextField(
                  //     style: TextStyle(color: Colors.black),
                  //     controller: supController,
                  //     decoration: const InputDecoration(
                  //         border: OutlineInputBorder(),
                  //         labelText: 'Supplier',labelStyle: TextStyle(color: Colors.black26)
                  //     ),
                  //   ),
                  // ),
                ),
                ListTile(
                  minLeadingWidth : 01,
                  minVerticalPadding: 10,
                  horizontalTitleGap: 08,

                  title: Text("Price",style: buildFontlink(),),
                  leading: const Icon(Icons.arrow_right),
                  trailing: SizedBox(
                    width: 210,
                    height: 35,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("description").
                        doc("5MepDMRTcSk49pMB2n5w").snapshots(),

                        builder: (context ,AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }

                          final userDoc = snapshot.data;
                          return  Center(child: Text(userDoc!["price"]));
                        }),)
                  // trailing:  Container(
                  //   width: 210,
                  //   height: 35,
                  //   child: TextField(
                  //     style: const TextStyle(color: Colors.black),
                  //     controller: valueController,
                  //     decoration: const InputDecoration(
                  //         border: OutlineInputBorder(),
                  //         labelText: 'Price',labelStyle: TextStyle(color: Colors.black26)
                  //     ),
                  //   ),
                  // ),
                ),
                ListTile(
                  minLeadingWidth : 01,
                  minVerticalPadding: 10,
                  horizontalTitleGap: 08,

                  title: Text("Date of Issue",style: buildFontlink(),),
                  leading: const Icon(Icons.arrow_right),
                  trailing: SizedBox(
                    height: 35,
                    width: 210,

                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("description").
                        doc("5MepDMRTcSk49pMB2n5w").snapshots(),

                        builder: (context ,AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }

                          final userDoc = snapshot.data;
                          return  Center(child: Text(userDoc!["date_of_issue"]));
                        }),
                  ),
                  // trailing: Container(
                  //   width: 210,
                  //   height: 35,
                  //   child: TextField(
                  //     readOnly: true,
                  //     style: const TextStyle(color: Colors.black),
                  //     controller: dateIssueController,
                  //     decoration: const InputDecoration(
                  //         border: OutlineInputBorder(),
                  //         labelText: 'yyyy-mm-dd',labelStyle: TextStyle(color: Colors.black26)
                  //     ),
                  //     onTap: () async {
                  //       var date =  await showDatePicker(
                  //
                  //           context: context,
                  //           initialDate:DateTime.now(),
                  //           firstDate:DateTime(1900),
                  //           lastDate: DateTime(2100));
                  //       dateIssueController.text = date.toString().substring(0,10);
                  //     },
                  //   ),
                  // ),
                ),
                ListTile(
                  minLeadingWidth : 01,
                  minVerticalPadding: 10,
                  horizontalTitleGap: 08,

                  title: Text("Configuration notes",style: buildFontlink(),),
                  leading: const Icon(Icons.arrow_right),
                  trailing: SizedBox(
                    width: 210,
                    height: 35,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("description").
                        doc("5MepDMRTcSk49pMB2n5w").snapshots(),

                        builder: (context ,AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }

                          final userDoc = snapshot.data;
                          return  Center(child: Text(userDoc!["configuration"]));
                        }),)
                  // trailing: Container(
                  //   width: 210,
                  //   height:150,
                  //   child:  Container(
                  //     height: 150,
                  //     width: 200,
                  //     child: TextField(
                  //       decoration: const InputDecoration(
                  //         border: OutlineInputBorder(),
                  //         // labelText: "Update Notes"
                  //       ),
                  //       maxLines: 10,
                  //       controller: configController,
                  //     ),
                  //   ),
                  // ),
                ),
                ListTile(
                  minLeadingWidth : 01,
                  minVerticalPadding: 10,
                  horizontalTitleGap: 08,

                  title: Text("Choose  Image",style: buildFontlink(),),
                  leading: const Icon(Icons.arrow_right),
                  trailing: SizedBox(
                    width: 210,
                    height: 40,
                    child:  InkWell(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>image_picking()));
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width/2.5,
                        decoration: BoxDecoration(border: Border.all(color: const Color(0xFF468c90)),
                          // gradient: const LinearGradient(
                          //   begin: Alignment.topLeft,
                          //   end: Alignment.bottomRight,
                          //   colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                          borderRadius: BorderRadius.circular(10),
                          //color: Color(0xFF5663ff)
                        ),
                        child: const Center(
                          child: Text('Pick Image',style: TextStyle(color:Color(0xFF468c90),fontSize: 14),),
                        ),
                      ),
                      // child: Container(
                      //   height: 30,
                      //   // width: MediaQuery.of(context).size.width/4,
                      //   decoration: BoxDecoration(
                      //       gradient: const LinearGradient(
                      //         begin: Alignment.topLeft,
                      //         end: Alignment.bottomRight,
                      //         colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),
                      //
                      //       borderRadius: BorderRadius.circular(10),color: Color(0xFF5663ff)),
                      //   child:  Center(
                      //     child: Text('Pick Image',style: buildTextStyle(),),
                      //   ),
                      // ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: () => buildSetState(),
                  child: Container(
                    height: 40,
                    width: 250,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF64C9CF),
                            Color(0xFF468c90),
                          ],),

                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFF5663ff)),

                    child: Center(child: Text(
                        "Save & Generate QR Code", style: buildTextStyle())),
                  ),
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                     Navigator.push(context, MaterialPageRoute(
                         builder: (context)=>const service_history(descriptionTextController: '',)));
                  },
                  child: Container(
                    height: 40,
                    width: 250,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF64C9CF),
                            Color(0xFF468c90),
                          ],),

                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFF5663ff)),

                    child: Center(child: Text(
                        "Service History", style: buildTextStyle())),
                  ),
                ),
                const SizedBox(height: 20,),















              ],
            )
          ],
        ),
      ),
    );

  }

  void buildSetState() => setState(() {

    alert();


  });

}
