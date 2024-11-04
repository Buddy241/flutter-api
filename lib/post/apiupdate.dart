import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class postapi3 extends StatefulWidget {
  const postapi3({super.key});

  @override
  State<postapi3> createState() => _postapi3State();
}

class _postapi3State extends State<postapi3> {
  TextEditingController a = TextEditingController();
  TextEditingController b = TextEditingController();
  TextEditingController c = TextEditingController();
  TextEditingController d = TextEditingController();


  var sample = {};
  fetchdata() async {
    final response = await http.post(
        Uri.parse(
            "http://49.204.232.254:98/gt/employee/create"),
        headers: {"content-type": "application/json"},
        body: json.encode({
          "employee_id ": a.text,
          "employee_name": b.text,
          "employee_phone": c.text,
          "employee_address":d.text,
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
          TextFormField(
            controller: c,
          ),
          TextFormField(
            controller: d,
          ),


          ElevatedButton(onPressed: () {
            fetchdata();
          }, child: Text("ok"))
        ],
      ),
    );
  }
}
