///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsJa with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsJa({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
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
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsJa _root = this; // ignore: unused_field

	@override 
	TranslationsJa $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsJa(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$common$ja common = _Translations$common$ja._(_root);
	@override late final _Translations$termsAgreement$ja termsAgreement = _Translations$termsAgreement$ja._(_root);
	@override late final _Translations$drawer$ja drawer = _Translations$drawer$ja._(_root);
	@override late final _Translations$login$ja login = _Translations$login$ja._(_root);
	@override late final _Translations$friends$ja friends = _Translations$friends$ja._(_root);
	@override late final _Translations$friendDetail$ja friendDetail = _Translations$friendDetail$ja._(_root);
	@override late final _Translations$search$ja search = _Translations$search$ja._(_root);
	@override late final _Translations$profile$ja profile = _Translations$profile$ja._(_root);
	@override late final _Translations$engageCard$ja engageCard = _Translations$engageCard$ja._(_root);
	@override late final _Translations$qrScanner$ja qrScanner = _Translations$qrScanner$ja._(_root);
	@override late final _Translations$favorites$ja favorites = _Translations$favorites$ja._(_root);
	@override late final _Translations$notifications$ja notifications = _Translations$notifications$ja._(_root);
	@override late final _Translations$eventCalendar$ja eventCalendar = _Translations$eventCalendar$ja._(_root);
	@override late final _Translations$avatars$ja avatars = _Translations$avatars$ja._(_root);
	@override late final _Translations$worldDetail$ja worldDetail = _Translations$worldDetail$ja._(_root);
	@override late final _Translations$avatarDetail$ja avatarDetail = _Translations$avatarDetail$ja._(_root);
	@override late final _Translations$groups$ja groups = _Translations$groups$ja._(_root);
	@override late final _Translations$groupDetail$ja groupDetail = _Translations$groupDetail$ja._(_root);
	@override late final _Translations$inventory$ja inventory = _Translations$inventory$ja._(_root);
	@override late final _Translations$feedback$ja feedback = _Translations$feedback$ja._(_root);
	@override late final _Translations$settings$ja settings = _Translations$settings$ja._(_root);
	@override late final _Translations$credits$ja credits = _Translations$credits$ja._(_root);
	@override late final _Translations$download$ja download = _Translations$download$ja._(_root);
	@override late final _Translations$instance$ja instance = _Translations$instance$ja._(_root);
	@override late final _Translations$status$ja status = _Translations$status$ja._(_root);
	@override late final _Translations$location$ja location = _Translations$location$ja._(_root);
	@override late final _Translations$reminder$ja reminder = _Translations$reminder$ja._(_root);
	@override late final _Translations$friend$ja friend = _Translations$friend$ja._(_root);
	@override late final _Translations$eventCalendarFilter$ja eventCalendarFilter = _Translations$eventCalendarFilter$ja._(_root);
	@override late final _Translations$activity$ja activity = _Translations$activity$ja._(_root);
	@override late final _Translations$insights$ja insights = _Translations$insights$ja._(_root);
	@override late final _Translations$moderation$ja moderation = _Translations$moderation$ja._(_root);
	@override late final _Translations$tools$ja tools = _Translations$tools$ja._(_root);
	@override late final _Translations$osc$ja osc = _Translations$osc$ja._(_root);
}

// Path: common
class _Translations$common$ja implements Translations$common$en {
	_Translations$common$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'VRCN';
	@override String get ok => 'OK';
	@override String get cancel => 'キャンセル';
	@override String get close => '閉じる';
	@override String get save => '保存';
	@override String get edit => '編集';
	@override String get delete => '削除';
	@override String get yes => 'はい';
	@override String get no => 'いいえ';
	@override String get loading => '読み込み中...';
	@override String error({required Object error}) => 'エラーが発生しました: ${error}';
	@override String get errorNomessage => 'エラーが発生しました';
	@override String get retry => '再試行';
	@override String get search => '検索';
	@override String get settings => '設定';
	@override String get confirm => '確認';
	@override String get agree => '同意する';
	@override String get decline => '同意しない';
	@override String get username => 'ユーザー名';
	@override String get password => 'パスワード';
	@override String get login => 'ログイン';
	@override String get logout => 'ログアウト';
	@override String get share => '共有';
}

// Path: termsAgreement
class _Translations$termsAgreement$ja implements Translations$termsAgreement$en {
	_Translations$termsAgreement$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get welcomeTitle => 'VRCN へようこそ';
	@override String get welcomeMessage => 'アプリをご利用いただく前に\n利用規約とプライバシーポリシーをご確認ください';
	@override String get termsTitle => '利用規約';
	@override String get termsSubtitle => 'アプリのご利用条件について';
	@override String get privacyTitle => 'プライバシーポリシー';
	@override String get privacySubtitle => '個人情報の取り扱いについて';
	@override String agreeTerms({required Object title}) => '「${title}」に同意する';
	@override String get checkContent => '内容を確認';
	@override String get notice => 'このアプリはVRChat Inc.の非公式アプリです。\nVRChat Inc.とは一切関係ありません。';
}

// Path: drawer
class _Translations$drawer$ja implements Translations$drawer$en {
	_Translations$drawer$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get home => 'ホーム';
	@override String get profile => 'プロフィール';
	@override String get favorite => 'お気に入り';
	@override String get eventCalendar => 'イベントカレンダー';
	@override String get avatar => 'アバター';
	@override String get group => 'グループ';
	@override String get inventory => 'インベントリ';
	@override String get review => 'レビュー';
	@override String get feedback => 'フィードバック';
	@override String get settings => '設定';
	@override String get activity => 'アクティビティ';
	@override String get insights => 'インサイト';
	@override String get moderation => 'モデレーション';
	@override String get tools => 'ツール';
	@override String get userLoading => 'ユーザー情報を読み込み中...';
	@override String get userError => 'ユーザー情報の取得に失敗しました';
	@override String get retry => '再試行';
	@override late final _Translations$drawer$section$ja section = _Translations$drawer$section$ja._(_root);
}

// Path: login
class _Translations$login$ja implements Translations$login$en {
	_Translations$login$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get forgotPassword => 'パスワードを忘れた場合';
	@override String get createAccount => 'アカウントを作成';
	@override String get subtitle => 'VRChatのアカウント情報でログイン';
	@override String get email => 'メールアドレス';
	@override String get emailHint => 'メールまたはユーザー名を入力';
	@override String get passwordHint => 'パスワードを入力';
	@override String get rememberMe => 'ログイン状態を保存';
	@override String get loggingIn => 'ログイン中...';
	@override String get errorEmptyEmail => 'ユーザー名またはメールアドレスを入力してください';
	@override String get errorEmptyPassword => 'パスワードを入力してください';
	@override String get errorLoginFailed => 'ログインに失敗しました。メールアドレスとパスワードを確認してください。';
	@override String get twoFactorTitle => '二段階認証';
	@override String get twoFactorSubtitle => '認証コードを入力してください';
	@override String get twoFactorInstruction => '認証アプリに表示されている\n6桁のコードを入力してください';
	@override String get twoFactorCodeHint => '認証コード';
	@override String get verify => '認証';
	@override String get verifying => '認証中...';
	@override String get errorEmpty2fa => '認証コードを入力してください';
	@override String get error2faFailed => '二段階認証に失敗しました。コードが正しいか確認してください。';
	@override String get backToLogin => 'ログイン画面に戻る';
	@override String get paste => 'ペースト';
	@override String get biometricLogin => '生体認証でログイン';
	@override String get biometricReason => '保存したVRChatログイン情報を使うには認証してください。';
	@override String get savedLoginMissing => '保存されたログイン情報がありません。';
}

// Path: friends
class _Translations$friends$ja implements Translations$friends$en {
	_Translations$friends$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get loading => 'フレンド情報を読み込み中...';
	@override String error({required Object error}) => 'フレンドの情報の取得に失敗しました: ${error}';
	@override String get notFound => 'フレンドが見つかりませんでした';
	@override String get private => 'プライベート';
	@override String get active => 'アクティブ';
	@override String get offline => 'オフライン';
	@override String get online => 'オンライン';
	@override String get groupTitle => 'ワールドごとにグループ化';
	@override String get refresh => '更新';
	@override String get searchHint => 'フレンド名で検索';
	@override String get noResult => '該当するフレンドはいません';
}

