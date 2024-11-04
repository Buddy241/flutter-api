import 'dart:convert';
import 'dart:core';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class postapi5 extends StatefulWidget {
  const postapi5({super.key});

  @override
  State<postapi5> createState() => _postapi5State();
}

class _postapi5State extends State<postapi5> {
  TextEditingController a = TextEditingController();



  var sample = {};
  fetchdata() async {
    final response = await http.post(
        Uri.parse(
            "http://49.204.232.254:98/gt/employee/delete"),
        headers: {"content-type": "application/json"},
        body: json.encode({
          "employee_id ": a.text,

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


          ElevatedButton(onPressed: () {
            fetchdata();
          }, child: Text("ok"))
        ],
      ),
    );
  }
}
