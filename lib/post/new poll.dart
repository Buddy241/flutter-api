
import 'dart:convert';

import 'package:flutter/material.dart';

import 'dart:async';

import '../color.dart';
import 'package:http/http.dart'as http;





class NewPolled extends StatefulWidget {
  const NewPolled({super.key});

  @override
  State<NewPolled> createState() => _NewPolledState();
}

class _NewPolledState extends State<NewPolled> {
  final List<TextEditingController> _controllers = List.generate(2, (index) => TextEditingController());
  final TextEditingController _questionController = TextEditingController();
  final bmc = GlobalKey<FormState>();
  List  a = [];
  Timer? _timer;
  Duration _timeRemaining = const Duration(minutes: 1); // Default poll duration
  bool _isPollActive = true;

  void addpoll()  {
    if(bmc.currentState!.validate()?? false){
      setState(() {
        a.add({
          // 'ques' = _questionController.text
        });
      });
    }
  }
  List<DropdownMenuItem<Duration>> _dropdownItems = [
    const DropdownMenuItem(child: Text("1 minute"), value: Duration(minutes: 1)),
    const DropdownMenuItem(child: Text("5 minutes"), value: Duration(minutes: 5)),
    const DropdownMenuItem(child: Text("10 minutes"), value: Duration(minutes: 10)),
    const DropdownMenuItem(child: Text("1 hour"), value: Duration(hours: 1)),
  ];

  Duration _selectedDuration = const Duration(minutes: 1);

  List<dynamic> _data = [];
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final url = Uri.parse('http://92.205.109.210:8028/polls/getall');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          _data = json.decode(response.body);
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load data with status: ${response.statusCode}';
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'Error occurred: $error';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timeRemaining = _selectedDuration;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining.inSeconds > 0) {
          _timeRemaining -= const Duration(seconds: 1);
        } else {
          _isPollActive = false;
          _timer?.cancel();
        }
      });
    });
  }

  void _restartTimer() {
    _timer?.cancel();
    _isPollActive = true;
    _startTimer();
  }

  void _selectDuration(Duration? duration) {
    if (duration != null) {
      setState(() {
        _selectedDuration = duration;
        _restartTimer();
      });
    }
  }

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String question="";
  List choices=[];


  final ctlDOB = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),

    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _selectTime(context);
        print(selectedDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        print(selectedTime);
      });
    }
  }

  void _addTextField() {
    if (_controllers.length < 4) {
      setState(() {
        _controllers.add(TextEditingController());
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You can only have up to 4 choices.'),
        ),
      );
    }
  }

  void _removeTextField(int index) {
    if (_controllers.length > 2) {
      setState(() {
        _controllers[index].dispose();
        _controllers.removeAt(index);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You must have at least 2 choices.'),
        ),
      );
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bac,
        appBar: AppBar(
          backgroundColor: bac,
          title: const Text("Welcome to New Poll",style: TextStyle(color: Colors.white),),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: bmc,
                child: Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Text("Create a New Poll",style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),),
                      Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircleAvatar(),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "User",
                                  style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),

                          // Icon(Icons.verified_outlined, color: Colors.black),
                          // GestureDetector(onTap: (){},child: const Icon(Icons.more_vert, color: Colors.black)),
                        ],
                      ),
                      ListTile(
                        leading: const Icon(Icons.poll, size: 30),
                        title: TextFormField(
                          controller: _questionController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Ask a question...",
                            hintText: "Ask a question...",
                            fillColor: Colors.white,
                            hintStyle: TextStyle(fontSize: 20.0, color: hin),
                            filled: true,
                            border: const OutlineInputBorder(),
                          ),
                        ),

                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _controllers.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _controllers[index],
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      labelText: "Choice ${index + 1}",
                                      hintText: "Choice ${index + 1}",
                                      fillColor: Colors.white,
                                      hintStyle: TextStyle(fontSize: 20.0, color: hin),
                                      filled: true,
                                      border: const OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: _addTextField,
                                  icon: const Icon(Icons.add),
                                ),
                                IconButton(
                                  onPressed: () => _removeTextField(index),
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Text(
                          "Poll duration",
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
                        ),
                        title: DropdownButton<Duration>(
                          value: _selectedDuration,
                          items: _dropdownItems,
                          onChanged: _isPollActive ? _selectDuration : null,
                        ),),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {

                            if(bmc.currentState!.validate()){

                              setState(() {
                                choices= _controllers.map((controller) => controller.text).toList();
                                print(choices);
                              });

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => userdraw3(question: _questionController.text,choices: choices,selectedDate: selectedDate,selectedTime: selectedTime,),
                              //     ));

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         PollDetails(
                              //       question: question,
                              //       choices: choices,
                              //       selectedDate: selectedDate,
                              //       selectedTime: selectedTime,
                              //     ),
                              //   ),
                              // );
                            }
                          },
                          child: const Text("Create"),
                        ),
                      ),
                      // Text(
                      //   "Time remaining: ${_timeRemaining.inMinutes}:${_timeRemaining.inSeconds % 60}",
                      //   style: const TextStyle(fontWeight: FontWeight.bold),
                      // ),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}