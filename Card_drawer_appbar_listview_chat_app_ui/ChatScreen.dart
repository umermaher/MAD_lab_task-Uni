import 'dart:async';

import 'package:chatscreenui/model/Message.dart';
import 'package:chatscreenui/utils/String.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chatscreenui/ui/ChatScreen/TaskScreen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.title});

  final String title;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final List<Message> _messages = Messages().messages();
  final ScrollController _scrollController = ScrollController();
  final msgTextController = TextEditingController();
  int? selectedUser;
  void _sendMessage(Message message) {
    setState(() {
      _messages.add(message);
    });
    msgTextController.text = Strings.empty;
    _scrollDown();
  }

  void _scrollDown() {
    Timer(const Duration(milliseconds: 500), () {
      _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(widget.title),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color(0xff0c9100)
        ),
        backgroundColor: const Color(0xff0c9100),
        leading: BackButton(
          onPressed:()=> SystemNavigator.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.task),
            tooltip: 'Open Task Screen',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const TaskScreen(title: "Task", data: "Data"))
              );
            },
          ),
        ],
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 10, top: 0, right: 10, bottom: 10
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  flex: 10,
                  child: ListView.builder(
                    itemCount: _messages.length + 1,
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, position) {

                      if(position == 0) {

                        return Container(
                          margin: const EdgeInsets.only(top: 10),
                          alignment: Alignment.center,
                          child: const Card(
                            elevation: 3,
                            color: Color(0xffe0e0e0),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, top: 5, bottom: 5
                              ),

                              child: Text(
                                Strings.today,
                                style: TextStyle(
                                  color: Color(0xff5e5e5e),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                            ),
                          ),
                        );
                      }
                      else {

                        Message msg = _messages.elementAt(position - 1);

                        return Row(
                          mainAxisAlignment: msg.owned ?
                          MainAxisAlignment.end : MainAxisAlignment.start,
                          children: [
                            Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              color: msg.owned ?
                              const Color(0xff0c9100) : Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, top: 10, right: 15, bottom: 10
                                ),
                                child:Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          msg.message,
                                          style: TextStyle(
                                            color: msg.owned ?
                                            Colors.white : const Color(0xff5e5e5e),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],

                        );
                      }
                    },
                  )
              ),
              Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 9,
                        child: PhysicalModel(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffe0e0e0),
                          elevation: 3,
                          shadowColor: const Color(0xffe0e0e0),
                          child: TextFormField(
                            controller: msgTextController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none
                                  )
                              ),
                              hintText: Strings.message,
                              filled: true,
                              contentPadding: const EdgeInsets.only(
                                left: 20, right: 20,
                              ),
                              fillColor: const Color(0xffe0e0e0),
                            ),
                            cursorColor: const Color(0xff0c9100),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: IconButton(
                            onPressed: () {
                              if(msgTextController.text.isNotEmpty) {
                                showAlertDialog(msgTextController.text);
                              }
                            },
                            icon: const Icon(Icons.send)
                        ),
                      )
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showAlertDialog(String msg) async{
    FocusScope.of(context).unfocus();
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text(Strings.selectUser),
              content: SizedBox(
                height: 130,
                child: Column(
                  children: [
                    RadioListTile(
                        title: Text(Strings.you),
                        value: 1,
                        groupValue: selectedUser,
                        onChanged: (value) {
                          _sendMessage(
                              Message(msg, true)
                          );
                          Navigator.pop(context);
                        }
                    ),
                    RadioListTile(
                        title: Text(Strings.other),
                        value: 2,
                        groupValue: selectedUser,
                        onChanged: (value) {
                          _sendMessage(
                              Message(msg, false)
                          );
                          Navigator.pop(context);
                        }
                    )
                  ],
                ),
              )
          );
        }
    );
  }
}