import 'dart:async';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:byte_converter/byte_converter.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:file_picker/file_picker.dart';
import '../i18n/strings.g.dart';
import '../widgets/message_box.dart';
import '../models/thumbnail.dart';
import '../services/localization.dart';
import '../services/app_share.dart';
import '../ui/custom_app_bar.dart';
import '../ui/custom_button_bar.dart';
import 'location.dart';

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
    final tr = t.startPage;
    final f = NumberFormat("###,###,###,###,##0.0", "en_US");

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
          // top bar
          CustomButtonBar(
            leftIcon: const Icon(Icons.image_search),
            leftText: tr.addFiles,
            onLeftClick: _addFiles,
            rightIcon: const Icon(Icons.clear),
            rightText: tr.clear,
            onRightClick: _clear,
          ),

          // list view
          Expanded(
            child: ListView(
              children: _items.map((item) {
                final converter = ByteConverter(item.sourceSize.toDouble());
                return ListTile(
                  leading: const Icon(Icons.photo_size_select_large),
                  title: Text(item.source),
                  subtitle: Text("${f.format(converter.kiloBytes)} KB"),
                  trailing: const Icon(Icons.delete),
                  onTap: () => _editItem(item),
                );
              }).toList(),
            ),
          ),

          // bottom bar
          CustomButtonBar(
            leftIcon: const Icon(Icons.auto_fix_high),
            leftText: tr.about,
            onLeftClick: _about,
            rightIcon: const Icon(Icons.arrow_forward_ios),
            rightText: t.common.next,
            onRightClick: _items.isEmpty ? null : _nextPage,
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------------------

  /// A time-consuming initialization.
  Future<void> _handleInit() async {
    setState(() {
      var images = appShare.images;
      _items.clear();
      for (var i = 0; i < images.length; i++) {
        _items.add(images[i]);
      }
    });
  }

  /// Removes clicked file.
  Future<void> _editItem(Thumbnail o) async {
    var index = _items.indexWhere((element) => element.source == o.source);
    if (index >= 0) {
      setState(() {
        _items.removeAt(index);
        log.info("remove file: ${o.source}");
        log.info("total ${_items.length} file(s)");
      });
    }
  }

  /// Adds more file(s) into list.
  Future<void> _addFiles() async {
    final items = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: [
        'jpeg',
        'jpg',
        'png',
        'gif',
        'webp',
        'bmp',
        'wbmp',
      ],
      withData: false,
    );

    if (items != null) {
      setState(() {
        log.info("selected ${items.count} file(s)");
        var count = 0;
        for (var i = 0; i < items.count; i++) {
          var item = items.files[i];
          var index =
              _items.indexWhere((element) => element.source == item.path);
          if (index < 0) {
            _items.add(Thumbnail(item.path!, item.name, item.size));
            log.info("add file: ${item.path}");
            count++;
          }
        }
        log.info("added $count file(s)");
        log.info("total ${_items.length} file(s)");
      });
    }
  }

  /// Clears all files in list.
  Future<void> _clear() async {
    setState(() {
      _items.clear();
      log.info("clear all file(s)");
      log.info("total ${_items.length} file(s)");
    });
  }

  /// Display about dialog box.
  Future<void> _about() async {
    MessageBox.info(context, "${t.app}, ${t.versionText}");
  }

  /// Next page.
  Future<void> _nextPage() async {
    if (_items.isEmpty) return;
    _copyData();

    Navigator.pop(context);
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeftWithFade,
        child: const LocationPage(),
      ),
    );
  }

  /// Copy data to AppShare instance.
  void _copyData() {
    var images = appShare.images;
    images.clear();
    for (var i = 0; i < _items.length; i++) {
      images.add(_items[i]);
    }
  }
}
