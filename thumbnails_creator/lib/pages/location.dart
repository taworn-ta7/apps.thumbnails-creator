import 'dart:async';
import 'package:logging/logging.dart';
import 'package:flutter/material.dart';
import '../i18n/strings.g.dart';
import '../services/app_share.dart';
import '../services/localization.dart';
import '../ui/custom_app_bar.dart';
import '../ui/custom_bottom_bar.dart';
import '../styles.dart';
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

  static const defaultFileOutput = '%F_thumb%N';

  // directory
  bool _asDir = false; // false = same as source, true = choose directory
  String? _dir;

  // file
  late TextEditingController _fileEdit;

  // initial timer handler
  late Timer _initTimer;

  @override
  void initState() {
    super.initState();
    _fileEdit = TextEditingController(text: defaultFileOutput);
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
          // widgets
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // directory
                  ListTile(
                    title: Text(tr.directory),
                  ),
                  RadioListTile<bool>(
                    title: Text(tr.dirAsSame),
                    value: false,
                    groupValue: _asDir,
                    onChanged: (bool? value) {
                      setState(() {
                        _asDir = value ?? false;
                      });
                    },
                  ),
                  RadioListTile<bool>(
                    title: Text(tr.dirAsFix),
                    subtitle: const Text('<directory>'),
                    value: true,
                    groupValue: _asDir,
                    secondary: IconButton(
                      icon: const Icon(Icons.more_horiz),
                      onPressed: () {},
                    ),
                    onChanged: (bool? value) {
                      setState(() {
                        _asDir = value ?? false;
                      });
                    },
                  ),

                  // file
                  ListTile(
                    title: Text(tr.file),
                  ),
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
                          _fileEdit.text = defaultFileOutput;
                        }),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      return value;
                    },
                    controller: _fileEdit,
                  ),
                ],
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
