import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stackwallet/pages/add_wallet_views/add_wallet_view/add_wallet_view.dart';
import 'package:stackwallet/providers/ui/color_theme_provider.dart';
import 'package:stackwallet/utilities/assets.dart';
import 'package:stackwallet/utilities/text_styles.dart';
import 'package:stackwallet/utilities/theme/color_theme.dart';
import 'package:stackwallet/utilities/theme/stack_colors.dart';
import 'package:stackwallet/utilities/util.dart';

class EmptyWallets extends ConsumerWidget {
  const EmptyWallets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("BUILD: $runtimeType");

    final isDesktop = Util.isDesktop;
    final bool isSorbet = ref.read(colorThemeProvider.state).state.themeType ==
        ThemeType.fruitSorbet;
    final bool isForest =
        ref.read(colorThemeProvider.state).state.themeType == ThemeType.forest;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 43,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 330 : double.infinity,
          ),
          child: Column(
            children: [
              const Spacer(
                flex: 2,
              ),
              (isSorbet || isForest)
                  ? SvgPicture.asset(
                      Assets.svg.stack(context),
                      width: isDesktop
                          ? 324
                          : MediaQuery.of(context).size.width / 3,
                    )
                  : Image(
                      image: AssetImage(
                        Assets.png.stack(context),
                      ),
                      width: isDesktop
                          ? 324
                          : MediaQuery.of(context).size.width / 3,
                    ),
              SizedBox(
                height: isDesktop ? 30 : 16,
              ),
              Text(
                "You do not have any wallets yet. Start building your crypto Stack!",
                textAlign: TextAlign.center,
                style: isDesktop
                    ? STextStyles.desktopSubtitleH2(context).copyWith(
                        color: Theme.of(context)
                            .extension<StackColors>()!
                            .textSubtitle1,
                      )
                    : STextStyles.subtitle(context).copyWith(
                        color: Theme.of(context)
                            .extension<StackColors>()!
                            .textSubtitle1,
                      ),
              ),
              SizedBox(
                height: isDesktop ? 30 : 16,
              ),
              if (isDesktop)
                const SizedBox(
                  width: 328,
                  height: 70,
                  child: AddWalletButton(
                    isDesktop: true,
                  ),
                ),
              if (!isDesktop)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    AddWalletButton(
                      isDesktop: false,
                    ),
                  ],
                ),
              const Spacer(
                flex: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddWalletButton extends StatelessWidget {
  const AddWalletButton({Key? key, required this.isDesktop}) : super(key: key);

  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: Theme.of(context)
          .extension<StackColors>()!
          .getPrimaryEnabledButtonStyle(context),
      onPressed: () {
        if (isDesktop) {
          Navigator.of(
            context,
            rootNavigator: true,
          ).pushNamed(AddWalletView.routeName);
        } else {
          Navigator.of(context).pushNamed(AddWalletView.routeName);
        }
      },
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Assets.svg.plus,
                width: isDesktop ? 18 : null,
                height: isDesktop ? 18 : null,
              ),
              SizedBox(
                width: isDesktop ? 8 : 5,
              ),
              Text(
                "Add Wallet",
                style: isDesktop
                    ? STextStyles.desktopButtonEnabled(context)
                    : STextStyles.button(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
