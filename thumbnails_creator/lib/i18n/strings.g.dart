
/*
 * Generated file. Do not edit.
 *
 * Locales: 2
 * Strings: 142 (71.0 per locale)
 *
 * Built on 2022-10-02 at 11:41 UTC
 */

import 'package:flutter/widgets.dart';

const AppLocale _baseLocale = AppLocale.en;
AppLocale _currLocale = _baseLocale;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale {
	en, // 'en' (base locale, fallback)
	th, // 'th'
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
_StringsEn _t = _currLocale.translations;
_StringsEn get t => _t;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class Translations {
	Translations._(); // no constructor

	static _StringsEn of(BuildContext context) {
		final inheritedWidget = context.dependOnInheritedWidgetOfExactType<_InheritedLocaleData>();
		if (inheritedWidget == null) {
			throw 'Please wrap your app with "TranslationProvider".';
		}
		return inheritedWidget.translations;
	}
}

class LocaleSettings {
	LocaleSettings._(); // no constructor

	/// Uses locale of the device, fallbacks to base locale.
	/// Returns the locale which has been set.
	static AppLocale useDeviceLocale() {
		final locale = AppLocaleUtils.findDeviceLocale();
		return setLocale(locale);
	}

	/// Sets locale
	/// Returns the locale which has been set.
	static AppLocale setLocale(AppLocale locale) {
		_currLocale = locale;
		_t = _currLocale.translations;

		// force rebuild if TranslationProvider is used
		_translationProviderKey.currentState?.setLocale(_currLocale);

		return _currLocale;
	}

	/// Sets locale using string tag (e.g. en_US, de-DE, fr)
	/// Fallbacks to base locale.
	/// Returns the locale which has been set.
	static AppLocale setLocaleRaw(String rawLocale) {
		final locale = AppLocaleUtils.parse(rawLocale);
		return setLocale(locale);
	}

	/// Gets current locale.
	static AppLocale get currentLocale {
		return _currLocale;
	}

	/// Gets base locale.
	static AppLocale get baseLocale {
		return _baseLocale;
	}

	/// Gets supported locales in string format.
	static List<String> get supportedLocalesRaw {
		return AppLocale.values
			.map((locale) => locale.languageTag)
			.toList();
	}

	/// Gets supported locales (as Locale objects) with base locale sorted first.
	static List<Locale> get supportedLocales {
		return AppLocale.values
			.map((locale) => locale.flutterLocale)
			.toList();
	}
}

/// Provides utility functions without any side effects.
class AppLocaleUtils {
	AppLocaleUtils._(); // no constructor

	/// Returns the locale of the device as the enum type.
	/// Fallbacks to base locale.
	static AppLocale findDeviceLocale() {
		final String? deviceLocale = WidgetsBinding.instance.window.locale.toLanguageTag();
		if (deviceLocale != null) {
			final typedLocale = _selectLocale(deviceLocale);
			if (typedLocale != null) {
				return typedLocale;
			}
		}
		return _baseLocale;
	}

	/// Returns the enum type of the raw locale.
	/// Fallbacks to base locale.
	static AppLocale parse(String rawLocale) {
		return _selectLocale(rawLocale) ?? _baseLocale;
	}
}

// context enums

// interfaces generated as mixins

// translation instances

late _StringsEn _translationsEn = _StringsEn.build();
late _StringsTh _translationsTh = _StringsTh.build();

// extensions for AppLocale

extension AppLocaleExtensions on AppLocale {

	/// Gets the translation instance managed by this library.
	/// [TranslationProvider] is using this instance.
	/// The plural resolvers are set via [LocaleSettings].
	_StringsEn get translations {
		switch (this) {
			case AppLocale.en: return _translationsEn;
			case AppLocale.th: return _translationsTh;
		}
	}

	/// Gets a new translation instance.
	/// [LocaleSettings] has no effect here.
	/// Suitable for dependency injection and unit tests.
	///
	/// Usage:
	/// final t = AppLocale.en.build(); // build
	/// String a = t.my.path; // access
	_StringsEn build() {
		switch (this) {
			case AppLocale.en: return _StringsEn.build();
			case AppLocale.th: return _StringsTh.build();
		}
	}

	String get languageTag {
		switch (this) {
			case AppLocale.en: return 'en';
			case AppLocale.th: return 'th';
		}
	}

	Locale get flutterLocale {
		switch (this) {
			case AppLocale.en: return const Locale.fromSubtags(languageCode: 'en');
			case AppLocale.th: return const Locale.fromSubtags(languageCode: 'th');
		}
	}
}

extension StringAppLocaleExtensions on String {
	AppLocale? toAppLocale() {
		switch (this) {
			case 'en': return AppLocale.en;
			case 'th': return AppLocale.th;
			default: return null;
		}
	}
}

// wrappers

GlobalKey<_TranslationProviderState> _translationProviderKey = GlobalKey<_TranslationProviderState>();

class TranslationProvider extends StatefulWidget {
	TranslationProvider({required this.child}) : super(key: _translationProviderKey);

	final Widget child;

	@override
	_TranslationProviderState createState() => _TranslationProviderState();

	static _InheritedLocaleData of(BuildContext context) {
		final inheritedWidget = context.dependOnInheritedWidgetOfExactType<_InheritedLocaleData>();
		if (inheritedWidget == null) {
			throw 'Please wrap your app with "TranslationProvider".';
		}
		return inheritedWidget;
	}
}

class _TranslationProviderState extends State<TranslationProvider> {
	AppLocale locale = _currLocale;

	void setLocale(AppLocale newLocale) {
		setState(() {
			locale = newLocale;
		});
	}

	@override
	Widget build(BuildContext context) {
		return _InheritedLocaleData(
			locale: locale,
			child: widget.child,
		);
	}
}

class _InheritedLocaleData extends InheritedWidget {
	final AppLocale locale;
	Locale get flutterLocale => locale.flutterLocale; // shortcut
	final _StringsEn translations; // store translations to avoid switch call

	_InheritedLocaleData({required this.locale, required Widget child})
		: translations = locale.translations, super(child: child);

	@override
	bool updateShouldNotify(_InheritedLocaleData oldWidget) {
		return oldWidget.locale != locale;
	}
}

// pluralization feature not used

// helpers

final _localeRegex = RegExp(r'^([a-z]{2,8})?([_-]([A-Za-z]{4}))?([_-]?([A-Z]{2}|[0-9]{3}))?$');
AppLocale? _selectLocale(String localeRaw) {
	final match = _localeRegex.firstMatch(localeRaw);
	AppLocale? selected;
	if (match != null) {
		final language = match.group(1);
		final country = match.group(5);

		// match exactly
		selected = AppLocale.values
			.cast<AppLocale?>()
			.firstWhere((supported) => supported?.languageTag == localeRaw.replaceAll('_', '-'), orElse: () => null);

		if (selected == null && language != null) {
			// match language
			selected = AppLocale.values
				.cast<AppLocale?>()
				.firstWhere((supported) => supported?.languageTag.startsWith(language) == true, orElse: () => null);
		}

		if (selected == null && country != null) {
			// match country
			selected = AppLocale.values
				.cast<AppLocale?>()
				.firstWhere((supported) => supported?.languageTag.contains(country) == true, orElse: () => null);
		}
	}
	return selected;
}

// translations

// Path: <root>
class _StringsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsEn.build();

	/// Access flat map
	dynamic operator[](String key) => _flatMap[key];

	// Internal flat map initialized lazily
	late final Map<String, dynamic> _flatMap = _buildFlatMap();

	late final _StringsEn _root = this; // ignore: unused_field

	// Translations
	String get app => 'Thumbnails Creator';
	String get version => '1.0.0';
	String get versionText => 'version ${_root.version}';
	late final _StringsSwitchLocaleEn switchLocale = _StringsSwitchLocaleEn._(_root);
	late final _StringsCommonEn common = _StringsCommonEn._(_root);
	late final _StringsQuestionEn question = _StringsQuestionEn._(_root);
	late final _StringsValidatorEn validator = _StringsValidatorEn._(_root);
	late final _StringsErrorEn error = _StringsErrorEn._(_root);
	late final _StringsMessageBoxEn messageBox = _StringsMessageBoxEn._(_root);
	late final _StringsWaitBoxEn waitBox = _StringsWaitBoxEn._(_root);
	late final _StringsImageChooserEn imageChooser = _StringsImageChooserEn._(_root);
	late final _StringsStartPageEn startPage = _StringsStartPageEn._(_root);
	late final _StringsLocationPageEn locationPage = _StringsLocationPageEn._(_root);
	late final _StringsPhotoPageEn photoPage = _StringsPhotoPageEn._(_root);
	late final _StringsProgressPageEn progressPage = _StringsProgressPageEn._(_root);
}

