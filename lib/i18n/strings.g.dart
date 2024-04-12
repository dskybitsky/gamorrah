/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 1
/// Strings: 150
///
/// Built on 2024-04-12 at 06:21 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
	en(languageCode: 'en', build: Translations.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, Translations> build;

	/// Gets current instance managed by [LocaleSettings].
	Translations get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
Translations get t => LocaleSettings.instance.currentTranslations;

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
class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	Translations get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final _StringsUiEn ui = _StringsUiEn._(_root);
	late final _StringsTypesEn types = _StringsTypesEn._(_root);
}

// Path: ui
class _StringsUiEn {
	_StringsUiEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsUiGeneralEn general = _StringsUiGeneralEn._(_root);
	late final _StringsUiHomePageEn homePage = _StringsUiHomePageEn._(_root);
	late final _StringsUiGamesPageEn gamesPage = _StringsUiGamesPageEn._(_root);
	late final _StringsUiGamePageEn gamePage = _StringsUiGamePageEn._(_root);
	late final _StringsUiSettingsPageEn settingsPage = _StringsUiSettingsPageEn._(_root);
	late final _StringsUiGamePlatformsControlEn gamePlatformsControl = _StringsUiGamePlatformsControlEn._(_root);
	late final _StringsUiGamePersonalControlEn gamePersonalControl = _StringsUiGamePersonalControlEn._(_root);
	late final _StringsUiGameHowLongToBeatControlEn gameHowLongToBeatControl = _StringsUiGameHowLongToBeatControlEn._(_root);
	late final _StringsUiGameStatusControlEn gameStatusControl = _StringsUiGameStatusControlEn._(_root);
	late final _StringsUiGameTagsControlEn gameTagsControl = _StringsUiGameTagsControlEn._(_root);
}

// Path: types
class _StringsTypesEn {
	_StringsTypesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsTypesGameEn game = _StringsTypesGameEn._(_root);
	late final _StringsTypesGameKindEn gameKind = _StringsTypesGameKindEn._(_root);
	late final _StringsTypesGamePlatformEn gamePlatform = _StringsTypesGamePlatformEn._(_root);
	late final _StringsTypesGamePlatformBrandEn gamePlatformBrand = _StringsTypesGamePlatformBrandEn._(_root);
	late final _StringsTypesGameStatusEn gameStatus = _StringsTypesGameStatusEn._(_root);
	late final _StringsTypesGamePersonalEn gamePersonal = _StringsTypesGamePersonalEn._(_root);
	late final _StringsTypesGamePersonalBeatenEn gamePersonalBeaten = _StringsTypesGamePersonalBeatenEn._(_root);
	late final _StringsTypesGameHowLongToBeatEn gameHowLongToBeat = _StringsTypesGameHowLongToBeatEn._(_root);
	late final _StringsTypesGamesFilterPlatformsOperatorEn gamesFilterPlatformsOperator = _StringsTypesGamesFilterPlatformsOperatorEn._(_root);
	late final _StringsTypesGamesFilterBeatenOperatorEn gamesFilterBeatenOperator = _StringsTypesGamesFilterBeatenOperatorEn._(_root);
	late final _StringsTypesGamesFilterHowLongToBeatPredicateEn gamesFilterHowLongToBeatPredicate = _StringsTypesGamesFilterHowLongToBeatPredicateEn._(_root);
	late final _StringsTypesGamesFilterHowLongToBeatOperatorEn gamesFilterHowLongToBeatOperator = _StringsTypesGamesFilterHowLongToBeatOperatorEn._(_root);
	late final _StringsTypesGamesFilterHowLongToBeatFieldEn gamesFilterHowLongToBeatField = _StringsTypesGamesFilterHowLongToBeatFieldEn._(_root);
	late final _StringsTypesGamesFilterTagsOperatorEn gamesFilterTagsOperator = _StringsTypesGamesFilterTagsOperatorEn._(_root);
}

