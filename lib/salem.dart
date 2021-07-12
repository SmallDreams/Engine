library salem_engine;

import 'dart:async';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:rive_loading/rive_loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

import 'package:salem/components/global/logical_keyboard.dart';
import 'package:salem/components/global/onWillPop.dart';
import 'package:salem/components/visualnovel/components/text_animation.dart';
import 'package:salem/components/visualnovel/gui/name_box.dart';
import 'package:salem/components/visualnovel/user_interface/background_builder.dart';
import 'package:salem/components/visualnovel/user_interface/buttons.dart';
import 'package:salem/components/visualnovel/user_interface/vn_img_builder.dart';
import 'package:salem/core/audio/game_audio.dart';
import 'package:salem/core/audio/voice_audio.dart';
import 'package:salem/core/persist/constants/get_routes.dart';

part 'components/global/main_menu.dart';
part 'components/global/undefined_view.dart';
part 'components/visualnovel/vn_constructor.dart';
part 'components/visualnovel/vn_scaffold.dart';
part 'core/audio/global_audio.dart';
part 'core/persist/route_observer.dart';
part 'core/persist/splash.dart';
part 'core/persist/rive_splash.dart';
part 'components/chat/chat_scaffold.dart';
part 'components/chat/models/core_speech.dart';

abstract class Salem {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    if (UniversalPlatform.isWindows ||
        UniversalPlatform.isLinux ||
        UniversalPlatform.isMacOS) {
      await DesktopWindow.setMinWindowSize(Size(1000, 600));
      await DesktopWindow.setMaxWindowSize(Size.infinite);
    }
    if (UniversalPlatform.isWeb) {
    } else {
      DartVLC.initialize();
    }
  }
}
