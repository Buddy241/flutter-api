import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class postapi2 extends StatefulWidget {
  const postapi2({super.key});

  @override
  State<postapi2> createState() => _postapi2State();
}

class _postapi2State extends State<postapi2> {
  String _selectedCategory = "General";
  List<String> categories = [
    "General",
    "Movies",
    "Education",
    "Fun",
    "News",
  ];

  List<DropdownMenuItem<String>> getDropdownItems() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String category in categories) {
      var newItem = DropdownMenuItem(
        value: category,
        child: Text(category),
      );
      dropdownItems.add(newItem);
    }
    return dropdownItems;
  }

  var sample = {};
  fetchdata() async {
    final response = await http.post(
        Uri.parse(
            "http://92.205.109.210:8028/category/create"),
        headers: {"content-type": "application/json"},
        body: json.encode({
          "category_name":[]

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
          ListTile(
            leading: const Text(
              "Category",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            title: DropdownButton<String>(
              value: _selectedCategory,
              items: getDropdownItems(),
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
            ),
          ),
          ElevatedButton(onPressed: () {
            fetchdata();
          }, child: Text("ok"))
        ],
      ),
    );
  }
}
