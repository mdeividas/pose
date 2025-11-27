import 'package:flutter/material.dart';
import 'package:pose/services/pose_service.dart';
import 'package:provider/provider.dart';
import 'package:pose/utils/js_interop.dart' as jsPose;

class Workspace extends StatefulWidget {
  const Workspace({super.key});

  @override
  _WorkspaceState createState() => _WorkspaceState();
}

class _WorkspaceState extends State<Workspace> {
  List<jsPose.Pose> poses = [];

  @override
  void initState() {
    super.initState();
  }

  void detect(BuildContext context) async {
    final poseService = context.read<PoseService>();

    print('Start detect');

    try {
      final detectedPoses = await poseService.detectFromImage(
        Image.asset('images/tmp/img_1.webp'),
      );

      print('Start detect results');
      print(detectedPoses);

      setState(() {
        poses = detectedPoses;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    detect(context);

    print('___DEBUG: start');
    print(poses);
    print('___DEBUG: end');

    return Scaffold(
      appBar: AppBar(title: const Text('Workspace')),
      body: Center(child: Image.asset('images/tmp/img_1.webp')),
    );
  }
}