// Path: friendDetail
class _Translations$friendDetail$ja implements Translations$friendDetail$en {
	_Translations$friendDetail$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get loading => 'ユーザー情報を読み込み中...';
	@override String error({required Object error}) => 'ユーザー情報の取得に失敗しました: ${error}';
	@override String get currentLocation => '現在の場所';
	@override String get basicInfo => '基本情報';
	@override String get userId => 'ユーザーID';
	@override String get dateJoined => '登録日';
	@override String get lastLogin => '最終ログイン';
	@override String get bio => '自己紹介';
	@override String get links => 'リンク';
	@override String get loadingLinks => 'リンク情報を読み込み中...';
	@override String get group => '所属グループ';
	@override String get groupDetail => 'グループ詳細を表示';
	@override String groupCode({required Object code}) => 'グループコード: ${code}';
	@override String memberCount({required Object count}) => 'メンバー数: ${count}人';
	@override String get unknownGroup => '不明なグループ';
	@override String get block => 'ブロック';
	@override String get mute => 'ミュート';
	@override String get openWebsite => 'ウェブサイトで開く';
	@override String get shareProfile => 'プロフィールを共有';
	@override String confirmBlockTitle({required Object name}) => '${name}をブロックしますか？';
	@override String get confirmBlockMessage => 'ブロックすると、このユーザーからのフレンド申請やメッセージを受け取らなくなります。';
	@override String confirmMuteTitle({required Object name}) => '${name}をミュートしますか？';
	@override String get confirmMuteMessage => 'ミュートすると、このユーザーの音声が聞こえなくなります。';
	@override String get blockSuccess => 'ブロックしました';
	@override String get muteSuccess => 'ミュートしました';
	@override String operationFailed({required Object error}) => '操作に失敗しました: ${error}';
	@override String get friendStatusEmpty => 'フレンドの状態を取得できませんでした。';
	@override String get addFriend => 'フレンドに追加';
	@override String get removeFriend => 'フレンドから削除';
	@override String get cancelFriendRequest => 'フレンド申請を取り消す';
	@override String get friendRequestPending => 'フレンド申請中';
	@override String relationshipCompleted({required Object action}) => '${action}しました';
	@override String get note => 'メモ';
	@override String get noNote => 'メモはありません';
	@override String get editNote => 'メモを編集';
	@override String noteTitle({required Object name}) => 'メモ: ${name}';
	@override String get noteHint => '自分だけが見られるメモを書く';
}

// Path: search
class _Translations$search$ja implements Translations$search$en {
	_Translations$search$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get userTab => 'ユーザー';
	@override String get worldTab => 'ワールド';
	@override String get avatarTab => 'アバター';
	@override String get groupTab => 'グループ';
	@override late final _Translations$search$tabs$ja tabs = _Translations$search$tabs$ja._(_root);
}

// Path: profile
class _Translations$profile$ja implements Translations$profile$en {
	_Translations$profile$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'プロフィール';
	@override String get edit => '編集';
	@override String get refresh => '更新';
	@override String get loading => 'プロフィール情報を読み込み中...';
	@override String get error => 'プロフィール情報の取得に失敗しました: {error}';
	@override String get displayName => '表示名';
	@override String get username => 'ユーザー名';
	@override String get userId => 'ユーザーID';
	@override String get engageCard => 'エンゲージカード';
	@override String get frined => 'フレンド';
	@override String get dateJoined => '登録日';
	@override String get userType => 'ユーザータイプ';
	@override String get status => 'ステータス';
	@override String get statusMessage => 'ステータスメッセージ';
	@override String get bio => '自己紹介';
	@override String get links => 'リンク';
	@override String get group => '所属グループ';
	@override String get groupDetail => 'グループ詳細を表示';
	@override String get avatar => '現在のアバター';
	@override String get avatarDetail => 'アバター詳細を表示';
	@override String get public => '公開';
	@override String get private => '非公開';
	@override String get hidden => '非表示';
	@override String get unknown => '不明';
	@override String get friends => 'フレンド';
	@override String get loadingLinks => 'リンク情報を読み込み中...';
	@override String get noGroup => '所属グループはありません';
	@override String get noBio => '自己紹介はありません';
	@override String get noLinks => 'リンクはありません';
	@override String get save => '変更を保存';
	@override String get saved => 'プロフィールを更新しました';
	@override String get saveFailed => '更新に失敗しました: {error}';
	@override String get discardTitle => '変更を破棄しますか？';
	@override String get discardContent => 'プロフィールに加えた変更は保存されません。';
	@override String get discardCancel => 'キャンセル';
	@override String get discardOk => '破棄する';
	@override String get basic => '基本情報';
	@override String get pronouns => '代名詞';
	@override String get addLink => '追加';
	@override String get removeLink => '削除';
	@override String get linkHint => 'リンクを入力 (例: https://twitter.com/username)';
	@override String get linksHint => 'リンクはプロフィールに表示され、タップすると開くことができます';
	@override String get statusMessageHint => 'あなたの今の状況やメッセージを入力';
	@override String get bioHint => 'あなた自身について書いてみましょう';
	@override late final _Translations$profile$userTypes$ja userTypes = _Translations$profile$userTypes$ja._(_root);
}

// Path: engageCard
class _Translations$engageCard$ja implements Translations$engageCard$en {
	_Translations$engageCard$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get pickBackground => '背景画像を選択';
	@override String get removeBackground => '背景画像を削除';
	@override String get scanQr => 'QRコードをスキャン';
	@override String get showAvatar => 'アバターを表示';
	@override String get hideAvatar => 'アバターを非表示';
	@override String get noBackground => '背景画像が選択されていません\n右上のボタンから設定できます';
	@override String get loading => '読み込み中...';
	@override String error({required Object error}) => 'エンゲージカード情報の取得に失敗しました: ${error}';
	@override String get copyUserId => 'ユーザーIDをコピー';
	@override String get copied => 'コピーしました';
}

// Path: qrScanner
class _Translations$qrScanner$ja implements Translations$qrScanner$en {
	_Translations$qrScanner$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'QRコードスキャン';
	@override String get guide => 'QRコードを枠内に合わせてください';
	@override String get loading => 'カメラを初期化中...';
	@override String error({required Object error}) => 'QRコードの読み取りに失敗しました: ${error}';
	@override String get notFound => '有効なユーザーQRコードが見つかりません';
}

// Path: favorites
class _Translations$favorites$ja implements Translations$favorites$en {
	_Translations$favorites$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'お気に入り';
	@override String get frined => 'フレンド';
	@override String get friendsTab => 'フレンド';
	@override String get worldsTab => 'ワールド';
	@override String get avatarsTab => 'アバター';
	@override String get emptyFolderTitle => 'お気に入りフォルダがありません';
	@override String get emptyFolderDescription => 'VRChat内でお気に入りフォルダを作成してください';
	@override String get emptyFriends => 'このフォルダにはフレンドがいません';
	@override String get emptyWorlds => 'このフォルダにはワールドがありません';
	@override String get emptyAvatars => 'このフォルダにはアバターがありません';
	@override String get emptyWorldsTabTitle => 'お気に入りのワールドがありません';
	@override String get emptyWorldsTabDescription => 'ワールド詳細画面からお気に入りに登録できます';
	@override String get emptyAvatarsTabTitle => 'お気に入りのアバターがありません';
	@override String get emptyAvatarsTabDescription => 'アバター詳細画面からお気に入りに登録できます';
	@override String get loading => 'お気に入りを読み込み中...';
	@override String get loadingFolder => 'フォルダ情報を読み込み中...';
	@override String error({required Object error}) => 'お気に入りの読み込みに失敗しました: ${error}';
	@override String get errorFolder => '情報の取得に失敗しました';
	@override String get remove => 'お気に入りから削除';
	@override String removeSuccess({required Object name}) => '${name}をお気に入りから削除しました';
	@override String removeFailed({required Object error}) => '削除に失敗しました: ${error}';
	@override String itemsCount({required Object count}) => '${count} アイテム';
	@override String get public => '公開';
	@override String get private => '非公開';
	@override String get hidden => '非表示';
	@override String get unknown => '不明';
	@override String get loadingError => '読み込みエラー';
}

