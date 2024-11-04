import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';

import '../facke class/listterfac.dart';

class limifac extends StatefulWidget {
  const limifac({super.key});



  @override
  State<limifac> createState() => _limifacState();
}
class _limifacState extends State<limifac> {
  Future<List<limiters>> fatch()async{
    var res = await http.get(Uri.parse("http://52.7.84.60/staging/photoconnect/public/index.php/api/newsfeed?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vNTIuNy44NC42MC9zdGFnaW5nL3Bob3RvY29ubmVjdC9wdWJsaWMvaW5kZXgucGhwL2FwaS9sb2dpbl92ZXJpZnlfb3RwIiwiaWF0IjoxNzI4Mjk1MjcxLCJuYmYiOjE3MjgyOTUyNzEsImp0aSI6IndycEJzZWlOQ2NUWHg2eE8iLCJzdWIiOiI3OTMiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.DAsmHyN5N5Jj4uetyOOH9MhHxWJTUEe0965ra5CRKWc&page=1"));
    var data = jsonDecode(res.body);
    return (data as List).map((json) => limiters.fromJson(json)).toList();
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
                  List<limiters> list = snapshot.data!;
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
