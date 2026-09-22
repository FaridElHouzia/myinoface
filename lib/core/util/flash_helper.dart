import 'package:flutter/material.dart';
import 'package:flash/flash.dart';
import 'package:get/get.dart';
import 'dart:collection';
import 'dart:async';


class _MessageItem<T> {
  final String message;
  Completer<Future<T>> completer;

  _MessageItem(this.message) : completer = Completer<Future<T>>();
}

class FlashHelper {
  static Completer<BuildContext> _buildCompleter = Completer<BuildContext>();
  static final Queue<_MessageItem> _messageQueue = Queue<_MessageItem>();
  static Completer? _previousCompleter;

  static void init(BuildContext context) {
    if (_buildCompleter.isCompleted == false) {
      _buildCompleter.complete(context);
    }
  }

  static void dispose() {
    _messageQueue.clear();

    if (_buildCompleter.isCompleted == false) {
      _buildCompleter.completeError('NotInitalize');
    }
    _buildCompleter = Completer<BuildContext>();
  }

  static Future<T?> toast<T>(String message) async {
    var context = await _buildCompleter.future;

    // Wait previous toast dismissed.
    if (_previousCompleter?.isCompleted == false) {
      var item = _MessageItem<T>(message);
      _messageQueue.add(item);
      return await item.completer.future;
    }

    _previousCompleter = Completer();

    Future<T?> showToast(String message) async {
      return await showFlash<T>(
        context: context,
        builder: (context, controller) {
          //! TODO: By Mazen
          return SizedBox();
          //! TODO: By Mazen
          // return Flash.dialog(
          //   controller: controller,
          //   alignment: const Alignment(0, 0.5),
          //   margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          //   borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          //   // enableDrag: false,
          //   backgroundColor: Colors.black87,
          //   child: DefaultTextStyle(
          //     style: const TextStyle(fontSize: 16.0, color: Colors.white),
          //     child: Padding(
          //       padding:
          //           const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          //       child: Text(message),
          //     ),
          //   ),
          // );
        },
        duration: const Duration(seconds: 3),
      ).whenComplete(() {
        if (_messageQueue.isNotEmpty) {
          var item = _messageQueue.removeFirst();
          item.completer.complete(showToast(item.message));
        } else {
          _previousCompleter?.complete();
        }
      });
    }

    return showToast(message);
  }

  static Color _backgroundColor(BuildContext context) {
    var theme = Theme.of(context);
    return theme.dialogTheme.backgroundColor ?? theme.dialogBackgroundColor;
  }

  static TextStyle _titleStyle(BuildContext context, [Color? color]) {
    var theme = Theme.of(context);
    return (theme.dialogTheme.titleTextStyle ?? theme.textTheme.bodyMedium ?? const TextStyle())
        .copyWith(color: color);
  }

  static TextStyle _contentStyle(BuildContext context, [Color? color]) {
    var theme = Theme.of(context);
    return (theme.dialogTheme.contentTextStyle ?? theme.textTheme.bodyMedium ?? const TextStyle())
        .copyWith(color: color);
  }

