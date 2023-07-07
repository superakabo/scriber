import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scriber/src/utilities/constants/font_variations.dart';

typedef BottomSheetData = ({
  StatusData? statusData,
  Widget? widget,
  SheetConfig config,
});

class SheetConfig {
  final bool isDismissible;
  final bool enableDrag;
  final bool isScrollControlled;
  final Duration animationDuration;
  final Color? backgroundColor;
  final double? elevation;
  final ShapeBorder? shape;
  final Clip? clipBehavior;
  final BoxConstraints? constraints;
  final Color? barrierColor;
  final bool useRootNavigator;
  final RouteSettings? routeSettings;
  final AnimationController? transitionAnimationController;
  final Offset? anchorPoint;

  const SheetConfig({
    this.isDismissible = false,
    this.enableDrag = false,
    this.isScrollControlled = true,
    this.useRootNavigator = false,
    this.animationDuration = const Duration(milliseconds: 330),
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.clipBehavior,
    this.constraints,
    this.barrierColor,
    this.routeSettings,
    this.transitionAnimationController,
    this.anchorPoint,
  });

  SheetConfig copyWith({
    bool? isDismissible,
    bool? enableDrag,
    bool? isScrollControlled,
    Duration? animationDuration,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    Color? barrierColor,
    bool? useRootNavigator,
    RouteSettings? routeSettings,
    AnimationController? transitionAnimationController,
    Offset? anchorPoint,
  }) {
    return SheetConfig(
      isDismissible: isDismissible ?? this.isDismissible,
      enableDrag: enableDrag ?? this.enableDrag,
      isScrollControlled: isScrollControlled ?? this.isScrollControlled,
      animationDuration: animationDuration ?? this.animationDuration,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      elevation: elevation ?? this.elevation,
      shape: shape ?? this.shape,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      constraints: constraints ?? this.constraints,
      barrierColor: barrierColor ?? this.barrierColor,
      useRootNavigator: useRootNavigator ?? this.useRootNavigator,
      routeSettings: routeSettings ?? this.routeSettings,
      transitionAnimationController: transitionAnimationController ?? this.transitionAnimationController,
      anchorPoint: anchorPoint ?? this.anchorPoint,
    );
  }
}

enum Status {
  none,
  loading,
  info,
  error;
}

class StatusData {
  final String title;
  final String message;
  final String positiveButtonText;
  final String negativeButtonText;
  final VoidCallback? onPositiveButtonPressed;
  final VoidCallback? onNegativeButtonPressed;
  final double? textScaleFactor;
  final Status status;

  const StatusData({
    required this.title,
    required this.message,
    required this.status,
    this.positiveButtonText = '',
    this.negativeButtonText = '',
    this.textScaleFactor,
    this.onPositiveButtonPressed,
    this.onNegativeButtonPressed,
  });

  StatusData copyWith({
    String? title,
    String? message,
    String? positiveButtonText,
    String? negativeButtonText,
    double? textScaleFactor,
    VoidCallback? onPositiveButtonPressed,
    VoidCallback? onNegativeButtonPressed,
    Status? status,
  }) {
    return StatusData(
      title: title ?? this.title,
      message: message ?? this.message,
      positiveButtonText: positiveButtonText ?? this.positiveButtonText,
      negativeButtonText: negativeButtonText ?? this.negativeButtonText,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      onPositiveButtonPressed: onPositiveButtonPressed ?? this.onPositiveButtonPressed,
      onNegativeButtonPressed: onNegativeButtonPressed ?? this.onNegativeButtonPressed,
      status: status ?? this.status,
    );
  }
}

