import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:localization_lite/translate.dart';

import 'PrimaryContainer.dart';

List<OverlayEntry> _overlays = [];
double top = 10;
void showOverlay(BuildContext context) {
  _overlays.add(_createOverlayEntry());
  top += 0.1;
  Overlay.of(context).insert(_overlays.last!);
}

void removeOverlay() {
  _overlays.last.remove();
  _overlays.removeLast();
}

OverlayEntry _createOverlayEntry() {
  return OverlayEntry(
    builder: (context) => Animate(
      effects: const [FadeEffect(), AlignEffect()],
      child: Positioned(
        top: top,
        left: MediaQuery.sizeOf(context).width * 0.1,
        width: MediaQuery.sizeOf(context).width * 0.8,
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
          child: PrimaryContainer(
              margin: 0,
              padding: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(child: Text(tr("toastTitle"))),
                    IconButton(onPressed: () {}, icon: Text(tr("undo"))),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.highlight_remove_rounded))
                  ],
                ),
              )),
        ),
      ),
    ),
  );
}
