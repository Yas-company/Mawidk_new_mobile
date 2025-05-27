import 'package:flutter/material.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/features/notification/data/model/notification_response_model.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final void Function()? onTap;
  const NotificationItem({super.key, required this.notification,this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isUnread = !(notification.isRead??false);

    Color getTypeColor(String type) {
      switch (type) {
        case 'success':
          return AppColors.primaryColor;
        case 'error':
          return AppColors.danger;
        case 'warning':
          return AppColors.ratingColor;
        default:
          return Colors.grey;
      }
    }
    Color getOpacityColor(String type) {
      switch (type) {
        case 'success':
          return AppColors.primaryColor3300;
        case 'error':
          return AppColors.danger.withOpacity(0.15);
        case 'warning':
          return AppColors.ratingColor.withOpacity(0.35);
        default:
          return Colors.grey;
      }
    }
    IconData getTypeIcon(String type) {
      switch (type) {
        case 'success':
          return Icons.calendar_today;
        case 'error':
          return Icons.close;
        case 'warning':
          return Icons.warning;
        default:
          return Icons.notifications;
      }
    }

    return InkWell(onTap:onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 0),
        decoration: BoxDecoration(
          color: isUnread ? AppColors.primaryColor550: Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Circle icon with color
            Container(
              margin: const EdgeInsets.only(top:3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getOpacityColor(notification.type??''),
              ),
              padding: const EdgeInsets.all(15),
              child: Icon(
                getTypeIcon(notification.type??''),
                color: getTypeColor(notification.type??''),
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            // Text section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PText(title:notification.title??'',size:PSize.text14,
                    fontWeight:FontWeight.w700,
                  ),
                  const SizedBox(height: 4),
                  PText(title: notification.message??'',
                    size: PSize.text14,fontColor:AppColors.grey200,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
