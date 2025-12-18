///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsJa = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ja,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ja>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsCommonJa common = TranslationsCommonJa._(_root);
	late final TranslationsTermsAgreementJa termsAgreement = TranslationsTermsAgreementJa._(_root);
	late final TranslationsDrawerJa drawer = TranslationsDrawerJa._(_root);
	late final TranslationsLoginJa login = TranslationsLoginJa._(_root);
	late final TranslationsFriendsJa friends = TranslationsFriendsJa._(_root);
	late final TranslationsFriendDetailJa friendDetail = TranslationsFriendDetailJa._(_root);
	late final TranslationsSearchJa search = TranslationsSearchJa._(_root);
	late final TranslationsProfileJa profile = TranslationsProfileJa._(_root);
	late final TranslationsEngageCardJa engageCard = TranslationsEngageCardJa._(_root);
	late final TranslationsQrScannerJa qrScanner = TranslationsQrScannerJa._(_root);
	late final TranslationsFavoritesJa favorites = TranslationsFavoritesJa._(_root);
	late final TranslationsNotificationsJa notifications = TranslationsNotificationsJa._(_root);
	late final TranslationsEventCalendarJa eventCalendar = TranslationsEventCalendarJa._(_root);
	late final TranslationsAvatarsJa avatars = TranslationsAvatarsJa._(_root);
	late final TranslationsWorldDetailJa worldDetail = TranslationsWorldDetailJa._(_root);
	late final TranslationsAvatarDetailJa avatarDetail = TranslationsAvatarDetailJa._(_root);
	late final TranslationsGroupsJa groups = TranslationsGroupsJa._(_root);
	late final TranslationsGroupDetailJa groupDetail = TranslationsGroupDetailJa._(_root);
	late final TranslationsInventoryJa inventory = TranslationsInventoryJa._(_root);
	late final TranslationsVrcnsyncJa vrcnsync = TranslationsVrcnsyncJa._(_root);
	late final TranslationsFeedbackJa feedback = TranslationsFeedbackJa._(_root);
	late final TranslationsSettingsJa settings = TranslationsSettingsJa._(_root);
	late final TranslationsCreditsJa credits = TranslationsCreditsJa._(_root);
	late final TranslationsDownloadJa download = TranslationsDownloadJa._(_root);
	late final TranslationsInstanceJa instance = TranslationsInstanceJa._(_root);
	late final TranslationsStatusJa status = TranslationsStatusJa._(_root);
	late final TranslationsLocationJa location = TranslationsLocationJa._(_root);
	late final TranslationsReminderJa reminder = TranslationsReminderJa._(_root);
	late final TranslationsFriendJa friend = TranslationsFriendJa._(_root);
	late final TranslationsEventCalendarFilterJa eventCalendarFilter = TranslationsEventCalendarFilterJa._(_root);
}

// Path: common
class TranslationsCommonJa {
	TranslationsCommonJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'VRCN'
	String get title => 'VRCN';

	/// ja: 'OK'
	String get ok => 'OK';

	/// ja: 'キャンセル'
	String get cancel => 'キャンセル';

	/// ja: '閉じる'
	String get close => '閉じる';

	/// ja: '保存'
	String get save => '保存';

	/// ja: '編集'
	String get edit => '編集';

	/// ja: '削除'
	String get delete => '削除';

	/// ja: 'はい'
	String get yes => 'はい';

	/// ja: 'いいえ'
	String get no => 'いいえ';

	/// ja: '読み込み中...'
	String get loading => '読み込み中...';

	/// ja: 'エラーが発生しました: ${error}'
	String error({required Object error}) => 'エラーが発生しました: ${error}';

	/// ja: 'エラーが発生しました'
	String get errorNomessage => 'エラーが発生しました';

	/// ja: '再試行'
	String get retry => '再試行';

	/// ja: '検索'
	String get search => '検索';

	/// ja: '設定'
	String get settings => '設定';

	/// ja: '確認'
	String get confirm => '確認';

	/// ja: '同意する'
	String get agree => '同意する';

	/// ja: '同意しない'
	String get decline => '同意しない';

	/// ja: 'ユーザー名'
	String get username => 'ユーザー名';

	/// ja: 'パスワード'
	String get password => 'パスワード';

	/// ja: 'ログイン'
	String get login => 'ログイン';

	/// ja: 'ログアウト'
	String get logout => 'ログアウト';

	/// ja: '共有'
	String get share => '共有';
}

// Path: termsAgreement
class TranslationsTermsAgreementJa {
	TranslationsTermsAgreementJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'VRCN へようこそ'
	String get welcomeTitle => 'VRCN へようこそ';

	/// ja: 'アプリをご利用いただく前に 利用規約とプライバシーポリシーをご確認ください'
	String get welcomeMessage => 'アプリをご利用いただく前に\n利用規約とプライバシーポリシーをご確認ください';

	/// ja: '利用規約'
	String get termsTitle => '利用規約';

	/// ja: 'アプリのご利用条件について'
	String get termsSubtitle => 'アプリのご利用条件について';

	/// ja: 'プライバシーポリシー'
	String get privacyTitle => 'プライバシーポリシー';

	/// ja: '個人情報の取り扱いについて'
	String get privacySubtitle => '個人情報の取り扱いについて';

	/// ja: '「${title}」に同意する'
	String agreeTerms({required Object title}) => '「${title}」に同意する';

	/// ja: '内容を確認'
	String get checkContent => '内容を確認';

	/// ja: 'このアプリはVRChat Inc.の非公式アプリです。 VRChat Inc.とは一切関係ありません。'
	String get notice => 'このアプリはVRChat Inc.の非公式アプリです。\nVRChat Inc.とは一切関係ありません。';
}

// Path: drawer
class TranslationsDrawerJa {
	TranslationsDrawerJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'ホーム'
	String get home => 'ホーム';

	/// ja: 'プロフィール'
	String get profile => 'プロフィール';

	/// ja: 'お気に入り'
	String get favorite => 'お気に入り';

	/// ja: 'イベントカレンダー'
	String get eventCalendar => 'イベントカレンダー';

	/// ja: 'アバター'
	String get avatar => 'アバター';

	/// ja: 'グループ'
	String get group => 'グループ';

	/// ja: 'インベントリ'
	String get inventory => 'インベントリ';

	/// ja: 'VRCNSync (β)'
	String get vrcnsync => 'VRCNSync (β)';

	/// ja: 'レビュー'
	String get review => 'レビュー';

	/// ja: 'フィードバック'
	String get feedback => 'フィードバック';

	/// ja: '設定'
	String get settings => '設定';

	/// ja: 'ユーザー情報を読み込み中...'
	String get userLoading => 'ユーザー情報を読み込み中...';

	/// ja: 'ユーザー情報の取得に失敗しました'
	String get userError => 'ユーザー情報の取得に失敗しました';

	/// ja: '再試行'
	String get retry => '再試行';

	late final TranslationsDrawerSectionJa section = TranslationsDrawerSectionJa._(_root);
}

// Path: login
class TranslationsLoginJa {
	TranslationsLoginJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'パスワードを忘れた場合'
	String get forgotPassword => 'パスワードを忘れた場合';

	/// ja: 'アカウントを作成'
	String get createAccount => 'アカウントを作成';

	/// ja: 'VRChatのアカウント情報でログイン'
	String get subtitle => 'VRChatのアカウント情報でログイン';

	/// ja: 'メールアドレス'
	String get email => 'メールアドレス';

	/// ja: 'メールまたはユーザー名を入力'
	String get emailHint => 'メールまたはユーザー名を入力';

	/// ja: 'パスワードを入力'
	String get passwordHint => 'パスワードを入力';

	/// ja: 'ログイン状態を保存'
	String get rememberMe => 'ログイン状態を保存';

	/// ja: 'ログイン中...'
	String get loggingIn => 'ログイン中...';

	/// ja: 'ユーザー名またはメールアドレスを入力してください'
	String get errorEmptyEmail => 'ユーザー名またはメールアドレスを入力してください';

	/// ja: 'パスワードを入力してください'
	String get errorEmptyPassword => 'パスワードを入力してください';

	/// ja: 'ログインに失敗しました。メールアドレスとパスワードを確認してください。'
	String get errorLoginFailed => 'ログインに失敗しました。メールアドレスとパスワードを確認してください。';

	/// ja: '二段階認証'
	String get twoFactorTitle => '二段階認証';

	/// ja: '認証コードを入力してください'
	String get twoFactorSubtitle => '認証コードを入力してください';

	/// ja: '認証アプリに表示されている 6桁のコードを入力してください'
	String get twoFactorInstruction => '認証アプリに表示されている\n6桁のコードを入力してください';

	/// ja: '認証コード'
	String get twoFactorCodeHint => '認証コード';

	/// ja: '認証'
	String get verify => '認証';

	/// ja: '認証中...'
	String get verifying => '認証中...';

	/// ja: '認証コードを入力してください'
	String get errorEmpty2fa => '認証コードを入力してください';

	/// ja: '二段階認証に失敗しました。コードが正しいか確認してください。'
	String get error2faFailed => '二段階認証に失敗しました。コードが正しいか確認してください。';

	/// ja: 'ログイン画面に戻る'
	String get backToLogin => 'ログイン画面に戻る';

	/// ja: 'ペースト'
	String get paste => 'ペースト';
}

// Path: friends
class TranslationsFriendsJa {
	TranslationsFriendsJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'フレンド情報を読み込み中...'
	String get loading => 'フレンド情報を読み込み中...';

	/// ja: 'フレンドの情報の取得に失敗しました: ${error}'
	String error({required Object error}) => 'フレンドの情報の取得に失敗しました: ${error}';

	/// ja: 'フレンドが見つかりませんでした'
	String get notFound => 'フレンドが見つかりませんでした';

	/// ja: 'プライベート'
	String get private => 'プライベート';

	/// ja: 'アクティブ'
	String get active => 'アクティブ';

	/// ja: 'オフライン'
	String get offline => 'オフライン';

	/// ja: 'オンライン'
	String get online => 'オンライン';

	/// ja: 'ワールドごとにグループ化'
	String get groupTitle => 'ワールドごとにグループ化';

	/// ja: '更新'
	String get refresh => '更新';

	/// ja: 'フレンド名で検索'
	String get searchHint => 'フレンド名で検索';

	/// ja: '該当するフレンドはいません'
	String get noResult => '該当するフレンドはいません';
}

// Path: friendDetail
class TranslationsFriendDetailJa {
	TranslationsFriendDetailJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'ユーザー情報を読み込み中...'
	String get loading => 'ユーザー情報を読み込み中...';

	/// ja: 'ユーザー情報の取得に失敗しました: ${error}'
	String error({required Object error}) => 'ユーザー情報の取得に失敗しました: ${error}';

	/// ja: '現在の場所'
	String get currentLocation => '現在の場所';

	/// ja: '基本情報'
	String get basicInfo => '基本情報';

	/// ja: 'ユーザーID'
	String get userId => 'ユーザーID';

	/// ja: '登録日'
	String get dateJoined => '登録日';

	/// ja: '最終ログイン'
	String get lastLogin => '最終ログイン';

	/// ja: '自己紹介'
	String get bio => '自己紹介';

	/// ja: 'リンク'
	String get links => 'リンク';

	/// ja: 'リンク情報を読み込み中...'
	String get loadingLinks => 'リンク情報を読み込み中...';

	/// ja: '所属グループ'
	String get group => '所属グループ';

	/// ja: 'グループ詳細を表示'
	String get groupDetail => 'グループ詳細を表示';

	/// ja: 'グループコード: ${code}'
	String groupCode({required Object code}) => 'グループコード: ${code}';

	/// ja: 'メンバー数: ${count}人'
	String memberCount({required Object count}) => 'メンバー数: ${count}人';

	/// ja: '不明なグループ'
	String get unknownGroup => '不明なグループ';

	/// ja: 'ブロック'
	String get block => 'ブロック';

	/// ja: 'ミュート'
	String get mute => 'ミュート';

	/// ja: 'ウェブサイトで開く'
	String get openWebsite => 'ウェブサイトで開く';

	/// ja: 'プロフィールを共有'
	String get shareProfile => 'プロフィールを共有';

	/// ja: '${name}をブロックしますか？'
	String confirmBlockTitle({required Object name}) => '${name}をブロックしますか？';

	/// ja: 'ブロックすると、このユーザーからのフレンド申請やメッセージを受け取らなくなります。'
	String get confirmBlockMessage => 'ブロックすると、このユーザーからのフレンド申請やメッセージを受け取らなくなります。';

	/// ja: '${name}をミュートしますか？'
	String confirmMuteTitle({required Object name}) => '${name}をミュートしますか？';

	/// ja: 'ミュートすると、このユーザーの音声が聞こえなくなります。'
	String get confirmMuteMessage => 'ミュートすると、このユーザーの音声が聞こえなくなります。';

	/// ja: 'ブロックしました'
	String get blockSuccess => 'ブロックしました';

	/// ja: 'ミュートしました'
	String get muteSuccess => 'ミュートしました';

	/// ja: '操作に失敗しました: ${error}'
	String operationFailed({required Object error}) => '操作に失敗しました: ${error}';
}

// Path: search
class TranslationsSearchJa {
	TranslationsSearchJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'ユーザー'
	String get userTab => 'ユーザー';

	/// ja: 'ワールド'
	String get worldTab => 'ワールド';

	/// ja: 'アバター'
	String get avatarTab => 'アバター';

	/// ja: 'グループ'
	String get groupTab => 'グループ';

	late final TranslationsSearchTabsJa tabs = TranslationsSearchTabsJa._(_root);
}

// Path: profile
class TranslationsProfileJa {
	TranslationsProfileJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'プロフィール'
	String get title => 'プロフィール';

	/// ja: '編集'
	String get edit => '編集';

	/// ja: '更新'
	String get refresh => '更新';

	/// ja: 'プロフィール情報を読み込み中...'
	String get loading => 'プロフィール情報を読み込み中...';

	/// ja: 'プロフィール情報の取得に失敗しました: {error}'
	String get error => 'プロフィール情報の取得に失敗しました: {error}';

