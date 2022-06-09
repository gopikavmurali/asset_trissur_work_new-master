
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



TextStyle buildTextStyle() =>
    TextStyle(color: Colors.white,fontSize: 14);

TextStyle headingText() =>
    TextStyle(fontSize: 18,fontStyle: FontStyle.normal,color: Colors.black45);

TextStyle dropStyle() => 
    TextStyle(fontWeight: FontWeight.w600);

TextStyle buildFontlink() {
  return GoogleFonts.getFont('Nunito Sans',
      fontSize: 18,fontWeight: FontWeight.bold,
      color: Colors.black87);
}

TextStyle buildheading() {
  return GoogleFonts.getFont('Nunito Sans',
      fontSize: 25,fontWeight: FontWeight.bold,
      color: Colors.black);
}


//function for validating name
String? validateName(value){
  if(value != null&& value.isEmpty){
    return "Name can't be blank";
  }
  else {
    return null;
  }
}

//function for validating phone
String?  validatePhone(value){
  if (value != null&& value.isEmpty)
  {
    return "Phone Number cant be blank";
  }

  else if(value.length!= 10)
  {
    return "Mobile Number must be 10 digit";
  }
  else return null;
}

//function for validating password
String? validatePassword(value){

  if(value != null && value.isEmpty){
    return "Passwordn can't be blank";
  }
  else if (value.length<6 ||value.length>6){
    return "Should have 6 characters ";
  }



}


 //Button for Complete
 Widget ContainerComplete({required int height,
   required int width,
   required BoxDecoration decoration,
   required  child}) {
  return Container(
    height: 40,
    width: 80,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.lightGreen),
    child: Center(child: Text("Complete",style: buildTextStyle(),)),
  );
 }

 //Button for Accept

Widget ContainerPending({required int height,
  required int width,
  required BoxDecoration decoration,
  required Text child,

}) {
  return Container(
    height: 40,
    width: 60,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), color: Color(0xFF468c90)),
    child: Center(child: Text("Pending", style: buildTextStyle(),)),
  );





}
//
// else if (formkey.currentState!.validate()) {
//   try {
//     await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: user_name.text, password: pass_word.text);
//     errorMessage = "";
//   } on FirebaseAuthException catch (error) {
//     errorMessage = error.message!;
//   }
// }
// setState(() {
//
// });