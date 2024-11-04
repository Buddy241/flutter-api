import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

class ip extends StatefulWidget {
  const ip({super.key});

  @override
  State<ip> createState() => _ipState();
}

class _ipState extends State<ip> {

  String stat = "";

  fetchstatqw() async {
    final response = await http.get(Uri.parse('https://api.ipify.org?format=json'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      setState(() {

        stat = data['ip'];
      });
      print(data);

    } else {
      setState(() {
        stat = 'Failed to load cat fact';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 90,),
          ElevatedButton(onPressed: (){
            fetchstatqw();
          }, child: Text("ip a")),
          Text(stat),
        ],
      ),
    );
  }
}