	/// ja: '表示名'
	String get displayName => '表示名';

	/// ja: 'ユーザー名'
	String get username => 'ユーザー名';

	/// ja: 'ユーザーID'
	String get userId => 'ユーザーID';

	/// ja: 'エンゲージカード'
	String get engageCard => 'エンゲージカード';

	/// ja: 'フレンド'
	String get frined => 'フレンド';

	/// ja: '登録日'
	String get dateJoined => '登録日';

	/// ja: 'ユーザータイプ'
	String get userType => 'ユーザータイプ';

	/// ja: 'ステータス'
	String get status => 'ステータス';

	/// ja: 'ステータスメッセージ'
	String get statusMessage => 'ステータスメッセージ';

	/// ja: '自己紹介'
	String get bio => '自己紹介';

	/// ja: 'リンク'
	String get links => 'リンク';

	/// ja: '所属グループ'
	String get group => '所属グループ';

	/// ja: 'グループ詳細を表示'
	String get groupDetail => 'グループ詳細を表示';

	/// ja: '現在のアバター'
	String get avatar => '現在のアバター';

	/// ja: 'アバター詳細を表示'
	String get avatarDetail => 'アバター詳細を表示';

	/// ja: '公開'
	String get public => '公開';

	/// ja: '非公開'
	String get private => '非公開';

	/// ja: '非表示'
	String get hidden => '非表示';

	/// ja: '不明'
	String get unknown => '不明';

	/// ja: 'フレンド'
	String get friends => 'フレンド';

	/// ja: 'リンク情報を読み込み中...'
	String get loadingLinks => 'リンク情報を読み込み中...';

	/// ja: '所属グループはありません'
	String get noGroup => '所属グループはありません';

	/// ja: '自己紹介はありません'
	String get noBio => '自己紹介はありません';

	/// ja: 'リンクはありません'
	String get noLinks => 'リンクはありません';

	/// ja: '変更を保存'
	String get save => '変更を保存';

	/// ja: 'プロフィールを更新しました'
	String get saved => 'プロフィールを更新しました';

	/// ja: '更新に失敗しました: {error}'
	String get saveFailed => '更新に失敗しました: {error}';

	/// ja: '変更を破棄しますか？'
	String get discardTitle => '変更を破棄しますか？';

	/// ja: 'プロフィールに加えた変更は保存されません。'
	String get discardContent => 'プロフィールに加えた変更は保存されません。';

	/// ja: 'キャンセル'
	String get discardCancel => 'キャンセル';

	/// ja: '破棄する'
	String get discardOk => '破棄する';

	/// ja: '基本情報'
	String get basic => '基本情報';

	/// ja: '代名詞'
	String get pronouns => '代名詞';

	/// ja: '追加'
	String get addLink => '追加';

	/// ja: '削除'
	String get removeLink => '削除';

	/// ja: 'リンクを入力 (例: https://twitter.com/username)'
	String get linkHint => 'リンクを入力 (例: https://twitter.com/username)';

	/// ja: 'リンクはプロフィールに表示され、タップすると開くことができます'
	String get linksHint => 'リンクはプロフィールに表示され、タップすると開くことができます';

	/// ja: 'あなたの今の状況やメッセージを入力'
	String get statusMessageHint => 'あなたの今の状況やメッセージを入力';

	/// ja: 'あなた自身について書いてみましょう'
	String get bioHint => 'あなた自身について書いてみましょう';
}

// Path: engageCard
class TranslationsEngageCardJa {
	TranslationsEngageCardJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '背景画像を選択'
	String get pickBackground => '背景画像を選択';

	/// ja: '背景画像を削除'
	String get removeBackground => '背景画像を削除';

	/// ja: 'QRコードをスキャン'
	String get scanQr => 'QRコードをスキャン';

	/// ja: 'アバターを表示'
	String get showAvatar => 'アバターを表示';

	/// ja: 'アバターを非表示'
	String get hideAvatar => 'アバターを非表示';

	/// ja: '背景画像が選択されていません 右上のボタンから設定できます'
	String get noBackground => '背景画像が選択されていません\n右上のボタンから設定できます';

	/// ja: '読み込み中...'
	String get loading => '読み込み中...';

	/// ja: 'エンゲージカード情報の取得に失敗しました: ${error}'
	String error({required Object error}) => 'エンゲージカード情報の取得に失敗しました: ${error}';

	/// ja: 'ユーザーIDをコピー'
	String get copyUserId => 'ユーザーIDをコピー';

	/// ja: 'コピーしました'
	String get copied => 'コピーしました';
}

// Path: qrScanner
class TranslationsQrScannerJa {
	TranslationsQrScannerJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'QRコードスキャン'
	String get title => 'QRコードスキャン';

	/// ja: 'QRコードを枠内に合わせてください'
	String get guide => 'QRコードを枠内に合わせてください';

	/// ja: 'カメラを初期化中...'
	String get loading => 'カメラを初期化中...';

	/// ja: 'QRコードの読み取りに失敗しました: ${error}'
	String error({required Object error}) => 'QRコードの読み取りに失敗しました: ${error}';

	/// ja: '有効なユーザーQRコードが見つかりません'
	String get notFound => '有効なユーザーQRコードが見つかりません';
}

// Path: favorites
class TranslationsFavoritesJa {
	TranslationsFavoritesJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'お気に入り'
	String get title => 'お気に入り';

	/// ja: 'フレンド'
	String get frined => 'フレンド';

	/// ja: 'フレンド'
	String get friendsTab => 'フレンド';

	/// ja: 'ワールド'
	String get worldsTab => 'ワールド';

	/// ja: 'アバター'
	String get avatarsTab => 'アバター';

	/// ja: 'お気に入りフォルダがありません'
	String get emptyFolderTitle => 'お気に入りフォルダがありません';

	/// ja: 'VRChat内でお気に入りフォルダを作成してください'
	String get emptyFolderDescription => 'VRChat内でお気に入りフォルダを作成してください';

	/// ja: 'このフォルダにはフレンドがいません'
	String get emptyFriends => 'このフォルダにはフレンドがいません';

	/// ja: 'このフォルダにはワールドがありません'
	String get emptyWorlds => 'このフォルダにはワールドがありません';

	/// ja: 'このフォルダにはアバターがありません'
	String get emptyAvatars => 'このフォルダにはアバターがありません';

	/// ja: 'お気に入りのワールドがありません'
	String get emptyWorldsTabTitle => 'お気に入りのワールドがありません';

	/// ja: 'ワールド詳細画面からお気に入りに登録できます'
	String get emptyWorldsTabDescription => 'ワールド詳細画面からお気に入りに登録できます';

	/// ja: 'お気に入りのアバターがありません'
	String get emptyAvatarsTabTitle => 'お気に入りのアバターがありません';

	/// ja: 'アバター詳細画面からお気に入りに登録できます'
	String get emptyAvatarsTabDescription => 'アバター詳細画面からお気に入りに登録できます';

	/// ja: 'お気に入りを読み込み中...'
	String get loading => 'お気に入りを読み込み中...';

	/// ja: 'フォルダ情報を読み込み中...'
	String get loadingFolder => 'フォルダ情報を読み込み中...';

	/// ja: 'お気に入りの読み込みに失敗しました: ${error}'
	String error({required Object error}) => 'お気に入りの読み込みに失敗しました: ${error}';

	/// ja: '情報の取得に失敗しました'
	String get errorFolder => '情報の取得に失敗しました';

	/// ja: 'お気に入りから削除'
	String get remove => 'お気に入りから削除';

	/// ja: '${name}をお気に入りから削除しました'
	String removeSuccess({required Object name}) => '${name}をお気に入りから削除しました';

	/// ja: '削除に失敗しました: ${error}'
	String removeFailed({required Object error}) => '削除に失敗しました: ${error}';

	/// ja: '${count} アイテム'
	String itemsCount({required Object count}) => '${count} アイテム';

	/// ja: '公開'
	String get public => '公開';

	/// ja: '非公開'
	String get private => '非公開';

	/// ja: '非表示'
	String get hidden => '非表示';

	/// ja: '不明'
	String get unknown => '不明';

	/// ja: '読み込みエラー'
	String get loadingError => '読み込みエラー';
}

// Path: notifications
class TranslationsNotificationsJa {
	TranslationsNotificationsJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '通知はありません'
	String get emptyTitle => '通知はありません';

	/// ja: 'フレンドリクエストや招待など 新しい通知がここに表示されます'
	String get emptyDescription => 'フレンドリクエストや招待など\n新しい通知がここに表示されます';

	/// ja: '${userName}さんからフレンドリクエストが届いています'
	String friendRequest({required Object userName}) => '${userName}さんからフレンドリクエストが届いています';

	/// ja: '${userName}さんから${worldName}への招待が届いています'
	String invite({required Object userName, required Object worldName}) => '${userName}さんから${worldName}への招待が届いています';

	/// ja: '${userName}さんがオンラインになりました'
	String friendOnline({required Object userName}) => '${userName}さんがオンラインになりました';

	/// ja: '${userName}さんがオフラインになりました'
	String friendOffline({required Object userName}) => '${userName}さんがオフラインになりました';

	/// ja: '${userName}さんがアクティブになりました'
	String friendActive({required Object userName}) => '${userName}さんがアクティブになりました';

	/// ja: '${userName}さんがフレンドに追加されました'
	String friendAdd({required Object userName}) => '${userName}さんがフレンドに追加されました';

	/// ja: '${userName}さんがフレンドから削除されました'
	String friendRemove({required Object userName}) => '${userName}さんがフレンドから削除されました';

	/// ja: '${userName}さんのステータスが更新されました: ${status}${world}'
	String statusUpdate({required Object userName, required Object status, required Object world}) => '${userName}さんのステータスが更新されました: ${status}${world}';

	/// ja: '${userName}さんが${worldName}に移動しました'
	String locationChange({required Object userName, required Object worldName}) => '${userName}さんが${worldName}に移動しました';

	/// ja: 'あなたの情報が更新されました${world}'
	String userUpdate({required Object world}) => 'あなたの情報が更新されました${world}';

	/// ja: 'あなたの移動: ${worldName}'
	String myLocationChange({required Object worldName}) => 'あなたの移動: ${worldName}';

	/// ja: '${userName}さんから参加リクエストが届いています'
	String requestInvite({required Object userName}) => '${userName}さんから参加リクエストが届いています';

	/// ja: '${userName}さんから投票キックがありました'
	String votekick({required Object userName}) => '${userName}さんから投票キックがありました';

	/// ja: '通知ID:${userName}の応答を受信しました'
	String responseReceived({required Object userName}) => '通知ID:${userName}の応答を受信しました';

	/// ja: 'エラー: ${worldName}'
	String error({required Object worldName}) => 'エラー: ${worldName}';

	/// ja: 'システム通知: ${extraData}'
	String system({required Object extraData}) => 'システム通知: ${extraData}';

	/// ja: '${seconds}秒前'
	String secondsAgo({required Object seconds}) => '${seconds}秒前';

	/// ja: '${minutes}分前'
	String minutesAgo({required Object minutes}) => '${minutes}分前';

	/// ja: '${hours}時間前'
	String hoursAgo({required Object hours}) => '${hours}時間前';
}

// Path: eventCalendar
class TranslationsEventCalendarJa {
	TranslationsEventCalendarJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'イベントカレンダー'
	String get title => 'イベントカレンダー';

	/// ja: 'イベントを絞り込む'
	String get filter => 'イベントを絞り込む';

	/// ja: 'イベント情報を更新'
	String get refresh => 'イベント情報を更新';

	/// ja: 'イベント情報を取得中...'
	String get loading => 'イベント情報を取得中...';

	/// ja: 'イベント情報の取得に失敗しました: ${error}'
	String error({required Object error}) => 'イベント情報の取得に失敗しました: ${error}';

	/// ja: 'フィルター適用中（${count}件）'
	String filterActive({required Object count}) => 'フィルター適用中（${count}件）';

	/// ja: 'クリア'
	String get clear => 'クリア';

	/// ja: '条件に一致するイベントがありません'
	String get noEvents => '条件に一致するイベントがありません';

	/// ja: 'フィルターをクリア'
	String get clearFilter => 'フィルターをクリア';

	/// ja: '今日'
	String get today => '今日';

	/// ja: 'リマインダーを設定'
	String get reminderSet => 'リマインダーを設定';

	/// ja: '設定済みリマインダー'
	String get reminderSetDone => '設定済みリマインダー';

	/// ja: 'リマインダーを削除しました'
	String get reminderDeleted => 'リマインダーを削除しました';

	/// ja: 'イベント名'
	String get eventName => 'イベント名';

	/// ja: '主催者'
	String get organizer => '主催者';

	/// ja: '説明'
	String get description => '説明';

	/// ja: 'ジャンル'
	String get genre => 'ジャンル';

	/// ja: '参加条件'
	String get condition => '参加条件';

	/// ja: '参加方法'
	String get way => '参加方法';

	/// ja: '備考'
	String get note => '備考';

	/// ja: 'Quest対応'
	String get quest => 'Quest対応';

	/// ja: '${count}件'
	String reminderCount({required Object count}) => '${count}件';

	/// ja: '${start}〜${end}'
	String startToEnd({required Object start, required Object end}) => '${start}〜${end}';
}

// Path: avatars
class TranslationsAvatarsJa {
	TranslationsAvatarsJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'アバター'
	String get title => 'アバター';

	/// ja: 'アバター名などで検索'
	String get searchHint => 'アバター名などで検索';

	/// ja: '検索'
	String get searchTooltip => '検索';

	/// ja: '検索結果が見つかりませんでした'
	String get searchEmptyTitle => '検索結果が見つかりませんでした';

	/// ja: '別の検索ワードをお試しください'
	String get searchEmptyDescription => '別の検索ワードをお試しください';

	/// ja: 'アバターがありません'
	String get emptyTitle => 'アバターがありません';

	/// ja: 'アバターを追加するか、後でもう一度お試しください'
	String get emptyDescription => 'アバターを追加するか、後でもう一度お試しください';

	/// ja: '更新する'
	String get refresh => '更新する';

	/// ja: 'アバターを読み込み中...'
	String get loading => 'アバターを読み込み中...';

