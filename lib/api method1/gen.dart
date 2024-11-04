import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';

import '../model class/gen model.dart';
class gen11 extends StatefulWidget {
  const gen11({super.key});

  @override
  State<gen11> createState() => _gen11State();
}

class _gen11State extends State<gen11> {
  Future<gen1>fetch() async{
    var res= await http.get(Uri.parse("https://api.genderize.io?name=luc"));
   return gen1.fromJson(jsonDecode(res.body));
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
                   Text(snapshot.data!.count!.toString()),
                   Text(snapshot.data!.name.toString()),
                   Text(snapshot.data!.gender.toString()),
                   Text(snapshot.data!.probability.toString()),
                 ],
               );
             }else if (snapshot.hasError){
               return Text("${snapshot.error}");
             }return CircularProgressIndicator();
              })
        ],
      ),
    );
  }
}
