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

/// StartPage class.
class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartState();
}

/// _StartState internal class.
class _StartState extends State<StartPage> {
  static final log = Logger('StartPage');
  static final appShare = AppShare.instance();

  // data
  final items = <Thumbnail>[];

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
    final tr = t.startPage;

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
                children: items.map((item) {
                  return ListTile(
                    leading: const Icon(Icons.photo_size_select_large),
                    title: Text(item.source),
                    subtitle: Text(item.target),
                    trailing: const Icon(Icons.delete),
                    onTap: () => _editItem(item),
                  );
                }).toList(),
              ),
            ),
          ),

          // bottom bar
          CustomBottomBar(
            leftIcon: const Icon(Icons.image_search),
            leftText: tr.addFiles,
            onLeftClick: _addFiles,
            rightIcon: const Icon(Icons.arrow_forward_ios),
            rightText: t.common.next,
            onRightClick: () =>
                Navigator.popAndPushNamed(context, Pages.location),
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
    //
  }

  /// Removes clicked file.
  Future<void> _editItem(Thumbnail o) async {
    items.remove(o);
  }

  /// Adds more file(s) into list.
  Future<void> _addFiles() async {
    //
  }
}
