
// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.plugins.imagepickerexample;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.imagepicker.ImagePickerPlugin;
import io.flutter.plugins.videoplayer.VideoPlayerPlugin;

public class MainActivity extends FlutterActivity {

  // TODO(cyanglaz): Remove this once v2 of GeneratedPluginRegistrant rolls to stable.
  // https://github.com/flutter/flutter/issues/42694
  @Override
  public void configureFlutterEngine(FlutterEngine flutterEngine) {
    super.configureFlutterEngine(flutterEngine);
    flutterEngine.getPlugins().add(new ImagePickerPlugin());
    flutterEngine.getPlugins().add(new VideoPlayerPlugin());
  }
}
