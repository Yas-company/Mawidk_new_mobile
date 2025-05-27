import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/features/survey/data/model/survey_response_model.dart';

class SpecializationCarousel extends StatefulWidget {
  final List<Option> specializations;

  const SpecializationCarousel({super.key, required this.specializations});

  @override
  State<SpecializationCarousel> createState() => _SpecializationCarouselState();
}

class _SpecializationCarouselState extends State<SpecializationCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    int totalPages = (widget.specializations.length / 4).ceil();

    return Column(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height*0.16,
          child: Card(color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            child: PageView.builder(
              controller: _pageController,
              itemCount: totalPages,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, pageIndex) {
                final startIndex = pageIndex * 4;
                final endIndex = (startIndex + 4).clamp(0, widget.specializations.length);
                final items = widget.specializations.sublist(startIndex, endIndex);
                return Padding(
                  padding: const EdgeInsets.only(top:14,left:8,right:8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: items.map((option) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap:() {
                        context.push(AppRouter.doctorsOfSpeciality,extra:{
                          'id':option.id??0,
                          'specializationName':option.optionText??''
                        });
                      },child: Column(
                          children: [
                            CircleAvatar(radius:25,
                              backgroundColor:AppColors.primaryColor200,
                              child: PImage(source:option.image??'',width:17, height: 17,
                                color:AppColors.primaryColor,)
                            ),
                            const SizedBox(height: 8),
                            SizedBox(width:80,child: PText(title:option.optionText??'',
                            size:PSize.text13,alignText:TextAlign.center,)),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(totalPages, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index ? AppColors.primaryColor : AppColors.grey200,
              ),
            );
          }),
        ),
      ],
    );
  }
}
