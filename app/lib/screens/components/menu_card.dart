import 'package:app/core/theme/theme.dart';
import 'package:flutter/material.dart';

class MenuCard extends StatefulWidget {
  final String description;
  final IconData icon;
  final int duration;
  final Function function;
  const MenuCard({
    super.key,
    required this.description,
    required this.icon,
    required this.duration,
    required this.function,
  });

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  late double tweenSize;

  @override
  void initState() {
    super.initState();
    tweenSize = 10;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    tweenSize = 50;
    return TweenAnimationBuilder<double>(
      duration: Duration(seconds: widget.duration + 1),
      curve: Curves.easeInCubic,
      tween: Tween<double>(begin: 0.0, end: tweenSize),
      child: Text(widget.description, style: theme.textTheme.bodyLarge),
      builder: (context, size, child) {
        return Card(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              width: 2,
              color: StudieTheme.secondaryColor,
              style: BorderStyle.solid,
            ),
          ),
          // color: StudieTheme.whiteSmoke,
          clipBehavior: Clip.hardEdge,
          shadowColor: theme.primaryColor,
          elevation: 10,
          child: InkWell(
            splashColor: StudieTheme.secondaryColor,
            onTap: () => widget.function(),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                gradient: LinearGradient(
                  begin: AlignmentGeometry.topLeft,
                  end: AlignmentGeometry.bottomRight,
                  colors: [
                    StudieTheme.whiteSmoke,
                    StudieTheme.terciaryColor,
                    StudieTheme.secondaryColor,
                    StudieTheme.primaryColor,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Icon(widget.icon, size: size), child!],
              ),
            ),
          ),
        );
      },
    );
  }
}
