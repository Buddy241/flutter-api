import 'package:Akash/model%20class/agiefi%20model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

import '../model class/ip model.dart';

class ip12 extends StatefulWidget {
  const ip12({super.key});

  @override
  State<ip12> createState() => _ip12State();
}

class _ip12State extends State<ip12> {
  Future<info31> fetch() async{
    var res = await http.get(Uri.parse("https://api.ipify.org?format=json"));
    return info31.fromJson(jsonDecode(res.body));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(future: fetch(),
              builder: (BuildContext context , snapshot){
                if(snapshot.hasData){
                  return Column(
                    children: [
                     Text(snapshot.data!.ip.toString())

                    ],
                  );
                } else if(snapshot.hasError){
                  return Text("${snapshot.error}");
                }return CircularProgressIndicator();
              })
        ],
      ),
    );
  }
}