// Path: notifications
class _Translations$notifications$ja implements Translations$notifications$en {
	_Translations$notifications$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '通知';
	@override String get emptyTitle => '通知はありません';
	@override String get emptyDescription => 'フレンドリクエストや招待など\n新しい通知がここに表示されます';
	@override String get all => 'すべて';
	@override String unread({required Object count}) => '未読 (${count})';
	@override String get read => '既読';
	@override String get activity => 'フレンドログ';
	@override String get onlineAlerts => 'オンライン通知';
	@override String get markAllRead => 'すべて既読にする';
	@override String get markAllReadDone => 'すべての通知を既読にしました';
	@override String get deleteConfirmTitle => '通知を削除しますか？';
	@override String get emptyUnread => '未読通知はありません';
	@override String get emptyRead => '既読通知はありません';
	@override String get friendOnlineAlerts => 'フレンドのオンライン通知';
	@override String selectedCount({required Object count}) => '${count}人選択中';
	@override String friendRequest({required Object userName}) => '${userName}さんからフレンドリクエストが届いています';
	@override String invite({required Object userName, required Object worldName}) => '${userName}さんから${worldName}への招待が届いています';
	@override String friendOnline({required Object userName}) => '${userName}さんがオンラインになりました';
	@override String friendOffline({required Object userName}) => '${userName}さんがオフラインになりました';
	@override String friendActive({required Object userName}) => '${userName}さんがアクティブになりました';
	@override String friendAdd({required Object userName}) => '${userName}さんがフレンドに追加されました';
	@override String friendRemove({required Object userName}) => '${userName}さんがフレンドから削除されました';
	@override String statusUpdate({required Object userName, required Object status, required Object world}) => '${userName}さんのステータスが更新されました: ${status}${world}';
	@override String locationChange({required Object userName, required Object worldName}) => '${userName}さんが${worldName}に移動しました';
	@override String userUpdate({required Object world}) => 'あなたの情報が更新されました${world}';
	@override String myLocationChange({required Object worldName}) => 'あなたの移動: ${worldName}';
	@override String requestInvite({required Object userName}) => '${userName}さんから参加リクエストが届いています';
	@override String votekick({required Object userName}) => '${userName}さんから投票キックがありました';
	@override String responseReceived({required Object userName}) => '通知ID:${userName}の応答を受信しました';
	@override String error({required Object worldName}) => 'エラー: ${worldName}';
	@override String system({required Object extraData}) => 'システム通知: ${extraData}';
	@override String secondsAgo({required Object seconds}) => '${seconds}秒前';
	@override String minutesAgo({required Object minutes}) => '${minutes}分前';
	@override String hoursAgo({required Object hours}) => '${hours}時間前';
	@override String get searchHint => '通知を検索';
	@override String get type => '種類';
	@override String get allTypes => 'すべての種類';
	@override String get responseSent => '応答を送信しました';
	@override String responseFailed({required Object error}) => '応答の送信に失敗しました: ${error}';
	@override String get friendOnlineChannel => 'フレンドのオンライン通知';
	@override String get friendOnlineChannelDescription => '選択したフレンドがオンラインになったときに通知します。';
}

// Path: eventCalendar
class _Translations$eventCalendar$ja implements Translations$eventCalendar$en {
	_Translations$eventCalendar$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'イベントカレンダー';
	@override String get filter => 'イベントを絞り込む';
	@override String get refresh => 'イベント情報を更新';
	@override String get loading => 'イベント情報を取得中...';
	@override String error({required Object error}) => 'イベント情報の取得に失敗しました: ${error}';
	@override String filterActive({required Object count}) => 'フィルター適用中（${count}件）';
	@override String get clear => 'クリア';
	@override String get noEvents => '条件に一致するイベントがありません';
	@override String get clearFilter => 'フィルターをクリア';
	@override String get today => '今日';
	@override String get reminderSet => 'リマインダーを設定';
	@override String get reminderSetDone => '設定済みリマインダー';
	@override String get reminderDeleted => 'リマインダーを削除しました';
	@override String get eventName => 'イベント名';
	@override String get organizer => '主催者';
	@override String get description => '説明';
	@override String get genre => 'ジャンル';
	@override String get condition => '参加条件';
	@override String get way => '参加方法';
	@override String get note => '備考';
	@override String get quest => 'Android対応';
	@override String reminderCount({required Object count}) => '${count}件';
	@override String startToEnd({required Object start, required Object end}) => '${start}〜${end}';
}

// Path: avatars
class _Translations$avatars$ja implements Translations$avatars$en {
	_Translations$avatars$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'アバター';
	@override String get searchHint => 'アバター名などで検索';
	@override String get searchTooltip => '検索';
	@override String get searchEmptyTitle => '検索結果が見つかりませんでした';
	@override String get searchEmptyDescription => '別の検索ワードをお試しください';
	@override String get emptyTitle => 'アバターがありません';
	@override String get emptyDescription => 'アバターを追加するか、後でもう一度お試しください';
	@override String get refresh => '更新する';
	@override String get loading => 'アバターを読み込み中...';
	@override String error({required Object error}) => 'アバター情報の取得に失敗しました: ${error}';
	@override String get current => '使用中';
	@override String get public => '公開';
	@override String get private => '非公開';
	@override String get hidden => '非表示';
	@override String get author => '作者';
	@override String get sortUpdated => '更新順';
	@override String get sortName => '名前順';
	@override String get sortTooltip => '並び替え';
	@override String get remoteTooltip => 'VRChatのアバター';
	@override String get localTooltip => 'ローカルアバターデータベース';
	@override String get localEmptyTitle => 'ローカルアバターはありません';
	@override String get localEmptyDescription => '閲覧・検索したアバターがここに表示されます。';
	@override String get viewModeTooltip => '表示モード切替';
}

// Path: worldDetail
class _Translations$worldDetail$ja implements Translations$worldDetail$en {
	_Translations$worldDetail$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get loading => 'ワールド情報を読み込み中...';
	@override String error({required Object error}) => 'ワールド情報の取得に失敗しました: ${error}';
	@override String get metadataTitle => 'ワールド詳細';
	@override String get capacity => '定員';
	@override String capacityValue({required Object recommended, required Object maximum}) => '${recommended} 推奨 / ${maximum} 最大';
	@override String get releaseStatus => '公開状況';
	@override String get releaseAll => 'すべて';
	@override String get releaseHidden => '非表示';
	@override String get releasePrivate => '非公開';
	@override String get releasePublic => '公開';
	@override String get publicInstances => 'パブリックインスタンス';
	@override String occupantsValue({required Object publicCount, required Object privateCount}) => '${publicCount} パブリック / ${privateCount} プライベート';
	@override String get publication => '公開日';
	@override String get platforms => '対応プラットフォーム';
	@override String get platformAndroid => 'Android';
	@override String get platformIos => 'iOS';
	@override String get platformPc => 'PC';
	@override String get share => 'このワールドを共有';
	@override String get openInVRChat => 'VRChat公式サイトで開く';
	@override String get report => 'このワールドを通報';
	@override String get creator => '作成者';
	@override String get created => '作成';
	@override String get updated => '更新';
	@override String get favorites => 'お気に入り';
	@override String get visits => '訪問数';
	@override String get occupants => '現在の人数';
	@override String get popularity => '評価';
	@override String get description => '説明';
	@override String get noDescription => '説明はありません';
	@override String get tags => 'タグ';
	@override String get joinPublic => 'パブリックで招待を送信';
	@override String get favoriteAdded => 'お気に入りに追加しました';
	@override String get favoriteRemoved => 'お気に入りから削除しました';
	@override String get unknown => '不明';
}

// Path: avatarDetail
class _Translations$avatarDetail$ja implements Translations$avatarDetail$en {
	_Translations$avatarDetail$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String changeSuccess({required Object name}) => 'アバター「${name}」に変更しました';
	@override String changeFailed({required Object error}) => 'アバターの変更に失敗しました: ${error}';
	@override String get changing => '変更中...';
	@override String get useThisAvatar => 'このアバターを使用';
	@override String get creator => '作成者';
	@override String get created => '作成';
	@override String get updated => '更新';
	@override String get description => '説明';
	@override String get noDescription => '説明はありません';
	@override String get tags => 'タグ';
	@override String get addToFavorites => 'お気に入りに追加';
	@override String get public => '公開';
	@override String get private => '非公開';
	@override String get hidden => '非表示';
	@override String get unknown => '不明';
	@override String get share => '共有';
	@override String get loading => 'アバター情報を読み込み中...';
	@override String error({required Object error}) => 'アバター情報の取得に失敗しました: ${error}';
}

// Path: groups
class _Translations$groups$ja implements Translations$groups$en {
	_Translations$groups$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'グループ';
	@override String get loadingUser => 'ユーザー情報を読み込み中...';
	@override String errorUser({required Object error}) => 'ユーザー情報の取得に失敗しました: ${error}';
	@override String get loadingGroups => 'グループ情報を読み込み中...';
	@override String errorGroups({required Object error}) => 'グループ情報の取得に失敗しました: ${error}';
	@override String get emptyTitle => 'グループに参加していません';
	@override String get emptyDescription => 'VRChatアプリやウェブサイトからグループに参加できます';
	@override String get searchGroups => 'グループを探す';
	@override String members({required Object count}) => '${count}人のメンバー';
	@override String get showDetails => '詳細を表示';
	@override String get unknownName => '名称不明';
}

