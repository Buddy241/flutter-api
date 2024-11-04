import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import '../model class/facke.dart';
class azx extends StatefulWidget {
  const azx({super.key});

  @override
  State<azx> createState() => _azxState();
}

class _azxState extends State<azx> {
  Future<List<Sonjdart>> fatch()async{
    var res = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    var data = jsonDecode(res.body);
    return (data as List).map((json) => Sonjdart.fromJson(json)).toList();
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
                  List<Sonjdart> list = snapshot.data!;
                  return Container(
                    height: 800,
                    child: ListView.builder(
                      itemCount: list.length,
                        itemBuilder: (BuildContext context, int index){
                          return ListTile(
                            leading: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(list[index].image!),fit: BoxFit.fill
                                )
                              ),
                            ),
                            title: Column(
                              children: [
                                Text(list[index].id.toString()),
                                Text(list[index].price.toString()),
                                Text(list[index].title.toString()),
                                Text(list[index].description.toString()),
                                Text(list[index].category.toString()),
                                Text(list[index].rating!.rate.toString()),
                                Text(list[index].rating!.count.toString()),
                              ],
                            ),
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

