import 'package:flutter/material.dart';
import '../styles.dart';

/// Bottom bar with left and right buttons.
class CustomBottomBar extends StatefulWidget {
  final Icon leftIcon;
  final String leftText;
  final void Function() onLeftClick;
  final Icon rightIcon;
  final String rightText;
  final void Function() onRightClick;

  const CustomBottomBar({
    Key? key,
    required this.leftIcon,
    required this.leftText,
    required this.onLeftClick,
    required this.rightIcon,
    required this.rightText,
    required this.onRightClick,
  }) : super(key: key);

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // ----------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // left button
        ElevatedButton.icon(
          icon: widget.leftIcon,
          label: Styles.buttonPadding(Text(widget.leftText)),
          onPressed: widget.onLeftClick,
        ),

        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // right button
              ElevatedButton.icon(
                icon: widget.rightIcon,
                label: Styles.buttonPadding(Text(widget.rightText)),
                onPressed: widget.onRightClick,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
