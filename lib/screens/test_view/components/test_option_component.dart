import 'package:app/global/colors/global_colors.dart';
import 'package:flutter/material.dart';

class TestOption extends StatefulWidget {
  final bool isActive;
  final String optionText;
  final String optionDescription;

  const TestOption({
    Key? key,
    required this.isActive,
    required this.optionText,
    required this.optionDescription,
  }) : super(key: key);

  @override
  State<TestOption> createState() => _TestOptionState();
}

class _TestOptionState extends State<TestOption> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // child | option
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
            color: widget.isActive ? globalColorAppPrimary : Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                offset: const Offset(1, 1),
                blurRadius: 6,
                // spreadRadius: 1
              )
            ],
          ),
          child: Text(
            widget.optionText,
            // textAlign: TextAlign.center,
            style: TextStyle(
              color: widget.isActive ? Colors.white : Colors.black,
              fontSize: 15,
            ),
          ),
        ),

        // child | option description
        if (widget.isActive) ...[
          const SizedBox(height: 5),
          Text(
            widget.optionDescription,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black54,
            ),
          ),
        ],
      ],
    );
  }
}

