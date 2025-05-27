import 'package:flutter/material.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';

class WhiteBackgroundWithImage extends StatelessWidget {
  final Widget child;
  final String? image;

  const WhiteBackgroundWithImage({
    super.key,
    required this.child,this.image
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color:AppColors.whiteBackground,
        child: Stack(
          children: [
            Positioned(top:20,right:0,
              child:PImage(source:AppSvgIcons.heartWhite,height:300,width:380,
              color:image == null? AppColors.primaryColor300:AppColors.dangerColor,)
            ),
            // Positioned(top:20,left:0,
            //     child:IconButton(onPressed:() {
            //       Navigator.pop(context);
            //     }, icon:Icon(Icons.arrow_forward,color:AppColors.primaryColor,))
            // ),
            Container(
              color: Colors.white.withOpacity(0.7), // Optional overlay
            ),
            child, // Your custom content on top
          ],
        ),
      ),
    );
  }
}
