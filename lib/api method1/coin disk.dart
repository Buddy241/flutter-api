import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model class/coin model.dart';
class getApi extends StatefulWidget {
  const getApi({super.key});

  @override
  State<getApi> createState() => _getApiState();
}

class _getApiState extends State<getApi> {

  Future<Genderize> fetch() async {
    var res = await http.get(Uri.parse("https://api.coindesk.com/v1/bpi/currentprice.json"));/// dart dosnot support the https
    return Genderize.fromJson(jsonDecode(res.body));/// decoding from josn
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: fetch(),
              builder: (BuildContext context , snapshot){
                if(snapshot.hasData)/// it takes the data from online
                  {
                  print(snapshot.data!.time!.updatedISO.toString() + "  count");///print the statment in the terminal
                  return Column(
                    children: [
                      Text(snapshot.data!.bpi!.uSD!.description.toString()),
                      Text(snapshot.data!.bpi!.eUR!.code.toString()),
                      Text(snapshot.data!.bpi!.uSD!.code.toString()),
                      Text(snapshot.data!.bpi!.uSD!.code.toString()),
                      Text(snapshot.data!.bpi!.uSD!.code.toString()),
                      Text(snapshot.data!.bpi!.uSD!.code.toString()),
                      Text(snapshot.data!.bpi!.uSD!.code.toString()),
                    ],
                  );
                } else if (snapshot.hasError){
                  return Text("${snapshot.error}");
                } return CircularProgressIndicator();/// its indigates the user to wait it is loding the page
              }
          )
        ],
      ),
    );
  }
}