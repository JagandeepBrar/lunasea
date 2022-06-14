import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';

class SABnzbdQueueTile extends StatefulWidget {
  final int index;
  final SABnzbdQueueData data;
  final Function refresh;
  final BuildContext queueContext;

  const SABnzbdQueueTile({
    required this.data,
    required this.index,
    required this.queueContext,
    required this.refresh,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SABnzbdQueueTile> {
  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: widget.data.name,
      body: [TextSpan(text: widget.data.subtitle)],
      bottomHeight: LunaLinearPercentIndicator.height,
      bottom: LunaLinearPercentIndicator(
        percent: min(1.0, max(0, widget.data.percentageDone / 100)),
      ),
      trailing: LunaReorderableListViewDragger(index: widget.index),
      onTap: _handlePopup,
    );
  }

  Future<void> _handlePopup() async {
    _Helper _helper = _Helper(widget.queueContext, widget.data, widget.refresh);
    List values = await SABnzbdDialogs.queueSettings(
        widget.queueContext, widget.data.name, widget.data.isPaused);
    if (values[0])
      switch (values[1]) {
        case 'status':
          widget.data.isPaused ? _helper._resumeJob() : _helper._pauseJob();
          break;
        case 'category':
          _helper._category();
          break;
        case 'priority':
          _helper._priority();
          break;
        case 'password':
          _helper._password();
          break;
        case 'rename':
          _helper._rename();
          break;
        case 'delete':
          _helper._delete();
          break;
        default:
          LunaLogger().warning('Unknown Case: ${values[1]}');
      }
  }
}

class _Helper {
  final BuildContext context;
  final SABnzbdQueueData data;
  final Function refresh;

  _Helper(
    this.context,
    this.data,
    this.refresh,
  );

  Future<void> _pauseJob() async {
    await SABnzbdAPI.from(LunaProfile.current)
        .pauseSingleJob(data.nzoId)
        .then((_) {
      showLunaSuccessSnackBar(
        title: 'Job Paused',
        message: data.name,
      );
      refresh();
    }).catchError((error) {
      showLunaErrorSnackBar(
        title: 'Failed to Pause Job',
        error: error,
      );
    });
  }

  Future<void> _resumeJob() async {
    await SABnzbdAPI.from(LunaProfile.current)
        .resumeSingleJob(data.nzoId)
        .then((_) {
      showLunaSuccessSnackBar(
        title: 'Job Resumed',
        message: data.name,
      );
      refresh();
    }).catchError((error) {
      showLunaErrorSnackBar(
        title: 'Failed to Resume Job',
        error: error,
      );
    });
  }

  Future<void> _category() async {
    List<SABnzbdCategoryData> categories =
        await SABnzbdAPI.from(LunaProfile.current).getCategories();
    List values = await SABnzbdDialogs.changeCategory(context, categories);
    if (values[0])
      await SABnzbdAPI.from(LunaProfile.current)
          .setCategory(data.nzoId, values[1])
          .then((_) {
        showLunaSuccessSnackBar(
          title: values[1] == ''
              ? 'Category Set (No Category)'
              : 'Category Set (${values[1]})',
          message: data.name,
        );
        refresh();
      }).catchError((error) {
        showLunaErrorSnackBar(
          title: 'Failed to Set Category',
          error: error,
        );
      });
  }

  Future<void> _priority() async {
    List values = await SABnzbdDialogs.changePriority(context);
    if (values[0])
      await SABnzbdAPI.from(LunaProfile.current)
          .setJobPriority(data.nzoId, values[1])
          .then((_) {
        showLunaSuccessSnackBar(
          title: 'Priority Set (${(values[2])})',
          message: data.name,
        );
        refresh();
      }).catchError((error) {
        showLunaErrorSnackBar(
          title: 'Failed to Set Priority',
          error: error,
        );
      });
  }

  Future<void> _rename() async {
    List values = await SABnzbdDialogs.renameJob(context, data.name);
    if (values[0])
      SABnzbdAPI.from(LunaProfile.current)
          .renameJob(data.nzoId, values[1])
          .then((_) {
        showLunaSuccessSnackBar(
          title: 'Job Renamed',
          message: values[1],
        );
        refresh();
      }).catchError((error) {
        showLunaErrorSnackBar(
          title: 'Failed to Rename Job',
          error: error,
        );
      });
  }

  Future<void> _delete() async {
    List values = await SABnzbdDialogs.deleteJob(context);
    if (values[0])
      await SABnzbdAPI.from(LunaProfile.current)
          .deleteJob(data.nzoId)
          .then((_) {
        showLunaSuccessSnackBar(
          title: 'Job Deleted',
          message: data.name,
        );
        refresh();
      }).catchError((error) {
        showLunaErrorSnackBar(
          title: 'Failed to Delete Job',
          error: error,
        );
      });
  }

  Future<void> _password() async {
    List values = await SABnzbdDialogs.setPassword(context);
    if (values[0])
      await SABnzbdAPI.from(LunaProfile.current)
          .setJobPassword(data.nzoId, data.name, values[1])
          .then((_) {
        showLunaSuccessSnackBar(
          title: 'Job Password Set',
          message: data.name,
        );
        refresh();
      }).catchError((error) {
        showLunaErrorSnackBar(
          title: 'Failed to Set Job Password',
          error: error,
        );
      });
  }
}