// Path: groupDetail
class _Translations$groupDetail$ja implements Translations$groupDetail$en {
	_Translations$groupDetail$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get loading => 'グループ情報を読み込み中...';
	@override String error({required Object error}) => 'グループ情報の取得に失敗しました: ${error}';
	@override String get share => 'グループ情報を共有';
	@override String get description => '説明';
	@override String get roles => 'ロール';
	@override String get basicInfo => '基本情報';
	@override String get createdAt => '作成日';
	@override String get owner => 'オーナー';
	@override String get rules => 'ルール';
	@override String get languages => '言語';
	@override String memberCount({required Object count}) => '${count} メンバー';
	@override late final _Translations$groupDetail$privacy$ja privacy = _Translations$groupDetail$privacy$ja._(_root);
	@override late final _Translations$groupDetail$role$ja role = _Translations$groupDetail$role$ja._(_root);
}

// Path: inventory
class _Translations$inventory$ja implements Translations$inventory$en {
	_Translations$inventory$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'インベントリ';
	@override String get gallery => 'ギャラリー';
	@override String get icon => 'アイコン';
	@override String get emoji => '絵文字';
	@override String get sticker => 'ステッカー';
	@override String get print => 'プリント';
	@override String get item => 'アイテム';
	@override String get upload => 'ファイルをアップロード';
	@override String get uploadGallery => 'ギャラリー画像をアップロード中...';
	@override String get uploadIcon => 'アイコンをアップロード中...';
	@override String get uploadEmoji => '絵文字をアップロード中...';
	@override String get uploadSticker => 'ステッカーをアップロード中...';
	@override String get uploadPrint => 'プリント画像をアップロード中...';
	@override String get selectImage => '画像を選択';
	@override String get selectFromGallery => 'ギャラリーから選択';
	@override String get takePhoto => 'カメラで撮影';
	@override String get uploadSuccess => 'アップロードが完了しました';
	@override String get uploadFailed => 'アップロードに失敗しました';
	@override String get uploadFailedFormat => 'ファイル形式またはサイズに問題があります。PNG形式で1MB以下の画像を選択してください。';
	@override String get uploadFailedAuth => '認証に失敗しました。再度ログインしてください。';
	@override String get uploadFailedSize => 'ファイルサイズが大きすぎます。より小さな画像を選択してください。';
	@override String uploadFailedServer({required Object code}) => 'サーバーエラーが発生しました (${code})';
	@override String pickImageFailed({required Object error}) => '画像の選択に失敗しました: ${error}';
	@override late final _Translations$inventory$tabs$ja tabs = _Translations$inventory$tabs$ja._(_root);
}

// Path: feedback
class _Translations$feedback$ja implements Translations$feedback$en {
	_Translations$feedback$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'フィードバック';
	@override String get type => 'フィードバックタイプ';
	@override Map<String, String> get types => {
		'bug': 'バグ報告',
		'feature': '機能要望',
		'improvement': '改善提案',
		'other': 'その他',
	};
	@override String get inputTitle => 'タイトル *';
	@override String get inputTitleHint => '簡潔にお聞かせください';
	@override String get inputDescription => '詳細説明 *';
	@override String get inputDescriptionHint => '詳細な説明をお聞かせください...';
	@override String get cancel => 'キャンセル';
	@override String get send => '送信';
	@override String get sending => '送信中...';
	@override String get required => 'タイトルと詳細説明は必須項目です';
	@override String get success => 'フィードバックを送信しました。ありがとうございます！';
	@override String get fail => 'フィードバックの送信に失敗しました';
}

// Path: settings
class _Translations$settings$ja implements Translations$settings$en {
	_Translations$settings$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get appearance => '外観';
	@override String get language => '言語';
	@override String get languageDescription => 'アプリの表示言語を選択できます';
	@override String get appIcon => 'アプリアイコン';
	@override String get appIconDescription => 'ホーム画面に表示されるアプリのアイコンを変更します';
	@override String get contentSettings => 'コンテンツ設定';
	@override String get searchEnabled => '検索機能が有効になりました';
	@override String get searchDisabled => '検索機能が無効になりました';
	@override String get enableSearch => '検索機能を有効';
	@override String get enableSearchDescription => '検索結果に性的なコンテンツや暴力的なコンテンツが表示される可能性があります。';
	@override String get apiSetting => 'アバター検索API';
	@override String get apiSettingDescription => 'アバター検索機能のAPIを設定します';
	@override String get apiSettingSaveUrl => 'URLを保存しました';
	@override String get notSet => '未設定 (アバター検索機能が使用できません)';
	@override String get notifications => '通知設定';
	@override String get eventReminder => 'イベントリマインダー';
	@override String get eventReminderDescription => '設定したイベントの開始前に通知を受け取ります';
	@override String get manageReminders => '設定済みリマインダーの管理';
	@override String get manageRemindersDescription => '通知のキャンセルや確認ができます';
	@override String get dataStorage => 'データとストレージ';
	@override String get clearCache => 'キャッシュを削除';
	@override String get clearCacheSuccess => 'キャッシュを削除しました';
	@override String get clearCacheError => 'キャッシュの削除中にエラーが発生しました';
	@override String cacheSize({required Object size}) => 'キャッシュサイズ: ${size}';
	@override String get calculatingCache => 'キャッシュサイズを計算中...';
	@override String get cacheError => 'キャッシュサイズを取得できませんでした';
	@override String get confirmClearCache => 'キャッシュを削除すると、一時的に保存された画像やデータが削除されます。\n\nアカウント情報やアプリの設定は削除されません。';
	@override String get appInfo => 'アプリ情報';
	@override String get version => 'バージョン';
	@override String get packageName => 'パッケージ名';
	@override String get credit => 'クレジット';
	@override String get creditDescription => '開発者・貢献者情報';
	@override String get contact => 'お問い合わせ';
	@override String get contactDescription => '不具合報告・ご意見はこちら';
	@override String get privacyPolicy => 'プライバシーポリシー';
	@override String get privacyPolicyDescription => '個人情報の取り扱いについて';
	@override String get termsOfService => '利用規約';
	@override String get termsOfServiceDescription => 'アプリのご利用条件';
	@override String get openSource => 'オープンソース情報';
	@override String get openSourceDescription => '使用しているライブラリ等のライセンス';
	@override String get github => 'GitHubリポジトリ';
	@override String get githubDescription => 'ソースコードを見る';
	@override String get logoutConfirm => 'ログアウトしますか？';
	@override String logoutError({required Object error}) => 'ログアウト中にエラーが発生しました: ${error}';
	@override String get iconChangeNotSupported => 'お使いのデバイスではアプリアイコンの変更がサポートされていません';
	@override String get iconChangeFailed => 'アイコンの変更に失敗しました';
	@override String get themeMode => 'テーマモード';
	@override String get themeModeDescription => 'アプリの表示テーマを選択できます';
	@override String get themeLight => '明るい';
	@override String get themeSystem => 'システム';
	@override String get themeDark => '暗い';
	@override String get appIconDefault => 'デフォルト';
	@override String get appIconIcon => 'アイコン';
	@override String get appIconLogo => 'ロゴ';
	@override String get delete => '削除する';
}

// Path: credits
class _Translations$credits$ja implements Translations$credits$en {
	_Translations$credits$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'クレジット';
	@override late final _Translations$credits$section$ja section = _Translations$credits$section$ja._(_root);
}

// Path: download
class _Translations$download$ja implements Translations$download$en {
	_Translations$download$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String shareFailure({required Object error}) => '共有に失敗しました: ${error}';
	@override String sharing({required Object fileName}) => '${fileName} を共有準備中...';
}

// Path: instance
class _Translations$instance$ja implements Translations$instance$en {
	_Translations$instance$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override late final _Translations$instance$type$ja type = _Translations$instance$type$ja._(_root);
}

// Path: status
class _Translations$status$ja implements Translations$status$en {
	_Translations$status$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get active => 'オンライン';
	@override String get joinMe => 'だれでもおいで';
	@override String get askMe => 'きいてみてね';
	@override String get busy => '取り込み中';
	@override String get offline => 'オフライン';
	@override String get unknown => 'ステータス不明';
}

// Path: location
class _Translations$location$ja implements Translations$location$en {
	_Translations$location$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get private => 'プライベート';
	@override String get traveling => '移動中';
	@override String playerCount({required Object userCount, required Object capacity}) => 'プレイヤー数: ${userCount} / ${capacity}';
	@override String instanceType({required Object type}) => 'インスタンスタイプ: ${type}';
	@override String get noInfo => 'ロケーション情報はありません';
	@override String get fetchError => 'ロケーション情報の取得に失敗しました';
	@override String get privateLocation => 'プライベートな場所にいます';
	@override String get inviteSending => '招待を送信中...';
	@override String get inviteSent => '招待を送信しました。通知から参加できます';
	@override String inviteFailed({required Object error}) => '招待の送信に失敗しました: ${error}';
	@override String get inviteButton => '自分に招待を送信';
	@override String isPrivate({required Object number}) => '${number}人がプライベート';
	@override String isActive({required Object number}) => '${number}人がアクティブ';
	@override String isOffline({required Object number}) => '${number}人がオフライン';
	@override String isTraveling({required Object number}) => '${number}人が移動中';
	@override String isStaying({required Object number}) => '${number}人が滞在中';
}

