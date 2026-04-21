import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/app_text_styles.dart';
import 'core/constants/strings.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  if (kDebugMode) {
    try {
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      debugPrint('Connected to Firebase emulators (Auth:9099, Firestore:8080)');
    } catch (e) {
      debugPrint('Emulator connection skipped: $e');
    }
  }

  runApp(const ProviderScope(child: WorkoutDiaryApp()));
}

class WorkoutDiaryApp extends StatelessWidget {
  const WorkoutDiaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text(
            'Workout Diary — Foundation ready',
            style: AppTextStyles.headlineMedium,
          ),
        ),
      ),
    );
  }
}
