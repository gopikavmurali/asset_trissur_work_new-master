
import 'package:asset_trissur_work_new/asset_master_home.dart';
import 'package:flutter/material.dart';

import 'constants.dart';


class Exercise {
  String name;
  Exercise({required this.name});
}


class radiobutton extends StatefulWidget {
 // radiobutton({ Key? key,}) : super(key: key);



  @override
  _radiobuttonState createState() => _radiobuttonState();
}

class _radiobuttonState extends State<radiobutton> {
  int _counter = 0;
  List<Exercise> reasons= [
    Exercise(name: 'Defective Product'),
    Exercise(name: 'Expired'),
    Exercise(name: 'Change in Requirement'),
  ];
  int _selected = -1;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      shape: const RoundedRectangleBorder(
             borderRadius: BorderRadius.all(Radius.circular(20))),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(

                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const asset_master_home(user_name: "", selectedPrivi: "")));
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(border: Border.all(color: const Color(0xFF468c90)),
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child: const Center(
                      child: Text('Cancel',style: TextStyle(color:Color(0xFF468c90),fontSize: 14),),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10,),


              Expanded(
                child: GestureDetector(
                  onTap: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const asset_master_home(user_name: "", selectedPrivi: "")));
                  },
                  child: Container(
                    height: 40,
                   // width: MediaQuery.of(context).size.width/4,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF64C9CF), Color(0xFF468c90),],),

                        borderRadius: BorderRadius.circular(10),color: const Color(0xFF5663ff)),
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
      content: SingleChildScrollView(
        child: SizedBox(

          width: 300,
          child: Column(
             mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text("Select Reason to Dispose",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: reasons.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RadioListTile(
                        activeColor:  const Color(0xFF468c90),
                          title: Text(reasons[index].name),
                          value: index,
                          groupValue: _selected,
                          onChanged: (value) {
                            setState(() {
                              _selected = index;
                            });
                          });
                    }),
              ),

              Text("$_selected"),


            ],
          ),
        ),
      ),
    );
  }

}