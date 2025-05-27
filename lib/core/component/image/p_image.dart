import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawidak/core/data/assets_helper/app_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PImage extends StatelessWidget {
  final String source;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final dynamic file;
  final bool? isFile;
  final bool? isProvider;
  final Color? color;
  final bool? isCircle;
  final Widget? placeholder;
  final Widget? errorWidget;

  const PImage({
    super.key,
    required this.source,
    this.width,
    this.color,
    this.file,
    this.isCircle = false,
    this.isFile = false,
    this.isProvider = false,
    this.height,
    this.fit = BoxFit.fill,
    this.placeholder,
    this.errorWidget,
  });

  bool _isSvg(String path) {
    return path.toLowerCase().endsWith('.svg');
  }

  bool _isUrl(String path) {
    return Uri.tryParse(path)?.hasAbsolutePath ?? false;
  }

  @override
  Widget build(BuildContext context) {
    if (isBase64Image(source)) {
      return Image.memory(base64Decode(source));
    }
    if (isFile ?? false) {
      return file is Uint8List ? Image.memory(file!) : Image.file(file);
    }
    if (_isSvg(source)) {
      // Render SVG image
      return _isUrl(source)
          ? SvgPicture.network(
        source,
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
        placeholderBuilder: (context) =>
        placeholder ??
            const Center(child: CircularProgressIndicator()),
        // errorBuilder: (context, error, stackTrace) =>
        // errorWidget ?? Icon(Icons.error, color: Colors.red),
      )
          : SvgPicture.asset(
        source,
        width: width,
        height: height,
        colorFilter: color == null
            ? null
            : ColorFilter.mode(
          color!, // Tint color
          BlendMode.srcIn, // Blend mode
        ),
        fit: fit ?? BoxFit.contain,
        // placeholderBuilder: (context) =>
        // placeholder ?? const Center(child: CircularProgressIndicator()),
        // errorBuilder: (context, error, stackTrace) =>
        // errorWidget ?? Icon(Icons.error, color: Colors.red),
      );
    } else {
      // Render PNG/JPG/GIF image
      if (_isUrl(source)) {
        return (isProvider ?? false)
            ? Image(
          image: CachedNetworkImageProvider(source),
          height: height,
          width: width,
          fit: fit,
          errorBuilder: (context, error, stackTrace) =>
          const PImage(source: AppIcons.errorPlaceHolder),
        )
            : ClipOval(
          clipBehavior: isCircle! ? Clip.antiAlias : Clip.none,
          child: CachedNetworkImage(
            imageUrl: source,
            width: width,
            height: height,
            fit: fit,
            placeholder: (context, url) =>
            SizedBox(height:height??45.sp,
              child: placeholder ??
                //   ShimmerPlaceholder(width: width,
                // height: height,borderRadius:const BorderRadius.all(Radius.circular(0)),),
                  Skeletonizer(
                    enabled: true, // Enable the skeleton animation
                    child: Container(
                      width: width,
                      height: height,
                      color: isDark
                             ? AppColors.primaryColor200
                             : const Color(0xffEBEBF3),
                    ),
                  ),
            ),
            errorWidget: (context, url, error) =>
            // errorWidget ?? const PImage(source: AppIcons.errorPlaceHolder),
            errorWidget ?? const Icon(Icons.error_outline),
          ),
        );
      } else {
        return Image.asset(
          source,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) =>
          const PImage(source: AppIcons.errorPlaceHolder),
        );
      }
    }
  }
}








class ShimmerPlaceholder extends StatefulWidget {
  final double? width;
  final double? height;
  final BorderRadius borderRadius;

  const ShimmerPlaceholder({
    super.key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  @override
  ShimmerPlaceholderState createState() => ShimmerPlaceholderState();
}

class ShimmerPlaceholderState extends State<ShimmerPlaceholder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _shimmerAnimation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [_shimmerAnimation.value - 1, _shimmerAnimation.value, _shimmerAnimation.value + 1],
              colors: [
                // isDark ? AppColors.darkFieldBackgroundColor : const Color(0xffEBEBF3),
                // isDark ? AppColors.darkFieldBackgroundColor.withOpacity(0.2) : const Color(0xffEBEBF3),
                // isDark ? AppColors.darkFieldBackgroundColor.withOpacity(0.4) : const Color(0xffEBEBF3),
                AppColors.grayColor700.withOpacity(0.1),
                Color(0xffEBEBF3).withOpacity(0.7),
                Color(0xffEBEBF3).withOpacity(0.2),
              ],
            ).createShader(bounds);
          },
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: widget.borderRadius,
            ),
          ),
        );
      },
    );
  }
}
