import 'package:Akash/facke%20class/specificcategory1.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
class specifilis extends StatefulWidget {
  const specifilis({super.key});

  @override
  State<specifilis> createState() => _specifilisState();
}

class _specifilisState extends State<specifilis> {
  Future<List<specificcategory>> fatch()async{
    var res = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    var data = jsonDecode(res.body);
    return (data as List).map((json) => specificcategory.fromJson(json)).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:  Column(
        children: [
          FutureBuilder(
              future: fatch(),
              builder: (BuildContext context, snapshot){
                if(snapshot.hasData){
                  List<specificcategory> list = snapshot.data!;
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
