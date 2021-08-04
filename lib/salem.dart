export 'core/persist/splash.dart';
export 'package:salem/core/persist/route_observer.dart';
export 'package:salem/components/global/undefined_view.dart';
export 'package:salem/components/visualnovel/vn_scaffold.dart';
export 'package:salem/components/chat/chat_scaffold.dart';
export 'package:salem/components/chat/models/core_chat.dart';
export 'package:salem/components/global/main_menu.dart';
export 'package:salem/components/visualnovel/gui/name_box.dart';
export 'package:salem/components/visualnovel/models/core_speech.dart';
export 'package:salem/core/audio/global_audio.dart';
export 'package:salem/components/visualnovel/models/bgm_volume.dart';
export 'package:salem/components/visualnovel/models/sfx_volume.dart';
export 'package:salem/components/visualnovel/models/voice_volume.dart';
export 'package:salem/components/visualnovel/models/text_speed.dart';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

abstract class Salem {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    if (UniversalPlatform.isWeb) {
    } else {
      DartVLC.initialize();
    }
  }
}
