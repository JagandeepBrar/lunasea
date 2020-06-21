import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSTypewriterMessage extends StatefulWidget {
    final String text;
    final String buttonText;
    final bool showButton;
    final Function onTapHandler;

    LSTypewriterMessage({
        Key key,
        @required this.text,
        this.showButton = false,
        this.buttonText = '',
        this.onTapHandler,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<LSTypewriterMessage> with TickerProviderStateMixin {
    Timer _timer;
    int _counter = 0;
    String _text = '';

    @override
    void initState() {
        super.initState();
        _timer = Timer.periodic(Duration(milliseconds: 100), handleTimer);
    }

    void dispose() {
        _timer?.cancel();
        super.dispose();
    }

    void handleTimer(Timer timer) {
        _counter++;
        if(_counter > widget.text.length) _counter = 0;
        if(mounted) setState(() => _text = widget.text.substring(0, _counter) + "_");
    }

    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [
            LunaSeaDatabaseValue.THEME_AMOLED.key,
            LunaSeaDatabaseValue.THEME_AMOLED_BORDER.key,
        ]),
        builder: (context, box, child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                Card(
                    child: child,
                    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    elevation: Constants.UI_ELEVATION,
                    shape: LunaSeaDatabaseValue.THEME_AMOLED.data && LunaSeaDatabaseValue.THEME_AMOLED_BORDER.data
                        ? LSRoundedShapeWithBorder()
                        : LSRoundedShape(),
                ),
                if(widget.showButton) LSButton(
                    text: widget.buttonText,
                    onTap: widget.onTapHandler,
                ),
            ],
        ),
        child: Row(
            children: <Widget>[
                Expanded(
                    child: Container(
                        child: Text(
                            _text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: Constants.UI_FONT_SIZE_TITLE,
                            ),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 24.0),
                    ),
                ),
            ],
        ),
    );
}