// Path: switchLocale
class _StringsSwitchLocaleEn {
	_StringsSwitchLocaleEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get en => 'Change Language to English';
	String get th => 'Change Language to ไทย';
}

// Path: common
class _StringsCommonEn {
	_StringsCommonEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get close => 'Close';
	String get ok => 'OK';
	String get cancel => 'Cancel';
	String get yes => 'Yes';
	String get no => 'No';
	String get retry => 'Retry';
	String get name => 'Name';
	String get value => 'Value';
	String get create => 'Create';
	String get createMore => 'Create...';
	String get update => 'Save';
	String get updateMore => 'Save...';
	String get remove => 'Delete';
	String get removeMore => 'Delete...';
	String get back => 'Back';
	String get next => 'Next';
}

// Path: question
class _StringsQuestionEn {
	_StringsQuestionEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get areYouSureToQuit => 'Are you sure to exit this program?';
	String get areYouSureToDelete => 'Are you sure to delete this item?';
	String get areYouSureToLeave => 'Are you sure to leave without save data?';
}

// Path: validator
class _StringsValidatorEn {
	_StringsValidatorEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String isMinInt({required Object min}) => 'Please input as integer, minimum >= $min.';
	String isMaxInt({required Object max}) => 'Please input as integer, maximum <= $max.';
	String get isPositiveInt => 'Please input as positive integer.';
	String get isPositiveOrZeroInt => 'Please input as positive integer or zero.';
	String get isNegativeInt => 'Please input as negative integer.';
	String get isNegativeOrZeroInt => 'Please input as negative integer or zero.';
	String isMinFloat({required Object min}) => 'Please input as floating-point, minimum >= $min.';
	String isMaxFloat({required Object max}) => 'Please input as floating-point, maximum <= $max.';
	String get isPositiveFloat => 'Please input as positive floating-point.';
	String get isPositiveOrZeroFloat => 'Please input as positive floating-point or zero.';
	String get isNegativeFloat => 'Please input as negative floating-point.';
	String get isNegativeOrZeroFloat => 'Please input as negative floating-point or zero.';
	String get isMoney => 'Please input as money.';
	String isMinLength({required Object min}) => 'Please input length >= $min.';
	String isMaxLength({required Object max}) => 'Please input length <= $max.';
	String get isEmail => 'Please input as email.';
	String get isSamePasswords => 'Password and confirm password must be equal.';
}

