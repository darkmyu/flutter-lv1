import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:calendar_scheduler/constant/colors.dart';
import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({super.key});

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  int? startTime;
  int? endTime;
  String? content;
  String? category;

  String selectedColor = categoryColors.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 600,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _Time(
                  onStartSaved: onStartTimeSaved,
                  onStartValidate: onStartTimeValidate,
                  onEndSaved: onEndTimeSaved,
                  onEndValidate: onEndTimeValidate,
                ),
                const SizedBox(height: 8.0),
                _Content(
                  onSaved: onContentSaved,
                  onValidate: onContentValidate,
                ),
                const SizedBox(height: 8.0),
                _Categories(
                  selectedColor: selectedColor,
                  onTap: (color) {
                    setState(() {
                      selectedColor = color;
                    });
                  },
                ),
                const SizedBox(height: 8.0),
                _SaveButton(
                  onPressed: onSavePressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onStartTimeSaved(String? value) {
    if (value == null) {
      return;
    }

    startTime = int.parse(value);
  }

  String? onStartTimeValidate(String? value) {}

  void onEndTimeSaved(String? value) {
    if (value == null) {
      return;
    }

    endTime = int.parse(value);
  }

  String? onEndTimeValidate(String? value) {}

  void onContentSaved(String? value) {
    if (value == null) {
      return;
    }

    content = value;
  }

  String? onContentValidate(String? value) {}

  void onSavePressed() {
    formKey.currentState!.save();

    print(startTime);
    print(endTime);
    print(content);
    print(category);
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;
  final FormFieldValidator<String> onStartValidate;
  final FormFieldValidator<String> onEndValidate;

  _Time({
    super.key,
    required this.onStartSaved,
    required this.onEndSaved,
    required this.onStartValidate,
    required this.onEndValidate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                label: '시작 시간',
                onSaved: onStartSaved,
                validator: onStartValidate,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: CustomTextField(
                label: '마감 시간',
                onSaved: onEndSaved,
                validator: onStartValidate,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> onValidate;

  const _Content({
    super.key,
    required this.onSaved,
    required this.onValidate,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        expand: true,
        onSaved: onSaved,
        validator: onValidate,
      ),
    );
  }
}

typedef OnColorSelected = void Function(String color);

class _Categories extends StatelessWidget {
  final String selectedColor;
  final OnColorSelected onTap;

  const _Categories({
    super.key,
    required this.selectedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: categoryColors
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () => onTap(e),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(
                      int.parse(
                        'FF$e',
                        radix: 16,
                      ),
                    ),
                    border: e == selectedColor
                        ? Border.all(
                            color: Colors.black,
                            width: 4.0,
                          )
                        : null,
                    shape: BoxShape.circle,
                  ),
                  width: 32.0,
                  height: 32.0,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('저장'),
          ),
        ),
      ],
    );
  }
}
