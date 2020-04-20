import 'package:flutter/material.dart';
import 'package:lunasea/core/ui/colors.dart';

class LSHeader extends StatelessWidget {
    final String text;
    
    LSHeader({
        @required this.text,
    });

    @override
    Widget build(BuildContext context) => Padding(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(
                    text.toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.white,
                    ),
                ),
                Padding(
                    child: Container(
                        height: 2.0,
                        width: 48.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: LSColors.accent,
                        ),
                    ),
                    padding: EdgeInsets.only(top: 4.0, left: 1.0),
                ),
            ],
        ),
        padding: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 8.0),
    );
}
