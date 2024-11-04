import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../color.dart';



class Comments extends StatefulWidget {
  final String userId;
  final String pollId;
  final String username;
  final String phoneno;
  final String gmail;

  const Comments({super.key, required this.userId, required this.pollId,required this.username,required this.phoneno,required this.gmail});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  void initState() {
    super.initState();
    fetchComments();
    _refresh();
  }
  bool isLikedByCurrentUser=false;
  bool replylike=false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _commentsController = TextEditingController();
  TextEditingController _replyController = TextEditingController();
  List<dynamic> comments = [];
  int? selectedIndex;
  String cmdid="";
  String uname="";

  Future<void> fetchComments() async {
    final response = await http.post(
      Uri.parse('http://49.204.232.254:64/comment/getbyid'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "poll_id": widget.pollId,
        "user_id":widget.userId
      }),
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      setState(() {
        comments = json.decode(response.body);
        //  cmdid = comments[]['_id'];
        print(comments);
      });
    } else {
      throw Exception('Failed to load comments');
    }
  }
  void setReplyText(String replyUserName) {
    _replyController.text = '@$replyUserName ';
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Validation Error'),
          content: Text('The value cannot be empty or null.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _refresh() async {
    // Simulate a network request or data refresh
    await Future.delayed(Duration(seconds: 2));

    fetchComments();
  }

  void _validateAndShowDialog() {
    String? valu1=_commentsController.text;
    String? value = _replyController.text;
    if (value.isEmpty||valu1.isEmpty) {
      _showAlertDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: back,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: back,
        leading: IconButton(
            onPressed: (){
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => userdraw3(userid: widget.userId,username: widget.username,email: widget.gmail,phoneno: widget.phoneno,)));
            },

            icon: Icon(Icons.arrow_back_ios,color: Colors.white)),
        title: Text("Comments",style: GoogleFonts.poppins(fontSize: 20,color: Colors.white),),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {

                    final comment = comments[index];
                    cmdid=comment['_id'];
                    print(cmdid);
                    if (comment.containsKey('user_id')){
                      var uidobj=comment['user_id'];
                      uname = uidobj['user_name'];
                      print(uidobj);
                    }
                    List a=comment['likers'];
                    int b=a.length;
                    String likecount=b.toString();
                    isLikedByCurrentUser=comment["isLiked"];
                    print(isLikedByCurrentUser);

                    return Padding(
                      padding:  EdgeInsets.only(left: 8.0),
                      child: Container(
                        // decoration: BoxDecoration(border: Border.all()),
                        width: 400,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = selectedIndex == index ? null : index;
                            });
                          },
                          child: Container(
                            width: 300,
                            // decoration: BoxDecoration(border: Border.all()),
                            child: Column(

                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.person),
                                    SizedBox(
                                      width: 350,
                                      child: Text("${uname} : ${comment['comment']!}",
                                        style: TextStyle(color: Colors.black, fontSize: 20),
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(right:10.0),
                                      child: IconButton(

                                          onPressed: () async {
                                            final url = 'http://49.204.232.254:64/comment/likecomment';

                                            // print(widget.authorid);
                                            final response = await http.post(
                                              Uri.parse(url),
                                              body: jsonEncode({
                                                "user_id":widget.userId,
                                                "comment_id":comment['_id'],
                                              }),
                                              headers: {
                                                'Content-Type': 'application/json',
                                              },
                                            );
                                            // print('_isLike after API call: ${_isFollowing}');


                                            final responseData = jsonDecode(response.body);

                                            if (responseData['message'] == "Comment liked successfully") {
                                              isLikedByCurrentUser = true;
                                              print('Like recorded successfully');
                                            } else if (responseData['message'] == "Like removed successfully") {
                                              isLikedByCurrentUser = false;
                                              print('liked user successfully.');
                                            } else {
                                              print('Like removed successfully.');
                                            }
                                            fetchComments();
                                          },
                                          icon: isLikedByCurrentUser? Column(
                                            children: [

                                              Icon(Icons.favorite,color: Colors.red,),
                                              Text(likecount),
                                            ],
                                          ): Column(
                                            children: [

                                              Icon(Icons.favorite_border_sharp,color: Colors.black,),
                                              likecount.isEmpty?Text("0"):Text(likecount),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    SizedBox(width: 100,),
                                    Text("${comment["replies"].length.toString()} Replies",style: TextStyle(color: Colors.black),),
                                    SizedBox(height: 20,),
                                  ],
                                ),
                                if (selectedIndex == index)
                                  Container(
                                    width: 430,
                                    // decoration: BoxDecoration(border: Border.all()),
                                    child: Column(
                                      children: [

                                        ...comment['replies'].map<Widget>((reply) {
                                          print(reply);
                                          String replyUserName = '';

                                          if (reply.containsKey('user_id')) {
                                            var replyUidObj = reply['user_id'];
                                            replyUserName = replyUidObj['user_name'];
                                            // replylike = replyUidObj['isLiked'];
                                            // print("aaaaaaabcd${replylike}");
                                          }
                                          replylike=reply['isLiked'];
                                          print(replylike);
                                          List count=reply['likers'];
                                          print(count.length);


                                          return Row(
                                            children: [
                                              SizedBox(width: 35,),
                                              const Icon(Icons.person),
                                              Card(
                                                child: Expanded(
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      setReplyText(replyUserName);
                                                    },
                                                    child: SizedBox(
                                                      width: 350,
                                                      child: Text("${replyUserName} : ${reply['reply_msg']}",
                                                        style: TextStyle(color: Colors.black, fontSize: 16),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(right: 5.0),
                                                child: IconButton(

                                                    onPressed: () async {
                                                      final url = 'http://49.204.232.254:64/comment/likereply';

                                                      // print(widget.authorid);
                                                      final response = await http.post(
                                                        Uri.parse(url),
                                                        body: jsonEncode({
                                                          "user_id":widget.userId,
                                                          "comment_id":comment['_id'],
                                                          "reply_id":reply['_id'],
                                                        }),
                                                        headers: {
                                                          'Content-Type': 'application/json',
                                                        },
                                                      );
                                                      // print('_isLike after API call: ${_isFollowing}');


                                                      final responseData = jsonDecode(response.body);

                                                      if (responseData['message'] == "Comment liked successfully") {
                                                        replylike = true;
                                                        print('Like recorded successfully');
                                                      } else if (responseData['message'] == "Like removed successfully") {
                                                        replylike = false;
                                                        print('liked user successfully.');
                                                      } else {
                                                        print('Like removed successfully.');
                                                      }
                                                      fetchComments();


                                                    },
                                                    icon: reply['isLiked']? Column(
                                                      children: [
                                                        Icon(Icons.favorite,color: Colors.red,),
                                                        Text(count.length.toString())
                                                      ],
                                                    ): Column(
                                                      children: [

                                                        Icon(Icons.favorite_border_sharp,color: Colors.black,),
                                                        count.length.toString().isEmpty?Text("0"):Text(count.length.toString())
                                                      ],
                                                    )),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(left: 38.0),
                                                child: Container(
                                                  width: 310,
                                                  child: TextFormField(
                                                    validator: (value){
                                                      if(value!.isEmpty||value==null){
                                                        return "Enter data";
                                                      }
                                                    },
                                                    controller: _replyController,
                                                    decoration: InputDecoration(
                                                      hintText: 'Write a reply...',
                                                      suffixIcon: IconButton(
                                                        icon: Icon(Icons.send),
                                                        onPressed: () async {
                                                          if (_formKey.currentState!.validate()) {
                                                            print("aaaaaaaaaaaa${widget.pollId}");
                                                            final url = Uri.parse('http://49.204.232.254:64/comment/replycomment');
                                                            final headers = {'Content-Type': 'application/json'};

                                                            final body = jsonEncode({
                                                              "poll_id": widget.pollId,
                                                              "user_id": widget.userId,
                                                              "reply_msg": _replyController.text,
                                                              "comment_id": comment['_id']
                                                            });

                                                            _replyController.clear();

                                                            final response = await http.post(url, headers: headers, body: body);

                                                            if (response.statusCode == 200 || response.statusCode == 201) {
                                                              // Handle success
                                                              print('Comment created successfully');
                                                              // Optionally refresh the comments
                                                              fetchComments();
                                                            } else {
                                                              // Handle error
                                                              print('Failed to create comment: ${response.statusCode}');
                                                              // You can show an error message to the user or handle the error accordingly
                                                            }
                                                          } else {
                                                            showErrorDialog("Reply cannot be empty.");
                                                          }
                                                          // Handle the reply action
                                                        },
                                                      ),
                                                    ),

                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _commentsController,
                      maxLength: 300,
                      maxLines: null,  // Allows the text field to grow vertically
                      keyboardType: TextInputType.multiline,
                      scrollController: ScrollController(), // Enables scrolling
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200], // Set the background color to light gray
                        hintText: 'Enter your text here',
                        contentPadding: EdgeInsets.all(8.0),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            final url = Uri.parse('http://49.204.232.254:64/comment/createcomment');
                            final headers = {'Content-Type': 'application/json'};
                            final body = jsonEncode({
                              "poll_id": widget.pollId,
                              "user_id": widget.userId,
                              "comment": _commentsController.text,
                            });

                            // Clear the text field before sending the comment
                            final commentText = _commentsController.text; // Store the text to send
                            _commentsController.clear(); // Clear the text field

                            // Dismiss the keyboard
                            FocusScope.of(context).unfocus();

                            final response = await http.post(url, headers: headers, body: body);

                            if (response.statusCode == 200 || response.statusCode == 201) {
                              // Handle success
                              print('Comment created successfully');
                              fetchComments(); // Optionally refresh comments
                            } else {
                              // Handle error
                              print('Failed to create comment: ${response.statusCode}');
                            }
                          },
                          icon: Icon(Icons.send, color: Colors.black),
                        ),

                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void handleSubmit() async {
  }
}
