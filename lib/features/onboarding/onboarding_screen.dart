import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:math' as math;


class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnBoardingModel> items = [
    OnBoardingModel(
      image: AppSvgIcons.mail,
      title: 'onboarding_title1'.tr(),
      description: 'onboarding_desc1'.tr(),
    ),
    OnBoardingModel(
      image: AppSvgIcons.successIcon,
      title: 'onboarding_title2'.tr(),
      description: 'onboarding_desc2'.tr(),
    ),
    OnBoardingModel(
      image: AppSvgIcons.call,
      title: 'onboarding_title3'.tr(),
      description: 'onboarding_desc3'.tr(),
    ),
  ];

  late AnimationController _imageController;
  late AnimationController _textController;

  late Animation<double> _imageAnimation;
  late Animation<Offset> _textSlideAnimation;

  @override
  void initState() {
    super.initState();

    _imageController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _imageAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _imageController, curve: Curves.easeIn));

    _textSlideAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));

    // Trigger the animation on the first page load
    _animatePageChange();
  }

  @override
  void dispose() {
    _imageController.dispose();
    _textController.dispose();
    super.dispose();
  }

  // void _nextPage() {
  //   if (_currentPage < items.length - 1) {
  //     setState(() {
  //       _currentPage++;
  //     });
  //     _pageController.nextPage(
  //       duration: const Duration(milliseconds: 500),
  //       curve: Curves.ease,
  //     );
  //     _animatePageChange();
  //   }
  // }
  void _nextPage() {
    if (_currentPage < items.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
      _animatePageChange();
    }
  }


  void _animatePageChange() {
    _imageController.reset();
    _textController.reset();
    _imageController.forward();
    _textController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.whiteBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: items.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                  _animatePageChange();
                },
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Padding(
                    key: ValueKey(index), // Add this
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: () {
                              // Skip logic
                            },
                            child: SharedText(
                              'skip'.tr(),
                              style: TextStyle(color: AppColors.primaryColor),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        FadeTransition(
                          opacity: _imageAnimation,
                          child: SharedImage(
                            assetPath: item.image,
                            isSvg: true,
                            height: 200,
                          ),
                        ),
                        SizedBox(height:12),
                        SlideTransition(
                          position: _textSlideAnimation,
                          child: SharedText(
                            item.title,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        SizedBox(height: 12),
                        SlideTransition(
                          position: _textSlideAnimation,
                          child: SharedText(
                            item.description,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: items.length,
                // effect: JumpingDotEffect(
                //   activeDotColor: AppColors.primaryColor,
                //   dotColor: Colors.grey,
                //   dotHeight: 10.0,
                //   dotWidth: 16.0,
                //   spacing: 16.0,
                //   jumpScale: 2,
                //   radius: 10.0,
                // ),
                effect: JumpingDotEffect(
                  activeDotColor: AppColors.primaryColor,
                  dotColor: Colors.grey,
                  dotHeight: 10.0,
                  dotWidth: 16.0,
                  strokeWidth: 12.0,
                  offset: 12.0,
                  verticalOffset: 16.0,
                  spacing: 16.0,
                  jumpScale: 2,
                  radius: 10.0,
                  paintStyle: PaintingStyle.fill,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AnimatedOpacity(
                  opacity:
                  _currentPage > 0
                      ? 1.0
                      : 0.0, // Show if not on the first page
                  duration: const Duration(
                    milliseconds: 200,
                  ), // Animation duration
                  child: GestureDetector(
                    onTap: _previousPage,
                    child: buildArrowButton(Icons.arrow_back, _currentPage,items.length),
                  ),
                ),
                // Next button (always visible)
                GestureDetector(
                  onTap: _nextPage,
                  child: buildArrowButton(Icons.arrow_forward,_currentPage,items.length),
                ),
              ],
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class OnBoardingModel {
  final String image;
  final String title;
  final String description;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.description,
  });
}


class SharedText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const SharedText(this.text, {super.key, this.style, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: textAlign,
    );
  }
}


class SharedImage extends StatelessWidget {
  final String assetPath;
  final bool isSvg;
  final double? height;

  const SharedImage({
    super.key,
    required this.assetPath,
    this.isSvg = false,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return isSvg
        ? SvgPicture.asset(
      assetPath,
      height: height,
    )
        : Image.asset(
      assetPath,
      height: height,
    );
  }
}




Widget buildArrowButton(IconData icon, int currentPage, int totalPages) {
  // Progress from 0.25 to 1.0
  double progress = ((currentPage + 1) / totalPages).clamp(0.0, 1.0);
  double angle = progress * 2 * math.pi; // portion of the full circle

  return SizedBox(
    width: 65,
    height: 65,
    child: Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: const Size(70, 70),
          painter: ArcPainter(angle), // in radians
        ),
        Container(
          width: 60,
          height: 70,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: Center(child: Icon(icon, color: Colors.white)),
        ),
      ],
    ),
  );
}




class ArcPainter extends CustomPainter {
  final double angle; // in radians (0 to 2π)

  ArcPainter(this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryColor
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final startAngle = -math.pi / 2; // start at top

    canvas.drawArc(rect, startAngle, angle, false, paint);
  }

  @override
  bool shouldRepaint(covariant ArcPainter oldDelegate) =>
      oldDelegate.angle != angle;
}


