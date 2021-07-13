library salem_engine;

import 'package:dart_vlc/dart_vlc.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

export 'core/persist/splash.dart';
export 'package:salem/core/persist/route_observer.dart';
export 'package:salem/components/global/undefined_view.dart';
export 'package:salem/components/visualnovel/vn_scaffold.dart';
export 'package:salem/components/chat/chat_scaffold.dart';
export 'package:salem/components/chat/models/core_chat.dart';
export 'package:salem/components/global/main_menu.dart';
export 'package:salem/components/visualnovel/gui/name_box.dart';
export 'package:salem/components/visualnovel/models/core_speech.dart';

abstract class Salem {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    if (UniversalPlatform.isWindows ||
        UniversalPlatform.isLinux ||
        UniversalPlatform.isMacOS) {
      await DesktopWindow.setMinWindowSize(Size(1000, 600));
      await DesktopWindow.setMaxWindowSize(Size.infinite);
    } else {}
    if (UniversalPlatform.isWeb) {
    } else {
      DartVLC.initialize();
    }
  }
}
