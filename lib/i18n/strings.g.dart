/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 1
/// Strings: 74
///
/// Built on 2024-03-02 at 05:33 UTC

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
	late final _StringsUiGamePersonalControlEn gamePersonalControl = _StringsUiGamePersonalControlEn._(_root);
	late final _StringsUiGameHowLongToBeatControlEn gameHowLongToBeatControl = _StringsUiGameHowLongToBeatControlEn._(_root);
}

// Path: types
class _StringsTypesEn {
	_StringsTypesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsTypesGameEn game = _StringsTypesGameEn._(_root);
	late final _StringsTypesGameKindEn gameKind = _StringsTypesGameKindEn._(_root);
	late final _StringsTypesGameStatusEn gameStatus = _StringsTypesGameStatusEn._(_root);
	late final _StringsTypesGamePersonalEn gamePersonal = _StringsTypesGamePersonalEn._(_root);
	late final _StringsTypesGamePersonalBeatenEn gamePersonalBeaten = _StringsTypesGamePersonalBeatenEn._(_root);
	late final _StringsTypesGameHowLongToBeatEn gameHowLongToBeat = _StringsTypesGameHowLongToBeatEn._(_root);
}

// Path: ui.general
class _StringsUiGeneralEn {
	_StringsUiGeneralEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get okButton => 'OK';
	String get cancelButton => 'Cancel';
	String get saveButton => 'Save';
	String get deleteButton => 'Delete';
	String get errorText => 'Error';
	String get emptyText => 'Empty';
	String get hoursText => 'Hours';
	String hoursCountText({required Object count}) => '${count} hours';
	String hoursCountShortText({required Object count}) => '${count} h.';
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
	String get addGameButton => 'Add Game';
	String get searchPlaceholder => 'Search...';
	String gamesTotalText({required Object count}) => 'Games total: ${count}';
	String get defaultGameTitle => 'New game';
}

// Path: ui.gamePage
class _StringsUiGamePageEn {
	_StringsUiGamePageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
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
	String get kindBundleLabel => '${_root.types.gameKind.bundle}';
	String get platformsLabel => '${_root.types.game.platforms}:';
	String get statusLabel => '${_root.types.game.status}:';
	String get defaultIncludedGameTitle => 'New included game';
	String get deleteGameConfirmationMessage => 'This game will be deleted. Proceed?';
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
	String get deleteAllGamesButton => 'Delete All Games';
	String get deleteAllGamesConfirmationMessage => 'All games will be deleted. Proceed?';
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
	String storyLabel({required Object count}) => 'S: ${_root.ui.general.hoursCountShortText(count: count)}';
	String storySidesLabel({required Object count}) => 'S+S: ${_root.ui.general.hoursCountShortText(count: count)}';
	String completionistLabel({required Object count}) => 'C: ${_root.ui.general.hoursCountShortText(count: count)}';
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
	String get howLongToBeat => 'HowLongToBeat';
	String get status => 'Status';
}

// Path: types.gameKind
class _StringsTypesGameKindEn {
	_StringsTypesGameKindEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get none => 'Game';
	String get bundle => 'Bundle';
	String get dlc => 'DLC/Expansion/Addon';
	String get content => 'Content Pack';
}

