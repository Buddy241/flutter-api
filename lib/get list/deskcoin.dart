import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;


class coin extends StatefulWidget {
  const coin({super.key});

  @override
  State<coin> createState() => _coinState();
}

class _coinState extends State<coin> {
  @override
  void initState(){
    super.initState();
    basic();
  }///this state will run first
  var sample={};
  var sample1 ={};
  basic()async{
    final response =await http.get(Uri.parse("https://api.coindesk.com/v1/bpi/currentprice.json"));
    if(response.statusCode==200){
      setState(() {
        sample=json.decode(response.body)["bpi"];
        sample1 = jsonDecode(response.body)["time"];
        print(sample);
        print(sample1);
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(sample["USD"].toString()),
          Text(sample1["updated"].toString())

        ],
      ),
    );
  }
}