// Path: reminder
class _Translations$reminder$ja implements Translations$reminder$en {
	_Translations$reminder$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get dialogTitle => 'リマインダーを設定';
	@override String get alreadySet => '設定済み';
	@override String get set => '設定する';
	@override String get cancel => 'キャンセル';
	@override String get delete => '削除する';
	@override String get deleteAll => 'すべてのリマインダーを削除';
	@override String get deleteAllConfirm => '設定したすべてのイベントリマインダーを削除します。この操作は元に戻せません。';
	@override String get deleted => 'リマインダーを削除しました';
	@override String get deletedAll => 'すべてのリマインダーを削除しました';
	@override String get noReminders => '設定済みのリマインダーはありません';
	@override String get setFromEvent => 'イベントページから通知を設定できます';
	@override String eventStart({required Object time}) => '${time} 開始';
	@override String notifyAt({required Object time, required Object label}) => '${time} (${label})';
	@override String get receiveNotification => 'いつ通知を受け取りますか？';
}

// Path: friend
class _Translations$friend$ja implements Translations$friend$en {
	_Translations$friend$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get sortFilter => '並び替え・フィルター';
	@override String get filter => 'フィルター';
	@override String get filterAll => 'すべて表示';
	@override String get filterOnline => 'オンラインのみ';
	@override String get filterOffline => 'オフラインのみ';
	@override String get filterFavorite => 'お気に入りのみ';
	@override String get sort => '並び替え';
	@override String get sortStatus => 'オンライン状態順';
	@override String get sortName => '名前順';
	@override String get sortLastLogin => '最終ログイン順';
	@override String get sortAsc => '昇順';
	@override String get sortDesc => '降順';
	@override String get close => '閉じる';
	@override String get searchTitle => 'フレンドを検索';
	@override String get searchHint => '名前、ユーザーID、場所';
}

// Path: eventCalendarFilter
class _Translations$eventCalendarFilter$ja implements Translations$eventCalendarFilter$en {
	_Translations$eventCalendarFilter$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get filterTitle => 'イベントを絞り込む';
	@override String get clear => 'クリア';
	@override String get keyword => 'キーワード検索';
	@override String get keywordHint => 'イベント名、説明、主催者など';
	@override String get date => '日付で絞り込み';
	@override String get dateHint => '特定の日付範囲のイベントを表示できます';
	@override String get startDate => '開始日';
	@override String get endDate => '終了日';
	@override String get select => '選択してください';
	@override String get time => '時間帯で絞り込み';
	@override String get timeHint => '特定の時間帯に開催されるイベントを表示できます';
	@override String get startTime => '開始時間';
	@override String get endTime => '終了時間';
	@override String get genre => 'ジャンルで絞り込み';
	@override String genreSelected({required Object count}) => '${count}個のジャンルを選択中';
	@override String get apply => '適用する';
	@override String get filterSummary => 'フィルター';
	@override String get filterNone => 'フィルターは設定されていません';
}

// Path: activity
class _Translations$activity$ja implements Translations$activity$en {
	_Translations$activity$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'アクティビティ';
	@override String get clearHistory => 'アクティビティ履歴を削除';
	@override String get feed => 'フィード';
	@override String get friendLog => 'フレンドログ';
	@override String get heatmap => 'ヒートマップ';
	@override String get empty => 'アクティビティはまだありません。';
	@override String trackedHours({required Object hours, required Object minutes}) => '${hours}時間${minutes}分を記録';
	@override String trackedMinutes({required Object minutes}) => '${minutes}分を記録';
	@override String summary({required Object kind, required Object detail}) => '${kind} · ${detail}';
	@override String get heatmapTitle => '過去6週間のフレンドアクティビティ';
	@override late final _Translations$activity$kind$ja kind = _Translations$activity$kind$ja._(_root);
}

// Path: insights
class _Translations$insights$ja implements Translations$insights$en {
	_Translations$insights$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'インサイト';
	@override String get mutualFriends => '相互フレンド';
	@override String get hotWorlds => '人気のワールド';
	@override String get instancePlayers => 'インスタンスの参加者';
	@override String get userHint => 'ユーザーID (usr_...)';
	@override String get enterUser => '比較するユーザーIDを入力してください。';
	@override String get noMutual => '相互フレンドはいません。';
	@override String get noLocations => 'フレンドの場所がありません。';
	@override String friendsCount({required Object count}) => '${count}人のフレンド';
	@override String get locationHint => '場所 (wrld_...:instance)';
	@override String get enterLocation => 'インスタンスの場所を入力してください。';
	@override String get noPlayers => '表示できるプレイヤーはいません。';
	@override String get load => '読み込む';
}

// Path: moderation
class _Translations$moderation$ja implements Translations$moderation$en {
	_Translations$moderation$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'モデレーション';
	@override String get clearPlayer => 'プレイヤーのモデレーションを削除';
	@override String get player => 'プレイヤー';
	@override String get groupBans => 'グループBAN';
	@override String get cleared => 'プレイヤーのモデレーションを削除しました';
	@override String get noPlayer => 'プレイヤーのモデレーションはありません。';
	@override String get remove => 'モデレーションを削除';
	@override String get groupHint => 'グループID (grp_...)';
	@override String get loadBans => 'BANを読み込む';
	@override String get enterGroup => 'グループIDを入力してください。';
	@override String get noGroup => 'グループBANはありません。';
	@override String get unban => 'BANを解除';
}

// Path: tools
class _Translations$tools$ja implements Translations$tools$en {
	_Translations$tools$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'ツール';
	@override String get groups => 'グループ';
	@override String get myAvatars => '所有アバター';
	@override String get status => 'ステータス';
	@override String get data => 'データ';
	@override String get server => 'サーバー';
	@override String get groupHint => 'グループID (grp_...)';
	@override String get loadGroup => 'グループを読み込む';
	@override String get join => '参加';
	@override String get leave => '退出';
	@override String get members => 'メンバー';
	@override String get bans => 'BAN';
	@override String get calendar => 'カレンダー';
	@override String get enterGroup => '管理するグループIDを入力してください。';
	@override String get noMembers => 'メンバーはいません。';
	@override String get banMember => 'メンバーをBAN';
	@override String get noGroupBans => 'グループBANはありません。';
	@override String get unbanMember => 'メンバーのBANを解除';
	@override String get noCalendar => 'グループのカレンダーイベントはありません。';
	@override String get followEvent => 'イベントをフォロー';
	@override String get unfollowEvent => 'イベントのフォローを解除';
	@override String get ownAvatars => '所有アバター';
	@override String get noOwnAvatars => '所有アバターが見つかりません。';
	@override String get editAvatar => 'アバターを編集';
	@override String get worldMetadata => 'ワールドメタデータ';
	@override String get worldId => 'ワールドID';
	@override String get worldHint => 'wrld_...';
	@override String get loadWorld => 'ワールドIDを読み込む';
	@override String get editWorldMetadata => 'ワールドメタデータを編集';
	@override String get worldPermissionHint => 'アカウントに権限があるワールドのみ編集できます。';
	@override String get statusPresets => 'ステータスプリセット';
	@override String get addPreset => 'プリセットを追加';
	@override String get applyPreset => 'プリセットを適用';
	@override String get deletePreset => 'プリセットを削除';
	@override String get applyPresetOnLogin => 'ログイン時にプリセットを適用';
	@override String get restoreStatus => 'ログイン後に選択したソーシャルステータスを復元します。';
	@override String get automaticPreset => '自動プリセット';
	@override String get discordNames => 'Discord名';
	@override String get scanFriendProfiles => 'フレンドのプロフィールをスキャン';
	@override String get exportDiscordNames => 'Discord名をエクスポート';
	@override String get noLinkedNames => 'リンクされた名前はまだありません。プロフィールの自己紹介にDiscord名を追加するか、インポート／エクスポートを使用してください。';
	@override String get dataTransfer => 'データ移行';
	@override String get dataTransferDescription => 'アクティビティ、メモ、アラート、プリセットを端末間で移行します。';
	@override String get exportData => 'データをエクスポート';
	@override String get importData => 'データをインポート';
	@override String get dataExportHint => 'バージョン付きJSON形式でエクスポートします。APIの内容は自動で上書きされません。インポートではローカルアプリデータのみ復元します。';
	@override String get apiOnline => 'VRChat APIはオンラインです';
	@override String get apiDegraded => 'VRChat APIの性能が低下しています';
	@override String get apiUnavailable => 'APIの状態を取得できません';
	@override String get serverRefreshHint => '引っ張って最新のサーバー状態を更新します。';
	@override String get groupActionCompleted => 'グループ操作が完了しました';
	@override String get editAvatarDialog => 'アバターを編集';
	@override String get editWorldDialog => 'ワールドメタデータを編集';
	@override String get newStatusPreset => '新しいステータスプリセット';
	@override String get name => '名前';
	@override String get description => '説明';
	@override String get capacity => '定員';
	@override String get tags => 'タグ（カンマ区切り）';
	@override String get pasteExport => 'VRCNのJSONエクスポートを貼り付け';
	@override String get dataImported => 'データをインポートしました';
	@override String importFailed({required Object error}) => 'インポートに失敗しました: ${error}';
	@override String get statusAvailable => 'オンライン';
	@override String get statusAskMe => '応答を求める';
	@override String get statusBusy => '取り込み中';
	@override String get statusJoinMe => '参加してほしい';
}

