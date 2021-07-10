library engine;

import 'package:dart_vlc/dart_vlc.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

export 'core/persist/route_observer.dart';
export 'core/persist/splash.dart';
export 'core/audio/global_audio.dart';
export 'components/visualnovel/vn_scaffold.dart';
export 'components/global/main_menu.dart';
export 'components/global/undefined_view.dart';

abstract class Salem {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    if (UniversalPlatform.isWindows ||
        UniversalPlatform.isLinux ||
        UniversalPlatform.isMacOS) {
      await DesktopWindow.setMinWindowSize(Size(1000, 500));
      await DesktopWindow.setMaxWindowSize(Size.infinite);
    }
    if (UniversalPlatform.isWeb) {
    } else {
      DartVLC.initialize();
    }
  }
}
