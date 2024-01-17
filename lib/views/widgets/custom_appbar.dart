import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Size size;
  final Color color;
  final Color textColor;
  final Color shadowColor;
  final Widget leadingIcon;
  final bool showDrawer;
  final bool showLeading;
  final List<Widget> actions;
  final String title;
  final bool showTrailing;
  final double elevation;
  const MyCustomAppBar({
    Key key,
    this.size,
    this.elevation,
    this.shadowColor,
    this.showDrawer = false,
    this.showTrailing = false,
    @required this.title,
    this.color,
    this.actions,
    this.leadingIcon,
    this.textColor,
    this.showLeading = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultTextColor = textColor ?? Colors.black;

    return AppBar(
      titleTextStyle: TextStyle(
        fontFamily: 'Akaya',
        fontSize: 32,
      ),
      systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
      elevation: elevation ?? 0,
      shadowColor: shadowColor ?? Theme.of(context).scaffoldBackgroundColor,
      automaticallyImplyLeading: false,
      leading: showLeading
          ? IconButton(
              icon: showDrawer
                  ? SvgPicture.asset(
                      'assets/icons/drawer.svg',
                      color: defaultTextColor,
                      fit: BoxFit.scaleDown,
                    )
                  : Icon(
                      Icons.arrow_back_ios_rounded,
                      color: defaultTextColor,
                      size: 35,
                    ),
              onPressed: () => showDrawer
                  ? null /*MainScreen.innerDrawerKey.currentState.open()*/
                  : Navigator.pop(context),
            )
          : leadingIcon,
      actions: actions ??
          (showTrailing
              ? [
                  IconButton(
                    icon: Icon(Icons.search, color: defaultTextColor, size: 35),
                    onPressed: () {},
                  ),
                ]
              : []),
      backgroundColor: color ?? Colors.deepPurple,
      // context.read<ThemeCubit>().defaultColor,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontFamily: 'Akaya',
          shadows: (elevation != 0)
              ? [Shadow(blurRadius: 2, color: defaultTextColor)]
              : [],
          color: defaultTextColor ?? Colors.white,
        ),
      ),

      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => size ?? Size(double.infinity, 60);
}