	/// ja: 'アバター情報の取得に失敗しました: ${error}'
	String error({required Object error}) => 'アバター情報の取得に失敗しました: ${error}';

	/// ja: '使用中'
	String get current => '使用中';

	/// ja: '公開'
	String get public => '公開';

	/// ja: '非公開'
	String get private => '非公開';

	/// ja: '非表示'
	String get hidden => '非表示';

	/// ja: '作者'
	String get author => '作者';

	/// ja: '更新順'
	String get sortUpdated => '更新順';

	/// ja: '名前順'
	String get sortName => '名前順';

	/// ja: '並び替え'
	String get sortTooltip => '並び替え';

	/// ja: '表示モード切替'
	String get viewModeTooltip => '表示モード切替';
}

// Path: worldDetail
class TranslationsWorldDetailJa {
	TranslationsWorldDetailJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'ワールド情報を読み込み中...'
	String get loading => 'ワールド情報を読み込み中...';

	/// ja: 'ワールド情報の取得に失敗しました: ${error}'
	String error({required Object error}) => 'ワールド情報の取得に失敗しました: ${error}';

	/// ja: 'このワールドを共有'
	String get share => 'このワールドを共有';

	/// ja: 'VRChat公式サイトで開く'
	String get openInVRChat => 'VRChat公式サイトで開く';

	/// ja: 'このワールドを通報'
	String get report => 'このワールドを通報';

	/// ja: '作成者'
	String get creator => '作成者';

	/// ja: '作成'
	String get created => '作成';

	/// ja: '更新'
	String get updated => '更新';

	/// ja: 'お気に入り'
	String get favorites => 'お気に入り';

	/// ja: '訪問数'
	String get visits => '訪問数';

	/// ja: '現在の人数'
	String get occupants => '現在の人数';

	/// ja: '評価'
	String get popularity => '評価';

	/// ja: '説明'
	String get description => '説明';

	/// ja: '説明はありません'
	String get noDescription => '説明はありません';

	/// ja: 'タグ'
	String get tags => 'タグ';

	/// ja: 'パブリックで招待を送信'
	String get joinPublic => 'パブリックで招待を送信';

	/// ja: 'お気に入りに追加しました'
	String get favoriteAdded => 'お気に入りに追加しました';

	/// ja: 'お気に入りから削除しました'
	String get favoriteRemoved => 'お気に入りから削除しました';

	/// ja: '不明'
	String get unknown => '不明';
}

// Path: avatarDetail
class TranslationsAvatarDetailJa {
	TranslationsAvatarDetailJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'アバター「${name}」に変更しました'
	String changeSuccess({required Object name}) => 'アバター「${name}」に変更しました';

	/// ja: 'アバターの変更に失敗しました: ${error}'
	String changeFailed({required Object error}) => 'アバターの変更に失敗しました: ${error}';

	/// ja: '変更中...'
	String get changing => '変更中...';

	/// ja: 'このアバターを使用'
	String get useThisAvatar => 'このアバターを使用';

	/// ja: '作成者'
	String get creator => '作成者';

	/// ja: '作成'
	String get created => '作成';

	/// ja: '更新'
	String get updated => '更新';

	/// ja: '説明'
	String get description => '説明';

	/// ja: '説明はありません'
	String get noDescription => '説明はありません';

	/// ja: 'タグ'
	String get tags => 'タグ';

	/// ja: 'お気に入りに追加'
	String get addToFavorites => 'お気に入りに追加';

	/// ja: '公開'
	String get public => '公開';

	/// ja: '非公開'
	String get private => '非公開';

	/// ja: '非表示'
	String get hidden => '非表示';

	/// ja: '不明'
	String get unknown => '不明';

	/// ja: '共有'
	String get share => '共有';

	/// ja: 'アバター情報を読み込み中...'
	String get loading => 'アバター情報を読み込み中...';

	/// ja: 'アバター情報の取得に失敗しました: ${error}'
	String error({required Object error}) => 'アバター情報の取得に失敗しました: ${error}';
}

// Path: groups
class TranslationsGroupsJa {
	TranslationsGroupsJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'グループ'
	String get title => 'グループ';

	/// ja: 'ユーザー情報を読み込み中...'
	String get loadingUser => 'ユーザー情報を読み込み中...';

	/// ja: 'ユーザー情報の取得に失敗しました: ${error}'
	String errorUser({required Object error}) => 'ユーザー情報の取得に失敗しました: ${error}';

	/// ja: 'グループ情報を読み込み中...'
	String get loadingGroups => 'グループ情報を読み込み中...';

	/// ja: 'グループ情報の取得に失敗しました: ${error}'
	String errorGroups({required Object error}) => 'グループ情報の取得に失敗しました: ${error}';

	/// ja: 'グループに参加していません'
	String get emptyTitle => 'グループに参加していません';

	/// ja: 'VRChatアプリやウェブサイトからグループに参加できます'
	String get emptyDescription => 'VRChatアプリやウェブサイトからグループに参加できます';

	/// ja: 'グループを探す'
	String get searchGroups => 'グループを探す';

	/// ja: '${count}人のメンバー'
	String members({required Object count}) => '${count}人のメンバー';

	/// ja: '詳細を表示'
	String get showDetails => '詳細を表示';

	/// ja: '名称不明'
	String get unknownName => '名称不明';
}

// Path: groupDetail
class TranslationsGroupDetailJa {
	TranslationsGroupDetailJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'グループ情報を読み込み中...'
	String get loading => 'グループ情報を読み込み中...';

	/// ja: 'グループ情報の取得に失敗しました: ${error}'
	String error({required Object error}) => 'グループ情報の取得に失敗しました: ${error}';

	/// ja: 'グループ情報を共有'
	String get share => 'グループ情報を共有';

	/// ja: '説明'
	String get description => '説明';

	/// ja: 'ロール'
	String get roles => 'ロール';

	/// ja: '基本情報'
	String get basicInfo => '基本情報';

	/// ja: '作成日'
	String get createdAt => '作成日';

	/// ja: 'オーナー'
	String get owner => 'オーナー';

	/// ja: 'ルール'
	String get rules => 'ルール';

	/// ja: '言語'
	String get languages => '言語';

	/// ja: '${count} メンバー'
	String memberCount({required Object count}) => '${count} メンバー';

	late final TranslationsGroupDetailPrivacyJa privacy = TranslationsGroupDetailPrivacyJa._(_root);
	late final TranslationsGroupDetailRoleJa role = TranslationsGroupDetailRoleJa._(_root);
}

// Path: inventory
class TranslationsInventoryJa {
	TranslationsInventoryJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'インベントリ'
	String get title => 'インベントリ';

	/// ja: 'ギャラリー'
	String get gallery => 'ギャラリー';

	/// ja: 'アイコン'
	String get icon => 'アイコン';

	/// ja: '絵文字'
	String get emoji => '絵文字';

	/// ja: 'ステッカー'
	String get sticker => 'ステッカー';

	/// ja: 'プリント'
	String get print => 'プリント';

	/// ja: 'ファイルをアップロード'
	String get upload => 'ファイルをアップロード';

	/// ja: 'ギャラリー画像をアップロード中...'
	String get uploadGallery => 'ギャラリー画像をアップロード中...';

	/// ja: 'アイコンをアップロード中...'
	String get uploadIcon => 'アイコンをアップロード中...';

	/// ja: '絵文字をアップロード中...'
	String get uploadEmoji => '絵文字をアップロード中...';

	/// ja: 'ステッカーをアップロード中...'
	String get uploadSticker => 'ステッカーをアップロード中...';

	/// ja: 'プリント画像をアップロード中...'
	String get uploadPrint => 'プリント画像をアップロード中...';

	/// ja: '画像を選択'
	String get selectImage => '画像を選択';

	/// ja: 'ギャラリーから選択'
	String get selectFromGallery => 'ギャラリーから選択';

	/// ja: 'カメラで撮影'
	String get takePhoto => 'カメラで撮影';

	/// ja: 'アップロードが完了しました'
	String get uploadSuccess => 'アップロードが完了しました';

	/// ja: 'アップロードに失敗しました'
	String get uploadFailed => 'アップロードに失敗しました';

	/// ja: 'ファイル形式またはサイズに問題があります。PNG形式で1MB以下の画像を選択してください。'
	String get uploadFailedFormat => 'ファイル形式またはサイズに問題があります。PNG形式で1MB以下の画像を選択してください。';

	/// ja: '認証に失敗しました。再度ログインしてください。'
	String get uploadFailedAuth => '認証に失敗しました。再度ログインしてください。';

	/// ja: 'ファイルサイズが大きすぎます。より小さな画像を選択してください。'
	String get uploadFailedSize => 'ファイルサイズが大きすぎます。より小さな画像を選択してください。';

	/// ja: 'サーバーエラーが発生しました (${code})'
	String uploadFailedServer({required Object code}) => 'サーバーエラーが発生しました (${code})';

	/// ja: '画像の選択に失敗しました: ${error}'
	String pickImageFailed({required Object error}) => '画像の選択に失敗しました: ${error}';

	late final TranslationsInventoryTabsJa tabs = TranslationsInventoryTabsJa._(_root);
}

// Path: vrcnsync
class TranslationsVrcnsyncJa {
	TranslationsVrcnsyncJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'VRCNSync (β)'
	String get title => 'VRCNSync (β)';

	/// ja: 'ベータ版機能'
	String get betaTitle => 'ベータ版機能';

	/// ja: 'この機能は開発中のベータ版です。予期せぬ問題が発生する可能性があります。 現在はローカルのみの実装ですが、クラウド版が需要があれば実装します。'
	String get betaDescription => 'この機能は開発中のベータ版です。予期せぬ問題が発生する可能性があります。\n現在はローカルのみの実装ですが、クラウド版が需要があれば実装します。';

	/// ja: 'VRCNSyncのGitHubページ'
	String get githubLink => 'VRCNSyncのGitHubページ';

	/// ja: 'GitHubページを開く'
	String get openGithub => 'GitHubページを開く';

	/// ja: 'サーバー実行中'
	String get serverRunning => 'サーバー実行中';

	/// ja: 'サーバー停止中'
	String get serverStopped => 'サーバー停止中';

	/// ja: 'PCからの写真をVRCNアルバムに保存します'
	String get serverRunningDesc => 'PCからの写真をVRCNアルバムに保存します';

	/// ja: 'サーバーが停止しています'
	String get serverStoppedDesc => 'サーバーが停止しています';

	/// ja: '写真をVRCNアルバムに保存しました'
	String get photoSaved => '写真をVRCNアルバムに保存しました';

	/// ja: '写真を受信しました（アルバム保存に失敗）'
	String get photoReceived => '写真を受信しました（アルバム保存に失敗）';

	/// ja: 'アルバムを開く'
	String get openAlbum => 'アルバムを開く';

	/// ja: 'フォトライブラリへのアクセス権限が必要です'
	String get permissionErrorIos => 'フォトライブラリへのアクセス権限が必要です';

	/// ja: 'ストレージへのアクセス権限が必要です'
	String get permissionErrorAndroid => 'ストレージへのアクセス権限が必要です';

	/// ja: '設定を開く'
	String get openSettings => '設定を開く';

	/// ja: '初期化に失敗しました: ${error}'
	String initError({required Object error}) => '初期化に失敗しました: ${error}';

	/// ja: 'フォトアプリを開けませんでした'
	String get openPhotoAppError => 'フォトアプリを開けませんでした';

	/// ja: 'サーバー情報'
	String get serverInfo => 'サーバー情報';

	/// ja: 'IP: ${ip}'
	String ip({required Object ip}) => 'IP: ${ip}';

	/// ja: 'ポート: ${port}'
	String port({required Object port}) => 'ポート: ${port}';

	/// ja: '${ip}:${port}'
	String address({required Object ip, required Object port}) => '${ip}:${port}';

	/// ja: '受信した写真は「VRCN」アルバムに自動保存されます'
	String get autoSave => '受信した写真は「VRCN」アルバムに自動保存されます';

	/// ja: '使用方法'
	String get usage => '使用方法';

	List<dynamic> get usageSteps => [
		TranslationsVrcnsync$usageSteps$0i0$Ja._(_root),
		TranslationsVrcnsync$usageSteps$0i1$Ja._(_root),
		TranslationsVrcnsync$usageSteps$0i2$Ja._(_root),
		TranslationsVrcnsync$usageSteps$0i3$Ja._(_root),
	];

	/// ja: '接続状況'
	String get stats => '接続状況';

	/// ja: 'サーバー状態'
	String get statServer => 'サーバー状態';

	/// ja: '実行中'
	String get statServerRunning => '実行中';

	/// ja: '停止中'
	String get statServerStopped => '停止中';

	/// ja: 'ネットワーク'
	String get statNetwork => 'ネットワーク';

	/// ja: '接続済み'
	String get statNetworkConnected => '接続済み';

	/// ja: '未接続'
	String get statNetworkDisconnected => '未接続';
}

// Path: feedback
class TranslationsFeedbackJa {
	TranslationsFeedbackJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'フィードバック'
	String get title => 'フィードバック';

	/// ja: 'フィードバックタイプ'
	String get type => 'フィードバックタイプ';

	Map<String, String> get types => {
		'bug': 'バグ報告',
		'feature': '機能要望',
		'improvement': '改善提案',
		'other': 'その他',
	};

	/// ja: 'タイトル *'
	String get inputTitle => 'タイトル *';

	/// ja: '簡潔にお聞かせください'
	String get inputTitleHint => '簡潔にお聞かせください';

	/// ja: '詳細説明 *'
	String get inputDescription => '詳細説明 *';

	/// ja: '詳細な説明をお聞かせください...'
	String get inputDescriptionHint => '詳細な説明をお聞かせください...';

	/// ja: 'キャンセル'
	String get cancel => 'キャンセル';

	/// ja: '送信'
	String get send => '送信';

	/// ja: '送信中...'
	String get sending => '送信中...';

	/// ja: 'タイトルと詳細説明は必須項目です'
	String get required => 'タイトルと詳細説明は必須項目です';