// Path: ui.general
class _StringsUiGeneralEn {
	_StringsUiGeneralEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get okButton => 'OK';
	String get cancelButton => 'Cancel';
	String get saveButton => 'Save';
	String get applyButton => 'Apply';
	String get deleteButton => 'Delete';
	String get errorText => 'Error';
	String get emptyText => 'Empty';
	String get noText => 'No';
	String get offText => 'Off';
	String get hoursText => 'Hours';
	String hoursCountText({required Object count}) => '${count} hours';
	String hoursCountShortText({required Object count}) => '${count}h';
	String get anyText => 'Any';
	String get confimationTitle => 'Confirmation';
	String get notificationTitle => 'Information';
	String get errorTitle => 'Error';
}

// Path: ui.homePage
class _StringsUiHomePageEn {
	_StringsUiHomePageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get settingsLink => 'Settings';
}

// Path: ui.gamesPage
class _StringsUiGamesPageEn {
	_StringsUiGamesPageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get addGameButton => 'Add new game';
	String get filterButton => 'Filter games';
	String get filterDialogTitle => 'Set Games Filter';
	String get filterPlatformsOperatorLabel => '${_root.types.game.platforms}';
	String get filterBeatenOperatorLabel => '${_root.types.gamePersonal.beaten}';
	String get filterHowLongToBeatOperatorLabel => '${_root.types.game.howLongToBeat}';
	String get filterHowLongToBeatFieldLabel => '${_root.types.gamesFilterHowLongToBeatPredicate.field}';
	String get filterTagsOperatorLabel => '${_root.types.game.tags}';
	String get saveViewButton => 'Save current view as...';
	String get saveViewDialogTitle => 'Save view';
	String get saveViewDialogIndexLabel => '#';
	String get saveViewDialogNameLabel => 'Name';
	String get searchPlaceholder => 'Search...';
	String gamesTotalText({required Object count}) => 'Games total: ${count}';
	String get defaultGameTitle => 'New game';
	String get defaultGamesViewName => 'New view';
	String get presetNameLabel => 'Preset';
	String get presetNamePlaceholder => 'Preset Name';
}

// Path: ui.gamePage
class _StringsUiGamePageEn {
	_StringsUiGamePageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get dialogTitle => 'Edit Game Information';
	String get addIncludedItemButton => 'Add Included Item';
	String get titleLabel => '${_root.types.game.title}:';
	String get titlePlaceholder => '${_root.types.game.title}';
	String get franchiseLabel => '${_root.types.game.franchise}:';
	String get franchisePlaceholder => '${_root.types.game.franchise}';
	String get editionLabel => '${_root.types.game.edition}:';
	String get editionPlaceholder => '${_root.types.game.edition}';
	String get yearLabel => '${_root.types.game.year}:';
	String get yearPlaceholder => '${_root.types.game.year}';
	String get thumbUrlLabel => '${_root.types.game.thumbUrl}:';
	String get thumbUrlPlaceholder => 'URL';
	String get kindLabel => '${_root.types.game.kind}:';
	String get platformsLabel => '${_root.types.game.platforms}:';
	String get statusLabel => '${_root.types.game.status}:';
	String get defaultIncludedGameTitle => 'New included game';
	String get deleteGameConfirmationMessage => 'This game will be deleted. Proceed?';
	String get defaultTag => 'sample tag';
}

// Path: ui.settingsPage
class _StringsUiSettingsPageEn {
	_StringsUiSettingsPageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get settingsTitle => 'Settings';
	String get importFromJsonButton => 'Import from JSON';
	String get importFromJsonSuccessMessage => 'Import finished succesfully';
	String get exportToJsonButton => 'Export to JSON';
	String get exportToJsonSuccessMessage => 'Export finished succesfully';
	String get exportToJsonErrorMessage => 'Export failed';
	String get deleteAllGamesButton => 'Delete All Games';
	String get deleteAllGamesConfirmationMessage => 'All games will be deleted. Proceed?';
}

