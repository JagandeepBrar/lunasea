import 'package:flutter/material.dart';
import 'package:lunasea/modules.dart';
import 'package:lunasea/router/router.dart';
import 'package:lunasea/router/routes/dashboard.dart';
import 'package:lunasea/vendor.dart';
import 'package:lunasea/widgets/ui.dart';

class LunaMessage extends StatelessWidget {
  final String text;
  final Color textColor;
  final String? buttonText;
  final Function? onTap;
  final bool useSafeArea;

  const LunaMessage({
    Key? key,
    required this.text,
    this.textColor = Colors.white,
    this.buttonText,
    this.onTap,
    this.useSafeArea = true,
  }) : super(key: key);

  /// Return a message that is meant to be shown within a [ListView].
  factory LunaMessage.inList({
    Key? key,
    required String text,
    bool useSafeArea = false,
  }) {
    return LunaMessage(
      key: key,
      text: text,
      useSafeArea: useSafeArea,
    );
  }

  /// Returns a centered message with a simple message, with a button to pop out of the route.
  factory LunaMessage.goBack({
    Key? key,
    required String text,
    required BuildContext context,
    bool useSafeArea = true,
  }) {
    return LunaMessage(
      key: key,
      text: text,
      buttonText: 'lunasea.GoBack'.tr(),
      onTap: () {
        if (LunaRouter.router.canPop()) {
          LunaRouter.router.pop();
        } else {
          LunaRouter.router.pushReplacement(DashboardRoutes.HOME.path);
        }
      },
      useSafeArea: useSafeArea,
    );
  }

  /// Return a pre-structured "An Error Has Occurred" message, with a "Try Again" button shown.
  factory LunaMessage.error({
    Key? key,
    required Function onTap,
    bool useSafeArea = true,
  }) {
    return LunaMessage(
      key: key,
      text: 'lunasea.AnErrorHasOccurred'.tr(),
      buttonText: 'lunasea.TryAgain'.tr(),
      onTap: onTap,
      useSafeArea: useSafeArea,
    );
  }

  /// Return a pre-structured "<module> Is Not Enabled" message, with a "Return to Dashboard" button shown.
  factory LunaMessage.moduleNotEnabled({
    Key? key,
    required BuildContext context,
    required String module,
    bool useSafeArea = true,
  }) {
    return LunaMessage(
      key: key,
      text: 'lunasea.ModuleIsNotEnabled'.tr(args: [module]),
      buttonText: 'lunasea.ReturnToDashboard'.tr(),
      onTap: LunaModule.DASHBOARD.launch,
      useSafeArea: useSafeArea,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: useSafeArea,
      left: useSafeArea,
      right: useSafeArea,
      bottom: useSafeArea,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            margin: LunaUI.MARGIN_H_DEFAULT_V_HALF,
            elevation: LunaUI.ELEVATION,
            shape: LunaUI.shapeBorder,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                        fontSize: LunaUI.FONT_SIZE_MESSAGES,
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(
                        vertical: 24.0, horizontal: 12.0),
                  ),
                ),
              ],
            ),
          ),
          if (buttonText != null)
            LunaButtonContainer(
              children: [
                LunaButton.text(
                  text: buttonText!,
                  icon: null,
                  onTap: onTap,
                  color: Colors.white,
                  backgroundColor: LunaColours.accent,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
