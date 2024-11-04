import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

import '../facke class/sing.dart';
class shortfak extends StatefulWidget {
  const shortfak({super.key});

  @override
  State<shortfak> createState() => _shortfakState();
}

class _shortfakState extends State<shortfak> {
  Future<List<singlepro>> fatch()async{
    var res = await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon?offset=0&limit=20"));
    var data = jsonDecode(res.body);
    return (data as List).map((json) => singlepro.fromJson(json)).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: fatch(),
              builder: (BuildContext context, snapshot){
                if(snapshot.hasData){
                  List<singlepro> list = snapshot.data!;
                  return Container(
                    height: 800,
                    child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index){
                          return  Column(
                            children: [
                              Text(list[index].id.toString()),
                              Text(list[index].title.toString()),
                              Text(list[index].price.toString()),
                              Text(list[index].description.toString()),
                              Text(list[index].category.toString()),
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(list[index].image!),fit: BoxFit.fill
                                    )
                                ),
                              ),
                              Text(list[index].rating.toString()),

                            ],
                          );
                        }
                    ),
                  );
                } else if(snapshot.hasError){
                  return Text("${snapshot.error}");
                } return CircularProgressIndicator();
              }
          )
        ],
      ),
    );
  }
}
