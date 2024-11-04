import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class api extends StatefulWidget {
  const api({super.key});

  @override
  State<api> createState() => _apiState();
}

class _apiState extends State<api> {
  String  cat = "";
  int lin =0;
  fetchCatFact() async {
    final response = await http.get(Uri.parse('https://catfact.ninja/fact'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      setState(() {
        cat = data['fact'];
        lin= data['length'];
      });
      print(data);

    } else {
      setState(() {
        cat = 'Failed to load cat fact';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          ElevatedButton(onPressed: (){
            fetchCatFact();
          }, child: Text("update")),
          Text(cat),
          Text(lin.toString())
        ],
      ),
    );
  }
}
