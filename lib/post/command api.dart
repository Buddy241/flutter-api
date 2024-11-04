// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class CommentPage extends StatefulWidget {
//   const CommentPage({super.key});
//
//   @override
//   State<CommentPage> createState() => _CommentPageState();
// }
//
// class _CommentPageState extends State<CommentPage> {
//   final TextEditingController _commentController = TextEditingController();
//   final Map<int, TextEditingController> _replyControllers = {};
//   final List<Map<String, dynamic>> comments = [];
//   fetchdata() async {
//     final response = await http.post(
//         Uri.parse(
//             "http://49.204.232.254:98/gt/employee/create"),
//         headers: {"content-type": "application/json"},
//         body: json.encode({
//           "likers": [],
//           "_id": "66d469229162486ec564bd1b",
//           "created_at": "2024-09-01T18:46:18.108Z",
//           "replies": [],
//           "createdAt": "2024-09-01T18:46:18.108Z",
//           "updatedAt": "2024-09-01T18:46:18.108Z",
//
//         }));
//     if (response.statusCode == 200||response.statusCode==201) {
//       print(response.body);
//       setState(() {
//         _fetchComments=json.decode(response.body)["New Employee"];
//       });
//       print("Category inserted successfully");
//     } else {
//       print("Failed to insert the category.Status code:${response.statusCode}");
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchComments();
//   }
//
//   // Future<void> _fetchComments() async {
//   //   try {
//   //     final response = await http.get(Uri.parse('http://92.205.109.210:8028/comment/createcomment'));
//   //
//   //     if (response.statusCode == 200) {
//   //       final List<dynamic> fetchedComments = json.decode(response.body);
//   //       print('Fetched comments: $fetchedComments');
//   //
//   //       setState(() {
//   //         comments.clear();
//   //         for (var comment in fetchedComments) {
//   //           comments.add({
//   //             'id': comment['id'], // Ensure this matches your backend response
//   //             'name': comment['name'] ?? 'User',
//   //             'comment': comment['comment'],
//   //             'image': comment['image'] ?? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtq6c36Ln-UD5vhJpHSe7N23naztbJbLshvA&s',
//   //             'likes': comment['likes'] ?? 0,
//   //             'isLiked': false,
//   //             'replies': comment['replies'] ?? [],
//   //             'isReplying': false,
//   //             'showReplies': false,
//   //           });
//   //         }
//   //       });
//   //     } else {
//   //       print('Failed to load comments: ${response.statusCode}');
//   //     }
//   //   } catch (e) {
//   //     print('Error fetching comments: $e');
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: const Text("Comment Box with Nested Replies"),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: comments.isEmpty
//                 ? Center(child: Text("No comments yet"))
//                 : ListView.builder(
//               itemCount: comments.length,
//               itemBuilder: (context, index) {
//                 final Map<String, dynamic> comment = comments[index];
//                 return _buildCommentItem(comment, 0); // Start at depth 0
//               },
//             ),
//           ),
//           _buildCommentInputField(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCommentInputField() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         height: 100,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.blue),
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: TextField(
//                   controller: _commentController,
//                   maxLength: 300,
//                   decoration: InputDecoration(
//                     hintText: 'Write a comment...',
//                     contentPadding: EdgeInsets.all(8.0),
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 if (_commentController.text.isNotEmpty) {
//                   await _sendComment(_commentController.text);
//                   _commentController.clear();
//                 }
//               },
//               child: const Icon(Icons.send),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _sendComment(String commentText) async {
//     try {
//       final response = await http.post(
//         Uri.parse('http://92.205.109.210:8028/comment/createcomment'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, String>{
//           'name': 'User', // Replace with actual user name
//           'comment': commentText,
//           'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtq6c36Ln-UD5vhJpHSe7N23naztbJbLshvA&s',
//           'likes': '0',
//         }),
//       );
//
//       if (response.statusCode == 201) {
//         final Map<String, dynamic> newComment = json.decode(response.body);
//         print('New comment created: $newComment');
//
//         setState(() {
//           comments.add({
//             'id': newComment['id'], // Ensure this matches your backend response
//             'name': newComment['name'] ?? 'User',
//             'comment': newComment['comment'],
//             'image': newComment['image'] ?? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtq6c36Ln-UD5vhJpHSe7N23naztbJbLshvA&s',
//             'likes': newComment['likes'] ?? 0,
//             'isLiked': false,
//             'replies': [],
//             'isReplying': false,
//             'showReplies': false,
//           });
//         });
//       } else {
//         print('Failed to send comment: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error sending comment: $e');
//     }
//   }
//
//   Widget _buildCommentItem(Map<String, dynamic> comment, int depth) {
//     final List<Map<String, dynamic>> replies = comment['replies'] as List<Map<String, dynamic>>;
//     final int commentIndex = comments.indexOf(comment);
//
//     return Padding(
//       padding: EdgeInsets.only(left: 20.0 * depth, top: 8.0, bottom: 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ListTile(
//             leading: CircleAvatar(
//               backgroundImage: NetworkImage(comment['image'] ?? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtq6c36Ln-UD5vhJpHSe7N23naztbJbLshvA&s'),
//             ),
//             title: Text(comment['name'] ?? "User"),
//             subtitle: Text(comment['comment'] ?? ""),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   icon: Icon(
//                     comment['isLiked'] ? Icons.thumb_up : Icons.thumb_up_outlined,
//                     color: comment['isLiked'] ? Colors.blue : Colors.grey,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       comment['isLiked'] = !comment['isLiked'];
//                       if (comment['isLiked']) {
//                         comment['likes'] += 1;
//                       } else {
//                         comment['likes'] -= 1;
//                       }
//                     });
//                   },
//                 ),
//                 Text(comment['likes'].toString()),
//                 IconButton(
//                   icon: Icon(Icons.reply, color: Colors.blue),
//                   onPressed: () {
//                     _handleReplyAction(comment, commentIndex);
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     comment['showReplies'] ? Icons.expand_less : Icons.expand_more,
//                     color: Colors.blue,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       comment['showReplies'] = !comment['showReplies'];
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//           if (comment['isReplying'] ?? false)
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: TextField(
//                 controller: _replyControllers[commentIndex] ??= TextEditingController(
//                   text: '@${comment['name']} ',
//                 ),
//                 minLines: 1,
//                 maxLines: 5,
//                 decoration: InputDecoration(
//                   hintText: 'Write a reply...',
//                   border: OutlineInputBorder(),
//                   suffixIcon: IconButton(
//                     icon: Icon(Icons.send, color: Colors.blue),
//                     onPressed: () {
//                       _handleSendReply(comment, commentIndex);
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           if (comment['showReplies'] && replies.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.only(left: 20.0), // Add left padding to indent replies
//               child: Column(
//                 children: replies.map((reply) {
//                   return _buildCommentItem(reply, depth + 1);
//                 }).toList(),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   void _handleReplyAction(Map<String, dynamic> comment, int commentIndex) {
//     setState(() {
//       comment['isReplying'] = !(comment['isReplying'] ?? false);
//       if (comment['isReplying']) {
//         _replyControllers[commentIndex] ??= TextEditingController(
//           text: '@${comment['name']} ',
//         );
//       }
//     });
//   }
//
//   Future<void> _handleSendReply(Map<String, dynamic> comment, int commentIndex) async {
//     final replyText = _replyControllers[commentIndex]?.text;
//     if (replyText != null && replyText.isNotEmpty) {
//       try {
//         final response = await http.post(
//           Uri.parse('http://92.205.109.210:8028/comment/reply'),
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8',
//           },
//           body: jsonEncode(<String, String>{
//             'name': 'User', // Replace with actual user name
//             'comment': replyText,
//             'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtq6c36Ln-UD5vhJpHSe7N23naztbJbLshvA&s',
//             'likes': '0',
//             'parentId': comment['id'].toString(), // Assuming each comment has an 'id' field
//           }),
//         );
//
//         if (response.statusCode == 201) {
//           final Map<String, dynamic> newReply = json.decode(response.body);
//           print('New reply created: $newReply');
//
//           setState(() {
//             comment['replies'].add({
//               'id': newReply['id'], // Ensure this matches your backend response
//               'name': newReply['name'] ?? 'User',
//               'comment': newReply['comment'],
//               'image': newReply['image'] ?? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtq6c36Ln-UD5vhJpHSe7N23naztbJbLshvA&s',
//               'likes': newReply['likes'] ?? 0,
//               'isLiked': false,
//               'replies': [],
//               'isReplying': false,
//               'showReplies': false,
//             });
//             _replyControllers[commentIndex]?.clear();
//             comment['isReplying'] = false;
//           });
//         } else {
//           print('Failed to send reply: ${response.statusCode}');
//         }
//       } catch (e) {
//         print('Error sending reply: $e');
//       }
//     }
//   }
// }
//
// class _fetchComments {
// }
// ]
// void main() {
//   runApp(MaterialApp(
//     home: CommentPage(),
//   ));
// }
