import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';

import '../facke class/sing.dart';

class singlefact extends StatefulWidget {
  const singlefact({super.key});

  @override
  State<singlefact> createState() => _singlefactState();
}

class _singlefactState extends State<singlefact> {
  Future<List<singlepro>> fatch()async{
    var res = await http.get(Uri.parse("https://fakestoreapi.com/products/1"));
    var data= jsonDecode(res.body);
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
