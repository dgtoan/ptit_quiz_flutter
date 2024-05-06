import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/datetime_picker.dart';
import '../../blocs/cubits/exam_cubit.dart';

class ManageExamDialog extends StatefulWidget {
  const ManageExamDialog({super.key, required this.isEdit});

  final bool isEdit;

  @override
  State<ManageExamDialog> createState() => _ManageExamDialogState();
}

class _ManageExamDialogState extends State<ManageExamDialog> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.isEdit ? 'Edit Exam' : 'Create Exam'),
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Exam Details'),
              Tab(text: 'Questions'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ExamDetailsTab(),
            QuestionsTab(),
          ],
        ),
      ),
    );
  }
}

class ExamDetailsTab extends StatefulWidget {
  const ExamDetailsTab({super.key});

  @override
  State<ExamDetailsTab> createState() => _ExamDetailsTabState();
}

class _ExamDetailsTabState extends State<ExamDetailsTab> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 200,
        minWidth: 500,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            // pick exam name
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Exam Name'),
            ),
            const SizedBox(height: 10),
            // pick exam duration
            TextFormField(
              controller: _durationController,
              decoration: const InputDecoration(labelText: 'Duration (minutes)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            // pick datetime start exam
            TextFormField(
              controller: _startDateController,
              decoration: const InputDecoration(labelText: 'Start Date'),
              onTap: () async {
                final DateTime? selectedDate = await showDateTimePicker(
                  context: context,
                  initialDate: DateTime.now(),
                );
      
                if (selectedDate != null) {
                  _startDateController.text = selectedDate.toString();
                }
              },
            ),
      
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    int datetimeOfExam = context.read<ExamCubit>().state.start!;
    _nameController.text = context.read<ExamCubit>().state.name;
    _durationController.text = context.read<ExamCubit>().state.duration.toString();
    _startDateController.text = datetimeOfExam == 0 ? '' : DateTime.fromMillisecondsSinceEpoch(datetimeOfExam).toString();
    _nameController.addListener(() {
      context.read<ExamCubit>().setName(_nameController.text);
    });
    _durationController.addListener(() {
      context.read<ExamCubit>().setDuration(int.parse(_durationController.text));
    });
    _startDateController.addListener(() {
      context.read<ExamCubit>().setStart(DateTime.parse(_startDateController.text).millisecondsSinceEpoch);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _durationController.dispose();
    _startDateController.dispose();
    super.dispose();
  }
}

class QuestionsTab extends StatelessWidget {
  const QuestionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Questions'),
      ],
    );
  }
}
