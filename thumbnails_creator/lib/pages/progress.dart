import 'dart:async';
import 'package:logging/logging.dart';
import 'package:flutter/material.dart';
import 'package:thumbnails_creator/models/Thumbnail.dart';
import 'package:thumbnails_creator/ui/custom_app_bar.dart';
import '../i18n/strings.g.dart';
import '../services/localization.dart';
import '../services/app_share.dart';
import '../ui/custom_app_bar.dart';
import '../ui/custom_bottom_bar.dart';
import '../pages.dart';

/// ProgressPage class.
class ProgressPage extends StatefulWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  State<ProgressPage> createState() => _ProgressState();
}

/// _ProgressState internal class.
class _ProgressState extends State<ProgressPage> {
  static final log = Logger('ProgressPage');
  static final appShare = AppShare.instance();

  // data
  final _items = <Thumbnail>[];

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
    final tr = t.progressPage;

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
          // list view
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                children: _items.map((item) {
                  return ListTile(
                    leading: const Icon(Icons.photo_size_select_large),
                    title: Text(item.source),
                    subtitle: const Text(''),
                    trailing: const Icon(Icons.check),
                  );
                }).toList(),
              ),
            ),
          ),

          // bottom bar
          CustomBottomBar(
            leftIcon: const Icon(Icons.arrow_back_ios),
            leftText: t.common.back,
            onLeftClick: () => Navigator.popAndPushNamed(context, Pages.photo),
            rightIcon: const Icon(Icons.arrow_forward_ios),
            rightText: t.common.next,
            onRightClick: () => Navigator.popAndPushNamed(context, ''),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------------------

  /// A time-consuming initialization.
  Future<void> _handleInit() async {
    await _refresh();
  }

  /// Refreshing page.
  Future<void> _refresh() async {
    log.finer("HERE");
  }
}
