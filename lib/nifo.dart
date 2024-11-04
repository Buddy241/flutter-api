import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

class nifo extends StatefulWidget {
  const nifo({super.key});

  @override
  State<nifo> createState() => _nifoState();
}

class _nifoState extends State<nifo> {

  String username = "";
  String profile_image = "";
  String images = "";



  fetchstatqw() async {
    final response = await http.get(Uri.parse('http://52.7.84.60/staging/photoconnect/public/index.php/api/newsfeed?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vNTIuNy44NC42MC9zdGFnaW5nL3Bob3RvY29ubmVjdC9wdWJsaWMvaW5kZXgucGhwL2FwaS9sb2dpbl92ZXJpZnlfb3RwIiwiaWF0IjoxNzI4Mjk1MjcxLCJuYmYiOjE3MjgyOTUyNzEsImp0aSI6IndycEJzZWlOQ2NUWHg2eE8iLCJzdWIiOiI3OTMiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.DAsmHyN5N5Jj4uetyOOH9MhHxWJTUEe0965ra5CRKWc&page=1'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      setState(() {
        username =data['ip'];
        profile_image=data['city'];
        images=data['readme'];
      });
      print(data);
    } else {
      setState(() {
        images = 'Failed to load cat fact';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 90,),
         Text(username),
          Image(image: NetworkImage(profile_image)),
          Image(image: NetworkImage(images)),
        ],
      ),
    );
  }
}
