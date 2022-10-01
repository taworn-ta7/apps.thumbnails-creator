import 'package:flutter/material.dart';
import '../i18n/strings.g.dart';

/// A customized AppBar.
class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final void Function(String locale) onLocaleChange;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.onLocaleChange,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // ----------------------------------------------------------------------

  /// Built widget tree.
  @override
  Widget build(BuildContext context) {
    return AppBar(
      //leading: Image.asset('assets/app.png'),
      title: Text(widget.title),
      actions: [
        // Thai language
        IconButton(
          icon: Image.asset('assets/locales/th.png'),
          tooltip: t.switchLocale.th,
          onPressed: () => setState(
            () => widget.onLocaleChange('th'),
          ),
        ),

        // English language
        IconButton(
          icon: Image.asset('assets/locales/en.png'),
          tooltip: t.switchLocale.en,
          onPressed: () => setState(
            () => widget.onLocaleChange('en'),
          ),
        ),
      ],
    );
  }
}
