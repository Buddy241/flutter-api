import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class postapi extends StatefulWidget {
  const postapi({super.key});

  @override
  State<postapi> createState() => _postapiState();
}

class _postapiState extends State<postapi> {
  TextEditingController a = TextEditingController();
  TextEditingController b = TextEditingController();
  TextEditingController c = TextEditingController();
  TextEditingController d = TextEditingController();
  fetchdata() async {
    final response = await http.post(
        Uri.parse(
            "http://catodotest.elevadosoftwares.com/Category/InsertCategory"),
        headers: {"content-type": "application/json"},
        body: json.encode({
          "categoryId ": int.parse(a.text),
          "category ": b.text,
          "description": c.text,
          "createdBy": int.parse(d.text)
        }));
    if (response.statusCode == 200) {
      print("successfully");
    } else {
      print("error");
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