// Path: ui.gamePlatformsControl
class _StringsUiGamePlatformsControlEn {
	_StringsUiGamePlatformsControlEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => '${_root.types.game.platforms}:';
}

// Path: ui.gamePersonalControl
class _StringsUiGamePersonalControlEn {
	_StringsUiGamePersonalControlEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get headerLabel => '${_root.types.gamePersonal.beaten}:';
	String get beatenLabel => '${_root.types.gamePersonal.beaten}:';
	String get ratingLabel => '${_root.types.gamePersonal.rating}:';
	String get timeSpentLabel => '${_root.types.gamePersonal.timeSpent}:';
}

// Path: ui.gameHowLongToBeatControl
class _StringsUiGameHowLongToBeatControlEn {
	_StringsUiGameHowLongToBeatControlEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get headerLabel => '${_root.types.game.howLongToBeat}:';
	String storyLabel({required Object count}) => 'Story: ${_root.ui.general.hoursCountText(count: count)}';
	String storySidesLabel({required Object count}) => 'Story + Sides: ${_root.ui.general.hoursCountText(count: count)}';
	String completionistLabel({required Object count}) => 'Completionist: ${_root.ui.general.hoursCountText(count: count)}';
}

// Path: ui.gameStatusControl
class _StringsUiGameStatusControlEn {
	_StringsUiGameStatusControlEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get titleLabel => '${_root.types.game.status}:';
}

// Path: ui.gameTagsControl
class _StringsUiGameTagsControlEn {
	_StringsUiGameTagsControlEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => '${_root.types.game.tags}:';
	String get newTagPlaceholder => 'Enter new tag';
}

// Path: types.game
class _StringsTypesGameEn {
	_StringsTypesGameEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Title';
	String get franchise => 'Franchise';
	String get edition => 'Edition';
	String get year => 'Year';
	String get thumbUrl => 'Thumbnail URL';
	String get kind => 'Kind';
	String get platforms => 'Platforms';
	String get personal => 'Personal';
	String get howLongToBeat => 'HowLongToBeat';
	String get tags => 'Tags';
	String get status => 'Status';
}

// Path: types.gameKind
class _StringsTypesGameKindEn {
	_StringsTypesGameKindEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get none => 'Game';
	Map<String, String> get values => {
		'bundle': 'Bundle',
		'dlc': 'DLC/Expansion/Addon',
		'content': 'Content Pack',
	};
}

// Path: types.gamePlatform
class _StringsTypesGamePlatformEn {
	_StringsTypesGamePlatformEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get none => 'Generic';
	Map<String, String> get values => {
		'pc': 'PC/Mac',
		'mobile': 'Mobile',
		'megadrive': 'Sega MegaDrive',
		'saturn': 'Sega Saturn',
		'dreamcast': 'Sega Dreamcast',
		'nes': 'Nintendo NES',
		'snes': 'Nintendo SNES',
		'n64': 'Nintendo 64',
		'gamecube': 'Nintendo GameCube',
		'wii': 'Nintendo Wii',
		'wiiu': 'Nintendo Wii U',
		'swtch': 'Nintendo Switch',
		'gb': 'Nintedo GameBoy',
		'gba': 'Nintendo GameBoy Advance',
		'ds': 'Nintendo DS',
		'ds3': 'Nintendo 3DS',
		'ps': 'Sony PlayStation',
		'ps2': 'Sony PlayStation 2',
		'ps3': 'Sony PlayStation 3',
		'ps4': 'Sony PlayStation 4/Pro',
		'ps5': 'Sony PlayStation 5',
		'psp': 'Sony PSP',
		'psvita': 'Sony PS Vita',
		'xbox': 'Microsoft XBox',
		'xbox360': 'Microsoft XBox 360',
		'xboxone': 'Microsoft XBox One',
		'xboxseries': 'Microsoft XBox Series S/X',
	};
}

