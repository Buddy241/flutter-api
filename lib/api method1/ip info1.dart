import 'package:Akash/model%20class/agiefi%20model.dart';
import 'package:Akash/model%20class/all.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

import '../model class/ip model.dart';

class info11 extends StatefulWidget {
  const info11({super.key});

  @override
  State<info11> createState() => _info11State();
}

class _info11State extends State<info11> {
  Future<all01> fetch() async{
    var res = await http.get(Uri.parse("https://ipinfo.io/161.185.160.93/geo"));
    return all01.fromJson(jsonDecode(res.body));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(future: fetch(),
              builder: (BuildContext context , snapshot){
                if(snapshot.hasData){
                  return Column(
                    children: [
                      Text(snapshot.data!.ip.toString()),
                      Text(snapshot.data!.city.toString()),
                      Text(snapshot.data!.country.toString()),
                      Text(snapshot.data!.loc.toString()),
                      Text(snapshot.data!.org.toString()),
                      Text(snapshot.data!.postal.toString()),
                      Text(snapshot.data!.timezone.toString()),
                      Text(snapshot.data!.readme.toString()),
                      Text(snapshot.data!.region.toString()),

                    ],
                  );
                } else if(snapshot.hasError){
                  return Text("${snapshot.error}");
                }return CircularProgressIndicator();
              })
        ],
      ),
    );
  }
}