	/// ja: 'フィードバックを送信しました。ありがとうございます！'
	String get success => 'フィードバックを送信しました。ありがとうございます！';

	/// ja: 'フィードバックの送信に失敗しました'
	String get fail => 'フィードバックの送信に失敗しました';
}

// Path: settings
class TranslationsSettingsJa {
	TranslationsSettingsJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '外観'
	String get appearance => '外観';

	/// ja: '言語'
	String get language => '言語';

	/// ja: 'アプリの表示言語を選択できます'
	String get languageDescription => 'アプリの表示言語を選択できます';

	/// ja: 'アプリアイコン'
	String get appIcon => 'アプリアイコン';

	/// ja: 'ホーム画面に表示されるアプリのアイコンを変更します'
	String get appIconDescription => 'ホーム画面に表示されるアプリのアイコンを変更します';

	/// ja: 'コンテンツ設定'
	String get contentSettings => 'コンテンツ設定';

	/// ja: '検索機能が有効になりました'
	String get searchEnabled => '検索機能が有効になりました';

	/// ja: '検索機能が無効になりました'
	String get searchDisabled => '検索機能が無効になりました';

	/// ja: '検索機能を有効'
	String get enableSearch => '検索機能を有効';

	/// ja: '検索結果に性的なコンテンツや暴力的なコンテンツが表示される可能性があります。'
	String get enableSearchDescription => '検索結果に性的なコンテンツや暴力的なコンテンツが表示される可能性があります。';

	/// ja: 'アバター検索API'
	String get apiSetting => 'アバター検索API';

	/// ja: 'アバター検索機能のAPIを設定します'
	String get apiSettingDescription => 'アバター検索機能のAPIを設定します';

	/// ja: 'URLを保存しました'
	String get apiSettingSaveUrl => 'URLを保存しました';

	/// ja: '未設定 (アバター検索機能が使用できません)'
	String get notSet => '未設定 (アバター検索機能が使用できません)';

	/// ja: '通知設定'
	String get notifications => '通知設定';

	/// ja: 'イベントリマインダー'
	String get eventReminder => 'イベントリマインダー';

	/// ja: '設定したイベントの開始前に通知を受け取ります'
	String get eventReminderDescription => '設定したイベントの開始前に通知を受け取ります';

	/// ja: '設定済みリマインダーの管理'
	String get manageReminders => '設定済みリマインダーの管理';

	/// ja: '通知のキャンセルや確認ができます'
	String get manageRemindersDescription => '通知のキャンセルや確認ができます';

	/// ja: 'データとストレージ'
	String get dataStorage => 'データとストレージ';

	/// ja: 'キャッシュを削除'
	String get clearCache => 'キャッシュを削除';

	/// ja: 'キャッシュを削除しました'
	String get clearCacheSuccess => 'キャッシュを削除しました';

	/// ja: 'キャッシュの削除中にエラーが発生しました'
	String get clearCacheError => 'キャッシュの削除中にエラーが発生しました';

	/// ja: 'キャッシュサイズ: ${size}'
	String cacheSize({required Object size}) => 'キャッシュサイズ: ${size}';

	/// ja: 'キャッシュサイズを計算中...'
	String get calculatingCache => 'キャッシュサイズを計算中...';

	/// ja: 'キャッシュサイズを取得できませんでした'
	String get cacheError => 'キャッシュサイズを取得できませんでした';

	/// ja: 'キャッシュを削除すると、一時的に保存された画像やデータが削除されます。 アカウント情報やアプリの設定は削除されません。'
	String get confirmClearCache => 'キャッシュを削除すると、一時的に保存された画像やデータが削除されます。\n\nアカウント情報やアプリの設定は削除されません。';

	/// ja: 'アプリ情報'
	String get appInfo => 'アプリ情報';

	/// ja: 'バージョン'
	String get version => 'バージョン';

	/// ja: 'パッケージ名'
	String get packageName => 'パッケージ名';

	/// ja: 'クレジット'
	String get credit => 'クレジット';

	/// ja: '開発者・貢献者情報'
	String get creditDescription => '開発者・貢献者情報';

	/// ja: 'お問い合わせ'
	String get contact => 'お問い合わせ';

	/// ja: '不具合報告・ご意見はこちら'
	String get contactDescription => '不具合報告・ご意見はこちら';

	/// ja: 'プライバシーポリシー'
	String get privacyPolicy => 'プライバシーポリシー';

	/// ja: '個人情報の取り扱いについて'
	String get privacyPolicyDescription => '個人情報の取り扱いについて';

	/// ja: '利用規約'
	String get termsOfService => '利用規約';

	/// ja: 'アプリのご利用条件'
	String get termsOfServiceDescription => 'アプリのご利用条件';

	/// ja: 'オープンソース情報'
	String get openSource => 'オープンソース情報';

	/// ja: '使用しているライブラリ等のライセンス'
	String get openSourceDescription => '使用しているライブラリ等のライセンス';

	/// ja: 'GitHubリポジトリ'
	String get github => 'GitHubリポジトリ';

	/// ja: 'ソースコードを見る'
	String get githubDescription => 'ソースコードを見る';

	/// ja: 'ログアウトしますか？'
	String get logoutConfirm => 'ログアウトしますか？';

	/// ja: 'ログアウト中にエラーが発生しました: ${error}'
	String logoutError({required Object error}) => 'ログアウト中にエラーが発生しました: ${error}';

	/// ja: 'お使いのデバイスではアプリアイコンの変更がサポートされていません'
	String get iconChangeNotSupported => 'お使いのデバイスではアプリアイコンの変更がサポートされていません';

	/// ja: 'アイコンの変更に失敗しました'
	String get iconChangeFailed => 'アイコンの変更に失敗しました';

	/// ja: 'テーマモード'
	String get themeMode => 'テーマモード';

	/// ja: 'アプリの表示テーマを選択できます'
	String get themeModeDescription => 'アプリの表示テーマを選択できます';

	/// ja: '明るい'
	String get themeLight => '明るい';

	/// ja: 'システム'
	String get themeSystem => 'システム';

	/// ja: '暗い'
	String get themeDark => '暗い';

	/// ja: 'デフォルト'
	String get appIconDefault => 'デフォルト';

	/// ja: 'アイコン'
	String get appIconIcon => 'アイコン';

	/// ja: 'ロゴ'
	String get appIconLogo => 'ロゴ';

	/// ja: '削除する'
	String get delete => '削除する';
}

// Path: credits
class TranslationsCreditsJa {
	TranslationsCreditsJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'クレジット'
	String get title => 'クレジット';

	late final TranslationsCreditsSectionJa section = TranslationsCreditsSectionJa._(_root);
}

// Path: download
class TranslationsDownloadJa {
	TranslationsDownloadJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'ダウンロードが完了しました'
	String get success => 'ダウンロードが完了しました';

	/// ja: 'ダウンロードに失敗しました: ${error}'
	String failure({required Object error}) => 'ダウンロードに失敗しました: ${error}';

	/// ja: '共有に失敗しました: ${error}'
	String shareFailure({required Object error}) => '共有に失敗しました: ${error}';

	/// ja: '権限が必要です'
	String get permissionTitle => '権限が必要です';

	/// ja: '${permissionType}への保存権限が拒否されています。 設定アプリから権限を有効にしてください。'
	String permissionDenied({required Object permissionType}) => '${permissionType}への保存権限が拒否されています。\n設定アプリから権限を有効にしてください。';

	/// ja: 'キャンセル'
	String get permissionCancel => 'キャンセル';

	/// ja: '設定を開く'
	String get permissionOpenSettings => '設定を開く';

	/// ja: 'フォト'
	String get permissionPhoto => 'フォト';

	/// ja: 'フォトライブラリ'
	String get permissionPhotoLibrary => 'フォトライブラリ';

	/// ja: 'ストレージ'
	String get permissionStorage => 'ストレージ';

	/// ja: '写真への保存権限が必要です'
	String get permissionPhotoRequired => '写真への保存権限が必要です';

	/// ja: 'フォトライブラリへの保存権限が必要です'
	String get permissionPhotoLibraryRequired => 'フォトライブラリへの保存権限が必要です';

	/// ja: 'ストレージへのアクセス権限が必要です'
	String get permissionStorageRequired => 'ストレージへのアクセス権限が必要です';

	/// ja: '権限チェック中にエラーが発生しました: ${error}'
	String permissionError({required Object error}) => '権限チェック中にエラーが発生しました: ${error}';

	/// ja: '${fileName} をダウンロード中...'
	String downloading({required Object fileName}) => '${fileName} をダウンロード中...';

	/// ja: '${fileName} を共有準備中...'
	String sharing({required Object fileName}) => '${fileName} を共有準備中...';
}

// Path: instance
class TranslationsInstanceJa {
	TranslationsInstanceJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsInstanceTypeJa type = TranslationsInstanceTypeJa._(_root);
}

// Path: status
class TranslationsStatusJa {
	TranslationsStatusJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'オンライン'
	String get active => 'オンライン';

	/// ja: 'だれでもおいで'
	String get joinMe => 'だれでもおいで';

	/// ja: 'きいてみてね'
	String get askMe => 'きいてみてね';

	/// ja: '取り込み中'
	String get busy => '取り込み中';

	/// ja: 'オフライン'
	String get offline => 'オフライン';

	/// ja: 'ステータス不明'
	String get unknown => 'ステータス不明';
}

// Path: location
class TranslationsLocationJa {
	TranslationsLocationJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'プライベート'
	String get private => 'プライベート';

	/// ja: 'プレイヤー数: ${userCount} / ${capacity}'
	String playerCount({required Object userCount, required Object capacity}) => 'プレイヤー数: ${userCount} / ${capacity}';

	/// ja: 'インスタンスタイプ: ${type}'
	String instanceType({required Object type}) => 'インスタンスタイプ: ${type}';

	/// ja: 'ロケーション情報はありません'
	String get noInfo => 'ロケーション情報はありません';

	/// ja: 'ロケーション情報の取得に失敗しました'
	String get fetchError => 'ロケーション情報の取得に失敗しました';

	/// ja: 'プライベートな場所にいます'
	String get privateLocation => 'プライベートな場所にいます';

	/// ja: '招待を送信中...'
	String get inviteSending => '招待を送信中...';

	/// ja: '招待を送信しました。通知から参加できます'
	String get inviteSent => '招待を送信しました。通知から参加できます';

	/// ja: '招待の送信に失敗しました: ${error}'
	String inviteFailed({required Object error}) => '招待の送信に失敗しました: ${error}';

	/// ja: '自分に招待を送信'
	String get inviteButton => '自分に招待を送信';

	/// ja: '${number}人がプライベート'
	String isPrivate({required Object number}) => '${number}人がプライベート';

	/// ja: '${number}人がアクティブ'
	String isActive({required Object number}) => '${number}人がアクティブ';

	/// ja: '${number}人がオフライン'
	String isOffline({required Object number}) => '${number}人がオフライン';

	/// ja: '${number}人が移動中'
	String isTraveling({required Object number}) => '${number}人が移動中';

	/// ja: '${number}人が滞在中'
	String isStaying({required Object number}) => '${number}人が滞在中';
}

// Path: reminder
class TranslationsReminderJa {
	TranslationsReminderJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'リマインダーを設定'
	String get dialogTitle => 'リマインダーを設定';

	/// ja: '設定済み'
	String get alreadySet => '設定済み';

	/// ja: '設定する'
	String get set => '設定する';

	/// ja: 'キャンセル'
	String get cancel => 'キャンセル';

	/// ja: '削除する'
	String get delete => '削除する';

	/// ja: 'すべてのリマインダーを削除'
	String get deleteAll => 'すべてのリマインダーを削除';

	/// ja: '設定したすべてのイベントリマインダーを削除します。この操作は元に戻せません。'
	String get deleteAllConfirm => '設定したすべてのイベントリマインダーを削除します。この操作は元に戻せません。';

	/// ja: 'リマインダーを削除しました'
	String get deleted => 'リマインダーを削除しました';

	/// ja: 'すべてのリマインダーを削除しました'
	String get deletedAll => 'すべてのリマインダーを削除しました';

	/// ja: '設定済みのリマインダーはありません'
	String get noReminders => '設定済みのリマインダーはありません';

	/// ja: 'イベントページから通知を設定できます'
	String get setFromEvent => 'イベントページから通知を設定できます';

	/// ja: '${time} 開始'
	String eventStart({required Object time}) => '${time} 開始';

	/// ja: '${time} (${label})'
	String notifyAt({required Object time, required Object label}) => '${time} (${label})';

	/// ja: 'いつ通知を受け取りますか？'
	String get receiveNotification => 'いつ通知を受け取りますか？';
}

// Path: friend
class TranslationsFriendJa {
	TranslationsFriendJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '並び替え・フィルター'
	String get sortFilter => '並び替え・フィルター';

	/// ja: 'フィルター'
	String get filter => 'フィルター';

	/// ja: 'すべて表示'
	String get filterAll => 'すべて表示';

	/// ja: 'オンラインのみ'
	String get filterOnline => 'オンラインのみ';

	/// ja: 'オフラインのみ'
	String get filterOffline => 'オフラインのみ';

	/// ja: 'お気に入りのみ'
	String get filterFavorite => 'お気に入りのみ';

	/// ja: '並び替え'
	String get sort => '並び替え';

	/// ja: 'オンライン状態順'
	String get sortStatus => 'オンライン状態順';

	/// ja: '名前順'
	String get sortName => '名前順';

	/// ja: '最終ログイン順'
	String get sortLastLogin => '最終ログイン順';

	/// ja: '昇順'
	String get sortAsc => '昇順';

	/// ja: '降順'
	String get sortDesc => '降順';

	/// ja: '閉じる'
	String get close => '閉じる';
}

// Path: eventCalendarFilter
class TranslationsEventCalendarFilterJa {
	TranslationsEventCalendarFilterJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'イベントを絞り込む'
	String get filterTitle => 'イベントを絞り込む';

	/// ja: 'クリア'
	String get clear => 'クリア';

	/// ja: 'キーワード検索'
	String get keyword => 'キーワード検索';

	/// ja: 'イベント名、説明、主催者など'
	String get keywordHint => 'イベント名、説明、主催者など';

