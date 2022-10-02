import 'dart:async';
import 'package:logging/logging.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:file_picker/file_picker.dart';
import '../i18n/strings.g.dart';
import '../services/localization.dart';
import '../services/types.dart';
import '../services/app_share.dart';
import '../ui/custom_app_bar.dart';
import '../ui/custom_button_bar.dart';
import '../styles.dart';
import 'start.dart';
import 'photo.dart';

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

  final _formKey = GlobalKey<FormState>();

  // directory
  DirEnumType _dirEnum = DirEnumType.sameAsSource;
  String _dir = '';

  // file
  late TextEditingController _fileEdit;

  // type
  ExtEnumType _type = ExtEnumType.png;

  // initial timer handler
  late Timer _initTimer;

  @override
  void initState() {
    super.initState();
    _fileEdit = TextEditingController();
    _initTimer = Timer(const Duration(), _handleInit);
    log.fine("$this initState()");
  }

  @override
  void dispose() {
    log.fine("$this dispose()");
    _initTimer.cancel();
    _fileEdit.dispose();
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
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // directory
                    ListTile(
                      title: Text(tr.directory),
                    ),
                    RadioListTile<DirEnumType>(
                      title: Text(tr.dirAsSame),
                      value: DirEnumType.sameAsSource,
                      groupValue: _dirEnum,
                      onChanged: (DirEnumType? value) {
                        setState(() {
                          _dirEnum = value!;
                        });
                      },
                    ),
                    RadioListTile<DirEnumType>(
                      title: Text(tr.dirAsFix),
                      subtitle: Text(_dir),
                      value: DirEnumType.chooseDir,
                      groupValue: _dirEnum,
                      secondary: IconButton(
                        icon: const Icon(Icons.more_horiz),
                        onPressed: _setDirectory,
                      ),
                      onChanged: (DirEnumType? value) {
                        setState(() {
                          _dirEnum = value!;
                        });
                      },
                    ),

                    // file
                    ListTile(
                      title: Text(tr.file),
                    ),
                    Styles.aroundLeftRight(
                      TextFormField(
                        decoration: InputDecoration(
                          border: Styles.inputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          counterText: '',
                          labelText: tr.fileOutput,
                          prefixIcon: const Icon(Icons.edit_note),
                          suffixIcon: GestureDetector(
                            child: const Icon(Icons.textsms),
                            onTap: () => setState(() {
                              _fileEdit.text = AppShare.defaultFileOutput;
                            }),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null) return t.validator.isNotBlank;
                          if (value.trim() == '') return t.validator.isNotBlank;
                          return null;
                        },
                        controller: _fileEdit,
                      ),
                    ),
                    Styles.aroundLeftRight(
                      Text(tr.fileHint),
                    ),

                    // type
                    ListTile(
                      title: Text(tr.type),
                    ),
                    RadioListTile<ExtEnumType>(
                      title: Text(tr.png),
                      value: ExtEnumType.png,
                      groupValue: _type,
                      onChanged: (ExtEnumType? value) {
                        setState(() {
                          _type = value!;
                        });
                      },
                    ),
                    RadioListTile<ExtEnumType>(
                      title: Text(tr.jpeg),
                      value: ExtEnumType.jpeg,
                      groupValue: _type,
                      onChanged: (ExtEnumType? value) {
                        setState(() {
                          _type = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // bottom bar
          CustomButtonBar(
            leftIcon: const Icon(Icons.arrow_back_ios),
            leftText: t.common.back,
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
      _dirEnum = appShare.dirEnum;
      _dir = appShare.dir;
      _fileEdit.text = appShare.filePattern;
      _type = appShare.extEnum;
    });
  }

  /// Chooses a directory.
  Future<void> _setDirectory() async {
    final path = await FilePicker.platform.getDirectoryPath();
    if (path != null) {
      setState(() {
        _dir = path;
        log.info("directory selected: $path");
      });
    }
  }

  /// Previous page.
  Future<void> _previousPage() async {
    _copyData();

    Navigator.pop(context);
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.leftToRightWithFade,
        child: const StartPage(),
      ),
    );
  }

  /// Next page.
  Future<void> _nextPage() async {
    if (!_formKey.currentState!.validate()) return;
    _copyData();

    Navigator.pop(context);
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeftWithFade,
        child: const PhotoPage(),
      ),
    );
  }

  /// Copy data to AppShare instance.
  void _copyData() {
    appShare.dirEnum = _dirEnum;
    appShare.dir = _dir;
    appShare.filePattern = _fileEdit.text.trim();
    appShare.extEnum = _type;
  }
}
