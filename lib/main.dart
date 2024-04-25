import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// ignore: unused_import
import 'package:ptit_quiz_frontend/core/constants/bloc_observer/bloc_observer.dart';
import 'package:ptit_quiz_frontend/core/theme/color_schemes.g.dart';

import 'di.dart';
import 'presentation/blocs/exam_bloc/exam_bloc.dart';
import 'core/router/app_router.dart';
import 'presentation/blocs/app_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();
  await dotenv.load(fileName: '.env');

  // debug
  // Bloc.observer = AppBlocObserver();

  FlutterNativeSplash.remove();
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => DependencyInjection.sl<AuthBloc>()),
        BlocProvider<ExamBloc>(create: (context) => DependencyInjection.sl<ExamBloc>()),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PTIT Quiz',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.appRouter,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
    );
  }
}