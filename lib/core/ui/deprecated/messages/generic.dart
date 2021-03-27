import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

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
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [
            LunaDatabaseValue.THEME_AMOLED.key,
            LunaDatabaseValue.THEME_AMOLED_BORDER.key,
        ]),
        builder: (context, box, child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                Card(
                    child: child,
                    margin: LunaUI.MARGIN_CARD,
                    elevation: LunaUI.ELEVATION,
                    shape: LunaUI.shapeBorder,
                ),
                if(showButton) LunaButtonContainer(
                    children: [
                        LunaButton.text(
                            text: buttonText,
                            onTap: onTapHandler,
                            backgroundColor: Theme.of(context).cardColor,
                            color: LunaColours.accent,
                        ),
                    ],
                ),
            ],
        ),
        child: Row(
            children: <Widget>[
                Expanded(
                    child: Container(
                        child: Text(
                            text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                                fontSize: Constants.UI_FONT_SIZE_TITLE,
                            ),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
                    ),
                ),
            ],
        ),
    );
}
