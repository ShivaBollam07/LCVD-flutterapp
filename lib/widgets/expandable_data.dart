import 'package:flutter/material.dart';
import 'package:lcvd/models/question.dart';

// stores ExpansionPanel state information

class QuestionGroup extends StatefulWidget {
  final List<Question> questions;
  const QuestionGroup({super.key, required this.questions});

  @override
  State<QuestionGroup> createState() => _QuestionGroupState();
}

class _QuestionGroupState extends State<QuestionGroup> {
  @override
  Widget build(BuildContext context) {
    return _buildPanel();
  }

  Widget _buildPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(15, 10, 0, 5),
          child: Text(
            "FAQs",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        ExpansionPanelList(
          expandedHeaderPadding: const EdgeInsets.all(0),
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              widget.questions[index].isExpanded = isExpanded;
            });
          },
          children: widget.questions.map<ExpansionPanel>((Question item) {
            return ExpansionPanel(
              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              canTapOnHeader: true,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  tileColor: Theme.of(context).colorScheme.surfaceContainer,
                  title: Text(item.headerValue),
                );
              },
              body: ListTile(
                title: Text(item.expandedValue),
              ),
              isExpanded: item.isExpanded,
            );
          }).toList(),
        ),
      ],
    );
  }
}
