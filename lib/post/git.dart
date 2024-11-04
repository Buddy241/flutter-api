import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class git extends StatefulWidget {
  const git({super.key});

  @override
  State<git> createState() => _gitState();
}

class _gitState extends State<git> {
  TextEditingController a = TextEditingController();
  TextEditingController b = TextEditingController();
  var sample = {};
  fetchdata() async {
    final response = await http.post(
        Uri.parse(
            "http://92.205.109.210:8028/user/login"),
        headers: {"content-type": "application/json"},
        body: json.encode({

          "phno":975858655,
          "password":123456

        }));
    if (response.statusCode == 200||response.statusCode==201) {
      print(response.body);
      setState(() {
        sample=json.decode(response.body)["New Employee"];
      });
      print("Category inserted successfully");
    } else {
      print("Failed to insert the category.Status code:${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: a,
          ),
          TextFormField(
            controller: b,
          ),
         
          
          ElevatedButton(onPressed: () {
            fetchdata();
          }, child: Text("ok"))
        ],
      ),
    );
  }
}
