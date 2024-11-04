import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';

import '../model class/jokes model.dart';

class joke extends StatefulWidget {
  const joke({super.key});

  @override
  State<joke> createState() => _jokeState();
}

class _jokeState extends State<joke> {
  Future<joke1> fetch() async{
    var res= await http.get(Uri.parse("https://official-joke-api.appspot.com/random_joke"));
  return joke1.fromJson(jsonDecode(res.body));
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
                   Text(snapshot.data!.id.toString()),
                   Text(snapshot.data!.type.toString()),
                   Text(snapshot.data!.punchline.toString()),
                   Text(snapshot.data!.id.toString()),
                 ],
               );
             }else if (snapshot.hasError){
               return Text("${snapshot.error}");
             }return CircularProgressIndicator();
              }
              )
        ],
      ),
    );
  }
}
