import 'package:flutter/material.dart';

class CustomTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.black),
      children: List.generate(9, (index) {
        return TableRow(
          children: [
            TableCell(child: Text('Row ${index + 1}')),
            TableCell(child: TextField()),
          ],
        );
      }),
    );
  }
}
