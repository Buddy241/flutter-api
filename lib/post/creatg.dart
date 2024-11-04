// import 'dart:convert';
//
// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:pinput/pinput.dart';
// import 'package:responsive_framework/responsive_framework.dart';
// import 'package:sprint1_backup/userlogin.dart';
//
// import 'color.dart';
//
// class UserCreate extends StatefulWidget {
//   const UserCreate({super.key});
//
//   @override
//   State<UserCreate> createState() => _UserCreateState();
// }
//
// class _UserCreateState extends State<UserCreate> {
//   final ctlName = TextEditingController();
//   final ctlPhonu = TextEditingController();
//   final ctlEmail = TextEditingController();
//   final ctlDOB = TextEditingController();
//   final ctlGender = TextEditingController();
//   final ctlPassword = TextEditingController();
//   final ctlConPass = TextEditingController();
//   final _otpControllers = List.generate(6, (index) => TextEditingController());
//   final _otpFocusNodes = List.generate(6, (index) => FocusNode());
//   final bmc = GlobalKey<FormState>();
//   bool signIsPasswordVisible = false;
//   bool signIsPasswordVisible1 = false;
//   bool isPhoneVerified = false;
//   bool isphonenoenable = true;
//   String otp = "";
//
//   String? selectedGender;
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null && picked != DateTime.now()) {
//       setState(() {
//         ctlDOB.text = DateFormat('dd/MM/yyyy').format(picked);
//       });
//     }
//   }
//
//   void _showOtpBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (BuildContext context) {
//         return Padding(
//           padding:
//           EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//           child: Container(
//             padding: EdgeInsets.all(16.0),
//             height: 300,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'Enter OTP',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   'An OTP has been sent to ${ctlPhonu.text}. Please enter it below:',
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 20),
//                 Pinput(
//                   length: 6,
//                   showCursor: true,
//                   onCompleted: (pin) {
//                     setState(() {
//                       otp = pin;
//                     });
//                     print("Entered OTP: $pin");
//                     _verifyotp();
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       Navigator.pop(context);
//                     });
//                   },
//                   child: Text('Next'),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   var sample = {};
//   String name = "";
//   String email = "";
//   String phoneno = "";
//   String gender = "";
//   String password = "";
//
//   createuser() async {
//     setState(() {
//       name = ctlName.text;
//       email = ctlEmail.text;
//       phoneno = ctlPhonu.text;
//       gender = selectedGender!;
//       password = ctlPassword.text;
//     });
//
//     final response = await http.post(Uri.parse("http://92.205.109.210:8028/api/createuser"),
//         headers: {
//           "content-type": "application/json"
//         },
//         body: json.encode(
//             {
//               "user_name": name,
//               "email": email,
//               "phone_number": phoneno,
//               "dob": "2000-02-10",
//               "gender": gender,
//               "password": password,
//               "age": 23
//             }
//         ));
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       setState(() {
//         sample = jsonDecode(response.body);
//         if (bmc.currentState!.validate()) {
//           showDialog(
//               context: context,
//               builder: (context) => AlertDialog(
//                 title: Text("User"),
//                 content: Text("User Created Successfully"),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => userlogin()),
//                       );
//                     },
//                     child: Text("OK"),
//                   ),
//                 ],
//               ));
//         }
//       });
//     }
//   }
//
//   var opt = {};
//
//   _otp() async {
//     final response = await http.post(Uri.parse("http://92.205.109.210:8028/mobileauth/send-otp-sms"),
//         headers: {
//           "content-type": "application/json"
//         },
//         body: jsonEncode({
//           "number": ctlPhonu.text,
//           "appName": "POLL APP"
//         })
//     );
//     _showOtpBottomSheet(context);
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       setState(() {
//         opt = json.decode(response.body);
//       });
//     }
//   }
//
//   var sample2 = {};
//
//   _verifyotp() async {
//     final response = await http.post(Uri.parse("http://92.205.109.210:8028/mobileauth/verify-otp-sms"),
//         headers: {
//           "content-type": "application/json"
//         },
//         body: jsonEncode({
//           "number": ctlPhonu.text,
//           "otp": otp,
//         })
//     );
//
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       setState(() {
//         sample2 = json.decode(response.body);
//         isPhoneVerified = true;
//         isphonenoenable = false;
//       });
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text("Verified"),
//           content: Text("OTP is verified"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text("OK"),
//             ),
//           ],
//         ),
//       );
//     } else {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text("Error"),
//           content: Text("Invalid OTP"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text("OK"),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: bac,
//         appBar: AppBar(
//           leading: IconButton(
//             icon: Icon(
//               Icons.arrow_back_ios,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               Navigator.pop(context); // Handle back button press
//             },
//           ),
//           backgroundColor: bac,
//           title: Text("CREATE YOUR ACCOUNT",
//               style: TextStyle(color: Colors.white)),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Icon(Icons.poll, color: Colors.white, size: 40),
//             )
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Form(
//                 key: bmc,
//                 child: Padding(
//                   padding: const EdgeInsets.all(5.0),
//                   child: FadeInDown(
//                     child: Card(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(5.5),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "PERSONAL DETAILS",
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 TextButton(
//                                   onPressed: () {
//                                     if (bmc.currentState!.validate()) {
//                                       setState(() {
//                                         createuser();
//                                       });
//                                     } else {
//                                       showDialog(
//                                           context: context,
//                                           builder: (context) => AlertDialog(
//                                             title: Text("User not Created"),
//                                             content: Text("Please fill all the details"),
//                                             actions: [
//                                               TextButton(
//                                                 onPressed: () {
//                                                   Navigator.pop(context);
//                                                 },
//                                                 child: Text("OK"),
//                                               ),
//                                             ],
//                                           ));
//                                     }
//                                   },
//                                   child: Text("SAVE",
//                                       style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(5.5),
//                             child: BounceInRight(
//                               child: TextFormField(
//                                 validator: (input) {
//                                   if (!RegExp(r"^[A-Za-z]{3,}(?:[-'][A-Za-z]+)*$")
//                                       .hasMatch(input!)) {
//                                     return 'Please enter a valid name';
//                                   }
//                                   return null;
//                                 },
//                                 controller: ctlName,
//                                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                                 style: TextStyle(color: Colors.black),
//                                 decoration: InputDecoration(
//                                   labelText: "Name",
//                                   fillColor: Colors.white,
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(25.0),
//                                     borderSide: BorderSide(color: bac),
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(25.0),
//                                     borderSide: BorderSide(color: Colors.blue, width: 1.0),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(5.5),
//                             child: BounceInRight(
//                               child: TextFormField(
//                                 enabled: isphonenoenable,
//                                 validator: (input) {
//                                   if (!RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(input!)) {
//                                     return 'Please enter a valid phone number';
//                                   }
//                                   return null;
//                                 },
//                                 controller: ctlPhonu,
//                                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                                 style: TextStyle(color: Colors.black),
//                                 keyboardType: TextInputType.number,
//                                 inputFormatters: <TextInputFormatter>[
//                                   FilteringTextInputFormatter.digitsOnly
//                                 ],
//                                 decoration: InputDecoration(
//                                   labelText: "Phone Number",
//                                   fillColor: Colors.white,
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(25.0),
//                                     borderSide: BorderSide(color: bac),
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(25.0),
//                                     borderSide: BorderSide(color: Colors.blue, width: 1.0),
//                                   ),
//                                   suffixIcon: isPhoneVerified
//                                       ? Icon(Icons.check, color: Colors.green)
//                                       : IconButton(
//                                     icon: Icon(Icons.send, color: Colors.blue),
//                                     onPressed: () {
//                                       if (ctlPhonu.text.isNotEmpty) {
//                                         _otp();
//                                       } else {
//                                         showDialog(
//                                             context: context,
//                                             builder: (context) => AlertDialog(
//                                               title: Text("Error"),
//                                               content: Text("Please enter a phone number"),
//                                               actions: [
//                                                 TextButton(
//                                                   onPressed: () {
//                                                     Navigator.pop(context);
//                                                   },
//                                                   child: Text("OK"),
//                                                 ),
//                                               ],
//                                             ));
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           if (isPhoneVerified) ...[
//                             Padding(
//                               padding: const EdgeInsets.all(5.5),
//                               child: BounceInRight(
//                                 child: TextFormField(
//                                   validator: (input) {
//                                     if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+.[a-zA-Z]+")
//                                         .hasMatch(input!)) {
//                                       return 'Please enter a valid email';
//                                     }
//                                     return null;
//                                   },
//                                   controller: ctlEmail,
//                                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                                   style: TextStyle(color: Colors.black),
//                                   keyboardType: TextInputType.emailAddress,
//                                   decoration: InputDecoration(
//                                     labelText: "Email",
//                                     fillColor: Colors.white,
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(25.0),
//                                       borderSide: BorderSide(color: bac),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(25.0),
//                                       borderSide: BorderSide(color: Colors.blue, width: 1.0),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(5.5),
//                               child: BounceInRight(
//                                 child: TextFormField(
//                                   validator: (input) {
//                                     if (input!.isEmpty) {
//                                       return 'Please select a date of birth';
//                                     }
//                                     return null;
//                                   },
//                                   controller: ctlDOB,
//                                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                                   style: TextStyle(color: Colors.black),
//                                   readOnly: true,
//                                   onTap: () {
//                                     _selectDate(context);
//                                   },
//                                   decoration: InputDecoration(
//                                     labelText: "Date of Birth",
//                                     fillColor: Colors.white,
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(25.0),
//                                       borderSide: BorderSide(color: bac),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(25.0),
//                                       borderSide: BorderSide(color: Colors.blue, width: 1.0),
//                                     ),
//                                     suffixIcon: Icon(Icons.calendar_today),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(5.5),
//                               child: BounceInRight(
//                                 child: DropdownButtonFormField<String>(
//                                   value: selectedGender,
//                                   items: ['Male', 'Female', 'Other']
//                                       .map((gender) => DropdownMenuItem<String>(
//                                     value: gender,
//                                     child: Text(gender),
//                                   ))
//                                       .toList(),
//                                   onChanged: (newValue) {
//                                     setState(() {
//                                       selectedGender = newValue;
//                                     });
//                                   },
//                                   decoration: InputDecoration(
//                                     labelText: "Gender",
//                                     fillColor: Colors.white,
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(25.0),
//                                       borderSide: BorderSide(color: bac),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(25.0),
//                                       borderSide: BorderSide(color: Colors.blue, width: 1.0),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(5.5),
//                               child: BounceInRight(
//                                 child: TextFormField(
//                                   validator: (input) {
//                                     if (input!.length < 6) {
//                                       return 'Password must be at least 6 characters long';
//                                     }
//                                     return null;
//                                   },
//                                   controller: ctlPassword,
//                                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                                   obscureText: !signIsPasswordVisible,
//                                   style: TextStyle(color: Colors.black),
//                                   decoration: InputDecoration(
//                                     labelText: "Password",
//                                     fillColor: Colors.white,
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(25.0),
//                                       borderSide: BorderSide(color: bac),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(25.0),
//                                       borderSide: BorderSide(color: Colors.blue, width: 1.0),
//                                     ),
//                                     suffixIcon: IconButton(
//                                       icon: Icon(
//                                         signIsPasswordVisible
//                                             ? Icons.visibility
//                                             : Icons.visibility_off,
//                                       ),
//                                       onPressed: () {
//                                         setState(() {
//                                           signIsPasswordVisible =
//                                           !signIsPasswordVisible;
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(5.5),
//                               child: BounceInRight(
//                                 child: TextFormField(
//                                   validator: (input) {
//                                     if (input != ctlPassword.text) {
//                                       return 'Passwords do not match';
//                                     }
//                                     return null;
//                                   },
//                                   controller: ctlConPass,
//                                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                                   obscureText: !signIsPasswordVisible1,
//                                   style: TextStyle(color: Colors.black),
//                                   decoration: InputDecoration(
//                                     labelText: "Confirm Password",
//                                     fillColor: Colors.white,
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(25.0),
//                                       borderSide: BorderSide(color: bac),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(25.0),
//                                       borderSide: BorderSide(color: Colors.blue, width: 1.0),
//                                     ),
//                                     suffixIcon: IconButton(
//                                       icon: Icon(
//                                         signIsPasswordVisible1
//                                             ? Icons.visibility
//                                             : Icons.visibility_off,
//                                       ),
//                                       onPressed: () {
//                                         setState(() {
//                                           signIsPasswordVisible1 =
//                                           !signIsPasswordVisible1;
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ]
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
