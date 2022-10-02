import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:logging/logging.dart';
import 'package:image/image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../i18n/strings.g.dart';
import '../models/thumbnail.dart';
import '../services/localization.dart';
import '../services/app_share.dart';
import '../ui/custom_app_bar.dart';
import '../ui/custom_button_bar.dart';
import 'photo.dart';
import 'start.dart';

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

  static final re = RegExp(r'%([%FN])');

  // data
  final _items = <Thumbnail>[];

  // start to process, null mean not started
  int? _start;
  bool _finish = false;

  // start timer
  late Timer? _startTimer;

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
    _startTimer?.cancel();
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
            child: ListView(
              children: _items.map((item) {
                return ListTile(
                  leading: const Icon(Icons.photo_size_select_large),
                  title: Text(item.sourceName),
                  subtitle: const Text(''),
                );
              }).toList(),
            ),
          ),

          // bottom bar
          CustomButtonBar(
            leftIcon: const Icon(Icons.arrow_back_ios),
            leftText: t.common.back,
            //onLeftClick: _start == null ? _previousPage : null,
            onLeftClick: _previousPage,
            rightIcon: const Icon(Icons.arrow_forward_ios),
            rightText: t.common.next,
            onRightClick: _nextPage,
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

    log.info("images: ${appShare.images.length} file(s)");
    for (var i = 0; i < appShare.images.length; i++) {
      var item = appShare.images[i];
      log.info("  ${i + 1}: ${item.source}");
    }
  }

  /// Previous page.
  Future<void> _previousPage() async {
    Navigator.pop(context);
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.leftToRightWithFade,
        child: const PhotoPage(),
      ),
    );
  }

  /// Next page.
  Future<void> _nextPage() async {
    if (_start == null) {
      _start = 0;
      _startTimer = Timer(const Duration(milliseconds: 1), _convert);
    } else if (_finish) {
      appShare.clear();

      Navigator.pop(context);
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          child: const StartPage(),
        ),
      );
    }
  }

  /// Processes the image file.
  Future<void> _convert() async {
    // get current thumbnail
    var o = appShare.images[_start!];
    _start = _start! + 1;
    log.info("index ${_start!}: ${o.source}");

    // get image source
    var sourceFile = File(o.source);
    var sourceBase = path.basenameWithoutExtension(o.source);
    var sourceExt = path.extension(o.source);
    var data = await sourceFile.readAsBytes();
    var image = decodeImage(data);
    if (image == null) {
      o.ok = false;
      o.error = t.error.cantOpenImage;
      log.warning("index ${_start!}: ${o.error}");
      return;
    }

    // reduces image, get size
    late int w, h;
    if (!appShare.asSize) {
      // size as %
      w = appShare.width * image.width ~/ 100;
      h = appShare.height * image.height ~/ 100;
      log.info("index ${_start!}: as %, width=$w, height=$h");
    } else {
      // size as fix
      w = appShare.width;
      h = appShare.height;
      log.info("index ${_start!}: as fix, width=$w, height=$h");
    }

    // make thumbnail
    var thumbnail = copyResize(image, width: w, height: h);

    // output directory
    late String dir;
    if (!appShare.asDir) {
      // same as source
      dir = sourceFile.parent.path;
      log.info("index ${_start!}: same as source, dir=$dir");
    } else {
      // directory fix
      dir = appShare.dir;
      log.info("index ${_start!}: fix directory, dir=$dir");
    }

    // output file type
    late String ext;
    switch (appShare.type) {
      case 1:
        ext = 'jpeg';
        break;
      case 0:
      default:
        ext = 'png';
        break;
    }
    log.info("index ${_start!}: ext=$ext");

    // output file name
    var filePath = '';
    var exists = false;
    var retry = 0;
    while (true) {
      var fileName = appShare.filePattern.replaceAllMapped(re, (match) {
        switch (match[1]) {
          case 'F':
            return sourceBase;
          case 'N':
            return retry <= 0 ? '' : retry.toString();
          case '%':
            return '%';
        }
        return '';
      });
      log.info("index ${_start!}: $fileName");
      filePath = path.join(dir, '$fileName.$ext');
      log.info("index ${_start!}: $filePath");
      exists = await File(filePath).exists();
      log.info("index ${_start!}: $exists");
      if (!exists) break;
      if (retry >= 10) break;
      retry++;
    }

    if (exists) {
      o.ok = false;
      o.error = 'error exists';
      log.warning("index ${_start!}: ${o.error}");
      return;
    }

    // output to file
    switch (appShare.type) {
      case 1:
        await File(filePath).writeAsBytes(encodeJpg(thumbnail));
        break;
      case 0:
      default:
        await File(filePath).writeAsBytes(encodePng(thumbnail));
        break;
    }

    log.info("index ${_start!}: ok :)");
  }
}
