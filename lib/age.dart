import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class gen extends StatefulWidget {
  const gen({super.key});

  @override
  State<gen> createState() => _genState();
}

class _genState extends State<gen> {

  @override
  void initState() {
    fetchage();
    super.initState();
  }

  int count=0;
  String name="";
  int  gender=0;
  double probabi =0.0;
  fetchage() async {
    final response = await http.get(Uri.parse('https://api.agify.io?name=meelad'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        count = data['count'];
        name = data['name'];
        gender= data['gender'];
        probabi= data['probability'];

      });
    } else {
      setState(() {
        name = "You can't reload";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(count.toString()),
          Text(name),
          Text(gender.toString()),
         // Text(probabi.toString()),
          ElevatedButton(onPressed: (){
            fetchage();
          }, child: Text("good to go"))
        ],
      ),
    );
  }
}
