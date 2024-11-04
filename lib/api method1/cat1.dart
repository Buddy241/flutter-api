import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Page1 extends StatefulWidget {
  const Page1({super.key});
  @override
  State<Page1> createState() => _Page1State();
}
class _Page1State extends State<Page1> {
  Future<List<dynamic>> fetch() async {
    try {
      print('Fetching data...');
      var res = await http.get(Uri.parse(
          "http://52.7.84.60/staging/photoconnect/public/index.php/api/newsfeed?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vNTIuNy44NC42MC9zdGFnaW5nL3Bob3RvY29ubmVjdC9wdWJsaWMvaW5kZXgucGhwL2FwaS9sb2dpbl92ZXJpZnlfb3RwIiwiaWF0IjoxNzI4Mjk1MjcxLCJuYmYiOjE3MjgyOTUyNzEsImp0aSI6IndycEJzZWlOQ2NUWHg2eE8iLCJzdWIiOiI3OTMiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.DAsmHyN5N5Jj4uetyOOH9MhHxWJTUEe0965ra5CRKWc&page=1"));
      if (res.statusCode == 200) {
        print('Response body: ${res.body}');
        try {
          var data = jsonDecode(res.body);
          print('Decoded JSON: $data');
          return data['newsfeed'];
        } catch (jsonError) {
          print('JSON Decoding Error: $jsonError');
          throw Exception('Failed to parse JSON');
        }
      } else {
        print('Server Error: ${res.statusCode}');
        throw Exception('Failed to fetch data from server');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('An error occurred while fetching data');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[50],
        leading: Icon(
          Icons.location_on_sharp,
          color: Colors.blue[400],
        ),
        title: const ListTile(
          leading: Text(
            "Chennai",
            style: TextStyle(fontSize: 20),
          ),
          title: Align(
            alignment: Alignment.topLeft,
            child: Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 30,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(8.0), // Smooth corner buttons
                ),
              ),
              onPressed: () {},
              child: const Text("Add Post",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          )
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final newsfeedData = snapshot.data!;
            return ListView.builder(
              itemCount: newsfeedData.length,
              itemBuilder: (context, index) {
                final item = newsfeedData[index];
                final profileImage = item['profile_image'] ?? '';
                final userName = item['user_name'] ?? 'User';
                final newsfeedImage = item['newsfeed_image'] ?? '';
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                                border: Border.all(),
                                image: DecorationImage(
                                  image: NetworkImage(profileImage),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            userName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ), // Username
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text("Follow",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white))),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.more_horiz, size: 25)),
                        ],
                      ),
                      if (newsfeedImage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            newsfeedImage,
                            height: 300,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 27,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.home_outlined,
                color: Colors.blue,
                size: 25,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.storefront,
                size: 25,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.camera_alt_outlined,
                size: 25,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_bag_outlined,
                size: 25,
              ),
            ),
            Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                border: Border.all(),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://via.placeholder.com/25'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
