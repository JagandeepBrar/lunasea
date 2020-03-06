import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/widgets/ui/button.dart';

class LSAnimatedGenericMessage extends StatelessWidget {
    final String text;
    final String buttonText;
    final bool showButton;
    final Function onTapHandler;

    LSAnimatedGenericMessage({
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
                                child: TyperAnimatedTextKit(
                                    text: [text],
                                    textAlign: TextAlign.center,
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                    ),
                                    alignment: AlignmentDirectional.topStart,
                                    isRepeatingAnimation: true,
                                ),
                                margin: EdgeInsets.symmetric(vertical: 24.0),
                            ),
                        ),
                    ],
                ),
                margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                elevation: 4.0,
            ),
            if(showButton) LSButton(
                text: buttonText,
                onTap: onTapHandler,
            ),
        ],
    );
}