// Path: error
class _StringsErrorEn {
	_StringsErrorEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get cantOpenImage => 'Cannot open image file!';
	String unknown({required Object statusCode}) => 'HTTP error ($statusCode)';
}

// Path: messageBox
class _StringsMessageBoxEn {
	_StringsMessageBoxEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get info => 'Information';
	String get warning => 'Warning';
	String get error => 'Error';
	String get question => 'Question';
}

// Path: waitBox
class _StringsWaitBoxEn {
	_StringsWaitBoxEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get message => 'Please wait...';
}

// Path: imageChooser
class _StringsImageChooserEn {
	_StringsImageChooserEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get upload => 'Upload';
	String get reset => 'Reset';
	String get revert => 'Revert';
}

// Path: startPage
class _StringsStartPageEn {
	_StringsStartPageEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get title => '${_root.app}';
	String get addFiles => 'Add File(s)...';
	String get clear => 'Clear';
	String get about => 'About...';
}

// Path: locationPage
class _StringsLocationPageEn {
	_StringsLocationPageEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Directory and File';
	String get directory => 'Directory';
	String get dirAsSame => 'Same as source images';
	String get dirAsFix => 'Select directory...';
	String get file => 'File';
	String get fileOutput => 'File pattern';
	String get fileHint => '%F - Filename without extension\n%N - Number of trying\n%% - Percent (%) sign';
	String get type => 'Type';
	String get png => 'PNG';
	String get jpeg => 'JPEG';
}

