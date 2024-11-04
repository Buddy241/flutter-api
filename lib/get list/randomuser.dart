import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class randomuser extends StatefulWidget {
  const randomuser({super.key});

  @override
  State<randomuser> createState() => _randomuserState();
}

class _randomuserState extends State<randomuser> {
  @override
  void initState(){
    super.initState();
    basic();
  }///this state will run first
  List data=[];
  var sample={};
  basic()async{
    final response =await http.get(Uri.parse("https://randomuser.me/api/"));
    print(response.statusCode);
    if(response.statusCode==200){
      setState(() {
        data=json.decode(response.body)["results"];
        // sample=json.decode(response.body)["info"];
        print(data);
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
                itemCount: data.length,
                itemBuilder: (BuildContext context,int index){
                  print(data);
                  return Column(
                    children: [
                      Text(data[index]["gender"]),
                      Text(data[index]["name"]["title"]),
                      Text(data[index]["location"]["street"]['number'].toString()),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}