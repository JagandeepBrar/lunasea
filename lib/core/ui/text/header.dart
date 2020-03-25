import 'package:flutter/material.dart';

class LSHeader extends StatelessWidget {
    final String text;
    
    LSHeader({
        @required this.text,
    });

    @override
    Widget build(BuildContext context) => Padding(
        child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 34.0,
                color: Colors.white,
            ),
        ),
        padding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
    );
}
