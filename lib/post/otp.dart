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
  TextEditingController number = TextEditingController();
  TextEditingController appname = TextEditingController();

  var sample = {};
  fetchdata() async {
    final response = await http.post(
        Uri.parse(
            "http://92.205.109.210:8028/mobileauth/send-otp-sms"),
        headers: {"content-type": "application/json"},
        body: json.encode({}));
    if (response.statusCode == 200||response.statusCode==201) {
      print(response.body);
      setState(() {
        sample=json.decode(response.body);
      });
      print(" successfully");
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
            controller: number,
          ),
          TextFormField(
            controller: appname,
          ),

          ElevatedButton(onPressed: () {
            fetchdata();
          }, child: Text(""))
        ],
      ),
    );
  }
}
