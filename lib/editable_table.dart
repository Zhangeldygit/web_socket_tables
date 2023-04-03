import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_test/editable_table_cell.dart';

class EditableTable extends StatefulWidget {
  const EditableTable({super.key});

  @override
  _EditableTableState createState() => _EditableTableState();
}

class _EditableTableState extends State<EditableTable> {
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.events'),
  );
  final List<List<String>> _tableData = [
    ['Ячейка 1', 'Ячейка 2', 'Ячейка 3'],
    ['Ячейка 4', 'Ячейка 5', 'Ячейка 6'],
    ['Ячейка 7', 'Ячейка 8', 'Ячейка 9'],
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Table(
            children: _tableData.map((rowData) {
              return TableRow(
                children: rowData.map((cellData) {
                  return TableCell(
                      child: EditableTableCell(
                    text: cellData,
                    channel: channel,
                  ));
                }).toList(),
              );
            }).toList(),
          ),
          StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                return Text(snapshot.hasData ? "${snapshot.data}" : '');
              }),
        ],
      ),
    );
  }
}
