import '../utils/js_interop.dart' as jsPose;

abstract class PoseBackend {
  Future<void> initialize();
  Future<List<jsPose.Pose>> detectFromImage(dynamic image);
  // Future<List<jsPose.Pose>> detectFromVideo(dynamic video);
}
