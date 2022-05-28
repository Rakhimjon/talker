import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerRouteObserver extends NavigatorObserver {
  TalkerRouteObserver(this.talker);

  final TalkerInterface talker;

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    talker.logTyped(TalkerRouteLog(route: route));
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    talker.logTyped(TalkerRouteLog(route: route, isPush: false));
  }
}

class TalkerRouteLog extends FlutterTalkerLog {
  TalkerRouteLog({
    required Route route,
    bool isPush = true,
  }) : super(_createMessage(route, isPush));

  @override
  AnsiPen get pen => AnsiPen()..xterm(166);

  @override
  Color get color => const Color(0xFFD75F00);

  @override
  String get title => 'ROUTE';

  static String _createMessage(
    Route<dynamic> route,
    bool isPush,
  ) {
    final buffer = StringBuffer();
    buffer.write(isPush ? 'Open' : 'Close');
    buffer.write(' route named ');
    buffer.write(route.settings.name ?? 'null');

    final args = route.settings.arguments;
    if (args != null) {
      buffer.write('\nWith args: $args');
    }
    return buffer.toString();
  }
}
