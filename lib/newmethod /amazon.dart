import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
class amzle extends StatefulWidget {
  const amzle({super.key});

  @override
  State<amzle> createState() => _amzleState();
}

class _amzleState extends State<amzle> {
  @override
  void initState(){
    super.initState();
    getamz();
  }
  List data = [];
  getamz()async{
    final response = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    print(response.statusCode);
    if(response.statusCode==200){
      setState(() {
        data = json.decode(response.body);
        print(data);
      });
    }else {
      print("888");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 900,
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                   height: 200,
                    width: 400,
                    decoration: BoxDecoration(
                        border: Border.all()
                    ),
                    child: Column(
                      children: [
                        // Text(data[index].toString()),
                        Text(data[index]["id"].toString()),
                        Text(data[index]["title"].toString()),
                        Text(data[index]["price"].toString()),
                        Text(data[index]["category"].toString()),
                        Text(data[index]["rating"].toString()),
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: NetworkImage(data[index]["image"]))
                          ),
                        )

                      ],
                    ),
                  );

                }),
          ),

        ],
      ),
    );
  }
}