	/// ja: '日付で絞り込み'
	String get date => '日付で絞り込み';

	/// ja: '特定の日付範囲のイベントを表示できます'
	String get dateHint => '特定の日付範囲のイベントを表示できます';

	/// ja: '開始日'
	String get startDate => '開始日';

	/// ja: '終了日'
	String get endDate => '終了日';

	/// ja: '選択してください'
	String get select => '選択してください';

	/// ja: '時間帯で絞り込み'
	String get time => '時間帯で絞り込み';

	/// ja: '特定の時間帯に開催されるイベントを表示できます'
	String get timeHint => '特定の時間帯に開催されるイベントを表示できます';

	/// ja: '開始時間'
	String get startTime => '開始時間';

	/// ja: '終了時間'
	String get endTime => '終了時間';

	/// ja: 'ジャンルで絞り込み'
	String get genre => 'ジャンルで絞り込み';

	/// ja: '${count}個のジャンルを選択中'
	String genreSelected({required Object count}) => '${count}個のジャンルを選択中';

	/// ja: '適用する'
	String get apply => '適用する';

	/// ja: 'フィルター'
	String get filterSummary => 'フィルター';

	/// ja: 'フィルターは設定されていません'
	String get filterNone => 'フィルターは設定されていません';
}

// Path: drawer.section
class TranslationsDrawerSectionJa {
	TranslationsDrawerSectionJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'コンテンツ'
	String get content => 'コンテンツ';

	/// ja: 'その他'
	String get other => 'その他';
}

// Path: search.tabs
class TranslationsSearchTabsJa {
	TranslationsSearchTabsJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsSearchTabsUserSearchJa userSearch = TranslationsSearchTabsUserSearchJa._(_root);
	late final TranslationsSearchTabsWorldSearchJa worldSearch = TranslationsSearchTabsWorldSearchJa._(_root);
	late final TranslationsSearchTabsGroupSearchJa groupSearch = TranslationsSearchTabsGroupSearchJa._(_root);
	late final TranslationsSearchTabsAvatarSearchJa avatarSearch = TranslationsSearchTabsAvatarSearchJa._(_root);
}

// Path: groupDetail.privacy
class TranslationsGroupDetailPrivacyJa {
	TranslationsGroupDetailPrivacyJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '公開'
	String get public => '公開';

	/// ja: '非公開'
	String get private => '非公開';

	/// ja: 'フレンド'
	String get friends => 'フレンド';

	/// ja: '招待制'
	String get invite => '招待制';

	/// ja: '不明'
	String get unknown => '不明';
}

// Path: groupDetail.role
class TranslationsGroupDetailRoleJa {
	TranslationsGroupDetailRoleJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '管理者'
	String get admin => '管理者';

	/// ja: 'モデレーター'
	String get moderator => 'モデレーター';

	/// ja: 'メンバー'
	String get member => 'メンバー';

	/// ja: '不明'
	String get unknown => '不明';
}

// Path: inventory.tabs
class TranslationsInventoryTabsJa {
	TranslationsInventoryTabsJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsInventoryTabsEmojiInventoryJa emojiInventory = TranslationsInventoryTabsEmojiInventoryJa._(_root);
	late final TranslationsInventoryTabsGalleryInventoryJa galleryInventory = TranslationsInventoryTabsGalleryInventoryJa._(_root);
	late final TranslationsInventoryTabsIconInventoryJa iconInventory = TranslationsInventoryTabsIconInventoryJa._(_root);
	late final TranslationsInventoryTabsPrintInventoryJa printInventory = TranslationsInventoryTabsPrintInventoryJa._(_root);
	late final TranslationsInventoryTabsStickerInventoryJa stickerInventory = TranslationsInventoryTabsStickerInventoryJa._(_root);
}

// Path: vrcnsync.usageSteps.0
class TranslationsVrcnsync$usageSteps$0i0$Ja {
	TranslationsVrcnsync$usageSteps$0i0$Ja._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'PCでVRCNSyncアプリを起動'
	String get title => 'PCでVRCNSyncアプリを起動';

	/// ja: 'PCでVRCNSyncアプリを起動してください'
	String get desc => 'PCでVRCNSyncアプリを起動してください';
}

// Path: vrcnsync.usageSteps.1
class TranslationsVrcnsync$usageSteps$0i1$Ja {
	TranslationsVrcnsync$usageSteps$0i1$Ja._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '同じWiFiネットワークに接続'
	String get title => '同じWiFiネットワークに接続';

	/// ja: 'PC・モバイル端末を同じWiFiネットワークに接続してください'
	String get desc => 'PC・モバイル端末を同じWiFiネットワークに接続してください';
}

// Path: vrcnsync.usageSteps.2
class TranslationsVrcnsync$usageSteps$0i2$Ja {
	TranslationsVrcnsync$usageSteps$0i2$Ja._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '接続先にモバイル端末を指定'
	String get title => '接続先にモバイル端末を指定';

	/// ja: 'PCアプリで上記のIPアドレスとポートを指定してください'
	String get desc => 'PCアプリで上記のIPアドレスとポートを指定してください';
}

// Path: vrcnsync.usageSteps.3
class TranslationsVrcnsync$usageSteps$0i3$Ja {
	TranslationsVrcnsync$usageSteps$0i3$Ja._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '写真を送信'
	String get title => '写真を送信';

	/// ja: 'PCから写真を送信すると、自動的にVRCNアルバムに保存されます'
	String get desc => 'PCから写真を送信すると、自動的にVRCNアルバムに保存されます';
}

// Path: credits.section
class TranslationsCreditsSectionJa {
	TranslationsCreditsSectionJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '開発'
	String get development => '開発';

	/// ja: '愉快なアイコンの人たち'
	String get iconPeople => '愉快なアイコンの人たち';

	/// ja: 'テスト・フィードバック'
	String get testFeedback => 'テスト・フィードバック';

	/// ja: 'スペシャルサンクス'
	String get specialThanks => 'スペシャルサンクス';
}

// Path: instance.type
class TranslationsInstanceTypeJa {
	TranslationsInstanceTypeJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'パブリック'
	String get public => 'パブリック';

	/// ja: 'フレンド+'
	String get hidden => 'フレンド+';

	/// ja: 'フレンド'
	String get friends => 'フレンド';

	/// ja: 'インバイト+'
	String get private => 'インバイト+';

	/// ja: '不明'
	String get unknown => '不明';
}

// Path: search.tabs.userSearch
class TranslationsSearchTabsUserSearchJa {
	TranslationsSearchTabsUserSearchJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'ユーザー検索'
	String get emptyTitle => 'ユーザー検索';

	/// ja: 'ユーザー名やIDで検索できます'
	String get emptyDescription => 'ユーザー名やIDで検索できます';

	/// ja: '検索中...'
	String get searching => '検索中...';

	/// ja: '該当するユーザーが見つかりません'
	String get noResults => '該当するユーザーが見つかりません';

	/// ja: 'ユーザー検索中にエラーが発生しました: ${error}'
	String error({required Object error}) => 'ユーザー検索中にエラーが発生しました: ${error}';

	/// ja: 'ユーザー名またはIDを入力'
	String get inputPlaceholder => 'ユーザー名またはIDを入力';
}

// Path: search.tabs.worldSearch
class TranslationsSearchTabsWorldSearchJa {
	TranslationsSearchTabsWorldSearchJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'ワールドを探索'
	String get emptyTitle => 'ワールドを探索';

	/// ja: 'キーワードを入力して検索してください'
	String get emptyDescription => 'キーワードを入力して検索してください';

	/// ja: '検索中...'
	String get searching => '検索中...';

	/// ja: '該当するワールドが見つかりませんでした'
	String get noResults => '該当するワールドが見つかりませんでした';

	/// ja: '「${query}」に一致するワールドが 見つかりませんでした'
	String noResultsWithQuery({required Object query}) => '「${query}」に一致するワールドが\n見つかりませんでした';

	/// ja: '検索キーワードを変えてみましょう'
	String get noResultsHint => '検索キーワードを変えてみましょう';

	/// ja: 'ワールド検索中にエラーが発生しました: ${error}'
	String error({required Object error}) => 'ワールド検索中にエラーが発生しました: ${error}';

	/// ja: '${count}件のワールドが見つかりました'
	String resultCount({required Object count}) => '${count}件のワールドが見つかりました';

	/// ja: 'by ${authorName}'
	String authorPrefix({required Object authorName}) => 'by ${authorName}';

	/// ja: 'リストビュー'
	String get listView => 'リストビュー';

	/// ja: 'グリッドビュー'
	String get gridView => 'グリッドビュー';
}

// Path: search.tabs.groupSearch
class TranslationsSearchTabsGroupSearchJa {
	TranslationsSearchTabsGroupSearchJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'グループを検索'
	String get emptyTitle => 'グループを検索';

	/// ja: 'キーワードを入力して検索してください'
	String get emptyDescription => 'キーワードを入力して検索してください';

	/// ja: '検索中...'
	String get searching => '検索中...';

	/// ja: '該当するグループが見つかりませんでした'
	String get noResults => '該当するグループが見つかりませんでした';

	/// ja: '「${query}」に一致するグループが 見つかりませんでした'
	String noResultsWithQuery({required Object query}) => '「${query}」に一致するグループが\n見つかりませんでした';

	/// ja: '検索キーワードを変えてみましょう'
	String get noResultsHint => '検索キーワードを変えてみましょう';

	/// ja: 'グループ検索中にエラーが発生しました: ${error}'
	String error({required Object error}) => 'グループ検索中にエラーが発生しました: ${error}';

	/// ja: '${count}件のグループが見つかりました'
	String resultCount({required Object count}) => '${count}件のグループが見つかりました';

	/// ja: 'リストビュー'
	String get listView => 'リストビュー';

	/// ja: 'グリッドビュー'
	String get gridView => 'グリッドビュー';

	/// ja: '${count} メンバー'
	String memberCount({required Object count}) => '${count} メンバー';
}

// Path: search.tabs.avatarSearch
class TranslationsSearchTabsAvatarSearchJa {
	TranslationsSearchTabsAvatarSearchJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'アバター'
	String get avatar => 'アバター';

	/// ja: 'アバターを検索'
	String get emptyTitle => 'アバターを検索';

	/// ja: 'キーワードを入力して検索してください'
	String get emptyDescription => 'キーワードを入力して検索してください';

	/// ja: 'アバターを検索中...'
	String get searching => 'アバターを検索中...';

	/// ja: '検索結果が見つかりませんでした'
	String get noResults => '検索結果が見つかりませんでした';

	/// ja: '別のキーワードで試してみましょう'
	String get noResultsHint => '別のキーワードで試してみましょう';

	/// ja: 'アバター検索中にエラーが発生しました: ${error}'
	String error({required Object error}) => 'アバター検索中にエラーが発生しました: ${error}';
}

// Path: inventory.tabs.emojiInventory
class TranslationsInventoryTabsEmojiInventoryJa {
	TranslationsInventoryTabsEmojiInventoryJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '絵文字を読み込み中...'
	String get loading => '絵文字を読み込み中...';

	/// ja: '絵文字の取得に失敗しました: ${error}'
	String error({required Object error}) => '絵文字の取得に失敗しました: ${error}';

	/// ja: '絵文字がありません'
	String get emptyTitle => '絵文字がありません';

	/// ja: 'VRChatでアップロードした絵文字がここに表示されます'
	String get emptyDescription => 'VRChatでアップロードした絵文字がここに表示されます';

	/// ja: 'ダブルタップでズーム'
	String get zoomHint => 'ダブルタップでズーム';
}

// Path: inventory.tabs.galleryInventory
class TranslationsInventoryTabsGalleryInventoryJa {
	TranslationsInventoryTabsGalleryInventoryJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'ギャラリーを読み込み中...'
	String get loading => 'ギャラリーを読み込み中...';

	/// ja: 'ギャラリーの取得に失敗しました: ${error}'
	String error({required Object error}) => 'ギャラリーの取得に失敗しました: ${error}';

	/// ja: 'ギャラリーがありません'
	String get emptyTitle => 'ギャラリーがありません';

	/// ja: 'VRChatでアップロードしたギャラリーがここに表示されます'
	String get emptyDescription => 'VRChatでアップロードしたギャラリーがここに表示されます';

	/// ja: 'ダブルタップでズーム'
	String get zoomHint => 'ダブルタップでズーム';
}

// Path: inventory.tabs.iconInventory
class TranslationsInventoryTabsIconInventoryJa {
	TranslationsInventoryTabsIconInventoryJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'アイコンを読み込み中...'
	String get loading => 'アイコンを読み込み中...';

	/// ja: 'アイコンの取得に失敗しました: ${error}'
	String error({required Object error}) => 'アイコンの取得に失敗しました: ${error}';

	/// ja: 'アイコンがありません'
	String get emptyTitle => 'アイコンがありません';

	/// ja: 'VRChatでアップロードしたアイコンがここに表示されます'
	String get emptyDescription => 'VRChatでアップロードしたアイコンがここに表示されます';

	/// ja: 'ダブルタップでズーム'
	String get zoomHint => 'ダブルタップでズーム';
}

// Path: inventory.tabs.printInventory
class TranslationsInventoryTabsPrintInventoryJa {
	TranslationsInventoryTabsPrintInventoryJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'プリントを読み込み中...'
	String get loading => 'プリントを読み込み中...';

	/// ja: 'プリントの取得に失敗しました: ${error}'
	String error({required Object error}) => 'プリントの取得に失敗しました: ${error}';

	/// ja: 'プリントがありません'
	String get emptyTitle => 'プリントがありません';

	/// ja: 'VRChatでアップロードしたプリントがここに表示されます'
	String get emptyDescription => 'VRChatでアップロードしたプリントがここに表示されます';

	/// ja: 'ダブルタップでズーム'
	String get zoomHint => 'ダブルタップでズーム';
}

// Path: inventory.tabs.stickerInventory
class TranslationsInventoryTabsStickerInventoryJa {
	TranslationsInventoryTabsStickerInventoryJa._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'ステッカーを読み込み中...'
	String get loading => 'ステッカーを読み込み中...';

