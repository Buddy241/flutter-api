
import 'package:Akash/model%20class/dog%20model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

class dog extends StatefulWidget {
  const dog({super.key});

  @override
  State<dog> createState() => _dogState();
}

class _dogState extends State<dog> {
  Future<dog1> fetch() async{
    var res = await http.get(Uri.parse("https://catfact.ninja/fact"));
    return dog1.fromJson(jsonDecode(res.body));
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

                      Image.network(snapshot.data!.message!),
                     Text(snapshot.data!.status.toString()),
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