// Path: osc
class _Translations$osc$ja implements Translations$osc$en {
	_Translations$osc$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get floatType => '小数 (0.0～1.0)';
	@override String get intType => '整数';
	@override String get boolType => '真偽値 (オン／オフ)';
	@override String get on => 'オン';
	@override String get off => 'オフ';
}

// Path: drawer.section
class _Translations$drawer$section$ja implements Translations$drawer$section$en {
	_Translations$drawer$section$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get content => 'コンテンツ';
	@override String get other => 'その他';
}

// Path: search.tabs
class _Translations$search$tabs$ja implements Translations$search$tabs$en {
	_Translations$search$tabs$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override late final _Translations$search$tabs$userSearch$ja userSearch = _Translations$search$tabs$userSearch$ja._(_root);
	@override late final _Translations$search$tabs$worldSearch$ja worldSearch = _Translations$search$tabs$worldSearch$ja._(_root);
	@override late final _Translations$search$tabs$groupSearch$ja groupSearch = _Translations$search$tabs$groupSearch$ja._(_root);
	@override late final _Translations$search$tabs$avatarSearch$ja avatarSearch = _Translations$search$tabs$avatarSearch$ja._(_root);
}

// Path: profile.userTypes
class _Translations$profile$userTypes$ja implements Translations$profile$userTypes$en {
	_Translations$profile$userTypes$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get admin => '管理者';
	@override String get trusted => '信頼済み';
	@override String get known => '既知';
	@override String get user => 'ユーザー';
	@override String get newUser => '新規ユーザー';
	@override String get visitor => 'ビジター';
}

// Path: groupDetail.privacy
class _Translations$groupDetail$privacy$ja implements Translations$groupDetail$privacy$en {
	_Translations$groupDetail$privacy$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get public => '公開';
	@override String get private => '非公開';
	@override String get friends => 'フレンド';
	@override String get invite => '招待制';
	@override String get unknown => '不明';
}

// Path: groupDetail.role
class _Translations$groupDetail$role$ja implements Translations$groupDetail$role$en {
	_Translations$groupDetail$role$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get admin => '管理者';
	@override String get moderator => 'モデレーター';
	@override String get member => 'メンバー';
	@override String get unknown => '不明';
}

// Path: inventory.tabs
class _Translations$inventory$tabs$ja implements Translations$inventory$tabs$en {
	_Translations$inventory$tabs$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override late final _Translations$inventory$tabs$emojiInventory$ja emojiInventory = _Translations$inventory$tabs$emojiInventory$ja._(_root);
	@override late final _Translations$inventory$tabs$galleryInventory$ja galleryInventory = _Translations$inventory$tabs$galleryInventory$ja._(_root);
	@override late final _Translations$inventory$tabs$iconInventory$ja iconInventory = _Translations$inventory$tabs$iconInventory$ja._(_root);
	@override late final _Translations$inventory$tabs$printInventory$ja printInventory = _Translations$inventory$tabs$printInventory$ja._(_root);
	@override late final _Translations$inventory$tabs$stickerInventory$ja stickerInventory = _Translations$inventory$tabs$stickerInventory$ja._(_root);
	@override late final _Translations$inventory$tabs$inventoryItem$ja inventoryItem = _Translations$inventory$tabs$inventoryItem$ja._(_root);
}

// Path: credits.section
class _Translations$credits$section$ja implements Translations$credits$section$en {
	_Translations$credits$section$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get development => '開発';
	@override String get iconPeople => '愉快なアイコンの人たち';
	@override String get testFeedback => 'テスト・フィードバック';
	@override String get specialThanks => 'スペシャルサンクス';
}

// Path: instance.type
class _Translations$instance$type$ja implements Translations$instance$type$en {
	_Translations$instance$type$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get public => 'パブリック';
	@override String get hidden => 'フレンド+';
	@override String get friends => 'フレンド';
	@override String get private => 'インバイト+';
	@override String get group => 'グループ';
	@override String get unknown => '不明';
}

// Path: activity.kind
class _Translations$activity$kind$ja implements Translations$activity$kind$en {
	_Translations$activity$kind$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get friendOnline => 'フレンドがオンラインになりました';
	@override String get friendOffline => 'フレンドがオフラインになりました';
	@override String get friendActive => 'フレンドがアクティブになりました';
	@override String get friendAdd => 'フレンドを追加しました';
	@override String get friendRemove => 'フレンドを削除しました';
	@override String get locationChange => '場所が変更されました';
	@override String get statusUpdate => 'ステータスを更新しました';
	@override String get activity => 'アクティビティ';
}

// Path: search.tabs.userSearch
class _Translations$search$tabs$userSearch$ja implements Translations$search$tabs$userSearch$en {
	_Translations$search$tabs$userSearch$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get emptyTitle => 'ユーザー検索';
	@override String get emptyDescription => 'ユーザー名やIDで検索できます';
	@override String get searching => '検索中...';
	@override String get noResults => '該当するユーザーが見つかりません';
	@override String error({required Object error}) => 'ユーザー検索中にエラーが発生しました: ${error}';
	@override String get inputPlaceholder => 'ユーザー名またはIDを入力';
}

// Path: search.tabs.worldSearch
class _Translations$search$tabs$worldSearch$ja implements Translations$search$tabs$worldSearch$en {
	_Translations$search$tabs$worldSearch$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get emptyTitle => 'ワールドを探索';
	@override String get emptyDescription => 'キーワードを入力して検索してください';
	@override String get searching => '検索中...';
	@override String get noResults => '該当するワールドが見つかりませんでした';
	@override String noResultsWithQuery({required Object query}) => '「${query}」に一致するワールドが\n見つかりませんでした';
	@override String get noResultsHint => '検索キーワードを変えてみましょう';
	@override String error({required Object error}) => 'ワールド検索中にエラーが発生しました: ${error}';
	@override String resultCount({required Object count}) => '${count}件のワールドが見つかりました';
	@override String authorPrefix({required Object authorName}) => 'by ${authorName}';
	@override String get listView => 'リストビュー';
	@override String get gridView => 'グリッドビュー';
}

// Path: search.tabs.groupSearch
class _Translations$search$tabs$groupSearch$ja implements Translations$search$tabs$groupSearch$en {
	_Translations$search$tabs$groupSearch$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get emptyTitle => 'グループを検索';
	@override String get emptyDescription => 'キーワードを入力して検索してください';
	@override String get searching => '検索中...';
	@override String get noResults => '該当するグループが見つかりませんでした';
	@override String noResultsWithQuery({required Object query}) => '「${query}」に一致するグループが\n見つかりませんでした';
	@override String get noResultsHint => '検索キーワードを変えてみましょう';
	@override String error({required Object error}) => 'グループ検索中にエラーが発生しました: ${error}';
	@override String resultCount({required Object count}) => '${count}件のグループが見つかりました';
	@override String get listView => 'リストビュー';
	@override String get gridView => 'グリッドビュー';
	@override String memberCount({required Object count}) => '${count} メンバー';
}

// Path: search.tabs.avatarSearch
class _Translations$search$tabs$avatarSearch$ja implements Translations$search$tabs$avatarSearch$en {
	_Translations$search$tabs$avatarSearch$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get avatar => 'アバター';
	@override String get emptyTitle => 'アバターを検索';
	@override String get emptyDescription => 'キーワードを入力して検索してください';
	@override String get searching => 'アバターを検索中...';
	@override String get noResults => '検索結果が見つかりませんでした';
	@override String get noResultsHint => '別のキーワードで試してみましょう';
	@override String error({required Object error}) => 'アバター検索中にエラーが発生しました: ${error}';
}