  static Future<T?> infoBar<T>({
    String? title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) async {
    BuildContext? ctz = Get.overlayContext;
    if (ctz == null) return null;
    return await showFlash<T>(
      context: ctz,
      duration: duration,
      builder: (context, controller) {
        //! TODO: By Mazen
        return SizedBox();
        // return Flash(
        //   controller: controller,
        //   behavior: FlashBehavior.floating,
        //   position: FlashPosition.bottom,
        //   horizontalDismissDirection: HorizontalDismissDirection.horizontal,
        //   backgroundColor: Colors.black87,
        //   child: FlashBar(
        //     title: title == null ? null : Text(title, style: _titleStyle(context, Colors.white)),
        //     content: Text(message, style: _contentStyle(context, Colors.white)),
        //     icon: Icon(Icons.info_outline, color: Colors.green[300]),
        //     // leftBarIndicatorColor: Colors.green[300],
        //   ),
        // );
      },
    );
  }

  static Future<T?> successBar<T>({
    String? title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    return showFlash<T>(
      context: Get.overlayContext!,
      duration: duration,
      builder: (context, controller) {
        //! TODO: By Mazen
        return SizedBox();
        // return Flash(
        //   controller: controller,
        //   behavior: FlashBehavior.floating,
        //   position: FlashPosition.bottom,
        //   horizontalDismissDirection: HorizontalDismissDirection.horizontal,
        //   backgroundColor: Colors.black87,
        //   child: FlashBar(
        //     title: title == null
        //         ? null
        //         : Text(title, style: _titleStyle(context, Colors.white)),
        //     content: Text(message, style: _contentStyle(context, Colors.white)),
        //     icon: Icon(Icons.check_circle, color: Colors.pink[300]),
        //     // leftBarIndicatorColor: Colors.pink[300],
        //   ),
        // );
      },
    );
  }

  static Future<T?> errorBar<T>({
    String? title,
    required String message,
    ChildBuilder<T>? primaryAction,
    Duration duration = const Duration(seconds: 3),
  }) {
    return showFlash<T>(
      context: Get.overlayContext!,
      duration: duration,
      builder: (context, controller) {
        return StatefulBuilder(builder: (context, setState) {
          //! TODO: By Mazen
          return SizedBox();
          // return Flash(
          //   controller: controller,
          //   behavior: FlashBehavior.floating,
          //   position: FlashPosition.bottom,
          //   horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          //   backgroundColor: Colors.black87,
          //   child: FlashBar(
          //     title: title == null
          //         ? null
          //         : Text(title, style: _titleStyle(context, Colors.white)),
          //     content:
          //         Text(message, style: _contentStyle(context, Colors.white)),
          //     primaryAction: primaryAction?.call(context, controller, setState),
          //     icon: Icon(Icons.warning, color: Colors.red[300]),
          //     // leftBarIndicatorColor: Colors.red[300],
          //   ),
          // );
        });
      },
    );
  }

  static Future<T?> actionBar<T>(
    BuildContext context, {
    String? title,
    required String message,
    required ChildBuilder<T> primaryAction,
    Duration duration = const Duration(seconds: 3),
  }) {
    return showFlash<T>(
      context: context,
      duration: duration,
      builder: (context, controller) {
        return StatefulBuilder(builder: (context, setState) {
          //! TODO: By Mazen
          return SizedBox();
          // return Flash(
          //   controller: controller,
          //   behavior: FlashBehavior.floating,
          //   position: FlashPosition.bottom,
          //   horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          //   backgroundColor: Colors.black87,
          //   child: FlashBar(
          //     title: title == null ? null : Text(title, style: _titleStyle(context, Colors.white)),
          //     content: Text(message, style: _contentStyle(context, Colors.white)),
          //     primaryAction: primaryAction.call(context, controller, setState),
          //   ),
          // );
        });
      },
    );
  }

  static Future<T?> simpleDialog<T>(
    BuildContext context, {
    String? title,
    required String message,
    Color? messageColor,
    ChildBuilder<T>? negativeAction,
    ChildBuilder<T>? positiveAction,
  }) {
    return showFlash<T>(
      context: context,
      persistent: false,
      builder: (context, controller) {
        return StatefulBuilder(
          builder: (context, setState) {
            //! TODO: By Mazen
            return SizedBox();
            // return Flash.dialog(
            //   controller: controller,
            //   backgroundColor: _backgroundColor(context),
            //   margin: const EdgeInsets.only(left: 40.0, right: 40.0),
            //   borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            //   child: FlashBar(
            //     title: title == null ? null : Text(title, style: _titleStyle(context)),
            //     content: Text(message, style: _contentStyle(context, messageColor)),
            //     actions: <Widget>[
            //        (negativeAction != null) ?
            //         negativeAction(context, controller, setState) : Container(),
            //        (positiveAction != null)?
            //         positiveAction(context, controller, setState) : Container(),
            //     ],
            //   ),
            // );
          },
        );
      },
    );
  }

  static Future<T?> customDialog<T>(
    BuildContext context, {
    ChildBuilder<T>? titleBuilder,
    required ChildBuilder messageBuilder,
    ChildBuilder<T>? negativeAction,
    ChildBuilder<T>? positiveAction,
  }) {
    return showFlash<T>(
      context: context,
      persistent: false,
      builder: (context, controller) {
        return StatefulBuilder(
          builder: (context, setState) {
            //! TODO: By Mazen
            return SizedBox();
            // return Flash.dialog(
            //   controller: controller,
            //   backgroundColor: _backgroundColor(context),
            //   margin: const EdgeInsets.only(left: 40.0, right: 40.0),
            //   borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            //   child: FlashBar(
            //     title: titleBuilder != null ? DefaultTextStyle(
            //       style: _titleStyle(context),
            //       child: titleBuilder.call(context, controller, setState),
            //     ) : null,
            //     content: DefaultTextStyle(
            //       style: _contentStyle(context),
            //       child: messageBuilder.call(context, controller, setState),
            //     ),
            //     actions: <Widget>[
            //        (negativeAction != null) ?
            //         negativeAction(context, controller, setState) : Container(),
            //        (positiveAction != null) ?
            //         positiveAction(context, controller, setState) : Container(),
            //     ],
            //   ),
            // );
          },
        );
      },
    );
  }

  static Future<String?> inputDialog(
    BuildContext context, {
    String? title,
    String? message,
    String? defaultValue,
    bool persistent = true,
    WillPopCallback? onWillPop,
  }) {
    var editingController = TextEditingController(text: defaultValue);
    //! TODO: By Mazen
    return Future.value('');
    // return showFlash<String>(
    //   context: context,
    //   persistent: persistent,
    //   onWillPop: onWillPop,
    //   builder: (context, controller) {
    //     var theme = Theme.of(context);
    //     return Flash<String>.bar(
    //       controller: controller,
    //       behavior: FlashBehavior.floating,
    //       position: FlashPosition.bottom,
    //       horizontalDismissDirection: HorizontalDismissDirection.horizontal,
    //       backgroundColor: Colors.black87,
    //       borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
    //       child: FlashBar(
    //         title: title == null
    //             ? null
    //             : Text(title, style: TextStyle(fontSize: 24.0)),
    //         content: Column(
    //           children: [
    //              (message != null) ? Text(message) : Container(),
    //             Form(
    //               child: TextFormField(
    //                 controller: editingController,
    //                 autofocus: true,
    //               ),
    //             ),
    //           ],
    //         ),
    //         // leftBarIndicatorColor: theme.primaryColor,
    //         primaryAction: IconButton(
    //           onPressed: () {
    //             var message = editingController.text;
    //             controller.dismiss(message);
    //           },
    //           icon: Icon(Icons.send, color: theme.colorScheme.secondary),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}

typedef ChildBuilder<T> = Widget Function(
    BuildContext context, FlashController<T> controller, StateSetter setState);
