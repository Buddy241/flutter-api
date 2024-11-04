import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

class dogs extends StatefulWidget {
  const dogs({super.key});

  @override
  State<dogs> createState() => _dogsState();
}

class _dogsState extends State<dogs> {
 String mess ="";
 String stat ="";
 fetchstatFact() async {
   final response = await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
   print(response.statusCode);
   if (response.statusCode == 200) {
     final data = json.decode(response.body);
     print(data);
     setState(() {
       mess = data['message'];
       stat = data['status'];
     });
     print(data);

   } else {
     setState(() {
       mess = 'Failed to load cat fact';
     }
     );
   }
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 90,),
          ElevatedButton(onPressed: (){
            fetchstatFact();
          }, child: Text("good boy")),
          Image.network(mess),
          Text(stat),
        ],
      ),
    );
  }
}