	/// ja: 'ステッカーの取得に失敗しました: ${error}'
	String error({required Object error}) => 'ステッカーの取得に失敗しました: ${error}';

	/// ja: 'ステッカーがありません'
	String get emptyTitle => 'ステッカーがありません';

	/// ja: 'VRChatでアップロードしたステッカーがここに表示されます'
	String get emptyDescription => 'VRChatでアップロードしたステッカーがここに表示されます';

	/// ja: 'ダブルタップでズーム'
	String get zoomHint => 'ダブルタップでズーム';
}

/// The flat map containing all translations for locale <ja>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'common.title' => 'VRCN',
			'common.ok' => 'OK',
			'common.cancel' => 'キャンセル',
			'common.close' => '閉じる',
			'common.save' => '保存',
			'common.edit' => '編集',
			'common.delete' => '削除',
			'common.yes' => 'はい',
			'common.no' => 'いいえ',
			'common.loading' => '読み込み中...',
			'common.error' => ({required Object error}) => 'エラーが発生しました: ${error}',
			'common.errorNomessage' => 'エラーが発生しました',
			'common.retry' => '再試行',
			'common.search' => '検索',
			'common.settings' => '設定',
			'common.confirm' => '確認',
			'common.agree' => '同意する',
			'common.decline' => '同意しない',
			'common.username' => 'ユーザー名',
			'common.password' => 'パスワード',
			'common.login' => 'ログイン',
			'common.logout' => 'ログアウト',
			'common.share' => '共有',
			'termsAgreement.welcomeTitle' => 'VRCN へようこそ',
			'termsAgreement.welcomeMessage' => 'アプリをご利用いただく前に\n利用規約とプライバシーポリシーをご確認ください',
			'termsAgreement.termsTitle' => '利用規約',
			'termsAgreement.termsSubtitle' => 'アプリのご利用条件について',
			'termsAgreement.privacyTitle' => 'プライバシーポリシー',
			'termsAgreement.privacySubtitle' => '個人情報の取り扱いについて',
			'termsAgreement.agreeTerms' => ({required Object title}) => '「${title}」に同意する',
			'termsAgreement.checkContent' => '内容を確認',
			'termsAgreement.notice' => 'このアプリはVRChat Inc.の非公式アプリです。\nVRChat Inc.とは一切関係ありません。',
			'drawer.home' => 'ホーム',
			'drawer.profile' => 'プロフィール',
			'drawer.favorite' => 'お気に入り',
			'drawer.eventCalendar' => 'イベントカレンダー',
			'drawer.avatar' => 'アバター',
			'drawer.group' => 'グループ',
			'drawer.inventory' => 'インベントリ',
			'drawer.vrcnsync' => 'VRCNSync (β)',
			'drawer.review' => 'レビュー',
			'drawer.feedback' => 'フィードバック',
			'drawer.settings' => '設定',
			'drawer.userLoading' => 'ユーザー情報を読み込み中...',
			'drawer.userError' => 'ユーザー情報の取得に失敗しました',
			'drawer.retry' => '再試行',
			'drawer.section.content' => 'コンテンツ',
			'drawer.section.other' => 'その他',
			'login.forgotPassword' => 'パスワードを忘れた場合',
			'login.createAccount' => 'アカウントを作成',
			'login.subtitle' => 'VRChatのアカウント情報でログイン',
			'login.email' => 'メールアドレス',
			'login.emailHint' => 'メールまたはユーザー名を入力',
			'login.passwordHint' => 'パスワードを入力',
			'login.rememberMe' => 'ログイン状態を保存',
			'login.loggingIn' => 'ログイン中...',
			'login.errorEmptyEmail' => 'ユーザー名またはメールアドレスを入力してください',
			'login.errorEmptyPassword' => 'パスワードを入力してください',
			'login.errorLoginFailed' => 'ログインに失敗しました。メールアドレスとパスワードを確認してください。',
			'login.twoFactorTitle' => '二段階認証',
			'login.twoFactorSubtitle' => '認証コードを入力してください',
			'login.twoFactorInstruction' => '認証アプリに表示されている\n6桁のコードを入力してください',
			'login.twoFactorCodeHint' => '認証コード',
			'login.verify' => '認証',
			'login.verifying' => '認証中...',
			'login.errorEmpty2fa' => '認証コードを入力してください',
			'login.error2faFailed' => '二段階認証に失敗しました。コードが正しいか確認してください。',
			'login.backToLogin' => 'ログイン画面に戻る',
			'login.paste' => 'ペースト',
			'friends.loading' => 'フレンド情報を読み込み中...',
			'friends.error' => ({required Object error}) => 'フレンドの情報の取得に失敗しました: ${error}',
			'friends.notFound' => 'フレンドが見つかりませんでした',
			'friends.private' => 'プライベート',
			'friends.active' => 'アクティブ',
			'friends.offline' => 'オフライン',
			'friends.online' => 'オンライン',
			'friends.groupTitle' => 'ワールドごとにグループ化',
			'friends.refresh' => '更新',
			'friends.searchHint' => 'フレンド名で検索',
			'friends.noResult' => '該当するフレンドはいません',
			'friendDetail.loading' => 'ユーザー情報を読み込み中...',
			'friendDetail.error' => ({required Object error}) => 'ユーザー情報の取得に失敗しました: ${error}',
			'friendDetail.currentLocation' => '現在の場所',
			'friendDetail.basicInfo' => '基本情報',
			'friendDetail.userId' => 'ユーザーID',
			'friendDetail.dateJoined' => '登録日',
			'friendDetail.lastLogin' => '最終ログイン',
			'friendDetail.bio' => '自己紹介',
			'friendDetail.links' => 'リンク',
			'friendDetail.loadingLinks' => 'リンク情報を読み込み中...',
			'friendDetail.group' => '所属グループ',
			'friendDetail.groupDetail' => 'グループ詳細を表示',
			'friendDetail.groupCode' => ({required Object code}) => 'グループコード: ${code}',
			'friendDetail.memberCount' => ({required Object count}) => 'メンバー数: ${count}人',
			'friendDetail.unknownGroup' => '不明なグループ',
			'friendDetail.block' => 'ブロック',
			'friendDetail.mute' => 'ミュート',
			'friendDetail.openWebsite' => 'ウェブサイトで開く',
			'friendDetail.shareProfile' => 'プロフィールを共有',
			'friendDetail.confirmBlockTitle' => ({required Object name}) => '${name}をブロックしますか？',
			'friendDetail.confirmBlockMessage' => 'ブロックすると、このユーザーからのフレンド申請やメッセージを受け取らなくなります。',
			'friendDetail.confirmMuteTitle' => ({required Object name}) => '${name}をミュートしますか？',
			'friendDetail.confirmMuteMessage' => 'ミュートすると、このユーザーの音声が聞こえなくなります。',
			'friendDetail.blockSuccess' => 'ブロックしました',
			'friendDetail.muteSuccess' => 'ミュートしました',
			'friendDetail.operationFailed' => ({required Object error}) => '操作に失敗しました: ${error}',
			'search.userTab' => 'ユーザー',
			'search.worldTab' => 'ワールド',
			'search.avatarTab' => 'アバター',
			'search.groupTab' => 'グループ',
			'search.tabs.userSearch.emptyTitle' => 'ユーザー検索',
			'search.tabs.userSearch.emptyDescription' => 'ユーザー名やIDで検索できます',
			'search.tabs.userSearch.searching' => '検索中...',
			'search.tabs.userSearch.noResults' => '該当するユーザーが見つかりません',
			'search.tabs.userSearch.error' => ({required Object error}) => 'ユーザー検索中にエラーが発生しました: ${error}',
			'search.tabs.userSearch.inputPlaceholder' => 'ユーザー名またはIDを入力',
			'search.tabs.worldSearch.emptyTitle' => 'ワールドを探索',
			'search.tabs.worldSearch.emptyDescription' => 'キーワードを入力して検索してください',
			'search.tabs.worldSearch.searching' => '検索中...',
			'search.tabs.worldSearch.noResults' => '該当するワールドが見つかりませんでした',
			'search.tabs.worldSearch.noResultsWithQuery' => ({required Object query}) => '「${query}」に一致するワールドが\n見つかりませんでした',
			'search.tabs.worldSearch.noResultsHint' => '検索キーワードを変えてみましょう',
			'search.tabs.worldSearch.error' => ({required Object error}) => 'ワールド検索中にエラーが発生しました: ${error}',
			'search.tabs.worldSearch.resultCount' => ({required Object count}) => '${count}件のワールドが見つかりました',
			'search.tabs.worldSearch.authorPrefix' => ({required Object authorName}) => 'by ${authorName}',
			'search.tabs.worldSearch.listView' => 'リストビュー',
			'search.tabs.worldSearch.gridView' => 'グリッドビュー',
			'search.tabs.groupSearch.emptyTitle' => 'グループを検索',
			'search.tabs.groupSearch.emptyDescription' => 'キーワードを入力して検索してください',
			'search.tabs.groupSearch.searching' => '検索中...',
			'search.tabs.groupSearch.noResults' => '該当するグループが見つかりませんでした',
			'search.tabs.groupSearch.noResultsWithQuery' => ({required Object query}) => '「${query}」に一致するグループが\n見つかりませんでした',
			'search.tabs.groupSearch.noResultsHint' => '検索キーワードを変えてみましょう',
			'search.tabs.groupSearch.error' => ({required Object error}) => 'グループ検索中にエラーが発生しました: ${error}',
			'search.tabs.groupSearch.resultCount' => ({required Object count}) => '${count}件のグループが見つかりました',
			'search.tabs.groupSearch.listView' => 'リストビュー',
			'search.tabs.groupSearch.gridView' => 'グリッドビュー',
			'search.tabs.groupSearch.memberCount' => ({required Object count}) => '${count} メンバー',
			'search.tabs.avatarSearch.avatar' => 'アバター',
			'search.tabs.avatarSearch.emptyTitle' => 'アバターを検索',
			'search.tabs.avatarSearch.emptyDescription' => 'キーワードを入力して検索してください',
			'search.tabs.avatarSearch.searching' => 'アバターを検索中...',
			'search.tabs.avatarSearch.noResults' => '検索結果が見つかりませんでした',
			'search.tabs.avatarSearch.noResultsHint' => '別のキーワードで試してみましょう',
			'search.tabs.avatarSearch.error' => ({required Object error}) => 'アバター検索中にエラーが発生しました: ${error}',
			'profile.title' => 'プロフィール',
			'profile.edit' => '編集',
			'profile.refresh' => '更新',
			'profile.loading' => 'プロフィール情報を読み込み中...',
			'profile.error' => 'プロフィール情報の取得に失敗しました: {error}',
			'profile.displayName' => '表示名',
			'profile.username' => 'ユーザー名',
			'profile.userId' => 'ユーザーID',
			'profile.engageCard' => 'エンゲージカード',
			'profile.frined' => 'フレンド',
			'profile.dateJoined' => '登録日',
			'profile.userType' => 'ユーザータイプ',
			'profile.status' => 'ステータス',
			'profile.statusMessage' => 'ステータスメッセージ',
			'profile.bio' => '自己紹介',
			'profile.links' => 'リンク',
			'profile.group' => '所属グループ',
			'profile.groupDetail' => 'グループ詳細を表示',
			'profile.avatar' => '現在のアバター',
			'profile.avatarDetail' => 'アバター詳細を表示',
			'profile.public' => '公開',
			'profile.private' => '非公開',
			'profile.hidden' => '非表示',
			'profile.unknown' => '不明',
			'profile.friends' => 'フレンド',
			'profile.loadingLinks' => 'リンク情報を読み込み中...',
			'profile.noGroup' => '所属グループはありません',
			'profile.noBio' => '自己紹介はありません',
			'profile.noLinks' => 'リンクはありません',
			'profile.save' => '変更を保存',
			'profile.saved' => 'プロフィールを更新しました',
			'profile.saveFailed' => '更新に失敗しました: {error}',
			'profile.discardTitle' => '変更を破棄しますか？',
			'profile.discardContent' => 'プロフィールに加えた変更は保存されません。',
			'profile.discardCancel' => 'キャンセル',
			'profile.discardOk' => '破棄する',
			'profile.basic' => '基本情報',
			'profile.pronouns' => '代名詞',
			'profile.addLink' => '追加',
			'profile.removeLink' => '削除',
			'profile.linkHint' => 'リンクを入力 (例: https://twitter.com/username)',
			'profile.linksHint' => 'リンクはプロフィールに表示され、タップすると開くことができます',
			'profile.statusMessageHint' => 'あなたの今の状況やメッセージを入力',
			'profile.bioHint' => 'あなた自身について書いてみましょう',
			'engageCard.pickBackground' => '背景画像を選択',
			'engageCard.removeBackground' => '背景画像を削除',
			'engageCard.scanQr' => 'QRコードをスキャン',
			'engageCard.showAvatar' => 'アバターを表示',
			'engageCard.hideAvatar' => 'アバターを非表示',
			'engageCard.noBackground' => '背景画像が選択されていません\n右上のボタンから設定できます',
			'engageCard.loading' => '読み込み中...',
			'engageCard.error' => ({required Object error}) => 'エンゲージカード情報の取得に失敗しました: ${error}',
			'engageCard.copyUserId' => 'ユーザーIDをコピー',
			'engageCard.copied' => 'コピーしました',
			'qrScanner.title' => 'QRコードスキャン',
			'qrScanner.guide' => 'QRコードを枠内に合わせてください',
			'qrScanner.loading' => 'カメラを初期化中...',
			'qrScanner.error' => ({required Object error}) => 'QRコードの読み取りに失敗しました: ${error}',
			'qrScanner.notFound' => '有効なユーザーQRコードが見つかりません',
			'favorites.title' => 'お気に入り',
			'favorites.frined' => 'フレンド',
			'favorites.friendsTab' => 'フレンド',
			'favorites.worldsTab' => 'ワールド',
			'favorites.avatarsTab' => 'アバター',
			'favorites.emptyFolderTitle' => 'お気に入りフォルダがありません',
			'favorites.emptyFolderDescription' => 'VRChat内でお気に入りフォルダを作成してください',
			'favorites.emptyFriends' => 'このフォルダにはフレンドがいません',
			'favorites.emptyWorlds' => 'このフォルダにはワールドがありません',
			'favorites.emptyAvatars' => 'このフォルダにはアバターがありません',
			'favorites.emptyWorldsTabTitle' => 'お気に入りのワールドがありません',
			'favorites.emptyWorldsTabDescription' => 'ワールド詳細画面からお気に入りに登録できます',
			'favorites.emptyAvatarsTabTitle' => 'お気に入りのアバターがありません',
			'favorites.emptyAvatarsTabDescription' => 'アバター詳細画面からお気に入りに登録できます',
			'favorites.loading' => 'お気に入りを読み込み中...',
			'favorites.loadingFolder' => 'フォルダ情報を読み込み中...',
			'favorites.error' => ({required Object error}) => 'お気に入りの読み込みに失敗しました: ${error}',
			'favorites.errorFolder' => '情報の取得に失敗しました',
			'favorites.remove' => 'お気に入りから削除',
			'favorites.removeSuccess' => ({required Object name}) => '${name}をお気に入りから削除しました',
			'favorites.removeFailed' => ({required Object error}) => '削除に失敗しました: ${error}',
			'favorites.itemsCount' => ({required Object count}) => '${count} アイテム',
			'favorites.public' => '公開',
			'favorites.private' => '非公開',
			'favorites.hidden' => '非表示',
			'favorites.unknown' => '不明',
			'favorites.loadingError' => '読み込みエラー',
			'notifications.emptyTitle' => '通知はありません',
			'notifications.emptyDescription' => 'フレンドリクエストや招待など\n新しい通知がここに表示されます',
			'notifications.friendRequest' => ({required Object userName}) => '${userName}さんからフレンドリクエストが届いています',
			'notifications.invite' => ({required Object userName, required Object worldName}) => '${userName}さんから${worldName}への招待が届いています',
			'notifications.friendOnline' => ({required Object userName}) => '${userName}さんがオンラインになりました',
			'notifications.friendOffline' => ({required Object userName}) => '${userName}さんがオフラインになりました',
			'notifications.friendActive' => ({required Object userName}) => '${userName}さんがアクティブになりました',
			'notifications.friendAdd' => ({required Object userName}) => '${userName}さんがフレンドに追加されました',
			'notifications.friendRemove' => ({required Object userName}) => '${userName}さんがフレンドから削除されました',
			'notifications.statusUpdate' => ({required Object userName, required Object status, required Object world}) => '${userName}さんのステータスが更新されました: ${status}${world}',
			'notifications.locationChange' => ({required Object userName, required Object worldName}) => '${userName}さんが${worldName}に移動しました',
			'notifications.userUpdate' => ({required Object world}) => 'あなたの情報が更新されました${world}',
			'notifications.myLocationChange' => ({required Object worldName}) => 'あなたの移動: ${worldName}',
			'notifications.requestInvite' => ({required Object userName}) => '${userName}さんから参加リクエストが届いています',
			'notifications.votekick' => ({required Object userName}) => '${userName}さんから投票キックがありました',
			'notifications.responseReceived' => ({required Object userName}) => '通知ID:${userName}の応答を受信しました',
			'notifications.error' => ({required Object worldName}) => 'エラー: ${worldName}',
			'notifications.system' => ({required Object extraData}) => 'システム通知: ${extraData}',
			'notifications.secondsAgo' => ({required Object seconds}) => '${seconds}秒前',
			'notifications.minutesAgo' => ({required Object minutes}) => '${minutes}分前',
			'notifications.hoursAgo' => ({required Object hours}) => '${hours}時間前',
			'eventCalendar.title' => 'イベントカレンダー',
			'eventCalendar.filter' => 'イベントを絞り込む',
			'eventCalendar.refresh' => 'イベント情報を更新',
			'eventCalendar.loading' => 'イベント情報を取得中...',
			'eventCalendar.error' => ({required Object error}) => 'イベント情報の取得に失敗しました: ${error}',
			'eventCalendar.filterActive' => ({required Object count}) => 'フィルター適用中（${count}件）',
			'eventCalendar.clear' => 'クリア',
			'eventCalendar.noEvents' => '条件に一致するイベントがありません',
			'eventCalendar.clearFilter' => 'フィルターをクリア',
			'eventCalendar.today' => '今日',
			'eventCalendar.reminderSet' => 'リマインダーを設定',
			'eventCalendar.reminderSetDone' => '設定済みリマインダー',
			'eventCalendar.reminderDeleted' => 'リマインダーを削除しました',
			'eventCalendar.eventName' => 'イベント名',
			'eventCalendar.organizer' => '主催者',
			'eventCalendar.description' => '説明',
			'eventCalendar.genre' => 'ジャンル',
			'eventCalendar.condition' => '参加条件',
			'eventCalendar.way' => '参加方法',
			'eventCalendar.note' => '備考',
			'eventCalendar.quest' => 'Quest対応',
			'eventCalendar.reminderCount' => ({required Object count}) => '${count}件',
			'eventCalendar.startToEnd' => ({required Object start, required Object end}) => '${start}〜${end}',
			'avatars.title' => 'アバター',
			'avatars.searchHint' => 'アバター名などで検索',
			'avatars.searchTooltip' => '検索',
			'avatars.searchEmptyTitle' => '検索結果が見つかりませんでした',
			'avatars.searchEmptyDescription' => '別の検索ワードをお試しください',
			'avatars.emptyTitle' => 'アバターがありません',
			'avatars.emptyDescription' => 'アバターを追加するか、後でもう一度お試しください',
			'avatars.refresh' => '更新する',
			'avatars.loading' => 'アバターを読み込み中...',
			'avatars.error' => ({required Object error}) => 'アバター情報の取得に失敗しました: ${error}',
			'avatars.current' => '使用中',
			'avatars.public' => '公開',
			'avatars.private' => '非公開',
			'avatars.hidden' => '非表示',
			'avatars.author' => '作者',
			'avatars.sortUpdated' => '更新順',
			'avatars.sortName' => '名前順',
			'avatars.sortTooltip' => '並び替え',
			'avatars.viewModeTooltip' => '表示モード切替',
			'worldDetail.loading' => 'ワールド情報を読み込み中...',
			'worldDetail.error' => ({required Object error}) => 'ワールド情報の取得に失敗しました: ${error}',
			'worldDetail.share' => 'このワールドを共有',
			'worldDetail.openInVRChat' => 'VRChat公式サイトで開く',
			'worldDetail.report' => 'このワールドを通報',
			'worldDetail.creator' => '作成者',
			'worldDetail.created' => '作成',
			'worldDetail.updated' => '更新',
			'worldDetail.favorites' => 'お気に入り',
			'worldDetail.visits' => '訪問数',
			'worldDetail.occupants' => '現在の人数',
			'worldDetail.popularity' => '評価',
			'worldDetail.description' => '説明',
			'worldDetail.noDescription' => '説明はありません',
			'worldDetail.tags' => 'タグ',
			'worldDetail.joinPublic' => 'パブリックで招待を送信',
			'worldDetail.favoriteAdded' => 'お気に入りに追加しました',
			'worldDetail.favoriteRemoved' => 'お気に入りから削除しました',
			'worldDetail.unknown' => '不明',
			'avatarDetail.changeSuccess' => ({required Object name}) => 'アバター「${name}」に変更しました',
			'avatarDetail.changeFailed' => ({required Object error}) => 'アバターの変更に失敗しました: ${error}',
			'avatarDetail.changing' => '変更中...',
			'avatarDetail.useThisAvatar' => 'このアバターを使用',
			'avatarDetail.creator' => '作成者',
			'avatarDetail.created' => '作成',
			'avatarDetail.updated' => '更新',
			'avatarDetail.description' => '説明',
			'avatarDetail.noDescription' => '説明はありません',
			'avatarDetail.tags' => 'タグ',
			'avatarDetail.addToFavorites' => 'お気に入りに追加',
			'avatarDetail.public' => '公開',
			'avatarDetail.private' => '非公開',
			'avatarDetail.hidden' => '非表示',
			'avatarDetail.unknown' => '不明',
			'avatarDetail.share' => '共有',
			'avatarDetail.loading' => 'アバター情報を読み込み中...',
			'avatarDetail.error' => ({required Object error}) => 'アバター情報の取得に失敗しました: ${error}',
			'groups.title' => 'グループ',
			'groups.loadingUser' => 'ユーザー情報を読み込み中...',
			'groups.errorUser' => ({required Object error}) => 'ユーザー情報の取得に失敗しました: ${error}',
			'groups.loadingGroups' => 'グループ情報を読み込み中...',
			'groups.errorGroups' => ({required Object error}) => 'グループ情報の取得に失敗しました: ${error}',
			'groups.emptyTitle' => 'グループに参加していません',
			'groups.emptyDescription' => 'VRChatアプリやウェブサイトからグループに参加できます',
			'groups.searchGroups' => 'グループを探す',
			'groups.members' => ({required Object count}) => '${count}人のメンバー',
			'groups.showDetails' => '詳細を表示',
			'groups.unknownName' => '名称不明',
			'groupDetail.loading' => 'グループ情報を読み込み中...',
			'groupDetail.error' => ({required Object error}) => 'グループ情報の取得に失敗しました: ${error}',
			'groupDetail.share' => 'グループ情報を共有',
			'groupDetail.description' => '説明',
			'groupDetail.roles' => 'ロール',
			'groupDetail.basicInfo' => '基本情報',
			'groupDetail.createdAt' => '作成日',
			'groupDetail.owner' => 'オーナー',
			'groupDetail.rules' => 'ルール',
			'groupDetail.languages' => '言語',
			'groupDetail.memberCount' => ({required Object count}) => '${count} メンバー',
			'groupDetail.privacy.public' => '公開',
			'groupDetail.privacy.private' => '非公開',
			'groupDetail.privacy.friends' => 'フレンド',
			'groupDetail.privacy.invite' => '招待制',
			'groupDetail.privacy.unknown' => '不明',
			'groupDetail.role.admin' => '管理者',
			'groupDetail.role.moderator' => 'モデレーター',
			'groupDetail.role.member' => 'メンバー',
			'groupDetail.role.unknown' => '不明',
			'inventory.title' => 'インベントリ',
			'inventory.gallery' => 'ギャラリー',
			'inventory.icon' => 'アイコン',
			'inventory.emoji' => '絵文字',
			'inventory.sticker' => 'ステッカー',
			'inventory.print' => 'プリント',
			'inventory.upload' => 'ファイルをアップロード',
			'inventory.uploadGallery' => 'ギャラリー画像をアップロード中...',
			'inventory.uploadIcon' => 'アイコンをアップロード中...',
			'inventory.uploadEmoji' => '絵文字をアップロード中...',
			'inventory.uploadSticker' => 'ステッカーをアップロード中...',
			'inventory.uploadPrint' => 'プリント画像をアップロード中...',
			'inventory.selectImage' => '画像を選択',
			'inventory.selectFromGallery' => 'ギャラリーから選択',
			'inventory.takePhoto' => 'カメラで撮影',
			'inventory.uploadSuccess' => 'アップロードが完了しました',
			'inventory.uploadFailed' => 'アップロードに失敗しました',
			'inventory.uploadFailedFormat' => 'ファイル形式またはサイズに問題があります。PNG形式で1MB以下の画像を選択してください。',
			'inventory.uploadFailedAuth' => '認証に失敗しました。再度ログインしてください。',
			'inventory.uploadFailedSize' => 'ファイルサイズが大きすぎます。より小さな画像を選択してください。',
			'inventory.uploadFailedServer' => ({required Object code}) => 'サーバーエラーが発生しました (${code})',
			'inventory.pickImageFailed' => ({required Object error}) => '画像の選択に失敗しました: ${error}',
			'inventory.tabs.emojiInventory.loading' => '絵文字を読み込み中...',
			'inventory.tabs.emojiInventory.error' => ({required Object error}) => '絵文字の取得に失敗しました: ${error}',
			'inventory.tabs.emojiInventory.emptyTitle' => '絵文字がありません',
			'inventory.tabs.emojiInventory.emptyDescription' => 'VRChatでアップロードした絵文字がここに表示されます',
			'inventory.tabs.emojiInventory.zoomHint' => 'ダブルタップでズーム',
			'inventory.tabs.galleryInventory.loading' => 'ギャラリーを読み込み中...',
			'inventory.tabs.galleryInventory.error' => ({required Object error}) => 'ギャラリーの取得に失敗しました: ${error}',
			'inventory.tabs.galleryInventory.emptyTitle' => 'ギャラリーがありません',
			'inventory.tabs.galleryInventory.emptyDescription' => 'VRChatでアップロードしたギャラリーがここに表示されます',
			'inventory.tabs.galleryInventory.zoomHint' => 'ダブルタップでズーム',
			'inventory.tabs.iconInventory.loading' => 'アイコンを読み込み中...',
			'inventory.tabs.iconInventory.error' => ({required Object error}) => 'アイコンの取得に失敗しました: ${error}',
			'inventory.tabs.iconInventory.emptyTitle' => 'アイコンがありません',
			'inventory.tabs.iconInventory.emptyDescription' => 'VRChatでアップロードしたアイコンがここに表示されます',
			'inventory.tabs.iconInventory.zoomHint' => 'ダブルタップでズーム',
			'inventory.tabs.printInventory.loading' => 'プリントを読み込み中...',
			'inventory.tabs.printInventory.error' => ({required Object error}) => 'プリントの取得に失敗しました: ${error}',
			'inventory.tabs.printInventory.emptyTitle' => 'プリントがありません',
			'inventory.tabs.printInventory.emptyDescription' => 'VRChatでアップロードしたプリントがここに表示されます',
			'inventory.tabs.printInventory.zoomHint' => 'ダブルタップでズーム',
			'inventory.tabs.stickerInventory.loading' => 'ステッカーを読み込み中...',
			'inventory.tabs.stickerInventory.error' => ({required Object error}) => 'ステッカーの取得に失敗しました: ${error}',
			'inventory.tabs.stickerInventory.emptyTitle' => 'ステッカーがありません',
			'inventory.tabs.stickerInventory.emptyDescription' => 'VRChatでアップロードしたステッカーがここに表示されます',
			'inventory.tabs.stickerInventory.zoomHint' => 'ダブルタップでズーム',
			'vrcnsync.title' => 'VRCNSync (β)',
			'vrcnsync.betaTitle' => 'ベータ版機能',
			'vrcnsync.betaDescription' => 'この機能は開発中のベータ版です。予期せぬ問題が発生する可能性があります。\n現在はローカルのみの実装ですが、クラウド版が需要があれば実装します。',
			'vrcnsync.githubLink' => 'VRCNSyncのGitHubページ',
			'vrcnsync.openGithub' => 'GitHubページを開く',
			'vrcnsync.serverRunning' => 'サーバー実行中',
			'vrcnsync.serverStopped' => 'サーバー停止中',
			'vrcnsync.serverRunningDesc' => 'PCからの写真をVRCNアルバムに保存します',
			'vrcnsync.serverStoppedDesc' => 'サーバーが停止しています',
			'vrcnsync.photoSaved' => '写真をVRCNアルバムに保存しました',
			'vrcnsync.photoReceived' => '写真を受信しました（アルバム保存に失敗）',
			'vrcnsync.openAlbum' => 'アルバムを開く',
			'vrcnsync.permissionErrorIos' => 'フォトライブラリへのアクセス権限が必要です',
			'vrcnsync.permissionErrorAndroid' => 'ストレージへのアクセス権限が必要です',
			'vrcnsync.openSettings' => '設定を開く',
			'vrcnsync.initError' => ({required Object error}) => '初期化に失敗しました: ${error}',
			'vrcnsync.openPhotoAppError' => 'フォトアプリを開けませんでした',
			'vrcnsync.serverInfo' => 'サーバー情報',
			'vrcnsync.ip' => ({required Object ip}) => 'IP: ${ip}',
			'vrcnsync.port' => ({required Object port}) => 'ポート: ${port}',
			'vrcnsync.address' => ({required Object ip, required Object port}) => '${ip}:${port}',
			'vrcnsync.autoSave' => '受信した写真は「VRCN」アルバムに自動保存されます',
			'vrcnsync.usage' => '使用方法',
			'vrcnsync.usageSteps.0.title' => 'PCでVRCNSyncアプリを起動',
			'vrcnsync.usageSteps.0.desc' => 'PCでVRCNSyncアプリを起動してください',
			'vrcnsync.usageSteps.1.title' => '同じWiFiネットワークに接続',
			'vrcnsync.usageSteps.1.desc' => 'PC・モバイル端末を同じWiFiネットワークに接続してください',
			'vrcnsync.usageSteps.2.title' => '接続先にモバイル端末を指定',
			'vrcnsync.usageSteps.2.desc' => 'PCアプリで上記のIPアドレスとポートを指定してください',
			'vrcnsync.usageSteps.3.title' => '写真を送信',
			'vrcnsync.usageSteps.3.desc' => 'PCから写真を送信すると、自動的にVRCNアルバムに保存されます',
			'vrcnsync.stats' => '接続状況',
			'vrcnsync.statServer' => 'サーバー状態',
			'vrcnsync.statServerRunning' => '実行中',
			'vrcnsync.statServerStopped' => '停止中',
			'vrcnsync.statNetwork' => 'ネットワーク',
			'vrcnsync.statNetworkConnected' => '接続済み',
			'vrcnsync.statNetworkDisconnected' => '未接続',
			'feedback.title' => 'フィードバック',
			'feedback.type' => 'フィードバックタイプ',
			'feedback.types.bug' => 'バグ報告',
			'feedback.types.feature' => '機能要望',
			'feedback.types.improvement' => '改善提案',
			'feedback.types.other' => 'その他',
			'feedback.inputTitle' => 'タイトル *',
			'feedback.inputTitleHint' => '簡潔にお聞かせください',
			'feedback.inputDescription' => '詳細説明 *',
			'feedback.inputDescriptionHint' => '詳細な説明をお聞かせください...',
			'feedback.cancel' => 'キャンセル',
			'feedback.send' => '送信',
			'feedback.sending' => '送信中...',
			'feedback.required' => 'タイトルと詳細説明は必須項目です',
			'feedback.success' => 'フィードバックを送信しました。ありがとうございます！',
			'feedback.fail' => 'フィードバックの送信に失敗しました',
			'settings.appearance' => '外観',
			'settings.language' => '言語',
			'settings.languageDescription' => 'アプリの表示言語を選択できます',
			'settings.appIcon' => 'アプリアイコン',
			'settings.appIconDescription' => 'ホーム画面に表示されるアプリのアイコンを変更します',
			'settings.contentSettings' => 'コンテンツ設定',
			'settings.searchEnabled' => '検索機能が有効になりました',
			'settings.searchDisabled' => '検索機能が無効になりました',
			'settings.enableSearch' => '検索機能を有効',
			'settings.enableSearchDescription' => '検索結果に性的なコンテンツや暴力的なコンテンツが表示される可能性があります。',
			'settings.apiSetting' => 'アバター検索API',
			'settings.apiSettingDescription' => 'アバター検索機能のAPIを設定します',
			'settings.apiSettingSaveUrl' => 'URLを保存しました',
			'settings.notSet' => '未設定 (アバター検索機能が使用できません)',
			'settings.notifications' => '通知設定',
			'settings.eventReminder' => 'イベントリマインダー',
			'settings.eventReminderDescription' => '設定したイベントの開始前に通知を受け取ります',
			'settings.manageReminders' => '設定済みリマインダーの管理',
			'settings.manageRemindersDescription' => '通知のキャンセルや確認ができます',
			'settings.dataStorage' => 'データとストレージ',
			'settings.clearCache' => 'キャッシュを削除',
			'settings.clearCacheSuccess' => 'キャッシュを削除しました',
			'settings.clearCacheError' => 'キャッシュの削除中にエラーが発生しました',
			'settings.cacheSize' => ({required Object size}) => 'キャッシュサイズ: ${size}',
			'settings.calculatingCache' => 'キャッシュサイズを計算中...',
			'settings.cacheError' => 'キャッシュサイズを取得できませんでした',
			'settings.confirmClearCache' => 'キャッシュを削除すると、一時的に保存された画像やデータが削除されます。\n\nアカウント情報やアプリの設定は削除されません。',
			'settings.appInfo' => 'アプリ情報',
			'settings.version' => 'バージョン',
			'settings.packageName' => 'パッケージ名',
			'settings.credit' => 'クレジット',
			'settings.creditDescription' => '開発者・貢献者情報',
			'settings.contact' => 'お問い合わせ',
			'settings.contactDescription' => '不具合報告・ご意見はこちら',
			'settings.privacyPolicy' => 'プライバシーポリシー',
			'settings.privacyPolicyDescription' => '個人情報の取り扱いについて',
			'settings.termsOfService' => '利用規約',
			'settings.termsOfServiceDescription' => 'アプリのご利用条件',
			'settings.openSource' => 'オープンソース情報',
			'settings.openSourceDescription' => '使用しているライブラリ等のライセンス',
			'settings.github' => 'GitHubリポジトリ',
			'settings.githubDescription' => 'ソースコードを見る',
			'settings.logoutConfirm' => 'ログアウトしますか？',
			'settings.logoutError' => ({required Object error}) => 'ログアウト中にエラーが発生しました: ${error}',
			'settings.iconChangeNotSupported' => 'お使いのデバイスではアプリアイコンの変更がサポートされていません',
			'settings.iconChangeFailed' => 'アイコンの変更に失敗しました',
			'settings.themeMode' => 'テーマモード',
			'settings.themeModeDescription' => 'アプリの表示テーマを選択できます',
			'settings.themeLight' => '明るい',
			_ => null,
		} ?? switch (path) {
			'settings.themeSystem' => 'システム',
			'settings.themeDark' => '暗い',
			'settings.appIconDefault' => 'デフォルト',
			'settings.appIconIcon' => 'アイコン',
			'settings.appIconLogo' => 'ロゴ',
			'settings.delete' => '削除する',
			'credits.title' => 'クレジット',
			'credits.section.development' => '開発',
			'credits.section.iconPeople' => '愉快なアイコンの人たち',
			'credits.section.testFeedback' => 'テスト・フィードバック',
			'credits.section.specialThanks' => 'スペシャルサンクス',
			'download.success' => 'ダウンロードが完了しました',
			'download.failure' => ({required Object error}) => 'ダウンロードに失敗しました: ${error}',
			'download.shareFailure' => ({required Object error}) => '共有に失敗しました: ${error}',
			'download.permissionTitle' => '権限が必要です',
			'download.permissionDenied' => ({required Object permissionType}) => '${permissionType}への保存権限が拒否されています。\n設定アプリから権限を有効にしてください。',
			'download.permissionCancel' => 'キャンセル',
			'download.permissionOpenSettings' => '設定を開く',
			'download.permissionPhoto' => 'フォト',
			'download.permissionPhotoLibrary' => 'フォトライブラリ',
			'download.permissionStorage' => 'ストレージ',
			'download.permissionPhotoRequired' => '写真への保存権限が必要です',
			'download.permissionPhotoLibraryRequired' => 'フォトライブラリへの保存権限が必要です',
			'download.permissionStorageRequired' => 'ストレージへのアクセス権限が必要です',
			'download.permissionError' => ({required Object error}) => '権限チェック中にエラーが発生しました: ${error}',
			'download.downloading' => ({required Object fileName}) => '${fileName} をダウンロード中...',
			'download.sharing' => ({required Object fileName}) => '${fileName} を共有準備中...',
			'instance.type.public' => 'パブリック',
			'instance.type.hidden' => 'フレンド+',
			'instance.type.friends' => 'フレンド',
			'instance.type.private' => 'インバイト+',
			'instance.type.unknown' => '不明',
			'status.active' => 'オンライン',
			'status.joinMe' => 'だれでもおいで',
			'status.askMe' => 'きいてみてね',
			'status.busy' => '取り込み中',
			'status.offline' => 'オフライン',
			'status.unknown' => 'ステータス不明',
			'location.private' => 'プライベート',
			'location.playerCount' => ({required Object userCount, required Object capacity}) => 'プレイヤー数: ${userCount} / ${capacity}',
			'location.instanceType' => ({required Object type}) => 'インスタンスタイプ: ${type}',
			'location.noInfo' => 'ロケーション情報はありません',
			'location.fetchError' => 'ロケーション情報の取得に失敗しました',
			'location.privateLocation' => 'プライベートな場所にいます',
			'location.inviteSending' => '招待を送信中...',
			'location.inviteSent' => '招待を送信しました。通知から参加できます',
			'location.inviteFailed' => ({required Object error}) => '招待の送信に失敗しました: ${error}',
			'location.inviteButton' => '自分に招待を送信',
			'location.isPrivate' => ({required Object number}) => '${number}人がプライベート',
			'location.isActive' => ({required Object number}) => '${number}人がアクティブ',
			'location.isOffline' => ({required Object number}) => '${number}人がオフライン',
			'location.isTraveling' => ({required Object number}) => '${number}人が移動中',
			'location.isStaying' => ({required Object number}) => '${number}人が滞在中',
			'reminder.dialogTitle' => 'リマインダーを設定',
			'reminder.alreadySet' => '設定済み',
			'reminder.set' => '設定する',
			'reminder.cancel' => 'キャンセル',
			'reminder.delete' => '削除する',
			'reminder.deleteAll' => 'すべてのリマインダーを削除',
			'reminder.deleteAllConfirm' => '設定したすべてのイベントリマインダーを削除します。この操作は元に戻せません。',
			'reminder.deleted' => 'リマインダーを削除しました',
			'reminder.deletedAll' => 'すべてのリマインダーを削除しました',
			'reminder.noReminders' => '設定済みのリマインダーはありません',
			'reminder.setFromEvent' => 'イベントページから通知を設定できます',
			'reminder.eventStart' => ({required Object time}) => '${time} 開始',
			'reminder.notifyAt' => ({required Object time, required Object label}) => '${time} (${label})',
			'reminder.receiveNotification' => 'いつ通知を受け取りますか？',
			'friend.sortFilter' => '並び替え・フィルター',
			'friend.filter' => 'フィルター',
			'friend.filterAll' => 'すべて表示',
			'friend.filterOnline' => 'オンラインのみ',
			'friend.filterOffline' => 'オフラインのみ',
			'friend.filterFavorite' => 'お気に入りのみ',
			'friend.sort' => '並び替え',
			'friend.sortStatus' => 'オンライン状態順',
			'friend.sortName' => '名前順',
			'friend.sortLastLogin' => '最終ログイン順',
			'friend.sortAsc' => '昇順',
			'friend.sortDesc' => '降順',
			'friend.close' => '閉じる',
			'eventCalendarFilter.filterTitle' => 'イベントを絞り込む',
			'eventCalendarFilter.clear' => 'クリア',
			'eventCalendarFilter.keyword' => 'キーワード検索',
			'eventCalendarFilter.keywordHint' => 'イベント名、説明、主催者など',
			'eventCalendarFilter.date' => '日付で絞り込み',
			'eventCalendarFilter.dateHint' => '特定の日付範囲のイベントを表示できます',
			'eventCalendarFilter.startDate' => '開始日',
			'eventCalendarFilter.endDate' => '終了日',
			'eventCalendarFilter.select' => '選択してください',
			'eventCalendarFilter.time' => '時間帯で絞り込み',
			'eventCalendarFilter.timeHint' => '特定の時間帯に開催されるイベントを表示できます',
			'eventCalendarFilter.startTime' => '開始時間',
			'eventCalendarFilter.endTime' => '終了時間',
			'eventCalendarFilter.genre' => 'ジャンルで絞り込み',
			'eventCalendarFilter.genreSelected' => ({required Object count}) => '${count}個のジャンルを選択中',
			'eventCalendarFilter.apply' => '適用する',
			'eventCalendarFilter.filterSummary' => 'フィルター',
			'eventCalendarFilter.filterNone' => 'フィルターは設定されていません',
			_ => null,
		};
	}
}
