import 'package:flutter/material.dart';

class LSListView extends StatelessWidget {
    final List<Widget> children;

    LSListView({
        @required this.children,
    });

    @override
    Widget build(BuildContext context) {
        return Scrollbar(
            child: ListView(
                children: children,
                padding: EdgeInsets.symmetric(vertical: 8.0),
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