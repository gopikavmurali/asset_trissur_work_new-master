import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'constants.dart';


class drop extends StatefulWidget {
  const drop({Key? key}) : super(key: key);

  @override
  _dropState createState() => _dropState();
}

class _dropState extends State<drop> {

  String selecteditem = "Asset Types";
  final List<String> itemname = ["Asset Types", "Current Assets", "Fixed Assets","Tangible Assets","Intangible Assets",
    "Operating Assets","Non Operating Assets"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text("Dropdown"),
      ),
      body:  Column(

        children: [
          ListTile(
            minLeadingWidth : 01,
            minVerticalPadding: 10,
            horizontalTitleGap: 08,

            title: Text("Item Name",style: buildFontlink(),),
            leading: Icon(Icons.arrow_right),
            trailing: Container(
              width: 210,
              height: 35,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(5)),

              child:  StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("items").orderBy("values").snapshots(),
                  builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
                    if(!snapshot.hasData)
                    {
                      return CircularProgressIndicator();
                    }
                    else
                    {
                      return
                        DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              elevation: 10,
                              iconEnabledColor: Colors.black,

                              onChanged: (value){
                                setState(() {
                                  selecteditem= value!;
                                }
                                );

                              },


                              items: snapshot.data?.docs.map((QueryDocumentSnapshot document){
                                final dynamic data = document.data();
                                return DropdownMenuItem<String>(
                                    value: data["id"].toString(),
                                    child: Text(data["values"].toString())
                                  //child: Text(document["values"].toString)
                                );
                              }

                              ).toList(),
                              value: null


                            ));
                    }


                  }
              ),

            ),
          ),
          // ListTile(
          //   minLeadingWidth : 01,
          //   minVerticalPadding: 10,
          //   horizontalTitleGap: 08,
          //
          //   title: Text("Item Name",style: buildFontlink(),),
          //   leading: Icon(Icons.arrow_right),
          //   trailing: Container(
          //     width: 210,
          //     height: 35,
          //     decoration: BoxDecoration(
          //         border: Border.all(color: Colors.black26),
          //         borderRadius: BorderRadius.circular(5)),
          //
          //     child:  DropdownButtonHideUnderline(
          //
          //
          //       child: DropdownButton<String>(
          //         elevation: 10,
          //         iconEnabledColor: Colors.black,
          //         value: selecteditem,
          //         onChanged: (value){
          //           setState(() {
          //             selecteditem= value!;
          //           });
          //         },
          //
          //         items: itemname.map<DropdownMenuItem<String>>((value){
          //
          //           return DropdownMenuItem(
          //
          //             child: Padding(
          //               padding: const EdgeInsets.only(left: 10.0),
          //               child: Text(    value),
          //             ),
          //             value: value,
          //
          //           );
          //         }).toList(),
          //       ),
          //     ),
          //
          //   ),
          // ),
        ],
      ),

      //department name,
    );

  }
}
