import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stackwallet/utilities/assets.dart';
import 'package:stackwallet/utilities/theme/stack_colors.dart';
import 'package:stackwallet/utilities/util.dart';
import 'package:stackwallet/widgets/conditional_parent.dart';
import 'package:stackwallet/widgets/desktop/desktop_dialog.dart';
import 'package:stackwallet/widgets/stack_dialog.dart';

class RescanningDialog extends StatefulWidget {
  const RescanningDialog({
    Key? key,
    // required this.onCancel,
  }) : super(key: key);

  // final VoidCallback onCancel;

  @override
  State<RescanningDialog> createState() => _RescanningDialogState();
}

class _RescanningDialogState extends State<RescanningDialog>
    with TickerProviderStateMixin {
  late AnimationController? _spinController;
  late Animation<double> _spinAnimation;

  late final bool isDesktop;

  // late final VoidCallback onCancel;
  @override
  void initState() {
    isDesktop = Util.isDesktop;
    // onCancel = widget.onCancel;

    _spinController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _spinAnimation = CurvedAnimation(
      parent: _spinController!,
      curve: Curves.linear,
    );

    super.initState();
  }

  @override
  void dispose() {
    _spinController?.dispose();
    _spinController = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: ConditionalParent(
        condition: isDesktop,
        builder: (child) => DesktopDialog(
          maxHeight: 200,
          maxWidth: 500,
          child: child,
        ),
        child: StackDialog(
          title: "Rescanning blockchain",
          message: "This may take a while. Please do not exit this screen.",
          icon: RotationTransition(
            turns: _spinAnimation,
            child: SvgPicture.asset(
              Assets.svg.arrowRotate3,
              width: 24,
              height: 24,
              color:
                  Theme.of(context).extension<StackColors>()!.accentColorDark,
            ),
          ),
          // rightButton: TextButton(
          //   style: Theme.of(context).textButtonTheme.style?.copyWith(
          //     backgroundColor: MaterialStateProperty.all<Color>(
          //       CFColors.buttonGray,
          //     ),
          //   ),
          //   child: Text(
          //     "Cancel",
          //     style: STextStyles.itemSubtitle12(context),
          //   ),
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //     onCancel.call();
          //   },
          // ),
        ),
      ),
    );
  }
}