// Path: photoPage
class _StringsPhotoPageEn {
	_StringsPhotoPageEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Photo Settings';
	String get sizeAsPercent => 'Size as percent';
	String get sizeAsFix => 'Size as fix width and height';
	String get width => 'Width';
	String get height => 'Height';
}

// Path: progressPage
class _StringsProgressPageEn {
	_StringsProgressPageEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Progress';
}

// Path: <root>
class _StringsTh implements _StringsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsTh.build();

	/// Access flat map
	@override dynamic operator[](String key) => _flatMap[key];

	// Internal flat map initialized lazily
	@override late final Map<String, dynamic> _flatMap = _buildFlatMap();

	@override late final _StringsTh _root = this; // ignore: unused_field

	// Translations
	@override String get app => 'Thumbnails Creator';
	@override String get version => '1.0.0';
	@override String get versionText => 'รุ่น ${_root.version}';
	@override late final _StringsSwitchLocaleTh switchLocale = _StringsSwitchLocaleTh._(_root);
	@override late final _StringsCommonTh common = _StringsCommonTh._(_root);
	@override late final _StringsQuestionTh question = _StringsQuestionTh._(_root);
	@override late final _StringsValidatorTh validator = _StringsValidatorTh._(_root);
	@override late final _StringsErrorTh error = _StringsErrorTh._(_root);
	@override late final _StringsMessageBoxTh messageBox = _StringsMessageBoxTh._(_root);
	@override late final _StringsWaitBoxTh waitBox = _StringsWaitBoxTh._(_root);
	@override late final _StringsImageChooserTh imageChooser = _StringsImageChooserTh._(_root);
	@override late final _StringsStartPageTh startPage = _StringsStartPageTh._(_root);
	@override late final _StringsLocationPageTh locationPage = _StringsLocationPageTh._(_root);
	@override late final _StringsPhotoPageTh photoPage = _StringsPhotoPageTh._(_root);
	@override late final _StringsProgressPageTh progressPage = _StringsProgressPageTh._(_root);
}

// Path: switchLocale
class _StringsSwitchLocaleTh implements _StringsSwitchLocaleEn {
	_StringsSwitchLocaleTh._(this._root);

	@override final _StringsTh _root; // ignore: unused_field

	// Translations
	@override String get en => 'สลับภาษาเป็น English';
	@override String get th => 'สลับภาษาเป็น ไทย';
}

// Path: common
class _StringsCommonTh implements _StringsCommonEn {
	_StringsCommonTh._(this._root);

	@override final _StringsTh _root; // ignore: unused_field

	// Translations
	@override String get close => 'ปิด';
	@override String get ok => 'ตกลง';
	@override String get cancel => 'ยกเลิก';
	@override String get yes => 'ใช่';
	@override String get no => 'ไม่ใช่';
	@override String get retry => 'ลองใหม่';
	@override String get name => 'ชื่อ';
	@override String get value => 'ค่า';
	@override String get create => 'สร้าง';
	@override String get createMore => 'สร้าง...';
	@override String get update => 'บันทึก';
	@override String get updateMore => 'บันทึก...';
	@override String get remove => 'ลบ';
	@override String get removeMore => 'ลบ...';
	@override String get back => 'กลับไปหน้าที่แล้ว';
	@override String get next => 'ไปหน้าถัดไป';
}

// Path: question
class _StringsQuestionTh implements _StringsQuestionEn {
	_StringsQuestionTh._(this._root);

	@override final _StringsTh _root; // ignore: unused_field

