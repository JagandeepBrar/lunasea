import 'package:flutter/material.dart';

import '../../../core/ui.dart';
import '../../../vendor.dart';
import '../routes/dashboard/widgets/navigation_bar.dart';
import 'database.dart';

class DashboardDialogs {
  Future<Tuple2<bool, int>> defaultPage(BuildContext context) async {
    bool _flag = false;
    int _index = 0;

    void _setValues(bool flag, int index) {
      _flag = flag;
      _index = index;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'lunasea.Page'.tr(),
      content: List.generate(
        DashboardNavigationBar.titles.length,
        (index) => LunaDialog.tile(
          text: DashboardNavigationBar.titles[index],
          icon: DashboardNavigationBar.icons[index],
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, index),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );

    return Tuple2(_flag, _index);
  }

  Future<Tuple2<bool, int>> setPastDays(BuildContext context) async {
    bool _flag = false;
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController _textController = TextEditingController(
      text: DashboardDatabaseValue.CALENDAR_DAYS_PAST.data.toString(),
    );

    void _setValues(bool flag) {
      if (_formKey.currentState!.validate()) {
        _flag = flag;
        Navigator.of(context, rootNavigator: true).pop();
      }
    }

    await LunaDialog.dialog(
      context: context,
      title: 'dashboard.PastDays'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Set'.tr(),
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(
          text: 'dashboard.PastDaysDescription'.tr(),
        ),
        Form(
          key: _formKey,
          child: LunaDialog.textFormInput(
            controller: _textController,
            title: 'dashboard.PastDays'.tr(),
            onSubmitted: (_) => _setValues(true),
            validator: (value) {
              int? _value = int.tryParse(value!);
              if (_value != null && _value >= 1) return null;
              return 'dashboard.MinimumOfOneDay'.tr();
            },
            keyboardType: TextInputType.number,
          ),
        ),
      ],
      contentPadding: LunaDialog.inputTextDialogContentPadding(),
    );

    return Tuple2(_flag, int.tryParse(_textController.text) ?? 14);
  }

  Future<Tuple2<bool, int>> setFutureDays(BuildContext context) async {
    bool _flag = false;
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController _textController = TextEditingController(
      text: DashboardDatabaseValue.CALENDAR_DAYS_FUTURE.data.toString(),
    );

    void _setValues(bool flag) {
      if (_formKey.currentState!.validate()) {
        _flag = flag;
        Navigator.of(context, rootNavigator: true).pop();
      }
    }

    await LunaDialog.dialog(
      context: context,
      title: 'dashboard.FutureDays'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Set'.tr(),
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(
          text: 'dashboard.FutureDaysDescription'.tr(),
        ),
        Form(
          key: _formKey,
          child: LunaDialog.textFormInput(
            controller: _textController,
            title: 'dashboard.FutureDays'.tr(),
            onSubmitted: (_) => _setValues(true),
            validator: (value) {
              int? _value = int.tryParse(value!);
              if (_value != null && _value >= 1) return null;
              return 'dashboard.MinimumOfOneDay'.tr();
            },
            keyboardType: TextInputType.number,
          ),
        ),
      ],
      contentPadding: LunaDialog.inputTextDialogContentPadding(),
    );

    return Tuple2(_flag, int.tryParse(_textController.text) ?? 14);
  }
}
