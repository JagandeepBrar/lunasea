import 'package:flutter/material.dart';
import 'package:lunasea/core/constants.dart';
import 'package:lunasea/widgets/ui/button.dart';

class LSGenericMessage extends StatelessWidget {
    final String text;
    final String buttonText;
    final bool showButton;
    final Function onTapHandler;

    LSGenericMessage({
        Key key,
        @required this.text,
        this.showButton = false,
        this.buttonText = '',
        this.onTapHandler,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
            Card(
                child: Row(
                    children: <Widget>[
                        Expanded(
                            child: Container(
                                child: Text(
                                    text,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                    ),
                                ),
                                margin: EdgeInsets.symmetric(vertical: 24.0),
                            ),
                        ),
                    ],
                ),
                margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                elevation: Constants.UI_ELEVATION,
            ),
            if(showButton) LSButton(
                text: buttonText,
                onTap: onTapHandler,
            ),
        ],
    );
}
