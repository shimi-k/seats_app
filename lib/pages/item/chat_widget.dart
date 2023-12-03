import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    required this.contactName,
    super.key,
  });
  final String contactName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contactName),
      ),
      //TODO:flutter_chat_uiでチャット画面を作る
      body: const Placeholder(),
    );
  }
}
