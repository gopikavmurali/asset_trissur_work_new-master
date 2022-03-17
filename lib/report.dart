
import 'package:flutter/material.dart';
import 'descriptiion_page.dart';

class report_page extends StatefulWidget {
  final String text2;
  final String number1;

   //final String nameController;
  const report_page( { required  this.text2, required this.number1,}); //const report_page({Key? key ,  required this.text}) : super(key: key);

  @override
  _report_pageState createState() => _report_pageState();
}

class _report_pageState extends State<report_page> {
  //late final String idController = "jgjgjgnhc";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:  const Text("Report of Assets",
          style: TextStyle(color: Colors.black,fontSize: 25),),

      ),
      body: Column(
        children:[
          Row(
            children:  [
              Padding(
               padding: const EdgeInsets.fromLTRB(30,20,20,10),
                child: Container(
                  height: 40,
                  width: 320,
                  decoration: const BoxDecoration(
                      color: Color(0xFFe0f4f5)

                  ),
                  child:   Center(child: Text("name:${widget.text2}",
                    style: TextStyle(fontSize: 26,color: Colors.black),)),
                ),
              ),
            ],
          ),
          Row(
            children:  [
              Padding(
                padding: const EdgeInsets.fromLTRB(30,20,20,10),
                child: Container(
                  height: 40,
                  width: 320,
                  decoration: const BoxDecoration(
                      color: Color(0xFFe0f4f5)

                  ),
                  child:   Center(child: Text('No.of total assets : ${widget.number1}',
                    style: TextStyle(fontSize: 26,color: Colors.black),)),
                ),
              ),
            ],
          ),
          Row(
            children:  [
              Padding(
                padding: const EdgeInsets.fromLTRB(30,20,20,10),
                child: Expanded(

                  child: Container(
                    height: 40,
                    width: 320,
                    decoration: const BoxDecoration(
                        color: Color(0xFFe0f4f5)

                    ),
                    child:  const Center(child: Text("Electrical& Maintenance",
                      style: TextStyle(fontSize: 26,color: Colors.black),)),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children:  [
              Padding(
                padding: const EdgeInsets.fromLTRB(30,20,20,10),
                child: Expanded(

                  child: Container(
                    height: 40,
                    width: 320,
                    decoration: const BoxDecoration(
                        color: Color(0xFFe0f4f5)

                    ),
                    child:  const Center(child: Text("IT",
                      style: TextStyle(fontSize: 26,color: Colors.black),)),
                  ),
                ),
              ),
            ],
          ),

        ],

      ),
    );
  }
}