	// Translations
	@override String get areYouSureToQuit => 'คุณแน่ใจที่จะออกจากโปรแกรมนี้หรือไม่?';
	@override String get areYouSureToDelete => 'คุณแน่ใจที่จะลบข้อมูลนี้หรือไม่?';
	@override String get areYouSureToLeave => 'คุณแน่ใจที่จะออกจากหน้านี้โดยไม่เซฟข้อมูล?';
}

// Path: validator
class _StringsValidatorTh implements _StringsValidatorEn {
	_StringsValidatorTh._(this._root);

	@override final _StringsTh _root; // ignore: unused_field

	// Translations
	@override String isMinInt({required Object min}) => 'กรอกข้อมูล เป็นเลขจำนวนเต็ม, อย่างน้อย >= $min.';
	@override String isMaxInt({required Object max}) => 'กรอกข้อมูล เป็นเลขจำนวนเต็ม, อย่างมาก <= $max.';
	@override String get isPositiveInt => 'กรอกข้อมูล เป็นเลขจำนวนเต็มบวก';
	@override String get isPositiveOrZeroInt => 'กรอกข้อมูล เป็นเลขจำนวนเต็มบวกหรือศูนย์';
	@override String get isNegativeInt => 'กรอกข้อมูล เป็นเลขจำนวนเต็มลบ';
	@override String get isNegativeOrZeroInt => 'กรอกข้อมูล เป็นเลขจำนวนเต็มลบหรือศูนย์';
	@override String isMinFloat({required Object min}) => 'กรอกข้อมูล เป็นเลขจำนวนทศนิยม, อย่างน้อย >= $min.';
	@override String isMaxFloat({required Object max}) => 'กรอกข้อมูล เป็นเลขจำนวนทศนิยม, อย่างมาก <= $max.';
	@override String get isPositiveFloat => 'กรอกข้อมูล เป็นเลขจำนวนทศนิยมบวก';
	@override String get isPositiveOrZeroFloat => 'กรอกข้อมูล เป็นเลขจำนวนทศนิยมบวกหรือศูนย์';
	@override String get isNegativeFloat => 'กรอกข้อมูล เป็นเลขจำนวนทศนิยมลบ';
	@override String get isNegativeOrZeroFloat => 'กรอกข้อมูล เป็นเลขจำนวนทศนิยมลบหรือศูนย์';
	@override String get isMoney => 'กรอกข้อมูล เป็นเลขจำนวนเงิน.';
	@override String isMinLength({required Object min}) => 'กรอกข้อมูล ความยาว >= $min';
	@override String isMaxLength({required Object max}) => 'กรอกข้อมูล ความยาว <= $max';
	@override String get isEmail => 'กรอกข้อมูล เป็นอีเมล';
	@override String get isSamePasswords => 'รหัสผ่าน และ ยืนยันรหัสผ่าน ต้องเหมือนกัน';
}

// Path: error
class _StringsErrorTh implements _StringsErrorEn {
	_StringsErrorTh._(this._root);

	@override final _StringsTh _root; // ignore: unused_field

	// Translations
	@override String get cantOpenImage => 'ไม่สามารถเปิดไฟล์รูปภาพได้!';
	@override String unknown({required Object statusCode}) => 'เกิดข้อผิดพลาดจาก HTTP ($statusCode)';
}

// Path: messageBox
class _StringsMessageBoxTh implements _StringsMessageBoxEn {
	_StringsMessageBoxTh._(this._root);

	@override final _StringsTh _root; // ignore: unused_field

	// Translations
	@override String get info => 'ข้อมูลข่าวสาร';
	@override String get warning => 'แจ้งเตือน';
	@override String get error => 'เกิดข้อผิดพลาด';
	@override String get question => 'คำถาม';
}

// Path: waitBox
class _StringsWaitBoxTh implements _StringsWaitBoxEn {
	_StringsWaitBoxTh._(this._root);

	@override final _StringsTh _root; // ignore: unused_field

	// Translations
	@override String get message => 'โปรดรอสักครู่...';
}

// Path: imageChooser
class _StringsImageChooserTh implements _StringsImageChooserEn {
	_StringsImageChooserTh._(this._root);

