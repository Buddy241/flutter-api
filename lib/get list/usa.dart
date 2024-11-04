import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;


class usa extends StatefulWidget {
  const usa({super.key});

  @override
  State<usa> createState() => _usaState();
}

class _usaState extends State<usa> {
  @override
  void initState(){
    super.initState();
    basic();
  }///this state will run first
  List data=[];
  List data1=[];
  basic()async{
    final response =await http.get(Uri.parse("https://datausa.io/api/data?drilldowns=Nation&measures=Population"));
    if(response.statusCode==200){
      setState(() {
        data=json.decode(response.body)["data"];
       data1 = jsonDecode(response.body)["source"];
        print(data);
        print(data1);
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
                          Text(data[index]["source"]),
                          Text(data[index]["data"]),
                        ],
                      );
                    }),
              )
            ],
          ),
    );


  }
}
