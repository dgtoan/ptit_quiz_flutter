
import 'dart:js';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ptit_quiz_frontend/core/router/app_router.dart';
import 'package:toastification/toastification.dart';

import '../../../domain/entities/question.dart';
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
        if (state is ExamDetailError) {
          print(state.message);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            toastification.show(
              context: context,
              type: ToastificationType.error,
              style: ToastificationStyle.flatColored,
              title: Text(state.message),
              description: Text(state.message),
              alignment: Alignment.topRight,
              autoCloseDuration: const Duration(seconds: 3),
              showProgressBar: false,
            );
          });
        }
      },
      builder: (context, state) {
        if (state is ExamDetailInitial) {
          context.read<ExamDetailBloc>().add(ExamDetailGetEvent(examId: widget.examId));
        }
        if (state is ExamDetailLoaded) {
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Time: ${state.exam.duration} minutes',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
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
              body: Center(
                child: SizedBox(
                  width: 1200,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth: 1000,
                                    minHeight: MediaQuery.of(context).size.height,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(40),
                                    child: Column(
                                      children: [
                                        Text(
                                          state.exam.name,
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        for (int i = 0; i < state.exam.questions!.length; i++)
                                          QuestionCard(
                                            question: state.exam.questions?[i],
                                            index: i,
                                          ),
                                      ]
                                    ),
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
                          top: 40,
                          right: 0,
                          child: Container(
                            width: 300,
                            height: 360,
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 8.0,
                                right: 16.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
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
            ),
          );         
        }
        return const Center(
          child: AppLoadingAnimation(),
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

class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key, required this.question, required this.index});

  final Question? question;
  final int index;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    if (question == null) {
      return const SizedBox();
    } else {
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: min(
                            780,
                            width > 800 ? width * 0.6 - 100: width * 0.7,
                          ),
                        ),
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Câu ${index + 1}: ${question!.content}',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      BuildAnswers(question: question!, index: index),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      );
    }
  }
}

class BuildAnswers extends StatefulWidget {
  final Question question;
  final int index;

  const BuildAnswers({super.key, required this.question, required this.index});

  @override
  State<BuildAnswers> createState() => _BuildAnswersState();
}

class _BuildAnswersState extends State<BuildAnswers> {
  int? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    final int length = widget.question.answers.length;
    final List<Widget> widgets = [];
    for (int i = 0; i < length; i++) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              Radio(
                value: i,
                groupValue: selectedAnswer,
                onChanged: (value) {
                  setState(() {
                    selectedAnswer = value;
                    print('Question ${widget.index + 1} - Answer: $value');
                  });
                },
              ),
              Text(widget.question.answers[i]),
            ],
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}