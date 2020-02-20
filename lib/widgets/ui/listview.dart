import 'package:flutter/material.dart';

class LSListView extends StatelessWidget {
    final List<Widget> children;
    final bool padBottom;

    LSListView({
        @required this.children,
        this.padBottom = false,
    });

    @override
    Widget build(BuildContext context) {
        return Scrollbar(
            child: ListView(
                children: children,
                padding: padBottom
                    ? EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 20.0)
                    : EdgeInsets.symmetric(vertical: 8.0),
                physics: AlwaysScrollableScrollPhysics(),
            ),
        );
    }
}

class LSListViewBuilder extends StatelessWidget {
    LSListViewBuilder();

    @override
    Widget build(BuildContext context) {
        return Scrollbar(
            child: ListView.builder(
                itemBuilder: (context, index) {
                    return null;
                },
            ),
        );
    }
}