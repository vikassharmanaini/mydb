import 'package:flutter/material.dart';

/// Vertical split with a draggable divider between [top] and [bottom].
class VerticalSplitPane extends StatefulWidget {
  const VerticalSplitPane({
    super.key,
    required this.top,
    required this.bottom,
    this.initialTopFraction = 0.52,
    this.minTop = 120,
    this.minBottom = 120,
  });

  final Widget top;
  final Widget bottom;
  final double initialTopFraction;
  final double minTop;
  final double minBottom;

  @override
  State<VerticalSplitPane> createState() => _VerticalSplitPaneState();
}

class _VerticalSplitPaneState extends State<VerticalSplitPane> {
  late double _topFraction = widget.initialTopFraction;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints c) {
        final double h = c.maxHeight;
        double topH = h * _topFraction;
        topH = topH.clamp(widget.minTop, h - widget.minBottom);
        return Column(
          children: <Widget>[
            SizedBox(height: topH, child: widget.top),
            MouseRegion(
              cursor: SystemMouseCursors.resizeUpDown,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onVerticalDragUpdate: (DragUpdateDetails d) {
                  setState(() {
                    _topFraction = ((topH + d.delta.dy) / h).clamp(
                      widget.minTop / h,
                      (h - widget.minBottom) / h,
                    );
                  });
                },
                child: Container(
                  height: 6,
                  color: Theme.of(context).dividerColor,
                  alignment: Alignment.center,
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurfaceVariant
                          .withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(child: widget.bottom),
          ],
        );
      },
    );
  }
}
