import 'dart:js_interop';

import 'package:pose/models/pose_landmark_type.dart';

@JS('initPoseWeb')
external JSPromise initPoseWeb(JSString wasmPath, JSString modelPath);

@JS('detectPoseWebForImage')
external JSPromise detectPoseWebForImage(JSString imgElementId);

@JS('detectPoseWebForVideo')
external JSPromise detectPoseWebForVideo(JSString videoElementId);

@JS('closePoseWeb')
external void closePoseWeb();

// Dart model
class Landmark {
  final double x, y, z, visibility;
  final UnifiedPoseLandmarkType landmarkType;

  Landmark({
    required this.x,
    required this.y,
    required this.z,
    required this.visibility,
    required this.landmarkType,
  });
}

class Pose {
  final List<Landmark> landmarks;
  Pose(this.landmarks);
}

List<Pose> convertJSResult(JSAny jsResult) {
  // TODO
  print(jsResult);
  final landmarks = <Landmark>[];

  return [Pose(landmarks)];
}