// Path: types.gamePlatformBrand
class _StringsTypesGamePlatformBrandEn {
	_StringsTypesGamePlatformBrandEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get none => 'None';
	Map<String, String> get values => {
		'sega': 'Sega',
		'nintendo': 'Nintedo',
		'sony': 'Sony',
		'microsoft': 'Microsoft',
	};
}

// Path: types.gameStatus
class _StringsTypesGameStatusEn {
	_StringsTypesGameStatusEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	Map<String, String> get values => {
		'backlog': 'Backlog',
		'playing': 'Playing',
		'finished': 'Finished',
		'wishlist': 'Wishlist',
	};
}

// Path: types.gamePersonal
class _StringsTypesGamePersonalEn {
	_StringsTypesGamePersonalEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get beaten => 'Beaten';
	String get rating => 'Rating';
	String get timeSpent => 'Time Spent';
}

// Path: types.gamePersonalBeaten
class _StringsTypesGamePersonalBeatenEn {
	_StringsTypesGamePersonalBeatenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get none => 'None';
	Map<String, String> get values => {
		'bronze': 'Bronze',
		'silver': 'Silver',
		'gold': 'Gold',
		'platinum': 'Platinum',
	};
}

// Path: types.gameHowLongToBeat
class _StringsTypesGameHowLongToBeatEn {
	_StringsTypesGameHowLongToBeatEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get story => 'Story';
	String get storySides => 'Story + Sides';
	String get completionist => 'Completionist';
}

// Path: types.gamesFilterPlatformsOperator
class _StringsTypesGamesFilterPlatformsOperatorEn {
	_StringsTypesGamesFilterPlatformsOperatorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	Map<String, String> get values => {
		'hasOneOf': 'Has one of',
		'hasNoneOf': 'Has none of',
		'equal': 'Exactly',
	};
}

// Path: types.gamesFilterBeatenOperator
class _StringsTypesGamesFilterBeatenOperatorEn {
	_StringsTypesGamesFilterBeatenOperatorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	Map<String, String> get values => {
		'equal': 'Equals to',
		'notEqual': 'Not equals to',
	};
}

// Path: types.gamesFilterHowLongToBeatPredicate
class _StringsTypesGamesFilterHowLongToBeatPredicateEn {
	_StringsTypesGamesFilterHowLongToBeatPredicateEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get field => 'Field';
}

// Path: types.gamesFilterHowLongToBeatOperator
class _StringsTypesGamesFilterHowLongToBeatOperatorEn {
	_StringsTypesGamesFilterHowLongToBeatOperatorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	Map<String, String> get values => {
		'less': 'Less than',
		'more': 'More than',
	};
}

// Path: types.gamesFilterHowLongToBeatField
class _StringsTypesGamesFilterHowLongToBeatFieldEn {
	_StringsTypesGamesFilterHowLongToBeatFieldEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	Map<String, String> get values => {
		'story': '${_root.types.gameHowLongToBeat.story}',
		'storySides': '${_root.types.gameHowLongToBeat.storySides}',
		'completionist': '${_root.types.gameHowLongToBeat.completionist}',
	};
}

