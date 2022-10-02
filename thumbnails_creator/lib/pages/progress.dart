import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:logging/logging.dart';
import 'package:image/image.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:page_transition/page_transition.dart';
import '../i18n/strings.g.dart';
import '../models/thumbnail.dart';
import '../services/localization.dart';
import '../services/types.dart';
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
  Timer? _startTimer;

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
                if (item.ok == false) {
                  late String error;
                  switch (item.error!) {
                    case ErrorEnumType.cantOpenImage:
                      error = t.error.cantOpenImage;
                      break;
                    case ErrorEnumType.cantSaveImage:
                      error = t.error.cantSaveImage;
                      break;
                    case ErrorEnumType.alreadyExists:
                      error = t.error.alreadyExists;
                      break;
                  }
                  return ListTile(
                    leading: const Icon(Icons.close),
                    title: Text(item.sourceName),
                    subtitle: Text(error),
                  );
                } else if (item.ok == true) {
                  return ListTile(
                    leading: const Icon(Icons.check),
                    title: Text(item.sourceName),
                    subtitle: Text(item.target ?? ''),
                  );
                } else {
                  return ListTile(
                    leading: const Icon(Icons.photo_size_select_large),
                    title: Text(item.sourceName),
                    subtitle: const Text(''),
                  );
                }
              }).toList(),
            ),
          ),

          // bottom bar
          CustomButtonBar(
            leftIcon: const Icon(Icons.arrow_back_ios),
            leftText: t.common.back,
            onLeftClick: _start == null ? _previousPage : null,
            rightIcon: !_finish
                ? const Icon(Icons.play_arrow)
                : const Icon(Icons.restart_alt),
            rightText: !_finish ? tr.start : tr.restart,
            onRightClick:
                _start == null ? _nextPage : (!_finish ? null : _nextPage),
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
      /* testing
      late Thumbnail o;
      setState(() {
        o = _items[0];
      });
      setState(() {
        o.ok = false;
        o.error = 'err';
      });
      */

      setState(() {
        _start = 0;
      });
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
    if (_start! >= appShare.images.length) {
      setState(() {
        _finish = true;
      });
      return;
    }

    // get current thumbnail
    var index = _start!;
    _start = _start! + 1;
    late Thumbnail o;
    setState(() {
      o = _items[index];
    });
    log.info("#$index: ${o.source}");

    // get image source
    var sourceFile = File(o.source);
    var basename = path.basenameWithoutExtension(o.source);
    var data = await sourceFile.readAsBytes();
    Image? image;
    if (data.isNotEmpty) {
      try {
        image = decodeImage(data);
      } catch (ex) {
        log.warning(ex);
        image = null;
      }
    }
    if (image == null) {
      _errorHandle(o, ErrorEnumType.cantOpenImage);
      log.warning("#$index: ${o.error}");
      return;
    }

    // reduces image, get size
    late int w, h;
    if (appShare.sizeEnum == SizeEnumType.percent) {
      // size as %
      w = appShare.width * image.width ~/ 100;
      h = appShare.height * image.height ~/ 100;
      log.info("#$index: size as %, width=$w, height=$h");
    } else {
      // size as fix
      w = appShare.width;
      h = appShare.height;
      log.info("#$index: size as fix, width=$w, height=$h");
    }

    // make thumbnail
    Image? thumbnail;
    try {
      thumbnail = copyResize(image, width: w, height: h);
    } on Exception {
      thumbnail = null;
    }
    if (thumbnail == null) {
      _errorHandle(o, ErrorEnumType.cantSaveImage);
      log.warning("#$index: ${o.error}");
      return;
    }

    // output directory
    late String dir;
    if (appShare.dirEnum == DirEnumType.sameAsSource) {
      // same as source
      dir = sourceFile.parent.path;
      log.info("#$index: same as source, dir=$dir");
    } else {
      // directory fix
      dir = appShare.dir;
      log.info("#$index: fix directory, dir=$dir");
    }

    // output file type
    late String ext;
    switch (appShare.extEnum) {
      case ExtEnumType.jpeg:
        ext = 'jpeg';
        break;
      case ExtEnumType.png:
      default:
        ext = 'png';
        break;
    }

    // output file name
    var filePath = '';
    var exists = false;
    var retry = 0;
    while (true) {
      var fileName = appShare.filePattern.replaceAllMapped(re, (match) {
        switch (match[1]) {
          case 'F':
            return basename;
          case 'N':
            return retry <= 0 ? '' : retry.toString();
          case '%':
            return '%';
        }
        return '';
      });
      filePath = path.join(dir, '$fileName.$ext');
      exists = await File(filePath).exists();
      log.info("#$index: $filePath, exists=$exists");
      if (!exists) break;
      if (retry >= AppShare.maxRetry) break;
      retry++;
    }
    if (exists) {
      _errorHandle(o, ErrorEnumType.alreadyExists);
      log.warning("#$index: ${o.error}");
      return;
    }

    // output to file
    switch (appShare.extEnum) {
      case ExtEnumType.jpeg:
        await File(filePath).writeAsBytes(encodeJpg(thumbnail));
        break;
      case ExtEnumType.png:
      default:
        await File(filePath).writeAsBytes(encodePng(thumbnail));
        break;
    }

    setState(() {
      o.target = filePath;
      o.ok = true;
    });
    log.info("#$index: ok :)");
    _startTimer = Timer(const Duration(milliseconds: 500), _convert);
  }

  /// Error handling.
  void _errorHandle(Thumbnail o, ErrorEnumType error) {
    setState(() {
      o.ok = false;
      o.error = error;
    });
    _startTimer = Timer(const Duration(milliseconds: 500), _convert);
  }
}
