import 'dart:async';
import 'package:logging/logging.dart';
import 'package:flutter/material.dart';
import '../i18n/strings.g.dart';
import '../services/app_share.dart';
import '../services/localization.dart';
import '../ui/custom_app_bar.dart';
import '../ui/custom_bottom_bar.dart';
import '../pages.dart';

/// LocationPage class.
class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationState();
}

/// _LocationState internal class.
class _LocationState extends State<LocationPage> {
  static final log = Logger('LocationPage');
  static final appShare = AppShare.instance();

  // initial timer handler
  late Timer _initTimer;

  @override
  void initState() {
    super.initState();
    _initTimer = Timer(const Duration(), _handleInit);
    log.fine("$this initState()");
  }

  @override
  void dispose() {
    log.fine("$this dispose()");
    _initTimer.cancel();
    super.dispose();
  }

  // ----------------------------------------------------------------------

  /// Built widget tree.
  @override
  Widget build(BuildContext context) {
    final tr = t.locationPage;

    return Scaffold(
      // AppBar
      appBar: CustomAppBar(
        title: tr.title,
        onLocaleChange: (locale) {
          setState(() => Localization.instance().change(context, locale));
        },
      ),

      // body
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // widgets
          const Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Text("Location"),
              ),
            ),
          ),

          // bottom bar
          CustomBottomBar(
            leftIcon: const Icon(Icons.arrow_back_ios),
            leftText: t.common.back,
            onLeftClick: () => Navigator.popAndPushNamed(context, ''),
            rightIcon: const Icon(Icons.arrow_forward_ios),
            rightText: t.common.next,
            onRightClick: () => Navigator.popAndPushNamed(context, Pages.photo),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------------------

  /// A time-consuming initialization.
  Future<void> _handleInit() async {
    //
  }
}
