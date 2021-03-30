import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrDetailsEditButton extends StatefulWidget {
    final LidarrCatalogueData data;
    
    LidarrDetailsEditButton({
        @required this.data,
    });

    @override
    State<LidarrDetailsEditButton> createState() => _State();
}

class _State extends State<LidarrDetailsEditButton> {
    @override
    Widget build(BuildContext context) => Consumer<LidarrState>(
        builder: (context, model, widget) => LunaIconButton(
            icon: Icons.edit,
            onPressed: () async => _enterEditArtist(context),
        ),
    );

    Future<void> _enterEditArtist(BuildContext context) async {
        final dynamic result = await Navigator.of(context).pushNamed(
            LidarrEditArtist.ROUTE_NAME,
            arguments: LidarrEditArtistArguments(entry: widget.data),
        );
        if(result != null && result[0]) showLunaSuccessSnackBar(
            title: 'Updated',
            message: widget.data.title,
        );
    }
}
