import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class EditableTableCell extends StatefulWidget {
  final String text;
  final WebSocketChannel channel;

  const EditableTableCell(
      {super.key, required this.text, required this.channel});

  @override
  _EditableTableCellState createState() => _EditableTableCellState();
}

class _EditableTableCellState extends State<EditableTableCell> {
  late TextEditingController _controller;
  late String text;

  @override
  void initState() {
    super.initState();
    text = widget.text;
    _controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    widget.channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _controller.selection = TextSelection(
                baseOffset: 0, extentOffset: _controller.value.text.length);
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: TextField(
            controller: _controller,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
            ),
            onEditingComplete: () {
              widget.channel.sink.add(_controller.text);
              FocusScope.of(context).unfocus();
            },
          ),
        ),
      ),
    );
  }
}
