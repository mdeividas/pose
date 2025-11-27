import 'package:flutter/material.dart';
import 'package:pose/services/pose_service.dart';
import 'package:provider/provider.dart';
import 'package:pose/widgets/workspace/workspace.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print('START APPLICATION');

  // Initialize pose service here
  final poseService = PoseService();
  await poseService.initialize();

  print('LOADED SERVICES');

  runApp(MyApp(poseService: poseService));
}

class MyApp extends StatefulWidget {
  final PoseService poseService;

  MyApp({super.key, required this.poseService});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Initialize services here
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider<PoseService>(create: (_) => widget.poseService)],
      child: MaterialApp(
        // TODO add new name
        title: 'Flutter Demo',
        theme: ThemeData(
          // TODO addjust theme
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        ),
        home: const Workspace(),
      ),
    );
  }
}
