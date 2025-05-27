import 'package:flutter/material.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';

class SearchMapOrListWidget extends StatelessWidget {
  final ValueChanged<bool> onValueChanged;
  final int count;
  final bool isMap;
  const SearchMapOrListWidget({super.key,required this.onValueChanged,required this.count,
  required this.isMap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PText(title: 'نتائج البحث :  $count', size: PSize.text14,fontColor: AppColors.blackColor,),
          // if(count!=0)
            ToggleButtonsWidget(isMap: isMap,
            onValueChanged: (bool isMap) {
              onValueChanged(isMap);
              // Do something with the value if needed
              print("Map selected: $isMap");
            },
          ),
        ],
      ),
    );
  }
}

class ToggleButtonsWidget extends StatefulWidget {
  final ValueChanged<bool> onValueChanged;
  final bool isMap;
  const ToggleButtonsWidget({super.key, required this.onValueChanged,required this.isMap});

  @override
  ToggleButtonsWidgetState createState() => ToggleButtonsWidgetState();
}

class ToggleButtonsWidgetState extends State<ToggleButtonsWidget> {
  late bool isMap = widget.isMap;

  @override
  void didUpdateWidget(covariant ToggleButtonsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isMap != widget.isMap) {
      setState(() {
        isMap = widget.isMap;
      });
    }
  }

  void _setView(bool mapSelected) {
    setState(() {
      isMap = mapSelected;
    });
    widget.onValueChanged(isMap);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.whiteColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _setView(true),
              child: Container(
                decoration: BoxDecoration(
                  color: isMap ? AppColors.primaryColor : Colors.transparent,
                  borderRadius: const BorderRadius.horizontal(right: Radius.circular(10)),
                ),
                child: Center(
                  child: Icon(
                    Icons.gps_fixed,
                    color: isMap ? AppColors.whiteColor : Colors.grey,
                    size: 23,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => _setView(false),
              child: Container(
                decoration: BoxDecoration(
                  color: !isMap ? AppColors.primaryColor : Colors.transparent,
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(10)),
                ),
                child: Center(
                  child: Icon(
                    Icons.menu,
                    color: !isMap ? AppColors.whiteColor : Colors.grey,
                    size: 23,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

