import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class joklis extends StatefulWidget {
  const joklis({super.key});

  @override
  State<joklis> createState() => _joklisState();
}

class _joklisState extends State<joklis> {
  @override
  void initState(){
    super.initState();
    basic();
  }///this state will run first
  // List data=[];
  var sample=[];
  basic()async{
    final response =await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon?offset=0&limit=20"));
    if(response.statusCode==200){
      setState(() {
        // data=json.decode(response.body)["results"];
        sample=json.decode(response.body);
        //print(data);
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 400,
            child: ListView.builder(
                itemCount: sample.length,
                itemBuilder: (BuildContext context,int index){
                  print(sample);
                  return Column(
                    children: [
                      Text(sample[index]["type"]),
                      Text(sample[index]["setup"]),
                      Text(sample[index]["punchline"]),
                      Text(sample[index]["id"])
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}