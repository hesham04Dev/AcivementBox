import 'dart:async';

import 'package:cherry_toast/resources/arrays.dart';
import 'package:cherry_toast/resources/extensions.dart';
import 'package:flutter/material.dart';

import 'PrimaryContainer.dart';
import 'flat_primary_container.dart';

class MyToast extends StatefulWidget {
  OverlayEntry? overlayEntry;

  MyToast({
    super.key,
    required this.title,
    this.button,
    this.toastPosition = Position.top,
    this.animationDuration = const Duration(
      milliseconds: 1500,
    ),
    this.animationCurve = Curves.ease,
    this.animationType = AnimationType.fromLeft,
    this.autoDismiss = true,
    this.toastDuration = const Duration(
      milliseconds: 3000,
    ),
    this.displayCloseButton = true,
    this.displayIcon = true,
    this.iconWidget,
  });
  final Text title;
  final Widget? button;
  final Widget? iconWidget;
  final Position toastPosition;
  final Duration animationDuration;
  final Cubic animationCurve;
  final AnimationType animationType;
  final bool autoDismiss;
  final Duration toastDuration;
  final bool displayCloseButton;
  final bool displayIcon;
  void show(BuildContext context) {
    overlayEntry = _overlayEntryBuilder();
    final overlay = Overlay.maybeOf(context);

    if (overlay != null) {
      overlay.insert(overlayEntry!);
    } else {
      Navigator.of(context).overlay?.insert(overlayEntry!);
    }
  }

  void closeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      opaque: false,
      builder: (context) {
        return SafeArea(
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            alignment: toastPosition.alignment,
            contentPadding: const EdgeInsets.all(0),
            insetPadding: const EdgeInsets.all(30),
            content: this,
          ),
        );
      },
    );
  }

  @override
  _MyToastState createState() => _MyToastState();
}

class _MyToastState extends State<MyToast> with TickerProviderStateMixin {
  late Animation<Offset> offsetAnimation;
  late Animation<Offset> disabledAnimationOffset;
  late AnimationController slideController;
  late BoxDecoration toastDecoration;
  Timer? autoDismissTimer;

  @override
  void initState() {
    super.initState();
    initAnimation();

    if (widget.autoDismiss) {
      autoDismissTimer = Timer(widget.toastDuration, () {
        slideController.reverse();
        Timer(widget.animationDuration, () {
          widget.closeOverlay();
        });
      });
    }
  }

  @override
  void dispose() {
    autoDismissTimer?.cancel();
    slideController.dispose();
    super.dispose();
  }

  void initAnimation() {
    slideController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    switch (widget.animationType) {
      case AnimationType.fromLeft:
        offsetAnimation = Tween<Offset>(
          begin: const Offset(-2, 0),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: slideController,
            curve: widget.animationCurve,
          ),
        );
        break;
      case AnimationType.fromRight:
        offsetAnimation = Tween<Offset>(
          begin: const Offset(2, 0),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: slideController,
            curve: widget.animationCurve,
          ),
        );
        break;
      case AnimationType.fromTop:
        offsetAnimation = Tween<Offset>(
          begin: const Offset(0, -2),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: slideController,
            curve: widget.animationCurve,
          ),
        );
        break;
      case AnimationType.fromBottom:
        offsetAnimation = Tween<Offset>(
          begin: const Offset(0, 2),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: slideController,
            curve: widget.animationCurve,
          ),
        );
        break;
      default:
    }

    T? ambiguate<T>(T? value) => value;

    ambiguate(WidgetsBinding.instance)?.addPostFrameCallback((_) {
      slideController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: offsetAnimation,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: renderMyToastContent(context),
      ),
    );
  }

  Widget renderMyToastContent(BuildContext context) {
    return FlatContainer(
      child: PrimaryContainer(
          margin: 0,
          paddingHorizontal: 10,
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.iconWidget ?? const SizedBox(),
              const SizedBox(
                width: 5,
              ),
              Expanded(child: widget.title),
              widget.button ?? const SizedBox(),
              const SizedBox(
                width: 5,
              ),
              widget.displayCloseButton
                  ? IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.close,
                        size: 15,
                      ))
                  : const SizedBox()
            ],
          )),
    );
  }
}