// Path: types.gameStatus
class _StringsTypesGameStatusEn {
	_StringsTypesGameStatusEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get backlog => 'Backlog';
	String get playing => 'Playing';
	String get finished => 'Finished';
	String get wishlist => 'Wishlist';
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
	String get none => 'No';
	String get bronze => 'Bronze';
	String get silver => 'Silver';
	String get gold => 'Gold';
	String get platinum => 'Platinum';
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

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'ui.general.okButton': return 'OK';
			case 'ui.general.cancelButton': return 'Cancel';
			case 'ui.general.saveButton': return 'Save';
			case 'ui.general.deleteButton': return 'Delete';
			case 'ui.general.errorText': return 'Error';
			case 'ui.general.emptyText': return 'Empty';
			case 'ui.general.hoursText': return 'Hours';
			case 'ui.general.hoursCountText': return ({required Object count}) => '${count} hours';
			case 'ui.general.hoursCountShortText': return ({required Object count}) => '${count} h.';
			case 'ui.homePage.settingsLink': return 'Settings';
			case 'ui.gamesPage.addGameButton': return 'Add Game';
			case 'ui.gamesPage.searchPlaceholder': return 'Search...';
			case 'ui.gamesPage.gamesTotalText': return ({required Object count}) => 'Games total: ${count}';
			case 'ui.gamesPage.defaultGameTitle': return 'New game';
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
			case 'ui.gamePage.kindBundleLabel': return '${_root.types.gameKind.bundle}';
			case 'ui.gamePage.platformsLabel': return '${_root.types.game.platforms}:';
			case 'ui.gamePage.statusLabel': return '${_root.types.game.status}:';
			case 'ui.gamePage.defaultIncludedGameTitle': return 'New included game';
			case 'ui.gamePage.deleteGameConfirmationMessage': return 'This game will be deleted. Proceed?';
			case 'ui.settingsPage.settingsTitle': return 'Settings';
			case 'ui.settingsPage.importFromJsonButton': return 'Import from JSON';
			case 'ui.settingsPage.importFromJsonSuccessMessage': return 'Import finished succesfully';
			case 'ui.settingsPage.exportToJsonButton': return 'Export to JSON';
			case 'ui.settingsPage.exportToJsonSuccessMessage': return 'Export finished succesfully';
			case 'ui.settingsPage.deleteAllGamesButton': return 'Delete All Games';
			case 'ui.settingsPage.deleteAllGamesConfirmationMessage': return 'All games will be deleted. Proceed?';
			case 'ui.gamePersonalControl.headerLabel': return '${_root.types.gamePersonal.beaten}:';
			case 'ui.gamePersonalControl.beatenLabel': return '${_root.types.gamePersonal.beaten}:';
			case 'ui.gamePersonalControl.ratingLabel': return '${_root.types.gamePersonal.rating}:';
			case 'ui.gamePersonalControl.timeSpentLabel': return '${_root.types.gamePersonal.timeSpent}:';
			case 'ui.gameHowLongToBeatControl.headerLabel': return '${_root.types.game.howLongToBeat}:';
			case 'ui.gameHowLongToBeatControl.storyLabel': return ({required Object count}) => 'S: ${_root.ui.general.hoursCountShortText(count: count)}';
			case 'ui.gameHowLongToBeatControl.storySidesLabel': return ({required Object count}) => 'S+S: ${_root.ui.general.hoursCountShortText(count: count)}';
			case 'ui.gameHowLongToBeatControl.completionistLabel': return ({required Object count}) => 'C: ${_root.ui.general.hoursCountShortText(count: count)}';
			case 'types.game.title': return 'Title';
			case 'types.game.franchise': return 'Franchise';
			case 'types.game.edition': return 'Edition';
			case 'types.game.year': return 'Year';
			case 'types.game.thumbUrl': return 'Thumbnail URL';
			case 'types.game.kind': return 'Kind';
			case 'types.game.platforms': return 'Platforms';
			case 'types.game.howLongToBeat': return 'HowLongToBeat';
			case 'types.game.status': return 'Status';
			case 'types.gameKind.none': return 'Game';
			case 'types.gameKind.bundle': return 'Bundle';
			case 'types.gameKind.dlc': return 'DLC/Expansion/Addon';
			case 'types.gameKind.content': return 'Content Pack';
			case 'types.gameStatus.backlog': return 'Backlog';
			case 'types.gameStatus.playing': return 'Playing';
			case 'types.gameStatus.finished': return 'Finished';
			case 'types.gameStatus.wishlist': return 'Wishlist';
			case 'types.gamePersonal.beaten': return 'Beaten';
			case 'types.gamePersonal.rating': return 'Rating';
			case 'types.gamePersonal.timeSpent': return 'Time Spent';
			case 'types.gamePersonalBeaten.none': return 'No';
			case 'types.gamePersonalBeaten.bronze': return 'Bronze';
			case 'types.gamePersonalBeaten.silver': return 'Silver';
			case 'types.gamePersonalBeaten.gold': return 'Gold';
			case 'types.gamePersonalBeaten.platinum': return 'Platinum';
			case 'types.gameHowLongToBeat.story': return 'Story';
			case 'types.gameHowLongToBeat.storySides': return 'Story + Sides';
			case 'types.gameHowLongToBeat.completionist': return 'Completionist';
			default: return null;
		}
	}
}
