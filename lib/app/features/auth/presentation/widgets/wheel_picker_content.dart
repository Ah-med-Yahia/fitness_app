import 'package:fitness_app/app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:wheel_slider/wheel_slider.dart';

class WheelPickerContent extends StatefulWidget {
  final String unit;
  final List<int> values;
  final int initialIndex;
  final ValueChanged<int> onChanged;

  const WheelPickerContent({
    super.key,
    required this.unit,
    required this.values,
    required this.initialIndex,
    required this.onChanged,
  });

  @override
  State<WheelPickerContent> createState() => _WheelPickerContentState();
}

class _WheelPickerContentState extends State<WheelPickerContent> {
  late final FixedExtentScrollController _controller;
  late int _selectedIndex;

  static const double _itemExtent = 78;

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController(initialItem: widget.initialIndex);
    _selectedIndex = widget.initialIndex;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final values = widget.values;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Unit label (Kg / CM / Year)
        Text(
          widget.unit,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'BaloThambi2',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 12),

        // Horizontal wheel slider (classic wheel feel)
        WheelSlider.customWidget(
          controller: _controller,
          horizontal: true,
          isInfinite: false,
          totalCount: values.length - 1,
          initValue: widget.initialIndex,
          onValueChanged: (dynamic raw) {
            final index = (raw as num).toInt().clamp(0, values.length - 1);
            setState(() => _selectedIndex = index);
            widget.onChanged(values[index]);
          },
          // Show only a few values at once
          horizontalListHeight: 80,
          horizontalListWidth: double.infinity,
          listWidth: 420,
          itemSize: _itemExtent,
          // Adds subtle 3D perspective
          perspective: 0.0007,
          squeeze: 1.1,
          isVibrate: true,
          showPointer: false,
          enableAnimation: false,
          children: List.generate(
            values.length,
            (i) {
              final isSelected = i == _selectedIndex;
              return Center(
                child: SizedBox(
                  width: _itemExtent,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      values[i].toString(),
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'BaloThambi2',
                        fontSize: isSelected ? 44 : 28,
                        fontWeight: FontWeight.w800,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.white.withValues(alpha: 0.75),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 6),
        const Center(
          child: Icon(
            Icons.arrow_drop_up,
            color: AppColors.primary,
            size: 18,
          ),
        ),
      ],
    );
  }
}