// Path: inventory.tabs.emojiInventory
class _Translations$inventory$tabs$emojiInventory$ja implements Translations$inventory$tabs$emojiInventory$en {
	_Translations$inventory$tabs$emojiInventory$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get loading => '絵文字を読み込み中...';
	@override String error({required Object error}) => '絵文字の取得に失敗しました: ${error}';
	@override String get emptyTitle => '絵文字がありません';
	@override String get emptyDescription => 'VRChatでアップロードした絵文字がここに表示されます';
	@override String get zoomHint => 'ダブルタップでズーム';
}

// Path: inventory.tabs.galleryInventory
class _Translations$inventory$tabs$galleryInventory$ja implements Translations$inventory$tabs$galleryInventory$en {
	_Translations$inventory$tabs$galleryInventory$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get loading => 'ギャラリーを読み込み中...';
	@override String error({required Object error}) => 'ギャラリーの取得に失敗しました: ${error}';
	@override String get emptyTitle => 'ギャラリーがありません';
	@override String get emptyDescription => 'VRChatでアップロードしたギャラリーがここに表示されます';
	@override String get zoomHint => 'ダブルタップでズーム';
}

// Path: inventory.tabs.iconInventory
class _Translations$inventory$tabs$iconInventory$ja implements Translations$inventory$tabs$iconInventory$en {
	_Translations$inventory$tabs$iconInventory$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get loading => 'アイコンを読み込み中...';
	@override String error({required Object error}) => 'アイコンの取得に失敗しました: ${error}';
	@override String get emptyTitle => 'アイコンがありません';
	@override String get emptyDescription => 'VRChatでアップロードしたアイコンがここに表示されます';
	@override String get zoomHint => 'ダブルタップでズーム';
}

// Path: inventory.tabs.printInventory
class _Translations$inventory$tabs$printInventory$ja implements Translations$inventory$tabs$printInventory$en {
	_Translations$inventory$tabs$printInventory$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get loading => 'プリントを読み込み中...';
	@override String error({required Object error}) => 'プリントの取得に失敗しました: ${error}';
	@override String get emptyTitle => 'プリントがありません';
	@override String get emptyDescription => 'VRChatでアップロードしたプリントがここに表示されます';
	@override String get zoomHint => 'ダブルタップでズーム';
}

// Path: inventory.tabs.stickerInventory
class _Translations$inventory$tabs$stickerInventory$ja implements Translations$inventory$tabs$stickerInventory$en {
	_Translations$inventory$tabs$stickerInventory$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get loading => 'ステッカーを読み込み中...';
	@override String error({required Object error}) => 'ステッカーの取得に失敗しました: ${error}';
	@override String get emptyTitle => 'ステッカーがありません';
	@override String get emptyDescription => 'VRChatでアップロードしたステッカーがここに表示されます';
	@override String get zoomHint => 'ダブルタップでズーム';
}

// Path: inventory.tabs.inventoryItem
class _Translations$inventory$tabs$inventoryItem$ja implements Translations$inventory$tabs$inventoryItem$en {
	_Translations$inventory$tabs$inventoryItem$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get loading => 'インベントリを読み込み中...';
	@override String error({required Object error}) => 'インベントリの取得に失敗しました: ${error}';
	@override String get emptyTitle => 'インベントリアイテムがありません';
	@override String get spawn => 'スポーン';
	@override String get unequip => '装備解除';
	@override String equipped({required Object slot}) => '装備中: ${slot}';
	@override String spawned({required Object name}) => '${name}をスポーンしました';
}