// Path: types.gamesFilterTagsOperator
class _StringsTypesGamesFilterTagsOperatorEn {
	_StringsTypesGamesFilterTagsOperatorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	Map<String, String> get values => {
		'hasOneOf': 'Has one of',
		'hasNoneOf': 'Has none of',
		'equal': 'Exactly',
	};
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'ui.general.okButton': return 'OK';
			case 'ui.general.cancelButton': return 'Cancel';
			case 'ui.general.saveButton': return 'Save';
			case 'ui.general.applyButton': return 'Apply';
			case 'ui.general.deleteButton': return 'Delete';
			case 'ui.general.errorText': return 'Error';
			case 'ui.general.emptyText': return 'Empty';
			case 'ui.general.noText': return 'No';
			case 'ui.general.offText': return 'Off';
			case 'ui.general.hoursText': return 'Hours';
			case 'ui.general.hoursCountText': return ({required Object count}) => '${count} hours';
			case 'ui.general.hoursCountShortText': return ({required Object count}) => '${count}h';
			case 'ui.general.anyText': return 'Any';
			case 'ui.general.confimationTitle': return 'Confirmation';
			case 'ui.general.notificationTitle': return 'Information';
			case 'ui.general.errorTitle': return 'Error';
			case 'ui.homePage.settingsLink': return 'Settings';
			case 'ui.gamesPage.addGameButton': return 'Add new game';
			case 'ui.gamesPage.filterButton': return 'Filter games';
			case 'ui.gamesPage.filterDialogTitle': return 'Set Games Filter';
			case 'ui.gamesPage.filterPlatformsOperatorLabel': return '${_root.types.game.platforms}';
			case 'ui.gamesPage.filterBeatenOperatorLabel': return '${_root.types.gamePersonal.beaten}';
			case 'ui.gamesPage.filterHowLongToBeatOperatorLabel': return '${_root.types.game.howLongToBeat}';
			case 'ui.gamesPage.filterHowLongToBeatFieldLabel': return '${_root.types.gamesFilterHowLongToBeatPredicate.field}';
			case 'ui.gamesPage.filterTagsOperatorLabel': return '${_root.types.game.tags}';
			case 'ui.gamesPage.saveViewButton': return 'Save current view as...';
			case 'ui.gamesPage.saveViewDialogTitle': return 'Save view';
			case 'ui.gamesPage.saveViewDialogIndexLabel': return '#';
			case 'ui.gamesPage.saveViewDialogNameLabel': return 'Name';
			case 'ui.gamesPage.searchPlaceholder': return 'Search...';
			case 'ui.gamesPage.gamesTotalText': return ({required Object count}) => 'Games total: ${count}';
			case 'ui.gamesPage.defaultGameTitle': return 'New game';
			case 'ui.gamesPage.defaultGamesViewName': return 'New view';
			case 'ui.gamesPage.presetNameLabel': return 'Preset';
			case 'ui.gamesPage.presetNamePlaceholder': return 'Preset Name';
			case 'ui.gamePage.dialogTitle': return 'Edit Game Information';
			case 'ui.gamePage.addIncludedItemButton': return 'Add Included Item';
			case 'ui.gamePage.titleLabel': return '${_root.types.game.title}:';
			case 'ui.gamePage.titlePlaceholder': return '${_root.types.game.title}';
			case 'ui.gamePage.franchiseLabel': return '${_root.types.game.franchise}:';
			case 'ui.gamePage.franchisePlaceholder': return '${_root.types.game.franchise}';
			case 'ui.gamePage.editionLabel': return '${_root.types.game.edition}:';
			case 'ui.gamePage.editionPlaceholder': return '${_root.types.game.edition}';
			case 'ui.gamePage.yearLabel': return '${_root.types.game.year}:';
			case 'ui.gamePage.yearPlaceholder': return '${_root.types.game.year}';
			case 'ui.gamePage.thumbUrlLabel': return '${_root.types.game.thumbUrl}:';
			case 'ui.gamePage.thumbUrlPlaceholder': return 'URL';
			case 'ui.gamePage.kindLabel': return '${_root.types.game.kind}:';
			case 'ui.gamePage.platformsLabel': return '${_root.types.game.platforms}:';
			case 'ui.gamePage.statusLabel': return '${_root.types.game.status}:';
			case 'ui.gamePage.defaultIncludedGameTitle': return 'New included game';
			case 'ui.gamePage.deleteGameConfirmationMessage': return 'This game will be deleted. Proceed?';
			case 'ui.gamePage.defaultTag': return 'sample tag';
			case 'ui.settingsPage.settingsTitle': return 'Settings';
			case 'ui.settingsPage.importFromJsonButton': return 'Import from JSON';
			case 'ui.settingsPage.importFromJsonSuccessMessage': return 'Import finished succesfully';
			case 'ui.settingsPage.exportToJsonButton': return 'Export to JSON';
			case 'ui.settingsPage.exportToJsonSuccessMessage': return 'Export finished succesfully';
			case 'ui.settingsPage.exportToJsonErrorMessage': return 'Export failed';
			case 'ui.settingsPage.deleteAllGamesButton': return 'Delete All Games';
			case 'ui.settingsPage.deleteAllGamesConfirmationMessage': return 'All games will be deleted. Proceed?';
			case 'ui.gamePlatformsControl.title': return '${_root.types.game.platforms}:';
			case 'ui.gamePersonalControl.headerLabel': return '${_root.types.gamePersonal.beaten}:';
			case 'ui.gamePersonalControl.beatenLabel': return '${_root.types.gamePersonal.beaten}:';
			case 'ui.gamePersonalControl.ratingLabel': return '${_root.types.gamePersonal.rating}:';
			case 'ui.gamePersonalControl.timeSpentLabel': return '${_root.types.gamePersonal.timeSpent}:';
			case 'ui.gameHowLongToBeatControl.headerLabel': return '${_root.types.game.howLongToBeat}:';
			case 'ui.gameHowLongToBeatControl.storyLabel': return ({required Object count}) => 'Story: ${_root.ui.general.hoursCountText(count: count)}';
			case 'ui.gameHowLongToBeatControl.storySidesLabel': return ({required Object count}) => 'Story + Sides: ${_root.ui.general.hoursCountText(count: count)}';
			case 'ui.gameHowLongToBeatControl.completionistLabel': return ({required Object count}) => 'Completionist: ${_root.ui.general.hoursCountText(count: count)}';
			case 'ui.gameStatusControl.titleLabel': return '${_root.types.game.status}:';
			case 'ui.gameTagsControl.title': return '${_root.types.game.tags}:';
			case 'ui.gameTagsControl.newTagPlaceholder': return 'Enter new tag';
			case 'types.game.title': return 'Title';
			case 'types.game.franchise': return 'Franchise';
			case 'types.game.edition': return 'Edition';
			case 'types.game.year': return 'Year';
			case 'types.game.thumbUrl': return 'Thumbnail URL';
			case 'types.game.kind': return 'Kind';
			case 'types.game.platforms': return 'Platforms';
			case 'types.game.personal': return 'Personal';
			case 'types.game.howLongToBeat': return 'HowLongToBeat';
			case 'types.game.tags': return 'Tags';
			case 'types.game.status': return 'Status';
			case 'types.gameKind.none': return 'Game';
			case 'types.gameKind.values.bundle': return 'Bundle';
			case 'types.gameKind.values.dlc': return 'DLC/Expansion/Addon';
			case 'types.gameKind.values.content': return 'Content Pack';
			case 'types.gamePlatform.none': return 'Generic';
			case 'types.gamePlatform.values.pc': return 'PC/Mac';
			case 'types.gamePlatform.values.mobile': return 'Mobile';
			case 'types.gamePlatform.values.megadrive': return 'Sega MegaDrive';
			case 'types.gamePlatform.values.saturn': return 'Sega Saturn';
			case 'types.gamePlatform.values.dreamcast': return 'Sega Dreamcast';
			case 'types.gamePlatform.values.nes': return 'Nintendo NES';
			case 'types.gamePlatform.values.snes': return 'Nintendo SNES';
			case 'types.gamePlatform.values.n64': return 'Nintendo 64';
			case 'types.gamePlatform.values.gamecube': return 'Nintendo GameCube';
			case 'types.gamePlatform.values.wii': return 'Nintendo Wii';
			case 'types.gamePlatform.values.wiiu': return 'Nintendo Wii U';
			case 'types.gamePlatform.values.swtch': return 'Nintendo Switch';
			case 'types.gamePlatform.values.gb': return 'Nintedo GameBoy';
			case 'types.gamePlatform.values.gba': return 'Nintendo GameBoy Advance';
			case 'types.gamePlatform.values.ds': return 'Nintendo DS';
			case 'types.gamePlatform.values.ds3': return 'Nintendo 3DS';
			case 'types.gamePlatform.values.ps': return 'Sony PlayStation';
			case 'types.gamePlatform.values.ps2': return 'Sony PlayStation 2';
			case 'types.gamePlatform.values.ps3': return 'Sony PlayStation 3';
			case 'types.gamePlatform.values.ps4': return 'Sony PlayStation 4/Pro';
			case 'types.gamePlatform.values.ps5': return 'Sony PlayStation 5';
			case 'types.gamePlatform.values.psp': return 'Sony PSP';
			case 'types.gamePlatform.values.psvita': return 'Sony PS Vita';
			case 'types.gamePlatform.values.xbox': return 'Microsoft XBox';
			case 'types.gamePlatform.values.xbox360': return 'Microsoft XBox 360';
			case 'types.gamePlatform.values.xboxone': return 'Microsoft XBox One';
			case 'types.gamePlatform.values.xboxseries': return 'Microsoft XBox Series S/X';
			case 'types.gamePlatformBrand.none': return 'None';
			case 'types.gamePlatformBrand.values.sega': return 'Sega';
			case 'types.gamePlatformBrand.values.nintendo': return 'Nintedo';
			case 'types.gamePlatformBrand.values.sony': return 'Sony';
			case 'types.gamePlatformBrand.values.microsoft': return 'Microsoft';
			case 'types.gameStatus.values.backlog': return 'Backlog';
			case 'types.gameStatus.values.playing': return 'Playing';
			case 'types.gameStatus.values.finished': return 'Finished';
			case 'types.gameStatus.values.wishlist': return 'Wishlist';
			case 'types.gamePersonal.beaten': return 'Beaten';
			case 'types.gamePersonal.rating': return 'Rating';
			case 'types.gamePersonal.timeSpent': return 'Time Spent';
			case 'types.gamePersonalBeaten.none': return 'None';
			case 'types.gamePersonalBeaten.values.bronze': return 'Bronze';
			case 'types.gamePersonalBeaten.values.silver': return 'Silver';
			case 'types.gamePersonalBeaten.values.gold': return 'Gold';
			case 'types.gamePersonalBeaten.values.platinum': return 'Platinum';
			case 'types.gameHowLongToBeat.story': return 'Story';
			case 'types.gameHowLongToBeat.storySides': return 'Story + Sides';
			case 'types.gameHowLongToBeat.completionist': return 'Completionist';
			case 'types.gamesFilterPlatformsOperator.values.hasOneOf': return 'Has one of';
			case 'types.gamesFilterPlatformsOperator.values.hasNoneOf': return 'Has none of';
			case 'types.gamesFilterPlatformsOperator.values.equal': return 'Exactly';
			case 'types.gamesFilterBeatenOperator.values.equal': return 'Equals to';
			case 'types.gamesFilterBeatenOperator.values.notEqual': return 'Not equals to';
			case 'types.gamesFilterHowLongToBeatPredicate.field': return 'Field';
			case 'types.gamesFilterHowLongToBeatOperator.values.less': return 'Less than';
			case 'types.gamesFilterHowLongToBeatOperator.values.more': return 'More than';
			case 'types.gamesFilterHowLongToBeatField.values.story': return '${_root.types.gameHowLongToBeat.story}';
			case 'types.gamesFilterHowLongToBeatField.values.storySides': return '${_root.types.gameHowLongToBeat.storySides}';
			case 'types.gamesFilterHowLongToBeatField.values.completionist': return '${_root.types.gameHowLongToBeat.completionist}';
			case 'types.gamesFilterTagsOperator.values.hasOneOf': return 'Has one of';
			case 'types.gamesFilterTagsOperator.values.hasNoneOf': return 'Has none of';
			case 'types.gamesFilterTagsOperator.values.equal': return 'Exactly';
			default: return null;
		}
	}
}
