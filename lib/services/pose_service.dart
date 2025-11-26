import 'package:flutter/foundation.dart';
import 'mobile_pose_backend.dart';
import 'web_pose_backend.dart';
import 'pose_backend.dart';
import '../utils/js_interop.dart' as jsPose;

class PoseService {
  static final PoseService _instance = PoseService._internal();
  factory PoseService() => _instance;
  PoseService._internal();

  late final PoseBackend _backend = WebPoseBackend();
  // late final PoseBackend _backend = kIsWeb ? WebPoseBackend() : MobilePoseBackend();

  Future<void> initialize() async {
    await _backend.initialize();
  }

  Future<List<jsPose.Pose>> detectFromImage(dynamic image) async {
    return _backend.detectFromImage(image);
  }

  // Future<List<jsPose.Pose>> detectFromVideo(dynamic video) async {
  //   return _backend.detectFromVideo(video);
  // }
}
