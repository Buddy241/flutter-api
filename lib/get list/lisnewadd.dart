import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../facke class/addnewlist.dart';


class lisnewadd extends StatefulWidget {
  const lisnewadd({super.key});

  @override
  State<lisnewadd> createState() => _lisnewaddState();
}

class _lisnewaddState extends State<lisnewadd> {
  Future<List<addnewlis>> fatch()async{
    var res = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    var data = jsonDecode(res.body);
    return (data as List).map((json) => addnewlis.fromJson(json)).toList();
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
                  List<addnewlis> list = snapshot.data!;
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