class _DragIndicator extends StatelessWidget {
  const _DragIndicator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 46,
          height: 5,
          child: DecoratedBox(
            position: DecorationPosition.foreground,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outline,
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoWidget extends StatelessWidget {
  final StatusData data;
  const _InfoWidget(this.data);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final padding = MediaQuery.paddingOf(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (data.title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Text(
              data.title,
              textAlign: TextAlign.center,
              textScaleFactor: data.textScaleFactor,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: (data.status == Status.error) ? theme.colorScheme.error : null,
                fontVariations: [
                  FontVariations.w500,
                ],
              ),
            ),
          ),
        if (data.message.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
            child: Text(
              data.message,
              textAlign: TextAlign.center,
              textScaleFactor: data.textScaleFactor,
              style: theme.textTheme.titleMedium?.copyWith(
                fontVariations: [
                  FontVariations.w500,
                ],
              ),
            ),
          ),
        Padding(
          padding: EdgeInsets.only(
            top: 32,
            left: 24,
            right: 24,
            bottom: max(16, padding.bottom),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (data.positiveButtonText.isNotEmpty)
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      fixedSize: const Size.fromHeight(48),
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      textStyle: theme.textTheme.bodyLarge?.copyWith(
                        fontVariations: [
                          FontVariations.w500,
                        ],
                      ),
                    ),
                    onPressed: data.onPositiveButtonPressed,
                    child: Text(
                      data.positiveButtonText,
                      textScaleFactor: data.textScaleFactor,
                    ),
                  ),
                ),
              if (data.positiveButtonText.isNotEmpty && data.negativeButtonText.isNotEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                ),
              if (data.negativeButtonText.isNotEmpty)
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      fixedSize: const Size.fromHeight(48),
                      backgroundColor: theme.colorScheme.secondary,
                      foregroundColor: theme.colorScheme.onSecondary,
                      textStyle: theme.textTheme.bodyLarge?.copyWith(
                        fontVariations: [
                          FontVariations.w500,
                        ],
                      ),
                    ),
                    onPressed: data.onNegativeButtonPressed,
                    child: Text(
                      data.negativeButtonText,
                      textScaleFactor: data.textScaleFactor,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProgressWidget extends StatelessWidget {
  final StatusData data;
  const _ProgressWidget(this.data);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final padding = MediaQuery.viewPaddingOf(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            data.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: 20,
          ),
          child: SizedBox(
            width: 80,
            height: 80,
            child: CircularProgressIndicator(
              backgroundColor: theme.colorScheme.outline.withOpacity(0.2),
              strokeWidth: 8,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            bottom: max(16, padding.bottom),
          ),
          child: Text(
            data.message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

class _WidgetBuilder extends StatelessWidget {
  final ValueNotifier<BottomSheetData> notifier;
  const _WidgetBuilder(this.notifier);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedSize(
        duration: notifier.value.config.animationDuration,
        child: ValueListenableBuilder(
          valueListenable: notifier,
          builder: (context, value, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (value.config.enableDrag) const _DragIndicator(),
                if (value.widget != null) value.widget!,
                if (value.statusData != null) ...[
                  if (value.statusData?.status == Status.loading) _ProgressWidget(value.statusData!),
                  if (value.statusData?.status == Status.info) _InfoWidget(value.statusData as StatusData),
                  if (value.statusData?.status == Status.error) _InfoWidget(value.statusData as StatusData),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class StatusBottomSheet extends ValueNotifier<BottomSheetData> {
  final BuildContext context;

  StatusBottomSheet._({
    required this.context,
    required BottomSheetData data,
  }) : super(data);

  factory StatusBottomSheet({
    required BuildContext context,
    SheetConfig config = const SheetConfig(),
  }) {
    return StatusBottomSheet._(
      context: context,
      data: (
        config: config,
        widget: const SizedBox.shrink(),
        statusData: null,
      ),
    );
  }

  factory StatusBottomSheet.widget({
    required BuildContext context,
    required Widget widget,
    SheetConfig config = const SheetConfig(),
  }) {
    return StatusBottomSheet._(
      context: context,
      data: (
        config: config,
        widget: widget,
        statusData: null,
      ),
    );
  }

  factory StatusBottomSheet.statusData({
    required BuildContext context,
    required StatusData statusData,
    SheetConfig config = const SheetConfig(),
  }) {
    return StatusBottomSheet._(
      context: context,
      data: (
        config: config,
        statusData: statusData,
        widget: null,
      ),
    );
  }

  bool _showing = false;
  bool get isShowing => _showing;

  /// dismiss the bottom sheet
  void dismiss({bool forcePop = false}) {
    final navigator = Navigator.of(context);
    if (_showing || forcePop) navigator.pop();
  }

  /// dismiss the bottom sheet and pop backstack until routeName is reached
  void dismissPopUntil(
    String routeName, {
    String fallbackRouteName = '/',
    bool forcePop = false,
  }) {
    final navigator = Navigator.of(context);
    if (_showing || forcePop) {
      navigator.popUntil((route) {
        return (route.settings.name == routeName) || (route.settings.name == fallbackRouteName);
      });
    }
  }

  /// dismiss the bottom sheet and push newRouteName
  void dismissPush(
    String routeName, {
    Object? arguments,
    bool forcePop = false,
  }) {
    final navigator = Navigator.of(context);
    if (_showing || forcePop) navigator.popAndPushNamed(routeName, arguments: arguments);
  }

  /// dismiss the bottom sheet, push newRouteName and pop
  /// the backstack until stopRouteName is reached
  void dismissPushAndRemoveUntil(
    String newRouteName, {
    String stopRouteName = '/',
    Object? arguments,
    bool forcePop = false,
  }) {
    final navigator = Navigator.of(context);
    if (_showing || forcePop) {
      navigator.pushNamedAndRemoveUntil(
        newRouteName,
        ModalRoute.withName(stopRouteName),
        arguments: arguments,
      );
    }
  }

  /// Update bottom sheet with new a StatusData or Widget
  void update({Widget? widget, StatusData? statusData}) {
    if (widget != null) {
      value = (
        widget: widget,
        config: value.config,
        statusData: null,
      );
    } else if (statusData != null) {
      value = (
        statusData: statusData,
        config: value.config,
        widget: null,
      );
    }
  }

  /// Show a bottom sheet that adapts to its value changes
  Future<void> show() async {
    if (_showing) return;
    _showing = true;

    return showModalBottomSheet<void>(
      context: context,
      isDismissible: value.config.isDismissible,
      enableDrag: value.config.enableDrag,
      isScrollControlled: value.config.isScrollControlled,
      backgroundColor: value.config.backgroundColor,
      elevation: value.config.elevation,
      shape: value.config.shape,
      clipBehavior: value.config.clipBehavior,
      constraints: value.config.constraints,
      barrierColor: value.config.barrierColor,
      useRootNavigator: value.config.useRootNavigator,
      routeSettings: value.config.routeSettings,
      transitionAnimationController: value.config.transitionAnimationController,
      anchorPoint: value.config.anchorPoint,
      builder: (context) => _WidgetBuilder(this),
    ).whenComplete(() {
      _showing = false;
    });
  }
}