	@override final _StringsTh _root; // ignore: unused_field

	// Translations
	@override String get upload => 'อัพโหลด';
	@override String get reset => 'รีเซ็ต';
	@override String get revert => 'ย้อนกลับ';
}

// Path: startPage
class _StringsStartPageTh implements _StringsStartPageEn {
	_StringsStartPageTh._(this._root);

	@override final _StringsTh _root; // ignore: unused_field

	// Translations
	@override String get title => '${_root.app}';
	@override String get addFiles => 'เพิ่มไฟล์...';
	@override String get clear => 'ลบไฟล์ทั้งหมด';
	@override String get about => 'เกี่ยวกับ...';
}

// Path: locationPage
class _StringsLocationPageTh implements _StringsLocationPageEn {
	_StringsLocationPageTh._(this._root);

	@override final _StringsTh _root; // ignore: unused_field

	// Translations
	@override String get title => 'พาธและไฟล์';
	@override String get directory => 'Directory';
	@override String get dirAsSame => 'เหมือนกับต้นทาง';
	@override String get dirAsFix => 'เลือก directory...';
	@override String get file => 'ไฟล์';
	@override String get fileOutput => 'รูปแบบไฟล์';
	@override String get fileHint => '%F - ชื่อไฟล์ ไม่รวมนามสกุล\n%N - จำนวนครั้งที่ลอง\n%% - เครื่องหมายเปอร์เซ็นต์ (%)';
	@override String get type => 'ชนิด';
	@override String get png => 'PNG';
	@override String get jpeg => 'JPEG';
}

// Path: photoPage
class _StringsPhotoPageTh implements _StringsPhotoPageEn {
	_StringsPhotoPageTh._(this._root);

	@override final _StringsTh _root; // ignore: unused_field

	// Translations
	@override String get title => 'การเซ็ตค่ารูปภาพ';
	@override String get sizeAsPercent => 'ขนาดเป็น %';
	@override String get sizeAsFix => 'ขนาดเป็น กว้าง x สูง';
	@override String get width => 'ความกว้าง';
	@override String get height => 'ความสูง';
}

// Path: progressPage
class _StringsProgressPageTh implements _StringsProgressPageEn {
	_StringsProgressPageTh._(this._root);

	@override final _StringsTh _root; // ignore: unused_field

