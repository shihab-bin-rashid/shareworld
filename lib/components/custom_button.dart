import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:verbose_share_world/generated/l10n.dart';

class CustomButton extends StatelessWidget {
  final String? label;
  final Widget? icon;
  final double? iconGap;
  final Function? onTap;
  final Color? color;
  final Color? textColor;
  final double? padding;
  final double? radius;
  final Widget? trailing;
  final double? textSize;
  final Color? borderColor;

  CustomButton({
    this.label,
    this.icon,
    this.iconGap,
    this.onTap,
    this.color,
    this.textColor,
    this.padding,
    this.radius,
    this.trailing,
    this.textSize,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return FadedScaleAnimation(
      GestureDetector(
        onTap: onTap as void Function()?,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 8),
            border: Border.all(
                color: borderColor ?? Colors.transparent, width: 1.5),
            color: color ?? theme.primaryColor,
          ),
          padding: EdgeInsets.all(padding ?? (icon != null ? 16.0 : 18.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon ?? SizedBox.shrink(),
              icon != null ? SizedBox(width: iconGap ?? 20) : SizedBox.shrink(),
              Text(
                label ?? S.of(context).next,
                textAlign: TextAlign.center,
                style: theme.textTheme.button!.copyWith(
                    color: textColor ?? theme.scaffoldBackgroundColor,
                    fontSize: textSize ?? 16),
              ),
              trailing != null ? Spacer() : SizedBox.shrink(),
              trailing ?? SizedBox.shrink(),
            ],
          ),
        ),
      ),
      durationInMilliseconds: 600,
    );
  }
}