import 'package:Akash/model%20class/agiefi%20model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

class age1 extends StatefulWidget {
  const age1({super.key});

  @override
  State<age1> createState() => _age1State();
}

class _age1State extends State<age1> {
  Future<ip11> fetch() async{
    var res = await http.get(Uri.parse("https://catfact.ninja/fact"));
    return ip11.fromJson(jsonDecode(res.body));
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
                      Text(snapshot.data!.name.toString()),
                      Text(snapshot.data!.count.toString()),
                      Text(snapshot.data!.age.toString()),
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
