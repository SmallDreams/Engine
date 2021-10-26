import 'dart:async';

import 'package:flutter/material.dart';
import 'package:salem/components/chat/models/chat_bubble.dart';

class SalemChatScreen extends StatefulWidget {
  final messages;
  final route;
  final nextRoute;
  SalemChatScreen({
    Key? key,
    required this.route,
    required this.messages,
    required this.nextRoute,
  }) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<SalemChatScreen> {
  int value = 1;
  int start = 5;
  var isContinue = false;
  _addItem() {
    setState(() {
      if (isFinished() == true) {
        isContinue = true;
        start = 10;
      } else {
        if (value < widget.messages.length) {
          value = value + 1;
        }
        if (start == 0) {
          start = 5;
          print(start);
        }
      }
    });
  }

  bool? isFinished() {
    if (value == widget.messages.length) {
      return true;
    } else {
      return false;
    }
  }

  callback(updateTimer) {
    setState(() {
      start = updateTimer;
    });
  }

  final _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                const CircleAvatar(
                  maxRadius: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Henry Briggs",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: value,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => BuildRow(
              callback: callback,
              messages: widget.messages,
              index: index,
              key: _key,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  isContinue == false
                      ? Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Write message...",
                                hintStyle: TextStyle(color: Colors.black54),
                                border: InputBorder.none),
                          ),
                        )
                      : Expanded(
                          child: InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed(widget.nextRoute),
                            child: Container(
                              color: Colors.black,
                              height: 30,
                              child: Center(
                                child: Text(
                                  "Continue",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: start == 0 ? _addItem : null,
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: start == 0 ? Colors.blue : Colors.black,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildRow extends StatefulWidget {
  final messages;
  final index;
  final Function callback;

  @override
  _BuildRowState createState() => _BuildRowState();

  BuildRow({
    this.messages,
    this.index,
    required this.callback,
    key,
  }) : super(key: key);
}

class _BuildRowState extends State<BuildRow> {
  late Timer _timer;
  int _start = 4;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        _start = 0;
        widget.callback(_start);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment: (widget.messages[widget.index].messageType == "receiver"
            ? Alignment.topLeft
            : Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            color: (widget.messages[widget.index].messageType == "receiver"
                ? Colors.grey.shade200
                : Colors.blue[200]),
          ),
          padding: EdgeInsets.all(16),
          child: widget.messages[widget.index].isVisible == false &&
                  widget.messages[widget.index].messageType == "receiver"
              ? Builder(
                  builder: (context) {
                    if (_start > 0) {
                      return TextCardBubble();
                    } else {
                      return Text(
                        widget.messages[widget.index].messageContent,
                        style: TextStyle(fontSize: 15),
                      );
                    }
                  },
                )
              : Text(
                  widget.messages[widget.index].messageContent,
                  style: TextStyle(fontSize: 15),
                ),
        ),
      ),
    );
  }
}
