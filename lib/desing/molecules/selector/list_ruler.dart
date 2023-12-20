import 'package:flutter/material.dart';
import 'package:progressprodis/desing/atoms/buttons/buttons.dart';
import 'package:progressprodis/desing/tokens/_tokens.dart';

class SelectorRuler extends StatefulWidget {
  const SelectorRuler({
    super.key,
    required this.types,
    required this.options,
    this.divisions = 200,
    this.maxValue = 200,
    this.initialValue = 0,
  });

  final Function(SelectedOptions option) options;
  final List<String> types;

  final int divisions;
  final int initialValue;
  final double maxValue;

  @override
  State<SelectorRuler> createState() => _SelectorWeightState(
        initialValue,
      );
}

class _SelectorWeightState extends State<SelectorRuler> {
  _SelectorWeightState(this.init);

  var type = 0;
  int init;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue == 0) {
      init = widget.maxValue ~/ 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        widget.types[type] == "ft"
                            ? (init * 0.05).toStringAsFixed(2)
                            : "$init",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Row(
                        children: [
                          SmallButton(
                            title: widget.types[0],
                            active: type == 0,
                            onTap: () {
                              setState(() {
                                type = 0;
                              });
                              widget.options(SelectedOptions(
                                value: init.toInt(),
                                type: widget.types[type],
                              ));
                            },
                          ),
                          const SizedBox(width: 5),
                          SmallButton(
                            title: widget.types[1],
                            active: type == 1,
                            onTap: () {
                              setState(() {
                                type = 1;
                              });
                              widget.options(SelectedOptions(
                                value: init.toInt(),
                                type: widget.types[type],
                              ));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ListHorizontalSelected(
              divisions: widget.divisions,
              maxValue: widget.maxValue,
              minValue: 0,
              height: 90,
              showCursor: true,
              onChanged: (p0) {
                setState(() {
                  init = p0;
                });
                widget.options(
                  SelectedOptions(
                    value: init.toInt(),
                    type: widget.types[type],
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.24,
                  child: Text(
                    widget.types[type] == "ft"
                        ? ((init - 5) * 0.05).toStringAsFixed(1)
                        : "${init - 10}",
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.26,
                  height: 30,
                  child: const Icon(
                    Icons.arrow_drop_up_rounded,
                    size: 48,
                    opticalSize: 0.1,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.24,
                  child: Text(
                    widget.types[type] == "ft"
                        ? ((init + 5) * 0.05).toStringAsFixed(1)
                        : "${init + 10}",
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}

class SelectedOptions {
  SelectedOptions({
    required this.value,
    required this.type,
  });

  final int value;
  final String type;
}

enum InitialPosition { start, center, end }

class ValueItem {
  final String value;
  final int index;
  final double fontSize;
  final Color color;

  ValueItem(this.value, this.index, this.fontSize, this.color);
}

class ListHorizontalSelected extends StatefulWidget {
  const ListHorizontalSelected({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.divisions,
    required this.height,
    required this.onChanged,
    this.initialPosition = 0,
    this.backgroundColor = AppColors.transparent,
    this.showCursor = true,
    this.cursorColor = AppColors.primaryColor,
    this.activeItemTextColor = Colors.blue,
    this.passiveItemsTextColor = Colors.grey,
    this.suffix = "",
  });

  final double minValue, maxValue;
  final int divisions;
  final double height;
  final Function(int) onChanged;
  final int initialPosition;
  final Color backgroundColor;
  final bool showCursor;
  final Color cursorColor;
  final Color activeItemTextColor;
  final Color passiveItemsTextColor;
  final String suffix;

  @override
  State<ListHorizontalSelected> createState() => _ListHorizontalSelectedState();
}

class _ListHorizontalSelectedState extends State<ListHorizontalSelected> {
  late FixedExtentScrollController _scrollController;
  late int curItem;
  List<ValueItem> valueMap = [];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i <= widget.maxValue; i++) {
      valueMap.add(
        ValueItem("|", i, 14.0, widget.passiveItemsTextColor),
      );
    }
    if (widget.initialPosition == 0) {
      _scrollController = FixedExtentScrollController(
        initialItem: (valueMap.length ~/ 2),
      );
    } else {
      _scrollController = FixedExtentScrollController(
        initialItem: widget.initialPosition,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: widget.height,
      alignment: Alignment.center,
      color: widget.backgroundColor,
      child: Stack(
        children: <Widget>[
          RotatedBox(
            quarterTurns: 3,
            child: ListWheelScrollView(
              controller: _scrollController,
              diameterRatio: 3,
              itemExtent: 10,
              onSelectedItemChanged: (item) {
                curItem = item;
                widget.onChanged(item);
              },
              children: valueMap.map((curValue) {
                return RotatedBox(
                  quarterTurns: 1,
                  child: Stack(
                    children: [
                      curValue.index % 5 == 0
                          ? Container(
                              height: 30,
                              width: 2,
                              color: AppColors.primaryColor,
                            )
                          : Container(
                              height: 20,
                              width: 1,
                              color: AppColors.primaryColor,
                            ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          Visibility(
            visible: widget.showCursor,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: widget.cursorColor,
                ),
                width: 3,
              ),
            ),
          )
        ],
      ),
    );
  }
}
