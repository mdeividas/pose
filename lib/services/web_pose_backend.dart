import 'dart:js_interop';

import 'package:flutter/foundation.dart';
import '../utils/js_interop.dart' as jsPose;
import 'pose_backend.dart';

class WebPoseBackend implements PoseBackend {
  bool _initialized = false;

  @override
  Future<void> initialize() async {
    if (_initialized) return;
    await jsPose
        .initPoseWeb(
          'https://cdn.jsdelivr.net/npm/@mediapipe/tasks-vision@latest/wasm'
              .toJS,
          'models/pose_landmarker_full.task'.toJS,
        )
        .toDart;
    _initialized = true;
  }

  @override
  Future<List<jsPose.Pose>> detectFromImage(dynamic image) async {
    if (!_initialized) {
      await initialize();
    }

    final result = await jsPose.detectPoseWebForImage(image).toDart;

    if (result == null) {
      return [];
    }

    return jsPose.convertJSResult(result);
  }

  @override
  Future<List<jsPose.Pose>> detectFromVideo(dynamic video) async {
    if (!_initialized) {
      await initialize();
    }

    final result = await jsPose
        .detectPoseWebForVideo(video.id.toString().toJS)
        .toDart;

    if (result == null) {
      return [];
    }

    return jsPose.convertJSResult(result);
  }
}