	// Translations
	@override String get title => 'การทำงาน';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on _StringsEn {
	Map<String, dynamic> _buildFlatMap() {
		return <String, dynamic>{
			'app': 'Thumbnails Creator',
			'version': '1.0.0',
			'versionText': 'version ${_root.version}',
			'switchLocale.en': 'Change Language to English',
			'switchLocale.th': 'Change Language to ไทย',
			'common.close': 'Close',
			'common.ok': 'OK',
			'common.cancel': 'Cancel',
			'common.yes': 'Yes',
			'common.no': 'No',
			'common.retry': 'Retry',
			'common.name': 'Name',
			'common.value': 'Value',
			'common.create': 'Create',
			'common.createMore': 'Create...',
			'common.update': 'Save',
			'common.updateMore': 'Save...',
			'common.remove': 'Delete',
			'common.removeMore': 'Delete...',
			'common.back': 'Back',
			'common.next': 'Next',
			'question.areYouSureToQuit': 'Are you sure to exit this program?',
			'question.areYouSureToDelete': 'Are you sure to delete this item?',
			'question.areYouSureToLeave': 'Are you sure to leave without save data?',
			'validator.isMinInt': ({required Object min}) => 'Please input as integer, minimum >= $min.',
			'validator.isMaxInt': ({required Object max}) => 'Please input as integer, maximum <= $max.',
			'validator.isPositiveInt': 'Please input as positive integer.',
			'validator.isPositiveOrZeroInt': 'Please input as positive integer or zero.',
			'validator.isNegativeInt': 'Please input as negative integer.',
			'validator.isNegativeOrZeroInt': 'Please input as negative integer or zero.',
			'validator.isMinFloat': ({required Object min}) => 'Please input as floating-point, minimum >= $min.',
			'validator.isMaxFloat': ({required Object max}) => 'Please input as floating-point, maximum <= $max.',
			'validator.isPositiveFloat': 'Please input as positive floating-point.',
			'validator.isPositiveOrZeroFloat': 'Please input as positive floating-point or zero.',
			'validator.isNegativeFloat': 'Please input as negative floating-point.',
			'validator.isNegativeOrZeroFloat': 'Please input as negative floating-point or zero.',
			'validator.isMoney': 'Please input as money.',
			'validator.isMinLength': ({required Object min}) => 'Please input length >= $min.',
			'validator.isMaxLength': ({required Object max}) => 'Please input length <= $max.',
			'validator.isEmail': 'Please input as email.',
			'validator.isSamePasswords': 'Password and confirm password must be equal.',
			'error.cantOpenImage': 'Cannot open image file!',
			'error.unknown': ({required Object statusCode}) => 'HTTP error ($statusCode)',
			'messageBox.info': 'Information',
			'messageBox.warning': 'Warning',
			'messageBox.error': 'Error',
			'messageBox.question': 'Question',
			'waitBox.message': 'Please wait...',
			'imageChooser.upload': 'Upload',
			'imageChooser.reset': 'Reset',
			'imageChooser.revert': 'Revert',
			'startPage.title': '${_root.app}',
			'startPage.addFiles': 'Add File(s)...',
			'startPage.clear': 'Clear',
			'startPage.about': 'About...',
			'locationPage.title': 'Directory and File',
			'locationPage.directory': 'Directory',
			'locationPage.dirAsSame': 'Same as source images',
			'locationPage.dirAsFix': 'Select directory...',
			'locationPage.file': 'File',
			'locationPage.fileOutput': 'File pattern',
			'locationPage.fileHint': '%F - Filename without extension\n%N - Number of trying\n%% - Percent (%) sign',
			'locationPage.type': 'Type',
			'locationPage.png': 'PNG',
			'locationPage.jpeg': 'JPEG',
			'photoPage.title': 'Photo Settings',
			'photoPage.sizeAsPercent': 'Size as percent',
			'photoPage.sizeAsFix': 'Size as fix width and height',
			'photoPage.width': 'Width',
			'photoPage.height': 'Height',
			'progressPage.title': 'Progress',
		};
	}
}

extension on _StringsTh {
	Map<String, dynamic> _buildFlatMap() {
		return <String, dynamic>{
			'app': 'Thumbnails Creator',
			'version': '1.0.0',
			'versionText': 'รุ่น ${_root.version}',
			'switchLocale.en': 'สลับภาษาเป็น English',
			'switchLocale.th': 'สลับภาษาเป็น ไทย',
			'common.close': 'ปิด',
			'common.ok': 'ตกลง',
			'common.cancel': 'ยกเลิก',
			'common.yes': 'ใช่',
			'common.no': 'ไม่ใช่',
			'common.retry': 'ลองใหม่',
			'common.name': 'ชื่อ',
			'common.value': 'ค่า',
			'common.create': 'สร้าง',
			'common.createMore': 'สร้าง...',
			'common.update': 'บันทึก',
			'common.updateMore': 'บันทึก...',
			'common.remove': 'ลบ',
			'common.removeMore': 'ลบ...',
			'common.back': 'กลับไปหน้าที่แล้ว',
			'common.next': 'ไปหน้าถัดไป',
			'question.areYouSureToQuit': 'คุณแน่ใจที่จะออกจากโปรแกรมนี้หรือไม่?',
			'question.areYouSureToDelete': 'คุณแน่ใจที่จะลบข้อมูลนี้หรือไม่?',
			'question.areYouSureToLeave': 'คุณแน่ใจที่จะออกจากหน้านี้โดยไม่เซฟข้อมูล?',
			'validator.isMinInt': ({required Object min}) => 'กรอกข้อมูล เป็นเลขจำนวนเต็ม, อย่างน้อย >= $min.',
			'validator.isMaxInt': ({required Object max}) => 'กรอกข้อมูล เป็นเลขจำนวนเต็ม, อย่างมาก <= $max.',
			'validator.isPositiveInt': 'กรอกข้อมูล เป็นเลขจำนวนเต็มบวก',
			'validator.isPositiveOrZeroInt': 'กรอกข้อมูล เป็นเลขจำนวนเต็มบวกหรือศูนย์',
			'validator.isNegativeInt': 'กรอกข้อมูล เป็นเลขจำนวนเต็มลบ',
			'validator.isNegativeOrZeroInt': 'กรอกข้อมูล เป็นเลขจำนวนเต็มลบหรือศูนย์',
			'validator.isMinFloat': ({required Object min}) => 'กรอกข้อมูล เป็นเลขจำนวนทศนิยม, อย่างน้อย >= $min.',
			'validator.isMaxFloat': ({required Object max}) => 'กรอกข้อมูล เป็นเลขจำนวนทศนิยม, อย่างมาก <= $max.',
			'validator.isPositiveFloat': 'กรอกข้อมูล เป็นเลขจำนวนทศนิยมบวก',
			'validator.isPositiveOrZeroFloat': 'กรอกข้อมูล เป็นเลขจำนวนทศนิยมบวกหรือศูนย์',
			'validator.isNegativeFloat': 'กรอกข้อมูล เป็นเลขจำนวนทศนิยมลบ',
			'validator.isNegativeOrZeroFloat': 'กรอกข้อมูล เป็นเลขจำนวนทศนิยมลบหรือศูนย์',
			'validator.isMoney': 'กรอกข้อมูล เป็นเลขจำนวนเงิน.',
			'validator.isMinLength': ({required Object min}) => 'กรอกข้อมูล ความยาว >= $min',
			'validator.isMaxLength': ({required Object max}) => 'กรอกข้อมูล ความยาว <= $max',
			'validator.isEmail': 'กรอกข้อมูล เป็นอีเมล',
			'validator.isSamePasswords': 'รหัสผ่าน และ ยืนยันรหัสผ่าน ต้องเหมือนกัน',
			'error.cantOpenImage': 'ไม่สามารถเปิดไฟล์รูปภาพได้!',
			'error.unknown': ({required Object statusCode}) => 'เกิดข้อผิดพลาดจาก HTTP ($statusCode)',
			'messageBox.info': 'ข้อมูลข่าวสาร',
			'messageBox.warning': 'แจ้งเตือน',
			'messageBox.error': 'เกิดข้อผิดพลาด',
			'messageBox.question': 'คำถาม',
			'waitBox.message': 'โปรดรอสักครู่...',
			'imageChooser.upload': 'อัพโหลด',
			'imageChooser.reset': 'รีเซ็ต',
			'imageChooser.revert': 'ย้อนกลับ',
			'startPage.title': '${_root.app}',
			'startPage.addFiles': 'เพิ่มไฟล์...',
			'startPage.clear': 'ลบไฟล์ทั้งหมด',
			'startPage.about': 'เกี่ยวกับ...',
			'locationPage.title': 'พาธและไฟล์',
			'locationPage.directory': 'Directory',
			'locationPage.dirAsSame': 'เหมือนกับต้นทาง',
			'locationPage.dirAsFix': 'เลือก directory...',
			'locationPage.file': 'ไฟล์',
			'locationPage.fileOutput': 'รูปแบบไฟล์',
			'locationPage.fileHint': '%F - ชื่อไฟล์ ไม่รวมนามสกุล\n%N - จำนวนครั้งที่ลอง\n%% - เครื่องหมายเปอร์เซ็นต์ (%)',
			'locationPage.type': 'ชนิด',
			'locationPage.png': 'PNG',
			'locationPage.jpeg': 'JPEG',
			'photoPage.title': 'การเซ็ตค่ารูปภาพ',
			'photoPage.sizeAsPercent': 'ขนาดเป็น %',
			'photoPage.sizeAsFix': 'ขนาดเป็น กว้าง x สูง',
			'photoPage.width': 'ความกว้าง',
			'photoPage.height': 'ความสูง',
			'progressPage.title': 'การทำงาน',
		};
	}
}
