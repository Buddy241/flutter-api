import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
class ama2 extends StatefulWidget {
  const ama2({super.key});

  @override
  State<ama2> createState() => _ama2State();
}

class _ama2State extends State<ama2> {
  void initState(){
    super.initState();
    maare();
  }
  var sample ={};
  List data = [];
  maare()async{
    final response = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    if(response.statusCode==200){
      setState(() {
        sample = json.decode(response.body);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index){
                // return data.isEmpty?CircularProgressIndicator():GestureDetector(
                //   onTap: (){
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => product1(
                //         id:data[index]["id"]
                //       )),
                //     );
                //   },
                //   child:
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
                      Text(data[index]["description"].toString()),
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

        ],
      ),
    );
  }
}
