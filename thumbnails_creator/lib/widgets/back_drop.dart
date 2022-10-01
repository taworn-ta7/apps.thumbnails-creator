import 'package:flutter/material.dart';

/// Backgroup image.
class BackDrop extends StatefulWidget {
  final String asset;
  final Widget child;

  const BackDrop({
    Key? key,
    required this.asset,
    required this.child,
  }) : super(key: key);

  @override
  State<BackDrop> createState() => _BackDropState();
}

class _BackDropState extends State<BackDrop> {
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
    return Stack(
      children: [
        // grid
        Column(
          children: [
            const Expanded(
              child: SizedBox.shrink(),
            ),
            Expanded(
              child: Row(
                children: [
                  const Expanded(
                    child: SizedBox.shrink(),
                  ),

                  // expanded image
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Image.asset(
                        widget.asset,
                        color: const Color.fromARGB(0x40, 0xff, 0xff, 0xff),
                        colorBlendMode: BlendMode.modulate,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // continue your widget tree
        widget.child,
      ],
    );
  }
}