/// The flat map containing all translations for locale <ja>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsJa {
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
			'drawer.review' => 'レビュー',
			'drawer.feedback' => 'フィードバック',
			'drawer.settings' => '設定',
			'drawer.activity' => 'アクティビティ',
			'drawer.insights' => 'インサイト',
			'drawer.moderation' => 'モデレーション',
			'drawer.tools' => 'ツール',
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
			'login.biometricLogin' => '生体認証でログイン',
			'login.biometricReason' => '保存したVRChatログイン情報を使うには認証してください。',
			'login.savedLoginMissing' => '保存されたログイン情報がありません。',
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
			'friendDetail.friendStatusEmpty' => 'フレンドの状態を取得できませんでした。',
			'friendDetail.addFriend' => 'フレンドに追加',
			'friendDetail.removeFriend' => 'フレンドから削除',
			'friendDetail.cancelFriendRequest' => 'フレンド申請を取り消す',
			'friendDetail.friendRequestPending' => 'フレンド申請中',
			'friendDetail.relationshipCompleted' => ({required Object action}) => '${action}しました',
			'friendDetail.note' => 'メモ',
			'friendDetail.noNote' => 'メモはありません',
			'friendDetail.editNote' => 'メモを編集',
			'friendDetail.noteTitle' => ({required Object name}) => 'メモ: ${name}',
			'friendDetail.noteHint' => '自分だけが見られるメモを書く',
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
			'profile.userTypes.admin' => '管理者',
			'profile.userTypes.trusted' => '信頼済み',
			'profile.userTypes.known' => '既知',
			'profile.userTypes.user' => 'ユーザー',
			'profile.userTypes.newUser' => '新規ユーザー',
			'profile.userTypes.visitor' => 'ビジター',
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
			'notifications.title' => '通知',
			'notifications.emptyTitle' => '通知はありません',
			'notifications.emptyDescription' => 'フレンドリクエストや招待など\n新しい通知がここに表示されます',
			'notifications.all' => 'すべて',
			'notifications.unread' => ({required Object count}) => '未読 (${count})',
			'notifications.read' => '既読',
			'notifications.activity' => 'フレンドログ',
			'notifications.onlineAlerts' => 'オンライン通知',
			'notifications.markAllRead' => 'すべて既読にする',
			'notifications.markAllReadDone' => 'すべての通知を既読にしました',
			'notifications.deleteConfirmTitle' => '通知を削除しますか？',
			'notifications.emptyUnread' => '未読通知はありません',
			'notifications.emptyRead' => '既読通知はありません',
			'notifications.friendOnlineAlerts' => 'フレンドのオンライン通知',
			'notifications.selectedCount' => ({required Object count}) => '${count}人選択中',
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
			'notifications.searchHint' => '通知を検索',
			'notifications.type' => '種類',
			'notifications.allTypes' => 'すべての種類',
			'notifications.responseSent' => '応答を送信しました',
			'notifications.responseFailed' => ({required Object error}) => '応答の送信に失敗しました: ${error}',
			'notifications.friendOnlineChannel' => 'フレンドのオンライン通知',
			'notifications.friendOnlineChannelDescription' => '選択したフレンドがオンラインになったときに通知します。',
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
			'eventCalendar.quest' => 'Android対応',
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
			'avatars.remoteTooltip' => 'VRChatのアバター',
			'avatars.localTooltip' => 'ローカルアバターデータベース',
			'avatars.localEmptyTitle' => 'ローカルアバターはありません',
			'avatars.localEmptyDescription' => '閲覧・検索したアバターがここに表示されます。',
			'avatars.viewModeTooltip' => '表示モード切替',
			'worldDetail.loading' => 'ワールド情報を読み込み中...',
			'worldDetail.error' => ({required Object error}) => 'ワールド情報の取得に失敗しました: ${error}',
			'worldDetail.metadataTitle' => 'ワールド詳細',
			'worldDetail.capacity' => '定員',
			'worldDetail.capacityValue' => ({required Object recommended, required Object maximum}) => '${recommended} 推奨 / ${maximum} 最大',
			'worldDetail.releaseStatus' => '公開状況',
			'worldDetail.releaseAll' => 'すべて',
			'worldDetail.releaseHidden' => '非表示',
			'worldDetail.releasePrivate' => '非公開',
			'worldDetail.releasePublic' => '公開',
			'worldDetail.publicInstances' => 'パブリックインスタンス',
			'worldDetail.occupantsValue' => ({required Object publicCount, required Object privateCount}) => '${publicCount} パブリック / ${privateCount} プライベート',
			'worldDetail.publication' => '公開日',
			'worldDetail.platforms' => '対応プラットフォーム',
			'worldDetail.platformAndroid' => 'Android',
			'worldDetail.platformIos' => 'iOS',
			'worldDetail.platformPc' => 'PC',
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
			'inventory.item' => 'アイテム',
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
			'inventory.tabs.inventoryItem.loading' => 'インベントリを読み込み中...',
			'inventory.tabs.inventoryItem.error' => ({required Object error}) => 'インベントリの取得に失敗しました: ${error}',
			'inventory.tabs.inventoryItem.emptyTitle' => 'インベントリアイテムがありません',
			'inventory.tabs.inventoryItem.spawn' => 'スポーン',
			'inventory.tabs.inventoryItem.unequip' => '装備解除',
			'inventory.tabs.inventoryItem.equipped' => ({required Object slot}) => '装備中: ${slot}',
			'inventory.tabs.inventoryItem.spawned' => ({required Object name}) => '${name}をスポーンしました',
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
			_ => null,
		} ?? switch (path) {
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
			'download.shareFailure' => ({required Object error}) => '共有に失敗しました: ${error}',
			'download.sharing' => ({required Object fileName}) => '${fileName} を共有準備中...',
			'instance.type.public' => 'パブリック',
			'instance.type.hidden' => 'フレンド+',
			'instance.type.friends' => 'フレンド',
			'instance.type.private' => 'インバイト+',
			'instance.type.group' => 'グループ',
			'instance.type.unknown' => '不明',
			'status.active' => 'オンライン',
			'status.joinMe' => 'だれでもおいで',
			'status.askMe' => 'きいてみてね',
			'status.busy' => '取り込み中',
			'status.offline' => 'オフライン',
			'status.unknown' => 'ステータス不明',
			'location.private' => 'プライベート',
			'location.traveling' => '移動中',
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
			'friend.searchTitle' => 'フレンドを検索',
			'friend.searchHint' => '名前、ユーザーID、場所',
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
			'activity.title' => 'アクティビティ',
			'activity.clearHistory' => 'アクティビティ履歴を削除',
			'activity.feed' => 'フィード',
			'activity.friendLog' => 'フレンドログ',
			'activity.heatmap' => 'ヒートマップ',
			'activity.empty' => 'アクティビティはまだありません。',
			'activity.trackedHours' => ({required Object hours, required Object minutes}) => '${hours}時間${minutes}分を記録',
			'activity.trackedMinutes' => ({required Object minutes}) => '${minutes}分を記録',
			'activity.summary' => ({required Object kind, required Object detail}) => '${kind} · ${detail}',
			'activity.heatmapTitle' => '過去6週間のフレンドアクティビティ',
			'activity.kind.friendOnline' => 'フレンドがオンラインになりました',
			'activity.kind.friendOffline' => 'フレンドがオフラインになりました',
			'activity.kind.friendActive' => 'フレンドがアクティブになりました',
			'activity.kind.friendAdd' => 'フレンドを追加しました',
			'activity.kind.friendRemove' => 'フレンドを削除しました',
			'activity.kind.locationChange' => '場所が変更されました',
			'activity.kind.statusUpdate' => 'ステータスを更新しました',
			'activity.kind.activity' => 'アクティビティ',
			'insights.title' => 'インサイト',
			'insights.mutualFriends' => '相互フレンド',
			'insights.hotWorlds' => '人気のワールド',
			'insights.instancePlayers' => 'インスタンスの参加者',
			'insights.userHint' => 'ユーザーID (usr_...)',
			'insights.enterUser' => '比較するユーザーIDを入力してください。',
			'insights.noMutual' => '相互フレンドはいません。',
			'insights.noLocations' => 'フレンドの場所がありません。',
			'insights.friendsCount' => ({required Object count}) => '${count}人のフレンド',
			'insights.locationHint' => '場所 (wrld_...:instance)',
			'insights.enterLocation' => 'インスタンスの場所を入力してください。',
			'insights.noPlayers' => '表示できるプレイヤーはいません。',
			'insights.load' => '読み込む',
			'moderation.title' => 'モデレーション',
			'moderation.clearPlayer' => 'プレイヤーのモデレーションを削除',
			'moderation.player' => 'プレイヤー',
			'moderation.groupBans' => 'グループBAN',
			'moderation.cleared' => 'プレイヤーのモデレーションを削除しました',
			'moderation.noPlayer' => 'プレイヤーのモデレーションはありません。',
			'moderation.remove' => 'モデレーションを削除',
			'moderation.groupHint' => 'グループID (grp_...)',
			'moderation.loadBans' => 'BANを読み込む',
			'moderation.enterGroup' => 'グループIDを入力してください。',
			'moderation.noGroup' => 'グループBANはありません。',
			'moderation.unban' => 'BANを解除',
			'tools.title' => 'ツール',
			'tools.groups' => 'グループ',
			'tools.myAvatars' => '所有アバター',
			'tools.status' => 'ステータス',
			'tools.data' => 'データ',
			'tools.server' => 'サーバー',
			'tools.groupHint' => 'グループID (grp_...)',
			'tools.loadGroup' => 'グループを読み込む',
			'tools.join' => '参加',
			'tools.leave' => '退出',
			'tools.members' => 'メンバー',
			'tools.bans' => 'BAN',
			'tools.calendar' => 'カレンダー',
			'tools.enterGroup' => '管理するグループIDを入力してください。',
			'tools.noMembers' => 'メンバーはいません。',
			'tools.banMember' => 'メンバーをBAN',
			'tools.noGroupBans' => 'グループBANはありません。',
			'tools.unbanMember' => 'メンバーのBANを解除',
			'tools.noCalendar' => 'グループのカレンダーイベントはありません。',
			'tools.followEvent' => 'イベントをフォロー',
			'tools.unfollowEvent' => 'イベントのフォローを解除',
			'tools.ownAvatars' => '所有アバター',
			'tools.noOwnAvatars' => '所有アバターが見つかりません。',
			'tools.editAvatar' => 'アバターを編集',
			'tools.worldMetadata' => 'ワールドメタデータ',
			'tools.worldId' => 'ワールドID',
			'tools.worldHint' => 'wrld_...',
			'tools.loadWorld' => 'ワールドIDを読み込む',
			'tools.editWorldMetadata' => 'ワールドメタデータを編集',
			'tools.worldPermissionHint' => 'アカウントに権限があるワールドのみ編集できます。',
			'tools.statusPresets' => 'ステータスプリセット',
			'tools.addPreset' => 'プリセットを追加',
			'tools.applyPreset' => 'プリセットを適用',
			'tools.deletePreset' => 'プリセットを削除',
			'tools.applyPresetOnLogin' => 'ログイン時にプリセットを適用',
			'tools.restoreStatus' => 'ログイン後に選択したソーシャルステータスを復元します。',
			'tools.automaticPreset' => '自動プリセット',
			'tools.discordNames' => 'Discord名',
			'tools.scanFriendProfiles' => 'フレンドのプロフィールをスキャン',
			'tools.exportDiscordNames' => 'Discord名をエクスポート',
			'tools.noLinkedNames' => 'リンクされた名前はまだありません。プロフィールの自己紹介にDiscord名を追加するか、インポート／エクスポートを使用してください。',
			'tools.dataTransfer' => 'データ移行',
			'tools.dataTransferDescription' => 'アクティビティ、メモ、アラート、プリセットを端末間で移行します。',
			'tools.exportData' => 'データをエクスポート',
			'tools.importData' => 'データをインポート',
			'tools.dataExportHint' => 'バージョン付きJSON形式でエクスポートします。APIの内容は自動で上書きされません。インポートではローカルアプリデータのみ復元します。',
			'tools.apiOnline' => 'VRChat APIはオンラインです',
			'tools.apiDegraded' => 'VRChat APIの性能が低下しています',
			'tools.apiUnavailable' => 'APIの状態を取得できません',
			'tools.serverRefreshHint' => '引っ張って最新のサーバー状態を更新します。',
			'tools.groupActionCompleted' => 'グループ操作が完了しました',
			'tools.editAvatarDialog' => 'アバターを編集',
			'tools.editWorldDialog' => 'ワールドメタデータを編集',
			'tools.newStatusPreset' => '新しいステータスプリセット',
			'tools.name' => '名前',
			'tools.description' => '説明',
			'tools.capacity' => '定員',
			'tools.tags' => 'タグ（カンマ区切り）',
			'tools.pasteExport' => 'VRCNのJSONエクスポートを貼り付け',
			'tools.dataImported' => 'データをインポートしました',
			'tools.importFailed' => ({required Object error}) => 'インポートに失敗しました: ${error}',
			'tools.statusAvailable' => 'オンライン',
			'tools.statusAskMe' => '応答を求める',
			'tools.statusBusy' => '取り込み中',
			'tools.statusJoinMe' => '参加してほしい',
			'osc.floatType' => '小数 (0.0～1.0)',
			'osc.intType' => '整数',
			'osc.boolType' => '真偽値 (オン／オフ)',
			'osc.on' => 'オン',
			'osc.off' => 'オフ',
			_ => null,
		};
	}
}
