import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

class koje extends StatefulWidget {
  const koje({super.key});

  @override
  State<koje> createState() => _kojeState();
}

class _kojeState extends State<koje> {

  String type = "";
  String setup = "";
  String punchline = "";
  int id = 0;



  fetchstatqwe() async {
    final response = await http.get(Uri.parse('https://official-joke-api.appspot.com/random_joke'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      setState(() {
        type =data['type'];
        setup =data['setup'];
        punchline =data['punchline'];
        id =data['id'];
      });
    } else {
      setState(() {
        type = 'Failed to load cat fact';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 90,),
          ElevatedButton(onPressed: (){fetchstatqwe();}, child: Text("ipa")),
          Text(type.toString()),
          Text(setup.toString()),
          Text(punchline.toString()),
          Text(id.toString()),



        ],
      ),
    );
  }
}
