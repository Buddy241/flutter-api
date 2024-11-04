import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

import '../facke class/prod121.dart';
class prod21 extends StatefulWidget {
  const prod21({super.key});

  @override
  State<prod21> createState() => _prod21State();
}

class _prod21State extends State<prod21> {
  Future<List<product>> fetch()async{
    var res = await http.get(Uri.parse("https://fakestoreapi.com/products/category/jewelery"));
    var data = jsonDecode(res.body);
    return (data as List).map((json)=> product.fromJson(json)).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: fetch(),
              builder: (BuildContext context, snapshot){
                if(snapshot.hasData){
                  List<product> list = snapshot.data!;
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
                              //Text(list[index].co.toString()),

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
