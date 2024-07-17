import 'dart:convert';

import '../model/raise_support_data.dart';
import '../../../Service/service.dart';
import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Wdgets/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ViewConverSations extends StatefulWidget {
  final Support support;
  const ViewConverSations({Key? key, required this.support}) : super(key: key);

  @override
  State<ViewConverSations> createState() => _ViewConverSationsState();
}

class _ViewConverSationsState extends State<ViewConverSations> {
  List<Conversation> conversations = [];
  final TextEditingController _messageController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getConvesation();
  }

  getConvesation() async {
    setState(() {
      isLoading = true;
    });
    final response = await ApiService.get(
      key: 'support/${widget.support.id}/conversations',
    );
    final responseData = jsonDecode(response);

    setState(() {
      conversations = (responseData['selectSupport']['conversations'] as List)
          .map((e) => Conversation.fromJson(e))
          .toList();
    });

    setState(() {
      isLoading = false;
    });
  }

  bool isSending = false;

  sendMessage() async {
    setState(() {
      isSending = true;
    });
    final response = await ApiService.post(
      key: 'support/${widget.support.id}/conversations',
      body: {
        "message": _messageController.text,
        "attach": "",
      },
    );
    final responseData = jsonDecode(response);
    if (responseData['statusCode'] == 200) {
      setState(() {
        isSending = false;
        conversations.add(
          Conversation(
            senderId: widget.support.userId,
            message: _messageController.text,
          ),
        );
      });
    } else {
      setState(() {
        isSending = false;
      });
    }
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Conversations',
        backgroundColor: ColorConst.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: conversations.length,
                    itemBuilder: (context, index) {
                      final isMe = conversations[index].senderId ==
                          widget.support.userId;
                      final conversation = conversations[index];
                      return Row(
                        mainAxisAlignment: isMe
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                              left: 10,
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: isMe
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                if (!isMe)
                                  Text(
                                    isMe ? 'You' : "Team",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isMe
                                        ? ColorConst.primaryColor
                                        : Colors.grey[200],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    conversation.message!,
                                    style: TextStyle(
                                      color: isMe ? Colors.white : Colors.black,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                if (isMe)
                                  Text(
                                    isMe ? 'You' : "Team",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),
          if (widget.support.status != 'close')
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      margin: const EdgeInsets.only(left: 10),
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type your message',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          contentPadding: EdgeInsets.only(
                            left: 20,
                            top: 10,
                            bottom: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: ColorConst.primaryColor,
                    child: IconButton(
                      icon: isSending
                          ? const CupertinoActivityIndicator()
                          : const Icon(
                              FontAwesome.send_o,
                              color: Colors.white,
                            ),
                      onPressed: () {
                        if (isSending) return;
                        if (_messageController.text.isNotEmpty) {
                          sendMessage();
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            )
          else
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      margin: const EdgeInsets.only(left: 10),
                      child: const TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'This conversation is closed',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          contentPadding: EdgeInsets.only(
                            left: 20,
                            top: 10,
                            bottom: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey,
                    child: IconButton(
                      icon: Icon(
                        FontAwesome.send_o,
                        color: Colors.white,
                      ),
                      onPressed: null,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
