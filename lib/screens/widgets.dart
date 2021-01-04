import 'package:flutter/material.dart';
import 'core/services.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton({
    this.icon,
    this.text,
    this.color,
    this.theme,
    this.disabled = false,
    this.measures,
    this.onPressed,
    this.textColor,
  });

  final Color color;
  final bool disabled;

  final String text;
  final Color textColor;

  final IconData icon;

  final ThemeData theme;
  final Measures measures;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: measures.toolbarHeight * 1.1,
      padding: EdgeInsets.symmetric(
        vertical: measures.value * 8.0,
        horizontal: measures.value * 16.0,
      ),
      child: RaisedButton.icon(
        color: color,
        textColor: textColor,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(
            measures.value * 8,
          ),
        ),
        label: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: measures.labelSize,
          ),
        ),
        icon: Icon(icon, size: measures.iconSize),
        onPressed: disabled ? null : onPressed,
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final Widget title;
  final Widget leading;
  final Widget subtitle;
  final Widget trailing;
  final VoidCallback onTap;

  final EdgeInsetsGeometry contentPadding;

  ListItem({
    this.title,
    this.onTap,
    this.leading,
    this.subtitle,
    this.trailing,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity(
        vertical: -4.0,
        horizontal: -4.0,
      ),
      contentPadding: contentPadding,
      trailing: trailing,
      subtitle: subtitle,
      leading: leading,
      title: title,
      onTap: onTap,
      dense: true,
    );
  }
}
