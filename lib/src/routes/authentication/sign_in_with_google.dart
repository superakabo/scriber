import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:scriber/src/models/user_model.dart';
import 'package:scriber/src/providers/user_provider.dart';
import 'package:scriber/src/utilities/constants/font_variations.dart';
import 'package:scriber/src/widgets/status_bottom_sheet.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../providers/authentication_provider.dart';
import '../../routes.dart';
import '../../utilities/constants/keys.dart';
import '../../utilities/constants/lotties.dart';
import '../../utilities/constants/svgs.dart';
import '../../utilities/constants/urls.dart';
import '../../utilities/exceptions/auth_exception.dart';
import '../../utilities/localizations/strings.dart';
import '../../utilities/miscellaneous/back_stack_manager.dart';

class SignInWithGoogle extends HookConsumerWidget {
  const SignInWithGoogle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final strings = Strings.of(context)!;
    final navigator = Navigator.of(context);
    final textScaleFactor = MediaQuery.textScaleFactorOf(context);

    final bottomSheet = useMemoized(() => StatusBottomSheet(context: context));
    final backStackManager = useMemoized(() => BackStackManager(navigator: navigator, numberOfTabs: 1));
    useEffect(() => bottomSheet.dispose, const []);

    final authProvider = ref.watch(authenticationProvider);
    final setUserData = ref.watch(userProvider.notifier);

    void onAuthenticationCompleted(UserCredential data) {
      setUserData.save(UserModel.fromUser(data.user));
      navigator.pushNamedAndRemoveUntil(
        Routes.notes.path,
        ModalRoute.withName('/'),
      );
    }

    void showException(AuthException exception) {
      final errorStatus = StatusData(
        status: Status.error,
        title: exception.title,
        message: exception.message,
        positiveButtonText: strings.ok,
        onPositiveButtonPressed: bottomSheet.dismiss,
      );
      bottomSheet
        ..update(statusData: errorStatus)
        ..show();
    }

    /// Mark: sign in with Google
    Future<void> attemptSignInWithGoogle() async {
      final (:credential, :exception) = await authProvider.signInWithGoogle();
      if (credential != null) onAuthenticationCompleted(credential);
      if (exception != null) showException(AuthException.from(exception, strings));
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavigationBarColor: Colors.black,
      ),
      child: WillPopScope(
        onWillPop: () {
          final backStack = backStackManager.onBackPressed(strings);
          return Future.value(backStack.canPop);
        },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 48,
                left: 32,
                right: 32,
                bottom: 32,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    strings.welcome,
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontVariations: [
                        FontVariations.w800,
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      strings.neverMissAnOpportunity,
                      textScaleFactor: min(1, textScaleFactor),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontVariations: [
                          FontVariations.w500,
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  AspectRatio(
                    aspectRatio: 1,
                    child: Lottie.asset(
                      Lotties.welcome,
                    ),
                  ),
                  const Spacer(),
                  OutlinedButton.icon(
                    key: Keys.signInButton,
                    style: OutlinedButton.styleFrom(
                      textStyle: theme.textTheme.bodyLarge,
                      fixedSize: const Size.fromHeight(48),
                    ),
                    label: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        strings.signinWithGoogle,
                        textScaleFactor: min(1, textScaleFactor),
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontVariations: [
                            FontVariations.w600,
                          ],
                        ),
                      ),
                    ),
                    icon: Image.asset(Images.google, width: 24, height: 24),
                    onPressed: attemptSignInWithGoogle,
                  ),
                  const Spacer(),
                  const Divider(
                    thickness: 0,
                    height: 0,
                    indent: 80,
                    endIndent: 80,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: GestureDetector(
                onTap: () => launchUrlString(Urls.termsConditions),
                child: Text.rich(
                  key: Keys.termsAndConditions,
                  textScaleFactor: min(1, textScaleFactor),
                  textAlign: TextAlign.center,
                  TextSpan(
                    text: '${strings.byContinuingYouAgreeToOur} ',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontVariations: [
                        FontVariations.w500,
                      ],
                    ),
                    children: [
                      TextSpan(
                        text: strings.termsAndConditions,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
