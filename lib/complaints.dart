
import 'package:asset_trissur_work_new/user_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'login_page.dart';

class complaints extends StatefulWidget {

  final String descriptionTextController;
  //final String descriptionController;
  const complaints({Key? key,
    required this.descriptionTextController,

  }) : super(key: key);
  //const updattion({Key? key}) : super(key: key);

  @override
  _complaintsState createState() => _complaintsState();
}

class _complaintsState extends State<complaints> {
  @override
   int count = 0;
  onDelete(String id){
    FirebaseFirestore.instance.collection("todos").doc(id).delete();
  }
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
        title:  Text("Complaints",style: TextStyle(color: Colors.black),),
          actions: [
          GestureDetector(
          onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
              },
           child: Icon(Icons.logout_outlined,color: Colors.black,)),
          SizedBox(width: 10,),




    ]),
     // body: SafeArea(
     //   child: StreamBuilder<QuerySnapshot>(
     //     stream: FirebaseFirestore.instance.collection("usercomplaints").snapshots(),
     //     builder: (ctx,snapshot){
     //       if(!snapshot.hasData){
     //         return CircularProgressIndicator();
     //       }
     //       else {
     //         return Expanded(
     //
     //           child: ListView(
     //             children: snapshot.data!.docs.map((document) {
     //               final dynamic data =document.data();
     //               return ListTile(
     //                 leading: Text("Date"),
     //                 title: (data["values"]),
     //               );
     //             }).toList(),
     //           ),
     //         );
     //       }
     //     },
     //   ),
     //
     // ),
       body: SafeArea(
         child:  StreamBuilder(
             stream: FirebaseFirestore.instance.collection("usercomplaints").snapshots(),
             builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot)
             {
               if (!snapshot.hasData)
               {
                 return Center(child: CircularProgressIndicator());
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
                           onDelete(document.id);
                         },
                         background: Container(
                           color: Colors.red,
                           child: Icon(Icons.delete),
                         ),

                         child: ListTile(
                           title: Text(data["values"].toString()),
                           leading: Padding(
                             padding: const EdgeInsets.all(8.0),
                             //child: Text(data["date"].toString()),
                             child: Text("dd-mm-yyyy"),
                           )
                         ),
                       );
                       // return Container(
                       //   height: 50,
                       //   width: MediaQuery.of(context).size.width,
                       //   child: Text("title:"+data["Title"]),
                       // );
                     }).toList(),

                   ),
                 );
               }
             }

         ),
       // child:ListView.builder(
       //
       //      itemCount: 10,
       //      itemBuilder: (context,snapshot){
       //
       //        return ListTile(
       //          leading: Padding(
       //           padding: EdgeInsets.only(top: 20.0),
       //            child: Text("12-12-2021"),
       //            ),
       //
       //          title: Padding(
       //             padding: EdgeInsets.only(top: 20.0),
       //            child: Text("${widget.descriptionTextController}"
       //                 "${widget.descriptionController}",style: TextStyle(color: Colors.black),),
       //           ),
       //
       //     );
       //       }
       //     )
       )
    );
        }
      }



