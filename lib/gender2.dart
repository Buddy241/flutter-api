import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';


class gen2 extends StatefulWidget {
  const gen2({super.key});

  @override
  State<gen2> createState() => _gen2State();
}

class _gen2State extends State<gen2> {
  int gencount = 0;
  String gename = "";
  String gen ="";
  double genprob = 0.0;

  getgen2() async{
    final genresponse = await http.get(Uri.parse("https://api.genderize.io?name=luc"));
    //print(genresponse.data);
    if(genresponse.statusCode==200){
      final data = json.decode(genresponse.body);
      print(data);
      setState(() {
        gencount = data['count'];
        gename = data['name'];
        gen = data['gender'];
        genprob = data['probability'];
      });
    }
    else {
      setState(() {
        gename = "You can't reload this page";
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(gencount.toString()),
          Text(gename),
          Text(gen),
          Text(genprob.toString()),
          ElevatedButton(onPressed: (){
            getgen2();
          }, child: Text("Get"))
        ],
      ),
    );
  }
}
