import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import '../utils/js_interop.dart' as jsPose;
import '../models/pose_landmark_type.dart';
import 'pose_backend.dart';

UnifiedPoseLandmarkType mapMLKitLandmark(PoseLandmarkType mlKit) {
  switch (mlKit) {
    case PoseLandmarkType.nose:
      return UnifiedPoseLandmarkType.nose;
    case PoseLandmarkType.leftEyeInner:
      return UnifiedPoseLandmarkType.leftEyeInner;
    case PoseLandmarkType.leftEye:
      return UnifiedPoseLandmarkType.leftEye;
    case PoseLandmarkType.leftEyeOuter:
      return UnifiedPoseLandmarkType.leftEyeOuter;
    case PoseLandmarkType.rightEyeInner:
      return UnifiedPoseLandmarkType.rightEyeInner;
    case PoseLandmarkType.rightEye:
      return UnifiedPoseLandmarkType.rightEye;
    case PoseLandmarkType.rightEyeOuter:
      return UnifiedPoseLandmarkType.rightEyeOuter;
    case PoseLandmarkType.leftEar:
      return UnifiedPoseLandmarkType.leftEar;
    case PoseLandmarkType.rightEar:
      return UnifiedPoseLandmarkType.rightEar;
    case PoseLandmarkType.leftMouth:
      return UnifiedPoseLandmarkType.mouthLeft;
    case PoseLandmarkType.rightMouth:
      return UnifiedPoseLandmarkType.mouthRight;
    case PoseLandmarkType.leftShoulder:
      return UnifiedPoseLandmarkType.leftShoulder;
    case PoseLandmarkType.rightShoulder:
      return UnifiedPoseLandmarkType.rightShoulder;
    case PoseLandmarkType.leftElbow:
      return UnifiedPoseLandmarkType.leftElbow;
    case PoseLandmarkType.rightElbow:
      return UnifiedPoseLandmarkType.rightElbow;
    case PoseLandmarkType.leftWrist:
      return UnifiedPoseLandmarkType.leftWrist;
    case PoseLandmarkType.rightWrist:
      return UnifiedPoseLandmarkType.rightWrist;
    case PoseLandmarkType.leftHip:
      return UnifiedPoseLandmarkType.leftHip;
    case PoseLandmarkType.rightHip:
      return UnifiedPoseLandmarkType.rightHip;
    case PoseLandmarkType.leftKnee:
      return UnifiedPoseLandmarkType.leftKnee;
    case PoseLandmarkType.rightKnee:
      return UnifiedPoseLandmarkType.rightKnee;
    case PoseLandmarkType.leftAnkle:
      return UnifiedPoseLandmarkType.leftAnkle;
    case PoseLandmarkType.rightAnkle:
      return UnifiedPoseLandmarkType.rightAnkle;
    case PoseLandmarkType.leftHeel:
      return UnifiedPoseLandmarkType.leftHeel;
    case PoseLandmarkType.rightHeel:
      return UnifiedPoseLandmarkType.rightHeel;
    case PoseLandmarkType.leftFootIndex:
      return UnifiedPoseLandmarkType.leftFootIndex;
    case PoseLandmarkType.rightFootIndex:
      return UnifiedPoseLandmarkType.rightFootIndex;
    default:
      return UnifiedPoseLandmarkType.nose;
  }
}

class MobilePoseBackend implements PoseBackend {
  late final PoseDetector _poseDetector;

  @override
  Future<void> initialize() async {
    _poseDetector = PoseDetector(
      options: PoseDetectorOptions(mode: PoseDetectionMode.stream),
    );
  }

  @override
  Future<List<jsPose.Pose>> detectFromImage(dynamic image) async {
    final poses = await _poseDetector.processImage(image);

    if (poses.isEmpty) {
      return [];
    }

    final List<jsPose.Pose> results = [];

    for (final pose in poses) {
      final landmarks = pose.landmarks.entries
          .map(
            (entry) => jsPose.Landmark(
              x: entry.value.x,
              y: entry.value.y,
              z: entry.value.z,
              visibility: entry.value.likelihood,
              landmarkType: mapMLKitLandmark(entry.value.type),
            ),
          )
          .toList();

      results.add(jsPose.Pose(landmarks));
    }

    return results;
  }

  // @override
  // Future<List<jsPose.Pose>> detectFromVideo(CameraImage cameraImage) async {
  //   final inputImage = InputImage.fromBytes(
  //     bytes: cameraImage.planes[0].bytes,
  //     metadata: InputImageMetadata(
  //       size: Size(cameraImage.width.toDouble(), cameraImage.height.toDouble()),
  //       rotation: InputImageRotation.rotation0deg,
  //       format: InputImageFormat.nv21, // TODO check for iOS (bgra8888)
  //       bytesPerRow: cameraImage.planes[0].bytesPerRow,
  //     ),
  //   );

  //   return await detectFromImage(inputImage);
  // }
}
