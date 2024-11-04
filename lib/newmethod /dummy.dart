
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

class product extends StatefulWidget {
  const product({super.key});

  @override
  State<product> createState() => _productState();
}

class _productState extends State<product> {
  @override
  void initState(){
    super.initState();
    getproduct();
  }
  List data = [];
  getproduct()async{
    final response = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    if(response.statusCode==200){
      setState(() {
        data = json.decode(response.body);
        print(data);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 600,
            child: ListView.builder(
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
          ElevatedButton(onPressed: (){}, child: Text("ok"))
        ],
      ),
    );
  }
}