
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ptit_quiz_frontend/core/router/app_router.dart';

import '../../blocs/exam_detail_bloc/exam_detail_bloc.dart';
import '../widgets/app_loading_animation.dart';

class ExamDetailScreen extends StatefulWidget {
  final String examId;

  const ExamDetailScreen({super.key, required this.examId});

  @override
  State<ExamDetailScreen> createState() => _ExamDetailScreenState();
}

class _ExamDetailScreenState extends State<ExamDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExamDetailBloc, ExamDetailState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is ExamDetailInitial) {
          context.read<ExamDetailBloc>().add(ExamDetailGetEvent(examId: widget.examId));
        }
        return SafeArea(
            child: Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.all(16.0),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    context.go(AppRoutes.home);
                  },
                  child: Text(
                    'PTIT Quiz',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              const Text('Timer'),
              const SizedBox(width: 32),
              FilledButton(
                onPressed: () {
                  // TODO: implement submit button
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      Icon(Icons.assignment_turned_in_outlined),
                      SizedBox(width: 8),
                      Text('Submit'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
          body: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: 1200,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 10000,
                                  color: Colors.yellow,
                                  child: const Center(
                                    child: Text('Question Detail'),
                                  ),
                                ),
                              ),
                            ),
                            if (MediaQuery.of(context).size.width > 800)
                              const SizedBox(width: 300),
                          ],
                        ),
                      ),
                      if (MediaQuery.of(context).size.width > 800)
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 300,
                            height: 450,
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 8.0,
                                right: 16.0,
                              ),
                              child: Container(
                                color: Colors.blue,
                                child: const Center(
                                  child: Text('Question List'),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  )
                ),
              ),
              if (state is ExamDetailLoading)
                const AppLoadingAnimation(),
            ],
          ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    if (kDebugMode) {
      print('ExamDetailScreen disposed');
    }
    super.dispose();
  }
}
