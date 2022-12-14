import 'dart:async';
import 'dart:math';
import 'package:logging/logging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import '../i18n/strings.g.dart';
import '../services/localization.dart';
import '../services/types.dart';
import '../services/app_share.dart';
import '../ui/custom_app_bar.dart';
import '../ui/custom_button_bar.dart';
import '../styles.dart';
import 'location.dart';
import 'progress.dart';

/// PhotoPage class.
class PhotoPage extends StatefulWidget {
  const PhotoPage({Key? key}) : super(key: key);

  @override
  State<PhotoPage> createState() => _PhotoState();
}

/// _PhotoState internal class.
class _PhotoState extends State<PhotoPage> {
  static final log = Logger('PhotoPage');
  static final appShare = AppShare.instance();

  final _formKey = GlobalKey<FormState>();

  // photo
  SizeEnumType _sizeEnum = SizeEnumType.percent;

  // file
  late TextEditingController _widthEdit;
  late TextEditingController _heightEdit;

  // initial timer handler
  late Timer _initTimer;

  @override
  void initState() {
    super.initState();
    _widthEdit = TextEditingController();
    _heightEdit = TextEditingController();
    _initTimer = Timer(const Duration(), _handleInit);
    log.fine("$this initState()");
  }

  @override
  void dispose() {
    log.fine("$this dispose()");
    _initTimer.cancel();
    _heightEdit.dispose();
    _widthEdit.dispose();
    super.dispose();
  }

  // ----------------------------------------------------------------------

  /// Built widget tree.
  @override
  Widget build(BuildContext context) {
    final tr = t.photoPage;

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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // size
                    ListTile(
                      title: Text(tr.size),
                    ),
                    RadioListTile<SizeEnumType>(
                      title: Text(tr.sizeAsPercent),
                      value: SizeEnumType.percent,
                      groupValue: _sizeEnum,
                      onChanged: (SizeEnumType? value) {
                        setState(() {
                          _sizeEnum = value!;
                        });
                      },
                    ),
                    RadioListTile<SizeEnumType>(
                      title: Text(tr.sizeAsFix),
                      value: SizeEnumType.fix,
                      groupValue: _sizeEnum,
                      onChanged: (SizeEnumType? value) {
                        setState(() {
                          _sizeEnum = value!;
                        });
                      },
                    ),

                    // width
                    ListTile(
                      title: Text(tr.width),
                    ),
                    Styles.aroundLeftRight(
                      TextFormField(
                        decoration: InputDecoration(
                          border: Styles.inputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          counterText: '',
                          labelText: tr.width,
                          prefixIcon: Transform.rotate(
                            angle: 90 * pi / 180,
                            child: const IconButton(
                              icon: Icon(Icons.height),
                              onPressed: null,
                            ),
                          ),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: false,
                          decimal: false,
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ], // Onl
                        validator: (value) {
                          var v = int.tryParse(value ?? '');
                          if (v == null || v <= 0) {
                            return t.validator.isPositiveInt;
                          }
                          return null;
                        },
                        controller: _widthEdit,
                      ),
                    ),

                    // height
                    ListTile(
                      title: Text(tr.height),
                    ),
                    Styles.aroundLeftRight(
                      TextFormField(
                        decoration: InputDecoration(
                          border: Styles.inputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          counterText: '',
                          labelText: tr.height,
                          prefixIcon: const Icon(Icons.height),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: false,
                          decimal: false,
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ], // Onl
                        validator: (value) {
                          var v = int.tryParse(value ?? '');
                          if (v == null || v <= 0) {
                            return t.validator.isPositiveInt;
                          }
                          return null;
                        },
                        controller: _heightEdit,
                      ),
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
      _sizeEnum = appShare.sizeEnum;
      _widthEdit.text = appShare.width.toString();
      _heightEdit.text = appShare.height.toString();
    });
  }

  /// Previous page.
  Future<void> _previousPage() async {
    _copyData();

    Navigator.pop(context);
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.leftToRightWithFade,
        child: const LocationPage(),
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
        child: const ProgressPage(),
      ),
    );
  }

  /// Copy data to AppShare instance.
  void _copyData() {
    appShare.sizeEnum = _sizeEnum;
    appShare.width = int.tryParse(_widthEdit.text) ?? 0;
    appShare.height = int.tryParse(_heightEdit.text) ?? 0;
  }
}
