library flutter_web_scrollbar;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// Welcome to the FlutterWebScrollBar Plugin!
/// In order to assist with using the plugin directly,
/// I've set up this introduction.
///
/// Before you begin implementing this scrollbar for
/// your web project, it's important to note that the plugin is
/// still under development.
///
/// We are actively working on things like mouse scroll detection, and
/// automatically determining the height of your page content.
///
/// Please feel free to file an issue report at the repository found here:
/// https://github.com/cairacshields/flutter_web_scrollbar_plugin

class FlutterWebScrollBar {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
        'plugins.flutter.io/flutter_web_scrollbar',
        const StandardMethodCodec(),
        registrar.messenger);
    final FlutterWebScrollBar instance = FlutterWebScrollBar();
    channel.setMethodCallHandler(instance.handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'flutter_web_scrollbar':
        Function scrollCallBack = call.arguments['scrollCallBack'];
        Color backgroundColor = call.arguments['scrollBarBackgroundColor'];
        double barWidth = call.arguments['scrollBarWidth'];
        Color handleColor = call.arguments['dragHandleColor'];
        double handleWidth = call.arguments['dragHandleWidth'];
        double handleHeight = call.arguments['dragHandleHeight'];
        double handleBorderRadius = call.arguments['dragHandleBorderRadius'];

        return FlutterWebScroller(
          scrollCallBack,
          scrollBarBackgroundColor: backgroundColor,
          scrollBarWidth: barWidth,
          dragHandleColor: handleColor,
          dragHandleWidth: handleWidth,
          dragHandleHeight: handleHeight,
          dragHandleBorderRadius: handleBorderRadius,
        );
      default:
        throw PlatformException(
            code: 'Unimplemented',
            details: "The flutter_web_scrollbar plugin for web doesn't implement "
                "the method '${call.method}'");
    }
  }
}


class FlutterWebScroller extends StatefulWidget {

  /// Required! CallBack function used to update the scrollable content with the new drag position
  final Function scrollCallBack;

  /// Optional: Background color of the scrollbar
  final Color scrollBarBackgroundColor;

  ///Optional: Width of the scrollbar
  final double scrollBarWidth;

  ///Optional: Color of the drag handle
  final Color dragHandleColor;

  ///Optional: Width of the drag handle
  final double dragHandleWidth;

  ///Optional: Height of the drag handle
  final double dragHandleHeight;

  ///Optional: Border Radius of the drag handle
  final double dragHandleBorderRadius;

  FlutterWebScroller(this.scrollCallBack,
      {this.scrollBarBackgroundColor = Colors.black12,
      this.dragHandleColor = Colors.grey,
      this.scrollBarWidth = 20.0,
      this.dragHandleHeight = 40.0,
      this.dragHandleWidth = 15.0,
      this.dragHandleBorderRadius = 3.0});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FlutterWebScrollerState();
  }
}

class _FlutterWebScrollerState extends State<FlutterWebScroller> {
  static double _offset = 0;

  @override
  Widget build(BuildContext context) {
    return //Scroll bar
        Container(
            alignment: Alignment.centerRight,
            height: MediaQuery.of(context).size.height,
            width: widget.scrollBarWidth,
            margin: EdgeInsets.only(
                left:
                    MediaQuery.of(context).size.width - widget.scrollBarWidth),
            decoration: BoxDecoration(color: widget.scrollBarBackgroundColor),
            child: Container(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                child: Container(
                  height: widget.dragHandleHeight,
                  width: widget.dragHandleWidth,
                  margin: EdgeInsets.only(left: 5.0, right: 5.0, top: _offset),
                  decoration: BoxDecoration(
                      color: widget.dragHandleColor,
                      borderRadius: BorderRadius.all(
                          Radius.circular(widget.dragHandleBorderRadius))),
                ),
                onVerticalDragUpdate: (dragUpdate) {
                  /// Send the new drag details to the callback in order to properly update the scrollable content position
                  widget.scrollCallBack(dragUpdate);

                  setState(() {
                    if (dragUpdate.globalPosition.dy >= 0) {
                      /// Update the offset of the drag handle to push it down or shift it up
                      _offset = dragUpdate.globalPosition.dy;
                    }
                  });
                },
              ),
            ));
  }
}
