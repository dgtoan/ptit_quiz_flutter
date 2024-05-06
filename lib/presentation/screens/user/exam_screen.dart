import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ptit_quiz_frontend/domain/entities/exam.dart';
import 'package:ptit_quiz_frontend/presentation/blocs/app_bloc.dart';
import 'package:ptit_quiz_frontend/presentation/screens/widgets/app_dialog.dart';
import 'package:ptit_quiz_frontend/presentation/screens/widgets/widgets.dart';
import 'package:toastification/toastification.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key, this.isAdmin = false});

  final bool isAdmin;

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  late List<Exam> exams;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExamBloc, ExamState> (
      listener: (context, state) {
        if (state is ExamStateError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            toastification.show(
              context: context,
              type: ToastificationType.error,
              style: ToastificationStyle.flatColored,
              title: const Text('Error'),
              description: Text(state.message),
              alignment: Alignment.topRight,
              autoCloseDuration: const Duration(seconds: 3),
              showProgressBar: false,
            );
          });
        }
        if (state is ExamStateListLoaded) {
          exams = state.exams;
        }
      },
      builder: (context, state) {
        if (state is ExamStateLoading) {
          return const Center(
            child: AppLoadingAnimation(),
          );
        } else if (state is ExamStateListLoaded) {
          final ongoingExams = exams.where((exam) => exam.start != null && exam.start! < DateTime.now().millisecondsSinceEpoch).toList();
          final upcomingExams = exams.where((exam) => exam.start == null || exam.start! > DateTime.now().millisecondsSinceEpoch).toList();
          return SingleChildScrollView(
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
                            Container(
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (widget.isAdmin)
                                    ...[
                                      IconButton(
                                        icon: const Icon(
                                          Icons.add,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          context.read<ExamCubit>().setExam(const Exam.empty());
                                          AppDialog.showManageExamDialog(context, () { });
                                        },
                                      ),
                                      const SizedBox(width: 16),
                                    ],
                                  IconButton(
                                    icon: const Icon(
                                      Icons.cached,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      context.read<ExamBloc>().add(const FetchExamsEvent());
                                    },
                                  ),
                                  const SizedBox(width: 16),
                                  Container(
                                    width: min(MediaQuery.of(context).size.width * 0.4, 240),
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 1,
                                          blurRadius: 12,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: TextField(
                                      onChanged: (value) => searchExams(value),
                                      decoration: const InputDecoration(
                                        icon: Padding(
                                          padding: EdgeInsets.only(left: 16),
                                          child: Icon(
                                            Icons.search,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        hintText: 'Search exams',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Ongoing Exams',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (ongoingExams.isNotEmpty)
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: ongoingExams.length,
                                itemBuilder: (context, index) {
                                  final exam = ongoingExams[index];
                                  return ExamCard(
                                    exam: exam,
                                    onPressed: widget.isAdmin 
                                      ? () {
                                        context.read<ExamCubit>().setExam(exam);
                                        AppDialog.showManageExamDialog(context, () { }, isEdit: true);
                                      }
                                      : () {
                                        context.go('/exam/${exam.id}');
                                      },
                                    isAdmin: widget.isAdmin
                                  );
                                },
                              )
                            else
                              const Center(
                                child: Text(
                                  'No ongoing exams',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            const SizedBox(height: 20),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Upcoming Exams',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (upcomingExams.isNotEmpty)
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: upcomingExams.length,
                                itemBuilder: (context, index) {
                                  final exam = upcomingExams[index];
                                  return ExamCard(
                                    exam: exam,
                                    onPressed: widget.isAdmin 
                                      ? () {
                                        context.read<ExamCubit>().setExam(exam);
                                        AppDialog.showManageExamDialog(context, () { }, isEdit: true);
                                      }
                                      : null,
                                    isAdmin: widget.isAdmin
                                  );
                                },
                              )
                            else
                              const Center(
                                child: Text(
                                  'No upcoming exams',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                          ],
                        ),
                      )
                    ),
                  )
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text(
              'No exams found',
              style: TextStyle(fontSize: 24),
            ),
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<ExamBloc>().add(const FetchExamsEvent());
    exams = [];
  }

  void searchExams(String query) {
    List<Exam> stateExams = (context.read<ExamBloc>().state as ExamStateListLoaded).exams;
    setState(() {
      exams = stateExams.where((exam) => exam.name.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

}

class ExamCard extends StatelessWidget {
  const ExamCard({
    super.key,
    required this.exam,
    required this.onPressed,
    this.isAdmin = false,
  });

  final Exam exam;
  final Function()? onPressed;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    bool isMedium = MediaQuery.of(context).size.width > 800;
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
          
          child: Flex(
            direction: isMedium ? Axis.horizontal : Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.network(
                  'https://scontent.fhan4-6.fna.fbcdn.net/v/t1.15752-9/440284058_473132688478898_7858552623376490913_n.png?_nc_cat=109&ccb=1-7&_nc_sid=5f2048&_nc_ohc=Mie7cibBa7QQ7kNvgFxqK4_&_nc_ht=scontent.fhan4-6.fna&oh=03_Q7cD1QFDwvpifFMpBlLYi0a685cFrvS09nhNvqA3e1zUMfkuPw&oe=66596B41',
                  width: 120,
                  height: 120,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exam.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Duration: ${exam.duration} minutes',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (exam.start != null)
                    Text(
                      'Start: ${DateTime.fromMillisecondsSinceEpoch(exam.start!).toString().substring(0, 16)}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                ],
              ),
              isMedium ? const Spacer() : const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(32),
                child: FilledButton(
                  onPressed: onPressed,
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: isAdmin ? const EdgeInsets.all(12) : const EdgeInsets.symmetric(vertical: 12),
                    child: Center(
                      child: Text(
                        isAdmin ? 'Edit' : 'On Going',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}