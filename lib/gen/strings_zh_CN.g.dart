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
class TranslationsZhCn with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZhCn({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.zhCn,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh-CN>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsZhCn _root = this; // ignore: unused_field

	@override 
	TranslationsZhCn $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsZhCn(meta: meta ?? this.$meta);

	// Translations
	@override late final Translations$common$zh_CN common = Translations$common$zh_CN.internal(_root);
	@override late final Translations$termsAgreement$zh_CN termsAgreement = Translations$termsAgreement$zh_CN.internal(_root);
	@override late final Translations$drawer$zh_CN drawer = Translations$drawer$zh_CN.internal(_root);
	@override late final Translations$login$zh_CN login = Translations$login$zh_CN.internal(_root);
	@override late final Translations$friends$zh_CN friends = Translations$friends$zh_CN.internal(_root);
	@override late final Translations$friendDetail$zh_CN friendDetail = Translations$friendDetail$zh_CN.internal(_root);
	@override late final Translations$search$zh_CN search = Translations$search$zh_CN.internal(_root);
	@override late final Translations$profile$zh_CN profile = Translations$profile$zh_CN.internal(_root);
	@override late final Translations$engageCard$zh_CN engageCard = Translations$engageCard$zh_CN.internal(_root);
	@override late final Translations$qrScanner$zh_CN qrScanner = Translations$qrScanner$zh_CN.internal(_root);
	@override late final Translations$favorites$zh_CN favorites = Translations$favorites$zh_CN.internal(_root);
	@override late final Translations$notifications$zh_CN notifications = Translations$notifications$zh_CN.internal(_root);
	@override late final Translations$eventCalendar$zh_CN eventCalendar = Translations$eventCalendar$zh_CN.internal(_root);
	@override late final Translations$avatars$zh_CN avatars = Translations$avatars$zh_CN.internal(_root);
	@override late final Translations$worldDetail$zh_CN worldDetail = Translations$worldDetail$zh_CN.internal(_root);
	@override late final Translations$avatarDetail$zh_CN avatarDetail = Translations$avatarDetail$zh_CN.internal(_root);
	@override late final Translations$groups$zh_CN groups = Translations$groups$zh_CN.internal(_root);
	@override late final Translations$groupDetail$zh_CN groupDetail = Translations$groupDetail$zh_CN.internal(_root);
	@override late final Translations$inventory$zh_CN inventory = Translations$inventory$zh_CN.internal(_root);
	@override late final Translations$feedback$zh_CN feedback = Translations$feedback$zh_CN.internal(_root);
	@override late final Translations$settings$zh_CN settings = Translations$settings$zh_CN.internal(_root);
	@override late final Translations$credits$zh_CN credits = Translations$credits$zh_CN.internal(_root);
	@override late final Translations$download$zh_CN download = Translations$download$zh_CN.internal(_root);
	@override late final Translations$instance$zh_CN instance = Translations$instance$zh_CN.internal(_root);
	@override late final Translations$status$zh_CN status = Translations$status$zh_CN.internal(_root);
	@override late final Translations$location$zh_CN location = Translations$location$zh_CN.internal(_root);
	@override late final Translations$reminder$zh_CN reminder = Translations$reminder$zh_CN.internal(_root);
	@override late final Translations$friend$zh_CN friend = Translations$friend$zh_CN.internal(_root);
	@override late final Translations$eventCalendarFilter$zh_CN eventCalendarFilter = Translations$eventCalendarFilter$zh_CN.internal(_root);
}

// Path: common
class Translations$common$zh_CN implements Translations$common$en {
	Translations$common$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => 'VRCN';
	@override String get ok => '确定';
	@override String get cancel => '取消';
	@override String get close => '关闭';
	@override String get save => '保存';
	@override String get edit => '编辑';
	@override String get delete => '删除';
	@override String get yes => '是';
	@override String get no => '否';
	@override String get loading => '加载中...';
	@override String error({required Object error}) => '发生错误：${error}';
	@override String get errorNomessage => '发生错误';
	@override String get retry => '重试';
	@override String get search => '搜索';
	@override String get settings => '设置';
	@override String get confirm => '确认';
	@override String get agree => '同意';
	@override String get decline => '不同意';
	@override String get username => '用户名';
	@override String get password => '密码';
	@override String get login => '登录';
	@override String get logout => '登出';
	@override String get share => '分享';
}

// Path: termsAgreement
class Translations$termsAgreement$zh_CN implements Translations$termsAgreement$en {
	Translations$termsAgreement$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get welcomeTitle => '欢迎来到 VRCN';
	@override String get welcomeMessage => '在使用本应用前，\n请阅读服务条款和隐私政策。';
	@override String get termsTitle => '服务条款';
	@override String get termsSubtitle => '关于应用的使用条件';
	@override String get privacyTitle => '隐私政策';
	@override String get privacySubtitle => '关于个人信息的处理';
	@override String agreeTerms({required Object title}) => '我同意“${title}”';
	@override String get checkContent => '查看内容';
	@override String get notice => '本应用是 VRChat Inc. 的非官方应用。\n与 VRChat Inc. 没有任何关系。';
}

// Path: drawer
class Translations$drawer$zh_CN implements Translations$drawer$en {
	Translations$drawer$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get home => '主页';
	@override String get profile => '个人资料';
	@override String get favorite => '收藏';
	@override String get eventCalendar => '活动日历';
	@override String get avatar => '虚拟形象';
	@override String get group => '群组';
	@override String get inventory => '物品栏';
	@override String get review => '评价';
	@override String get feedback => '反馈';
	@override String get settings => '设置';
	@override String get userLoading => '正在加载用户信息...';
	@override String get userError => '加载用户信息失败';
	@override String get retry => '重试';
	@override late final Translations$drawer$section$zh_CN section = Translations$drawer$section$zh_CN.internal(_root);
}

// Path: login
class Translations$login$zh_CN implements Translations$login$en {
	Translations$login$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get forgotPassword => '忘记密码？';
	@override String get createAccount => '注册';
	@override String get subtitle => '使用您的 VRChat 账户登录';
	@override String get email => '邮箱地址';
	@override String get emailHint => '输入邮箱或用户名';
	@override String get passwordHint => '输入密码';
	@override String get rememberMe => '记住登录状态';
	@override String get loggingIn => '登录中...';
	@override String get errorEmptyEmail => '请输入用户名或邮箱地址';
	@override String get errorEmptyPassword => '请输入密码';
	@override String get errorLoginFailed => '登录失败。请检查您的邮箱和密码。';
	@override String get twoFactorTitle => '两步验证';
	@override String get twoFactorSubtitle => '请输入验证码';
	@override String get twoFactorInstruction => '请输入您的验证器应用中显示的\n6位数验证码';
	@override String get twoFactorCodeHint => '验证码';
	@override String get verify => '验证';
	@override String get verifying => '验证中...';
	@override String get errorEmpty2fa => '请输入验证码';
	@override String get error2faFailed => '两步验证失败。请检查验证码是否正确。';
	@override String get backToLogin => '返回登录页面';
	@override String get paste => '粘贴';
}

// Path: friends
class Translations$friends$zh_CN implements Translations$friends$en {
	Translations$friends$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get loading => '正在加载好友信息...';
	@override String error({required Object error}) => '获取好友信息失败：${error}';
	@override String get notFound => '未找到好友';
	@override String get private => '私密';
	@override String get active => '活跃';
	@override String get offline => '离线';
	@override String get online => '在线';
	@override String get groupTitle => '按世界分组';
	@override String get refresh => '刷新';
	@override String get searchHint => '按好友名称搜索';
	@override String get noResult => '没有找到相关的好友';
}

// Path: friendDetail
class Translations$friendDetail$zh_CN implements Translations$friendDetail$en {
	Translations$friendDetail$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get loading => '正在加载用户信息...';
	@override String error({required Object error}) => '获取用户信息失败：${error}';
	@override String get currentLocation => '当前位置';
	@override String get basicInfo => '基本信息';
	@override String get userId => '用户ID';
	@override String get dateJoined => '注册日期';
	@override String get lastLogin => '最后登录';
	@override String get bio => '个人简介';
	@override String get links => '链接';
	@override String get loadingLinks => '正在加载链接信息...';
	@override String get group => '所属群组';
	@override String get groupDetail => '显示群组详情';
	@override String groupCode({required Object code}) => '群组代码：${code}';
	@override String memberCount({required Object count}) => '成员数：${count}人';
	@override String get unknownGroup => '未知群组';
	@override String get block => '屏蔽';
	@override String get mute => '静音';
	@override String get openWebsite => '在网站上打开';
	@override String get shareProfile => '分享个人资料';
	@override String confirmBlockTitle({required Object name}) => '要屏蔽 ${name} 吗？';
	@override String get confirmBlockMessage => '屏蔽后，您将不会再收到该用户的好友请求和消息。';
	@override String confirmMuteTitle({required Object name}) => '要将 ${name} 静音吗？';
	@override String get confirmMuteMessage => '静音后，您将听不到该用户的声音。';
	@override String get blockSuccess => '已屏蔽';
	@override String get muteSuccess => '已静音';
	@override String operationFailed({required Object error}) => '操作失败：${error}';
}

// Path: search
class Translations$search$zh_CN implements Translations$search$en {
	Translations$search$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get userTab => '用户';
	@override String get worldTab => '世界';
	@override String get avatarTab => '虚拟形象';
	@override String get groupTab => '群组';
	@override late final Translations$search$tabs$zh_CN tabs = Translations$search$tabs$zh_CN.internal(_root);
}

// Path: profile
class Translations$profile$zh_CN implements Translations$profile$en {
	Translations$profile$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '个人资料';
	@override String get edit => '编辑';
	@override String get refresh => '刷新';
	@override String get loading => '正在加载个人资料信息...';
	@override String get error => '获取个人资料信息失败：{error}';
	@override String get displayName => '显示名称';
	@override String get username => '用户名';
	@override String get userId => '用户ID';
	@override String get engageCard => '互动卡片';
	@override String get frined => '好友';
	@override String get dateJoined => '注册日期';
	@override String get userType => '用户类型';
	@override String get status => '状态';
	@override String get statusMessage => '状态消息';
	@override String get bio => '个人简介';
	@override String get links => '链接';
	@override String get group => '所属群组';
	@override String get groupDetail => '显示群组详情';
	@override String get avatar => '当前虚拟形象';
	@override String get avatarDetail => '显示虚拟形象详情';
	@override String get public => '公开';
	@override String get private => '私密';
	@override String get hidden => '隐藏';
	@override String get unknown => '未知';
	@override String get friends => '好友';
	@override String get loadingLinks => '正在加载链接信息...';
	@override String get noGroup => '未加入任何群组';
	@override String get noBio => '无个人简介';
	@override String get noLinks => '无链接';
	@override String get save => '保存更改';
	@override String get saved => '个人资料已更新';
	@override String get saveFailed => '更新失败：{error}';
	@override String get discardTitle => '要放弃更改吗？';
	@override String get discardContent => '您对个人资料所做的更改将不会被保存。';
	@override String get discardCancel => '取消';
	@override String get discardOk => '放弃';
	@override String get basic => '基本信息';
	@override String get pronouns => '代词';
	@override String get addLink => '添加';
	@override String get removeLink => '移除';
	@override String get linkHint => '输入链接（例如：https://twitter.com/username）';
	@override String get linksHint => '链接将显示在您的个人资料上，点击即可打开';
	@override String get statusMessageHint => '输入您当前的状态或消息';
	@override String get bioHint => '写一些关于您自己的介绍吧';
}

// Path: engageCard
class Translations$engageCard$zh_CN implements Translations$engageCard$en {
	Translations$engageCard$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get pickBackground => '选择背景图片';
	@override String get removeBackground => '移除背景图片';
	@override String get scanQr => '扫描二维码';
	@override String get showAvatar => '显示虚拟形象';
	@override String get hideAvatar => '隐藏虚拟形象';
	@override String get noBackground => '未选择背景图片\n您可以通过右上角的按钮进行设置';
	@override String get loading => '加载中...';
	@override String error({required Object error}) => '获取互动卡片信息失败：${error}';
	@override String get copyUserId => '复制用户ID';
	@override String get copied => '已复制';
}

// Path: qrScanner
class Translations$qrScanner$zh_CN implements Translations$qrScanner$en {
	Translations$qrScanner$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '扫描二维码';
	@override String get guide => '请将二维码对准框内';
	@override String get loading => '正在初始化相机...';
	@override String error({required Object error}) => '读取二维码失败：${error}';
	@override String get notFound => '未找到有效的用户二维码';
}

// Path: favorites
class Translations$favorites$zh_CN implements Translations$favorites$en {
	Translations$favorites$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '收藏';
	@override String get frined => '好友';
	@override String get friendsTab => '好友';
	@override String get worldsTab => '世界';
	@override String get avatarsTab => '虚拟形象';
	@override String get emptyFolderTitle => '没有收藏文件夹';
	@override String get emptyFolderDescription => '请在VRChat内创建收藏文件夹';
	@override String get emptyFriends => '此文件夹中没有好友';
	@override String get emptyWorlds => '此文件夹中没有世界';
	@override String get emptyAvatars => '此文件夹中没有虚拟形象';
	@override String get emptyWorldsTabTitle => '没有收藏的世界';
	@override String get emptyWorldsTabDescription => '您可以从世界详情页面将世界添加到收藏';
	@override String get emptyAvatarsTabTitle => '没有收藏的虚拟形象';
	@override String get emptyAvatarsTabDescription => '您可以从虚拟形象详情页面将形象添加到收藏';
	@override String get loading => '正在加载收藏...';
	@override String get loadingFolder => '正在加载文件夹信息...';
	@override String error({required Object error}) => '加载收藏失败：${error}';
	@override String get errorFolder => '获取信息失败';
	@override String get remove => '从收藏中移除';
	@override String removeSuccess({required Object name}) => '已将 ${name} 从收藏中移除';
	@override String removeFailed({required Object error}) => '移除失败：${error}';
	@override String itemsCount({required Object count}) => '${count} 个项目';
	@override String get public => '公开';
	@override String get private => '私密';
	@override String get hidden => '隐藏';
	@override String get unknown => '未知';
	@override String get loadingError => '加载错误';
}

// Path: notifications
class Translations$notifications$zh_CN implements Translations$notifications$en {
	Translations$notifications$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '通知';
	@override String get emptyTitle => '没有通知';
	@override String get emptyDescription => '好友请求、邀请等新通知\n将会显示在这里';
	@override String get all => '全部';
	@override String unread({required Object count}) => '未读 (${count})';
	@override String get read => '已读';
	@override String get activity => '好友日志';
	@override String get onlineAlerts => '上线提醒';
	@override String get markAllRead => '全部标为已读';
	@override String get markAllReadDone => '所有通知已标为已读';
	@override String get deleteConfirmTitle => '删除通知？';
	@override String get emptyUnread => '没有未读通知';
	@override String get emptyRead => '没有已读通知';
	@override String get friendOnlineAlerts => '好友上线提醒';
	@override String selectedCount({required Object count}) => '已选择 ${count} 人';
	@override String friendRequest({required Object userName}) => '您收到了来自 ${userName} 的好友请求';
	@override String invite({required Object userName, required Object worldName}) => '您收到了来自 ${userName} 前往 ${worldName} 的邀请';
	@override String friendOnline({required Object userName}) => '${userName} 已上线';
	@override String friendOffline({required Object userName}) => '${userName} 已离线';
	@override String friendActive({required Object userName}) => '${userName} 变为活跃状态';
	@override String friendAdd({required Object userName}) => '${userName} 已被添加为好友';
	@override String friendRemove({required Object userName}) => '${userName} 已从好友中移除';
	@override String statusUpdate({required Object userName, required Object status, required Object world}) => '${userName} 的状态已更新：${status}${world}';
	@override String locationChange({required Object userName, required Object worldName}) => '${userName} 已移动到 ${worldName}';
	@override String userUpdate({required Object world}) => '您的信息已更新${world}';
	@override String myLocationChange({required Object worldName}) => '您的移动：${worldName}';
	@override String requestInvite({required Object userName}) => '您收到了来自 ${userName} 的加入请求';
	@override String votekick({required Object userName}) => '收到了来自 ${userName} 的投票踢出';
	@override String responseReceived({required Object userName}) => '已收到通知ID:${userName}的响应';
	@override String error({required Object worldName}) => '错误：${worldName}';
	@override String system({required Object extraData}) => '系统通知：${extraData}';
	@override String secondsAgo({required Object seconds}) => '${seconds}秒前';
	@override String minutesAgo({required Object minutes}) => '${minutes}分钟前';
	@override String hoursAgo({required Object hours}) => '${hours}小时前';
}

// Path: eventCalendar
class Translations$eventCalendar$zh_CN implements Translations$eventCalendar$en {
	Translations$eventCalendar$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '活动日历';
	@override String get filter => '筛选活动';
	@override String get refresh => '刷新活动信息';
	@override String get loading => '正在获取活动信息...';
	@override String error({required Object error}) => '获取活动信息失败：${error}';
	@override String filterActive({required Object count}) => '筛选已应用（${count}条）';
	@override String get clear => '清除';
	@override String get noEvents => '没有符合条件的活动';
	@override String get clearFilter => '清除筛选';
	@override String get today => '今天';
	@override String get reminderSet => '设置提醒';
	@override String get reminderSetDone => '已设置提醒';
	@override String get reminderDeleted => '已删除提醒';
	@override String get eventName => '活动名称';
	@override String get organizer => '主办方';
	@override String get description => '说明';
	@override String get genre => '类型';
	@override String get condition => '参加条件';
	@override String get way => '参加方法';
	@override String get note => '备注';
	@override String get quest => '支持Quest';
	@override String reminderCount({required Object count}) => '${count}条';
	@override String startToEnd({required Object start, required Object end}) => '${start} ~ ${end}';
}

// Path: avatars
class Translations$avatars$zh_CN implements Translations$avatars$en {
	Translations$avatars$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '虚拟形象';
	@override String get searchHint => '按虚拟形象名称等搜索';
	@override String get searchTooltip => '搜索';
	@override String get searchEmptyTitle => '未找到搜索结果';
	@override String get searchEmptyDescription => '请尝试其他搜索词';
	@override String get emptyTitle => '没有虚拟形象';
	@override String get emptyDescription => '请添加虚拟形象或稍后重试';
	@override String get refresh => '刷新';
	@override String get loading => '正在加载虚拟形象...';
	@override String error({required Object error}) => '获取虚拟形象信息失败：${error}';
	@override String get current => '使用中';
	@override String get public => '公开';
	@override String get private => '私密';
	@override String get hidden => '隐藏';
	@override String get author => '作者';
	@override String get sortUpdated => '按更新时间';
	@override String get sortName => '按名称';
	@override String get sortTooltip => '排序';
	@override String get viewModeTooltip => '切换视图模式';
}

// Path: worldDetail
class Translations$worldDetail$zh_CN implements Translations$worldDetail$en {
	Translations$worldDetail$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get loading => '正在加载世界信息...';
	@override String error({required Object error}) => '获取世界信息失败：${error}';
	@override String get share => '分享这个世界';
	@override String get openInVRChat => '在VRChat官网打开';
	@override String get report => '举报这个世界';
	@override String get creator => '创建者';
	@override String get created => '创建于';
	@override String get updated => '更新于';
	@override String get favorites => '收藏数';
	@override String get visits => '访问数';
	@override String get occupants => '当前人数';
	@override String get popularity => '评价';
	@override String get description => '说明';
	@override String get noDescription => '没有说明';
	@override String get tags => '标签';
	@override String get joinPublic => '发送公开邀请';
	@override String get favoriteAdded => '已添加到收藏';
	@override String get favoriteRemoved => '已从收藏中移除';
	@override String get unknown => '未知';
}

// Path: avatarDetail
class Translations$avatarDetail$zh_CN implements Translations$avatarDetail$en {
	Translations$avatarDetail$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String changeSuccess({required Object name}) => '已更换为虚拟形象“${name}”';
	@override String changeFailed({required Object error}) => '更换虚拟形象失败：${error}';
	@override String get changing => '更换中...';
	@override String get useThisAvatar => '使用此虚拟形象';
	@override String get creator => '创建者';
	@override String get created => '创建于';
	@override String get updated => '更新于';
	@override String get description => '说明';
	@override String get noDescription => '没有说明';
	@override String get tags => '标签';
	@override String get addToFavorites => '添加到收藏';
	@override String get public => '公开';
	@override String get private => '私密';
	@override String get hidden => '隐藏';
	@override String get unknown => '未知';
	@override String get share => '分享';
	@override String get loading => '正在加载虚拟形象信息...';
	@override String error({required Object error}) => '获取虚拟形象信息失败：${error}';
}

// Path: groups
class Translations$groups$zh_CN implements Translations$groups$en {
	Translations$groups$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '群组';
	@override String get loadingUser => '正在加载用户信息...';
	@override String errorUser({required Object error}) => '获取用户信息失败：${error}';
	@override String get loadingGroups => '正在加载群组信息...';
	@override String errorGroups({required Object error}) => '获取群组信息失败：${error}';
	@override String get emptyTitle => '您尚未加入任何群组';
	@override String get emptyDescription => '您可以从VRChat应用或网站加入群组';
	@override String get searchGroups => '查找群组';
	@override String members({required Object count}) => '${count}名成员';
	@override String get showDetails => '显示详情';
	@override String get unknownName => '名称未知';
}

// Path: groupDetail
class Translations$groupDetail$zh_CN implements Translations$groupDetail$en {
	Translations$groupDetail$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get loading => '正在加载群组信息...';
	@override String error({required Object error}) => '获取群组信息失败：${error}';
	@override String get share => '分享群组信息';
	@override String get description => '说明';
	@override String get roles => '角色';
	@override String get basicInfo => '基本信息';
	@override String get createdAt => '创建日期';
	@override String get owner => '所有者';
	@override String get rules => '规则';
	@override String get languages => '语言';
	@override String memberCount({required Object count}) => '${count} 成员';
	@override late final Translations$groupDetail$privacy$zh_CN privacy = Translations$groupDetail$privacy$zh_CN.internal(_root);
	@override late final Translations$groupDetail$role$zh_CN role = Translations$groupDetail$role$zh_CN.internal(_root);
}

// Path: inventory
class Translations$inventory$zh_CN implements Translations$inventory$en {
	Translations$inventory$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '物品栏';
	@override String get gallery => '画廊';
	@override String get icon => '图标';
	@override String get emoji => '表情';
	@override String get sticker => '贴纸';
	@override String get print => '打印图';
	@override String get item => '物品';
	@override String get upload => '上传文件';
	@override String get uploadGallery => '正在上传画廊图片...';
	@override String get uploadIcon => '正在上传图标...';
	@override String get uploadEmoji => '正在上传表情...';
	@override String get uploadSticker => '正在上传贴纸...';
	@override String get uploadPrint => '正在上传打印图...';
	@override String get selectImage => '选择图片';
	@override String get selectFromGallery => '从相册选择';
	@override String get takePhoto => '使用相机拍摄';
	@override String get uploadSuccess => '上传成功';
	@override String get uploadFailed => '上传失败';
	@override String get uploadFailedFormat => '文件格式或大小有问题。请选择小于1MB的PNG格式图片。';
	@override String get uploadFailedAuth => '认证失败。请重新登录。';
	@override String get uploadFailedSize => '文件太大。请选择更小的图片。';
	@override String uploadFailedServer({required Object code}) => '发生服务器错误 (${code})';
	@override String pickImageFailed({required Object error}) => '选择图片失败：${error}';
	@override late final Translations$inventory$tabs$zh_CN tabs = Translations$inventory$tabs$zh_CN.internal(_root);
}

// Path: feedback
class Translations$feedback$zh_CN implements Translations$feedback$en {
	Translations$feedback$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '反馈';
	@override String get type => '反馈类型';
	@override Map<String, String> get types => {
		'bug': '错误报告',
		'feature': '功能请求',
		'improvement': '改进建议',
		'other': '其他',
	};
	@override String get inputTitle => '标题 *';
	@override String get inputTitleHint => '请简要说明';
	@override String get inputDescription => '详细说明 *';
	@override String get inputDescriptionHint => '请提供详细说明...';
	@override String get cancel => '取消';
	@override String get send => '发送';
	@override String get sending => '发送中...';
	@override String get required => '标题和详细说明为必填项';
	@override String get success => '反馈已发送。谢谢！';
	@override String get fail => '反馈发送失败';
}

// Path: settings
class Translations$settings$zh_CN implements Translations$settings$en {
	Translations$settings$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get appearance => '外观';
	@override String get language => '语言';
	@override String get languageDescription => '您可以选择应用程序的显示语言';
	@override String get appIcon => '应用图标';
	@override String get appIconDescription => '更改主屏幕上显示的应用图标';
	@override String get contentSettings => '内容设置';
	@override String get searchEnabled => '搜索功能已启用';
	@override String get searchDisabled => '搜索功能已禁用';
	@override String get enableSearch => '启用搜索功能';
	@override String get enableSearchDescription => '搜索结果可能包含成人或暴力内容。';
	@override String get apiSetting => '虚拟形象搜索API';
	@override String get apiSettingDescription => '设置虚拟形象搜索功能的API';
	@override String get apiSettingSaveUrl => 'URL已保存';
	@override String get notSet => '未设置（虚拟形象搜索功能无法使用）';
	@override String get notifications => '通知设置';
	@override String get eventReminder => '活动提醒';
	@override String get eventReminderDescription => '在您设定的活动开始前接收通知';
	@override String get manageReminders => '管理已设置的提醒';
	@override String get manageRemindersDescription => '可以取消或确认通知';
	@override String get dataStorage => '数据与存储';
	@override String get clearCache => '清除缓存';
	@override String get clearCacheSuccess => '缓存已清除';
	@override String get clearCacheError => '清除缓存时发生错误';
	@override String cacheSize({required Object size}) => '缓存大小: ${size}';
	@override String get calculatingCache => '正在计算缓存大小...';
	@override String get cacheError => '无法获取缓存大小';
	@override String get confirmClearCache => '清除缓存将删除临时保存的图片和数据。\n\n您的账户信息和应用设置不会被删除。';
	@override String get appInfo => '应用信息';
	@override String get version => '版本';
	@override String get packageName => '包名';
	@override String get credit => '鸣谢';
	@override String get creditDescription => '开发者和贡献者信息';
	@override String get contact => '联系我们';
	@override String get contactDescription => 'BUG报告和建议请点此';
	@override String get privacyPolicy => '隐私政策';
	@override String get privacyPolicyDescription => '关于个人信息的处理';
	@override String get termsOfService => '服务条款';
	@override String get termsOfServiceDescription => '应用使用条件';
	@override String get openSource => '开源信息';
	@override String get openSourceDescription => '所使用的库等许可证信息';
	@override String get github => 'GitHub仓库';
	@override String get githubDescription => '查看源代码';
	@override String get logoutConfirm => '确定要登出吗？';
	@override String logoutError({required Object error}) => '登出时发生错误：${error}';
	@override String get iconChangeNotSupported => '您的设备不支持更改应用图标';
	@override String get iconChangeFailed => '更改图标失败';
	@override String get themeMode => '主题模式';
	@override String get themeModeDescription => '您可以选择应用的显示主题';
	@override String get themeLight => '浅色';
	@override String get themeSystem => '系统';
	@override String get themeDark => '深色';
	@override String get appIconDefault => '默认';
	@override String get appIconIcon => '图标';
	@override String get appIconLogo => '标志';
	@override String get delete => '删除';
}

// Path: credits
class Translations$credits$zh_CN implements Translations$credits$en {
	Translations$credits$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '鸣谢';
	@override late final Translations$credits$section$zh_CN section = Translations$credits$section$zh_CN.internal(_root);
}

// Path: download
class Translations$download$zh_CN implements Translations$download$en {
	Translations$download$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String shareFailure({required Object error}) => '分享失败：${error}';
	@override String sharing({required Object fileName}) => '正在准备分享 ${fileName}...';
}

// Path: instance
class Translations$instance$zh_CN implements Translations$instance$en {
	Translations$instance$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override late final Translations$instance$type$zh_CN type = Translations$instance$type$zh_CN.internal(_root);
}

// Path: status
class Translations$status$zh_CN implements Translations$status$en {
	Translations$status$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get active => '在线';
	@override String get joinMe => '欢迎加入';
	@override String get askMe => '请问我';
	@override String get busy => '忙碌';
	@override String get offline => '离线';
	@override String get unknown => '状态未知';
}

// Path: location
class Translations$location$zh_CN implements Translations$location$en {
	Translations$location$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get private => '私密';
	@override String playerCount({required Object userCount, required Object capacity}) => '玩家数：${userCount} / ${capacity}';
	@override String instanceType({required Object type}) => '实例类型：${type}';
	@override String get noInfo => '没有位置信息';
	@override String get fetchError => '获取位置信息失败';
	@override String get privateLocation => '您在一个私密地点';
	@override String get inviteSending => '发送邀请中...';
	@override String get inviteSent => '邀请已发送。您可以从通知中加入';
	@override String inviteFailed({required Object error}) => '发送邀请失败：${error}';
	@override String get inviteButton => '向自己发送邀请';
	@override String isPrivate({required Object number}) => '${number}人私密';
	@override String isActive({required Object number}) => '${number}人在线';
	@override String isOffline({required Object number}) => '${number}人离线';
	@override String isTraveling({required Object number}) => '${number}人移动中';
	@override String isStaying({required Object number}) => '${number}人停留中';
}

// Path: reminder
class Translations$reminder$zh_CN implements Translations$reminder$en {
	Translations$reminder$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get dialogTitle => '设置提醒';
	@override String get alreadySet => '已设置';
	@override String get set => '设置';
	@override String get cancel => '取消';
	@override String get delete => '删除';
	@override String get deleteAll => '删除所有提醒';
	@override String get deleteAllConfirm => '这将删除所有已设置的活动提醒。此操作无法撤销。';
	@override String get deleted => '提醒已删除';
	@override String get deletedAll => '所有提醒已删除';
	@override String get noReminders => '没有已设置的提醒';
	@override String get setFromEvent => '您可以从活动页面设置通知';
	@override String eventStart({required Object time}) => '${time} 开始';
	@override String notifyAt({required Object time, required Object label}) => '${time} (${label})';
	@override String get receiveNotification => '您想在何时收到通知？';
}

// Path: friend
class Translations$friend$zh_CN implements Translations$friend$en {
	Translations$friend$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get sortFilter => '排序和筛选';
	@override String get filter => '筛选';
	@override String get filterAll => '显示全部';
	@override String get filterOnline => '仅在线';
	@override String get filterOffline => '仅离线';
	@override String get filterFavorite => '仅收藏';
	@override String get sort => '排序';
	@override String get sortStatus => '按在线状态';
	@override String get sortName => '按名称';
	@override String get sortLastLogin => '按最后登录时间';
	@override String get sortAsc => '升序';
	@override String get sortDesc => '降序';
	@override String get close => '关闭';
}

// Path: eventCalendarFilter
class Translations$eventCalendarFilter$zh_CN implements Translations$eventCalendarFilter$en {
	Translations$eventCalendarFilter$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get filterTitle => '筛选活动';
	@override String get clear => '清除';
	@override String get keyword => '关键词搜索';
	@override String get keywordHint => '活动名称、说明、主办方等';
	@override String get date => '按日期筛选';
	@override String get dateHint => '可以显示特定日期范围的活动';
	@override String get startDate => '开始日期';
	@override String get endDate => '结束日期';
	@override String get select => '请选择';
	@override String get time => '按时间段筛选';
	@override String get timeHint => '可以显示特定时间段举办的活动';
	@override String get startTime => '开始时间';
	@override String get endTime => '结束时间';
	@override String get genre => '按类型筛选';
	@override String genreSelected({required Object count}) => '已选择 ${count} 个类型';
	@override String get apply => '应用';
	@override String get filterSummary => '筛选器';
	@override String get filterNone => '未设置筛选器';
}

// Path: drawer.section
class Translations$drawer$section$zh_CN implements Translations$drawer$section$en {
	Translations$drawer$section$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get content => '内容';
	@override String get other => '其他';
}

// Path: search.tabs
class Translations$search$tabs$zh_CN implements Translations$search$tabs$en {
	Translations$search$tabs$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override late final Translations$search$tabs$userSearch$zh_CN userSearch = Translations$search$tabs$userSearch$zh_CN.internal(_root);
	@override late final Translations$search$tabs$worldSearch$zh_CN worldSearch = Translations$search$tabs$worldSearch$zh_CN.internal(_root);
	@override late final Translations$search$tabs$groupSearch$zh_CN groupSearch = Translations$search$tabs$groupSearch$zh_CN.internal(_root);
	@override late final Translations$search$tabs$avatarSearch$zh_CN avatarSearch = Translations$search$tabs$avatarSearch$zh_CN.internal(_root);
}

// Path: groupDetail.privacy
class Translations$groupDetail$privacy$zh_CN implements Translations$groupDetail$privacy$en {
	Translations$groupDetail$privacy$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get public => '公开';
	@override String get private => '私密';
	@override String get friends => '好友';
	@override String get invite => '邀请制';
	@override String get unknown => '未知';
}

// Path: groupDetail.role
class Translations$groupDetail$role$zh_CN implements Translations$groupDetail$role$en {
	Translations$groupDetail$role$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get admin => '管理员';
	@override String get moderator => '版主';
	@override String get member => '成员';
	@override String get unknown => '未知';
}

// Path: inventory.tabs
class Translations$inventory$tabs$zh_CN implements Translations$inventory$tabs$en {
	Translations$inventory$tabs$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override late final Translations$inventory$tabs$emojiInventory$zh_CN emojiInventory = Translations$inventory$tabs$emojiInventory$zh_CN.internal(_root);
	@override late final Translations$inventory$tabs$galleryInventory$zh_CN galleryInventory = Translations$inventory$tabs$galleryInventory$zh_CN.internal(_root);
	@override late final Translations$inventory$tabs$iconInventory$zh_CN iconInventory = Translations$inventory$tabs$iconInventory$zh_CN.internal(_root);
	@override late final Translations$inventory$tabs$printInventory$zh_CN printInventory = Translations$inventory$tabs$printInventory$zh_CN.internal(_root);
	@override late final Translations$inventory$tabs$stickerInventory$zh_CN stickerInventory = Translations$inventory$tabs$stickerInventory$zh_CN.internal(_root);
	@override late final Translations$inventory$tabs$inventoryItem$zh_CN inventoryItem = Translations$inventory$tabs$inventoryItem$zh_CN.internal(_root);
}

// Path: credits.section
class Translations$credits$section$zh_CN implements Translations$credits$section$en {
	Translations$credits$section$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get development => '开发';
	@override String get iconPeople => '有趣的图标制作者们';
	@override String get testFeedback => '测试与反馈';
	@override String get specialThanks => '特别感谢';
}

// Path: instance.type
class Translations$instance$type$zh_CN implements Translations$instance$type$en {
	Translations$instance$type$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get public => '公开';
	@override String get hidden => '好友+';
	@override String get friends => '好友';
	@override String get private => '邀请+';
	@override String get unknown => '未知';
}

// Path: search.tabs.userSearch
class Translations$search$tabs$userSearch$zh_CN implements Translations$search$tabs$userSearch$en {
	Translations$search$tabs$userSearch$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get emptyTitle => '用户搜索';
	@override String get emptyDescription => '您可以通过用户名或ID进行搜索';
	@override String get searching => '搜索中...';
	@override String get noResults => '未找到相关用户';
	@override String error({required Object error}) => '用户搜索时发生错误：${error}';
	@override String get inputPlaceholder => '输入用户名或ID';
}

// Path: search.tabs.worldSearch
class Translations$search$tabs$worldSearch$zh_CN implements Translations$search$tabs$worldSearch$en {
	Translations$search$tabs$worldSearch$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get emptyTitle => '探索世界';
	@override String get emptyDescription => '请输入关键词进行搜索';
	@override String get searching => '搜索中...';
	@override String get noResults => '未找到相关世界';
	@override String noResultsWithQuery({required Object query}) => '未找到与“${query}”匹配的世界';
	@override String get noResultsHint => '尝试更换搜索关键词吧';
	@override String error({required Object error}) => '世界搜索时发生错误：${error}';
	@override String resultCount({required Object count}) => '找到了 ${count} 个世界';
	@override String authorPrefix({required Object authorName}) => 'by ${authorName}';
	@override String get listView => '列表视图';
	@override String get gridView => '网格视图';
}

// Path: search.tabs.groupSearch
class Translations$search$tabs$groupSearch$zh_CN implements Translations$search$tabs$groupSearch$en {
	Translations$search$tabs$groupSearch$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get emptyTitle => '搜索群组';
	@override String get emptyDescription => '请输入关键词进行搜索';
	@override String get searching => '搜索中...';
	@override String get noResults => '未找到相关群组';
	@override String noResultsWithQuery({required Object query}) => '未找到与“${query}”匹配的群组';
	@override String get noResultsHint => '尝试更换搜索关键词吧';
	@override String error({required Object error}) => '群组搜索时发生错误：${error}';
	@override String resultCount({required Object count}) => '找到了 ${count} 个群组';
	@override String get listView => '列表视图';
	@override String get gridView => '网格视图';
	@override String memberCount({required Object count}) => '${count} 成员';
}

// Path: search.tabs.avatarSearch
class Translations$search$tabs$avatarSearch$zh_CN implements Translations$search$tabs$avatarSearch$en {
	Translations$search$tabs$avatarSearch$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get avatar => '虚拟形象';
	@override String get emptyTitle => '搜索虚拟形象';
	@override String get emptyDescription => '请输入关键词进行搜索';
	@override String get searching => '正在搜索虚拟形象...';
	@override String get noResults => '未找到搜索结果';
	@override String get noResultsHint => '试试其他关键词吧';
	@override String error({required Object error}) => '虚拟形象搜索时发生错误：${error}';
}

// Path: inventory.tabs.emojiInventory
class Translations$inventory$tabs$emojiInventory$zh_CN implements Translations$inventory$tabs$emojiInventory$en {
	Translations$inventory$tabs$emojiInventory$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get loading => '正在加载表情...';
	@override String error({required Object error}) => '获取表情失败：${error}';
	@override String get emptyTitle => '没有表情';
	@override String get emptyDescription => '您在VRChat中上传的表情将显示在这里';
	@override String get zoomHint => '双击缩放';
}

// Path: inventory.tabs.galleryInventory
class Translations$inventory$tabs$galleryInventory$zh_CN implements Translations$inventory$tabs$galleryInventory$en {
	Translations$inventory$tabs$galleryInventory$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get loading => '正在加载画廊...';
	@override String error({required Object error}) => '获取画廊失败：${error}';
	@override String get emptyTitle => '没有画廊';
	@override String get emptyDescription => '您在VRChat中上传的画廊将显示在这里';
	@override String get zoomHint => '双击缩放';
}

// Path: inventory.tabs.iconInventory
class Translations$inventory$tabs$iconInventory$zh_CN implements Translations$inventory$tabs$iconInventory$en {
	Translations$inventory$tabs$iconInventory$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get loading => '正在加载图标...';
	@override String error({required Object error}) => '获取图标失败：${error}';
	@override String get emptyTitle => '没有图标';
	@override String get emptyDescription => '您在VRChat中上传的图标将显示在这里';
	@override String get zoomHint => '双击缩放';
}

// Path: inventory.tabs.printInventory
class Translations$inventory$tabs$printInventory$zh_CN implements Translations$inventory$tabs$printInventory$en {
	Translations$inventory$tabs$printInventory$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get loading => '正在加载打印图...';
	@override String error({required Object error}) => '获取打印图失败：${error}';
	@override String get emptyTitle => '没有打印图';
	@override String get emptyDescription => '您在VRChat中上传的打印图将显示在这里';
	@override String get zoomHint => '双击缩放';
}

// Path: inventory.tabs.stickerInventory
class Translations$inventory$tabs$stickerInventory$zh_CN implements Translations$inventory$tabs$stickerInventory$en {
	Translations$inventory$tabs$stickerInventory$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get loading => '正在加载贴纸...';
	@override String error({required Object error}) => '获取贴纸失败：${error}';
	@override String get emptyTitle => '没有贴纸';
	@override String get emptyDescription => '您在VRChat中上传的贴纸将显示在这里';
	@override String get zoomHint => '双击缩放';
}

// Path: inventory.tabs.inventoryItem
class Translations$inventory$tabs$inventoryItem$zh_CN implements Translations$inventory$tabs$inventoryItem$en {
	Translations$inventory$tabs$inventoryItem$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get loading => '正在加载物品栏...';
	@override String error({required Object error}) => '获取物品栏失败：${error}';
	@override String get emptyTitle => '没有物品';
	@override String get spawn => '生成';
	@override String get unequip => '卸下';
	@override String equipped({required Object slot}) => '已装备：${slot}';
	@override String spawned({required Object name}) => '已生成 ${name}';
}

/// The flat map containing all translations for locale <zh-CN>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsZhCn {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'common.title' => 'VRCN',
			'common.ok' => '确定',
			'common.cancel' => '取消',
			'common.close' => '关闭',
			'common.save' => '保存',
			'common.edit' => '编辑',
			'common.delete' => '删除',
			'common.yes' => '是',
			'common.no' => '否',
			'common.loading' => '加载中...',
			'common.error' => ({required Object error}) => '发生错误：${error}',
			'common.errorNomessage' => '发生错误',
			'common.retry' => '重试',
			'common.search' => '搜索',
			'common.settings' => '设置',
			'common.confirm' => '确认',
			'common.agree' => '同意',
			'common.decline' => '不同意',
			'common.username' => '用户名',
			'common.password' => '密码',
			'common.login' => '登录',
			'common.logout' => '登出',
			'common.share' => '分享',
			'termsAgreement.welcomeTitle' => '欢迎来到 VRCN',
			'termsAgreement.welcomeMessage' => '在使用本应用前，\n请阅读服务条款和隐私政策。',
			'termsAgreement.termsTitle' => '服务条款',
			'termsAgreement.termsSubtitle' => '关于应用的使用条件',
			'termsAgreement.privacyTitle' => '隐私政策',
			'termsAgreement.privacySubtitle' => '关于个人信息的处理',
			'termsAgreement.agreeTerms' => ({required Object title}) => '我同意“${title}”',
			'termsAgreement.checkContent' => '查看内容',
			'termsAgreement.notice' => '本应用是 VRChat Inc. 的非官方应用。\n与 VRChat Inc. 没有任何关系。',
			'drawer.home' => '主页',
			'drawer.profile' => '个人资料',
			'drawer.favorite' => '收藏',
			'drawer.eventCalendar' => '活动日历',
			'drawer.avatar' => '虚拟形象',
			'drawer.group' => '群组',
			'drawer.inventory' => '物品栏',
			'drawer.review' => '评价',
			'drawer.feedback' => '反馈',
			'drawer.settings' => '设置',
			'drawer.userLoading' => '正在加载用户信息...',
			'drawer.userError' => '加载用户信息失败',
			'drawer.retry' => '重试',
			'drawer.section.content' => '内容',
			'drawer.section.other' => '其他',
			'login.forgotPassword' => '忘记密码？',
			'login.createAccount' => '注册',
			'login.subtitle' => '使用您的 VRChat 账户登录',
			'login.email' => '邮箱地址',
			'login.emailHint' => '输入邮箱或用户名',
			'login.passwordHint' => '输入密码',
			'login.rememberMe' => '记住登录状态',
			'login.loggingIn' => '登录中...',
			'login.errorEmptyEmail' => '请输入用户名或邮箱地址',
			'login.errorEmptyPassword' => '请输入密码',
			'login.errorLoginFailed' => '登录失败。请检查您的邮箱和密码。',
			'login.twoFactorTitle' => '两步验证',
			'login.twoFactorSubtitle' => '请输入验证码',
			'login.twoFactorInstruction' => '请输入您的验证器应用中显示的\n6位数验证码',
			'login.twoFactorCodeHint' => '验证码',
			'login.verify' => '验证',
			'login.verifying' => '验证中...',
			'login.errorEmpty2fa' => '请输入验证码',
			'login.error2faFailed' => '两步验证失败。请检查验证码是否正确。',
			'login.backToLogin' => '返回登录页面',
			'login.paste' => '粘贴',
			'friends.loading' => '正在加载好友信息...',
			'friends.error' => ({required Object error}) => '获取好友信息失败：${error}',
			'friends.notFound' => '未找到好友',
			'friends.private' => '私密',
			'friends.active' => '活跃',
			'friends.offline' => '离线',
			'friends.online' => '在线',
			'friends.groupTitle' => '按世界分组',
			'friends.refresh' => '刷新',
			'friends.searchHint' => '按好友名称搜索',
			'friends.noResult' => '没有找到相关的好友',
			'friendDetail.loading' => '正在加载用户信息...',
			'friendDetail.error' => ({required Object error}) => '获取用户信息失败：${error}',
			'friendDetail.currentLocation' => '当前位置',
			'friendDetail.basicInfo' => '基本信息',
			'friendDetail.userId' => '用户ID',
			'friendDetail.dateJoined' => '注册日期',
			'friendDetail.lastLogin' => '最后登录',
			'friendDetail.bio' => '个人简介',
			'friendDetail.links' => '链接',
			'friendDetail.loadingLinks' => '正在加载链接信息...',
			'friendDetail.group' => '所属群组',
			'friendDetail.groupDetail' => '显示群组详情',
			'friendDetail.groupCode' => ({required Object code}) => '群组代码：${code}',
			'friendDetail.memberCount' => ({required Object count}) => '成员数：${count}人',
			'friendDetail.unknownGroup' => '未知群组',
			'friendDetail.block' => '屏蔽',
			'friendDetail.mute' => '静音',
			'friendDetail.openWebsite' => '在网站上打开',
			'friendDetail.shareProfile' => '分享个人资料',
			'friendDetail.confirmBlockTitle' => ({required Object name}) => '要屏蔽 ${name} 吗？',
			'friendDetail.confirmBlockMessage' => '屏蔽后，您将不会再收到该用户的好友请求和消息。',
			'friendDetail.confirmMuteTitle' => ({required Object name}) => '要将 ${name} 静音吗？',
			'friendDetail.confirmMuteMessage' => '静音后，您将听不到该用户的声音。',
			'friendDetail.blockSuccess' => '已屏蔽',
			'friendDetail.muteSuccess' => '已静音',
			'friendDetail.operationFailed' => ({required Object error}) => '操作失败：${error}',
			'search.userTab' => '用户',
			'search.worldTab' => '世界',
			'search.avatarTab' => '虚拟形象',
			'search.groupTab' => '群组',
			'search.tabs.userSearch.emptyTitle' => '用户搜索',
			'search.tabs.userSearch.emptyDescription' => '您可以通过用户名或ID进行搜索',
			'search.tabs.userSearch.searching' => '搜索中...',
			'search.tabs.userSearch.noResults' => '未找到相关用户',
			'search.tabs.userSearch.error' => ({required Object error}) => '用户搜索时发生错误：${error}',
			'search.tabs.userSearch.inputPlaceholder' => '输入用户名或ID',
			'search.tabs.worldSearch.emptyTitle' => '探索世界',
			'search.tabs.worldSearch.emptyDescription' => '请输入关键词进行搜索',
			'search.tabs.worldSearch.searching' => '搜索中...',
			'search.tabs.worldSearch.noResults' => '未找到相关世界',
			'search.tabs.worldSearch.noResultsWithQuery' => ({required Object query}) => '未找到与“${query}”匹配的世界',
			'search.tabs.worldSearch.noResultsHint' => '尝试更换搜索关键词吧',
			'search.tabs.worldSearch.error' => ({required Object error}) => '世界搜索时发生错误：${error}',
			'search.tabs.worldSearch.resultCount' => ({required Object count}) => '找到了 ${count} 个世界',
			'search.tabs.worldSearch.authorPrefix' => ({required Object authorName}) => 'by ${authorName}',
			'search.tabs.worldSearch.listView' => '列表视图',
			'search.tabs.worldSearch.gridView' => '网格视图',
			'search.tabs.groupSearch.emptyTitle' => '搜索群组',
			'search.tabs.groupSearch.emptyDescription' => '请输入关键词进行搜索',
			'search.tabs.groupSearch.searching' => '搜索中...',
			'search.tabs.groupSearch.noResults' => '未找到相关群组',
			'search.tabs.groupSearch.noResultsWithQuery' => ({required Object query}) => '未找到与“${query}”匹配的群组',
			'search.tabs.groupSearch.noResultsHint' => '尝试更换搜索关键词吧',
			'search.tabs.groupSearch.error' => ({required Object error}) => '群组搜索时发生错误：${error}',
			'search.tabs.groupSearch.resultCount' => ({required Object count}) => '找到了 ${count} 个群组',
			'search.tabs.groupSearch.listView' => '列表视图',
			'search.tabs.groupSearch.gridView' => '网格视图',
			'search.tabs.groupSearch.memberCount' => ({required Object count}) => '${count} 成员',
			'search.tabs.avatarSearch.avatar' => '虚拟形象',
			'search.tabs.avatarSearch.emptyTitle' => '搜索虚拟形象',
			'search.tabs.avatarSearch.emptyDescription' => '请输入关键词进行搜索',
			'search.tabs.avatarSearch.searching' => '正在搜索虚拟形象...',
			'search.tabs.avatarSearch.noResults' => '未找到搜索结果',
			'search.tabs.avatarSearch.noResultsHint' => '试试其他关键词吧',
			'search.tabs.avatarSearch.error' => ({required Object error}) => '虚拟形象搜索时发生错误：${error}',
			'profile.title' => '个人资料',
			'profile.edit' => '编辑',
			'profile.refresh' => '刷新',
			'profile.loading' => '正在加载个人资料信息...',
			'profile.error' => '获取个人资料信息失败：{error}',
			'profile.displayName' => '显示名称',
			'profile.username' => '用户名',
			'profile.userId' => '用户ID',
			'profile.engageCard' => '互动卡片',
			'profile.frined' => '好友',
			'profile.dateJoined' => '注册日期',
			'profile.userType' => '用户类型',
			'profile.status' => '状态',
			'profile.statusMessage' => '状态消息',
			'profile.bio' => '个人简介',
			'profile.links' => '链接',
			'profile.group' => '所属群组',
			'profile.groupDetail' => '显示群组详情',
			'profile.avatar' => '当前虚拟形象',
			'profile.avatarDetail' => '显示虚拟形象详情',
			'profile.public' => '公开',
			'profile.private' => '私密',
			'profile.hidden' => '隐藏',
			'profile.unknown' => '未知',
			'profile.friends' => '好友',
			'profile.loadingLinks' => '正在加载链接信息...',
			'profile.noGroup' => '未加入任何群组',
			'profile.noBio' => '无个人简介',
			'profile.noLinks' => '无链接',
			'profile.save' => '保存更改',
			'profile.saved' => '个人资料已更新',
			'profile.saveFailed' => '更新失败：{error}',
			'profile.discardTitle' => '要放弃更改吗？',
			'profile.discardContent' => '您对个人资料所做的更改将不会被保存。',
			'profile.discardCancel' => '取消',
			'profile.discardOk' => '放弃',
			'profile.basic' => '基本信息',
			'profile.pronouns' => '代词',
			'profile.addLink' => '添加',
			'profile.removeLink' => '移除',
			'profile.linkHint' => '输入链接（例如：https://twitter.com/username）',
			'profile.linksHint' => '链接将显示在您的个人资料上，点击即可打开',
			'profile.statusMessageHint' => '输入您当前的状态或消息',
			'profile.bioHint' => '写一些关于您自己的介绍吧',
			'engageCard.pickBackground' => '选择背景图片',
			'engageCard.removeBackground' => '移除背景图片',
			'engageCard.scanQr' => '扫描二维码',
			'engageCard.showAvatar' => '显示虚拟形象',
			'engageCard.hideAvatar' => '隐藏虚拟形象',
			'engageCard.noBackground' => '未选择背景图片\n您可以通过右上角的按钮进行设置',
			'engageCard.loading' => '加载中...',
			'engageCard.error' => ({required Object error}) => '获取互动卡片信息失败：${error}',
			'engageCard.copyUserId' => '复制用户ID',
			'engageCard.copied' => '已复制',
			'qrScanner.title' => '扫描二维码',
			'qrScanner.guide' => '请将二维码对准框内',
			'qrScanner.loading' => '正在初始化相机...',
			'qrScanner.error' => ({required Object error}) => '读取二维码失败：${error}',
			'qrScanner.notFound' => '未找到有效的用户二维码',
			'favorites.title' => '收藏',
			'favorites.frined' => '好友',
			'favorites.friendsTab' => '好友',
			'favorites.worldsTab' => '世界',
			'favorites.avatarsTab' => '虚拟形象',
			'favorites.emptyFolderTitle' => '没有收藏文件夹',
			'favorites.emptyFolderDescription' => '请在VRChat内创建收藏文件夹',
			'favorites.emptyFriends' => '此文件夹中没有好友',
			'favorites.emptyWorlds' => '此文件夹中没有世界',
			'favorites.emptyAvatars' => '此文件夹中没有虚拟形象',
			'favorites.emptyWorldsTabTitle' => '没有收藏的世界',
			'favorites.emptyWorldsTabDescription' => '您可以从世界详情页面将世界添加到收藏',
			'favorites.emptyAvatarsTabTitle' => '没有收藏的虚拟形象',
			'favorites.emptyAvatarsTabDescription' => '您可以从虚拟形象详情页面将形象添加到收藏',
			'favorites.loading' => '正在加载收藏...',
			'favorites.loadingFolder' => '正在加载文件夹信息...',
			'favorites.error' => ({required Object error}) => '加载收藏失败：${error}',
			'favorites.errorFolder' => '获取信息失败',
			'favorites.remove' => '从收藏中移除',
			'favorites.removeSuccess' => ({required Object name}) => '已将 ${name} 从收藏中移除',
			'favorites.removeFailed' => ({required Object error}) => '移除失败：${error}',
			'favorites.itemsCount' => ({required Object count}) => '${count} 个项目',
			'favorites.public' => '公开',
			'favorites.private' => '私密',
			'favorites.hidden' => '隐藏',
			'favorites.unknown' => '未知',
			'favorites.loadingError' => '加载错误',
			'notifications.title' => '通知',
			'notifications.emptyTitle' => '没有通知',
			'notifications.emptyDescription' => '好友请求、邀请等新通知\n将会显示在这里',
			'notifications.all' => '全部',
			'notifications.unread' => ({required Object count}) => '未读 (${count})',
			'notifications.read' => '已读',
			'notifications.activity' => '好友日志',
			'notifications.onlineAlerts' => '上线提醒',
			'notifications.markAllRead' => '全部标为已读',
			'notifications.markAllReadDone' => '所有通知已标为已读',
			'notifications.deleteConfirmTitle' => '删除通知？',
			'notifications.emptyUnread' => '没有未读通知',
			'notifications.emptyRead' => '没有已读通知',
			'notifications.friendOnlineAlerts' => '好友上线提醒',
			'notifications.selectedCount' => ({required Object count}) => '已选择 ${count} 人',
			'notifications.friendRequest' => ({required Object userName}) => '您收到了来自 ${userName} 的好友请求',
			'notifications.invite' => ({required Object userName, required Object worldName}) => '您收到了来自 ${userName} 前往 ${worldName} 的邀请',
			'notifications.friendOnline' => ({required Object userName}) => '${userName} 已上线',
			'notifications.friendOffline' => ({required Object userName}) => '${userName} 已离线',
			'notifications.friendActive' => ({required Object userName}) => '${userName} 变为活跃状态',
			'notifications.friendAdd' => ({required Object userName}) => '${userName} 已被添加为好友',
			'notifications.friendRemove' => ({required Object userName}) => '${userName} 已从好友中移除',
			'notifications.statusUpdate' => ({required Object userName, required Object status, required Object world}) => '${userName} 的状态已更新：${status}${world}',
			'notifications.locationChange' => ({required Object userName, required Object worldName}) => '${userName} 已移动到 ${worldName}',
			'notifications.userUpdate' => ({required Object world}) => '您的信息已更新${world}',
			'notifications.myLocationChange' => ({required Object worldName}) => '您的移动：${worldName}',
			'notifications.requestInvite' => ({required Object userName}) => '您收到了来自 ${userName} 的加入请求',
			'notifications.votekick' => ({required Object userName}) => '收到了来自 ${userName} 的投票踢出',
			'notifications.responseReceived' => ({required Object userName}) => '已收到通知ID:${userName}的响应',
			'notifications.error' => ({required Object worldName}) => '错误：${worldName}',
			'notifications.system' => ({required Object extraData}) => '系统通知：${extraData}',
			'notifications.secondsAgo' => ({required Object seconds}) => '${seconds}秒前',
			'notifications.minutesAgo' => ({required Object minutes}) => '${minutes}分钟前',
			'notifications.hoursAgo' => ({required Object hours}) => '${hours}小时前',
			'eventCalendar.title' => '活动日历',
			'eventCalendar.filter' => '筛选活动',
			'eventCalendar.refresh' => '刷新活动信息',
			'eventCalendar.loading' => '正在获取活动信息...',
			'eventCalendar.error' => ({required Object error}) => '获取活动信息失败：${error}',
			'eventCalendar.filterActive' => ({required Object count}) => '筛选已应用（${count}条）',
			'eventCalendar.clear' => '清除',
			'eventCalendar.noEvents' => '没有符合条件的活动',
			'eventCalendar.clearFilter' => '清除筛选',
			'eventCalendar.today' => '今天',
			'eventCalendar.reminderSet' => '设置提醒',
			'eventCalendar.reminderSetDone' => '已设置提醒',
			'eventCalendar.reminderDeleted' => '已删除提醒',
			'eventCalendar.eventName' => '活动名称',
			'eventCalendar.organizer' => '主办方',
			'eventCalendar.description' => '说明',
			'eventCalendar.genre' => '类型',
			'eventCalendar.condition' => '参加条件',
			'eventCalendar.way' => '参加方法',
			'eventCalendar.note' => '备注',
			'eventCalendar.quest' => '支持Quest',
			'eventCalendar.reminderCount' => ({required Object count}) => '${count}条',
			'eventCalendar.startToEnd' => ({required Object start, required Object end}) => '${start} ~ ${end}',
			'avatars.title' => '虚拟形象',
			'avatars.searchHint' => '按虚拟形象名称等搜索',
			'avatars.searchTooltip' => '搜索',
			'avatars.searchEmptyTitle' => '未找到搜索结果',
			'avatars.searchEmptyDescription' => '请尝试其他搜索词',
			'avatars.emptyTitle' => '没有虚拟形象',
			'avatars.emptyDescription' => '请添加虚拟形象或稍后重试',
			'avatars.refresh' => '刷新',
			'avatars.loading' => '正在加载虚拟形象...',
			'avatars.error' => ({required Object error}) => '获取虚拟形象信息失败：${error}',
			'avatars.current' => '使用中',
			'avatars.public' => '公开',
			'avatars.private' => '私密',
			'avatars.hidden' => '隐藏',
			'avatars.author' => '作者',
			'avatars.sortUpdated' => '按更新时间',
			'avatars.sortName' => '按名称',
			'avatars.sortTooltip' => '排序',
			'avatars.viewModeTooltip' => '切换视图模式',
			'worldDetail.loading' => '正在加载世界信息...',
			'worldDetail.error' => ({required Object error}) => '获取世界信息失败：${error}',
			'worldDetail.share' => '分享这个世界',
			'worldDetail.openInVRChat' => '在VRChat官网打开',
			'worldDetail.report' => '举报这个世界',
			'worldDetail.creator' => '创建者',
			'worldDetail.created' => '创建于',
			'worldDetail.updated' => '更新于',
			'worldDetail.favorites' => '收藏数',
			'worldDetail.visits' => '访问数',
			'worldDetail.occupants' => '当前人数',
			'worldDetail.popularity' => '评价',
			'worldDetail.description' => '说明',
			'worldDetail.noDescription' => '没有说明',
			'worldDetail.tags' => '标签',
			'worldDetail.joinPublic' => '发送公开邀请',
			'worldDetail.favoriteAdded' => '已添加到收藏',
			'worldDetail.favoriteRemoved' => '已从收藏中移除',
			'worldDetail.unknown' => '未知',
			'avatarDetail.changeSuccess' => ({required Object name}) => '已更换为虚拟形象“${name}”',
			'avatarDetail.changeFailed' => ({required Object error}) => '更换虚拟形象失败：${error}',
			'avatarDetail.changing' => '更换中...',
			'avatarDetail.useThisAvatar' => '使用此虚拟形象',
			'avatarDetail.creator' => '创建者',
			'avatarDetail.created' => '创建于',
			'avatarDetail.updated' => '更新于',
			'avatarDetail.description' => '说明',
			'avatarDetail.noDescription' => '没有说明',
			'avatarDetail.tags' => '标签',
			'avatarDetail.addToFavorites' => '添加到收藏',
			'avatarDetail.public' => '公开',
			'avatarDetail.private' => '私密',
			'avatarDetail.hidden' => '隐藏',
			'avatarDetail.unknown' => '未知',
			'avatarDetail.share' => '分享',
			'avatarDetail.loading' => '正在加载虚拟形象信息...',
			'avatarDetail.error' => ({required Object error}) => '获取虚拟形象信息失败：${error}',
			'groups.title' => '群组',
			'groups.loadingUser' => '正在加载用户信息...',
			'groups.errorUser' => ({required Object error}) => '获取用户信息失败：${error}',
			'groups.loadingGroups' => '正在加载群组信息...',
			'groups.errorGroups' => ({required Object error}) => '获取群组信息失败：${error}',
			'groups.emptyTitle' => '您尚未加入任何群组',
			'groups.emptyDescription' => '您可以从VRChat应用或网站加入群组',
			'groups.searchGroups' => '查找群组',
			'groups.members' => ({required Object count}) => '${count}名成员',
			'groups.showDetails' => '显示详情',
			'groups.unknownName' => '名称未知',
			'groupDetail.loading' => '正在加载群组信息...',
			'groupDetail.error' => ({required Object error}) => '获取群组信息失败：${error}',
			'groupDetail.share' => '分享群组信息',
			'groupDetail.description' => '说明',
			'groupDetail.roles' => '角色',
			'groupDetail.basicInfo' => '基本信息',
			'groupDetail.createdAt' => '创建日期',
			'groupDetail.owner' => '所有者',
			'groupDetail.rules' => '规则',
			'groupDetail.languages' => '语言',
			'groupDetail.memberCount' => ({required Object count}) => '${count} 成员',
			'groupDetail.privacy.public' => '公开',
			'groupDetail.privacy.private' => '私密',
			'groupDetail.privacy.friends' => '好友',
			'groupDetail.privacy.invite' => '邀请制',
			'groupDetail.privacy.unknown' => '未知',
			'groupDetail.role.admin' => '管理员',
			'groupDetail.role.moderator' => '版主',
			'groupDetail.role.member' => '成员',
			'groupDetail.role.unknown' => '未知',
			'inventory.title' => '物品栏',
			'inventory.gallery' => '画廊',
			'inventory.icon' => '图标',
			'inventory.emoji' => '表情',
			'inventory.sticker' => '贴纸',
			'inventory.print' => '打印图',
			'inventory.item' => '物品',
			'inventory.upload' => '上传文件',
			'inventory.uploadGallery' => '正在上传画廊图片...',
			'inventory.uploadIcon' => '正在上传图标...',
			'inventory.uploadEmoji' => '正在上传表情...',
			'inventory.uploadSticker' => '正在上传贴纸...',
			'inventory.uploadPrint' => '正在上传打印图...',
			'inventory.selectImage' => '选择图片',
			'inventory.selectFromGallery' => '从相册选择',
			'inventory.takePhoto' => '使用相机拍摄',
			'inventory.uploadSuccess' => '上传成功',
			'inventory.uploadFailed' => '上传失败',
			'inventory.uploadFailedFormat' => '文件格式或大小有问题。请选择小于1MB的PNG格式图片。',
			'inventory.uploadFailedAuth' => '认证失败。请重新登录。',
			'inventory.uploadFailedSize' => '文件太大。请选择更小的图片。',
			'inventory.uploadFailedServer' => ({required Object code}) => '发生服务器错误 (${code})',
			'inventory.pickImageFailed' => ({required Object error}) => '选择图片失败：${error}',
			'inventory.tabs.emojiInventory.loading' => '正在加载表情...',
			'inventory.tabs.emojiInventory.error' => ({required Object error}) => '获取表情失败：${error}',
			'inventory.tabs.emojiInventory.emptyTitle' => '没有表情',
			'inventory.tabs.emojiInventory.emptyDescription' => '您在VRChat中上传的表情将显示在这里',
			'inventory.tabs.emojiInventory.zoomHint' => '双击缩放',
			'inventory.tabs.galleryInventory.loading' => '正在加载画廊...',
			'inventory.tabs.galleryInventory.error' => ({required Object error}) => '获取画廊失败：${error}',
			'inventory.tabs.galleryInventory.emptyTitle' => '没有画廊',
			'inventory.tabs.galleryInventory.emptyDescription' => '您在VRChat中上传的画廊将显示在这里',
			'inventory.tabs.galleryInventory.zoomHint' => '双击缩放',
			'inventory.tabs.iconInventory.loading' => '正在加载图标...',
			'inventory.tabs.iconInventory.error' => ({required Object error}) => '获取图标失败：${error}',
			'inventory.tabs.iconInventory.emptyTitle' => '没有图标',
			'inventory.tabs.iconInventory.emptyDescription' => '您在VRChat中上传的图标将显示在这里',
			'inventory.tabs.iconInventory.zoomHint' => '双击缩放',
			'inventory.tabs.printInventory.loading' => '正在加载打印图...',
			'inventory.tabs.printInventory.error' => ({required Object error}) => '获取打印图失败：${error}',
			'inventory.tabs.printInventory.emptyTitle' => '没有打印图',
			'inventory.tabs.printInventory.emptyDescription' => '您在VRChat中上传的打印图将显示在这里',
			'inventory.tabs.printInventory.zoomHint' => '双击缩放',
			'inventory.tabs.stickerInventory.loading' => '正在加载贴纸...',
			'inventory.tabs.stickerInventory.error' => ({required Object error}) => '获取贴纸失败：${error}',
			'inventory.tabs.stickerInventory.emptyTitle' => '没有贴纸',
			'inventory.tabs.stickerInventory.emptyDescription' => '您在VRChat中上传的贴纸将显示在这里',
			'inventory.tabs.stickerInventory.zoomHint' => '双击缩放',
			'inventory.tabs.inventoryItem.loading' => '正在加载物品栏...',
			'inventory.tabs.inventoryItem.error' => ({required Object error}) => '获取物品栏失败：${error}',
			'inventory.tabs.inventoryItem.emptyTitle' => '没有物品',
			'inventory.tabs.inventoryItem.spawn' => '生成',
			'inventory.tabs.inventoryItem.unequip' => '卸下',
			'inventory.tabs.inventoryItem.equipped' => ({required Object slot}) => '已装备：${slot}',
			'inventory.tabs.inventoryItem.spawned' => ({required Object name}) => '已生成 ${name}',
			'feedback.title' => '反馈',
			'feedback.type' => '反馈类型',
			'feedback.types.bug' => '错误报告',
			'feedback.types.feature' => '功能请求',
			'feedback.types.improvement' => '改进建议',
			'feedback.types.other' => '其他',
			'feedback.inputTitle' => '标题 *',
			'feedback.inputTitleHint' => '请简要说明',
			'feedback.inputDescription' => '详细说明 *',
			'feedback.inputDescriptionHint' => '请提供详细说明...',
			'feedback.cancel' => '取消',
			'feedback.send' => '发送',
			'feedback.sending' => '发送中...',
			'feedback.required' => '标题和详细说明为必填项',
			'feedback.success' => '反馈已发送。谢谢！',
			'feedback.fail' => '反馈发送失败',
			'settings.appearance' => '外观',
			'settings.language' => '语言',
			'settings.languageDescription' => '您可以选择应用程序的显示语言',
			'settings.appIcon' => '应用图标',
			'settings.appIconDescription' => '更改主屏幕上显示的应用图标',
			'settings.contentSettings' => '内容设置',
			'settings.searchEnabled' => '搜索功能已启用',
			'settings.searchDisabled' => '搜索功能已禁用',
			'settings.enableSearch' => '启用搜索功能',
			'settings.enableSearchDescription' => '搜索结果可能包含成人或暴力内容。',
			'settings.apiSetting' => '虚拟形象搜索API',
			'settings.apiSettingDescription' => '设置虚拟形象搜索功能的API',
			'settings.apiSettingSaveUrl' => 'URL已保存',
			'settings.notSet' => '未设置（虚拟形象搜索功能无法使用）',
			'settings.notifications' => '通知设置',
			'settings.eventReminder' => '活动提醒',
			'settings.eventReminderDescription' => '在您设定的活动开始前接收通知',
			'settings.manageReminders' => '管理已设置的提醒',
			'settings.manageRemindersDescription' => '可以取消或确认通知',
			'settings.dataStorage' => '数据与存储',
			'settings.clearCache' => '清除缓存',
			'settings.clearCacheSuccess' => '缓存已清除',
			'settings.clearCacheError' => '清除缓存时发生错误',
			'settings.cacheSize' => ({required Object size}) => '缓存大小: ${size}',
			'settings.calculatingCache' => '正在计算缓存大小...',
			'settings.cacheError' => '无法获取缓存大小',
			'settings.confirmClearCache' => '清除缓存将删除临时保存的图片和数据。\n\n您的账户信息和应用设置不会被删除。',
			'settings.appInfo' => '应用信息',
			'settings.version' => '版本',
			'settings.packageName' => '包名',
			'settings.credit' => '鸣谢',
			'settings.creditDescription' => '开发者和贡献者信息',
			'settings.contact' => '联系我们',
			'settings.contactDescription' => 'BUG报告和建议请点此',
			'settings.privacyPolicy' => '隐私政策',
			'settings.privacyPolicyDescription' => '关于个人信息的处理',
			'settings.termsOfService' => '服务条款',
			'settings.termsOfServiceDescription' => '应用使用条件',
			'settings.openSource' => '开源信息',
			'settings.openSourceDescription' => '所使用的库等许可证信息',
			'settings.github' => 'GitHub仓库',
			'settings.githubDescription' => '查看源代码',
			'settings.logoutConfirm' => '确定要登出吗？',
			'settings.logoutError' => ({required Object error}) => '登出时发生错误：${error}',
			'settings.iconChangeNotSupported' => '您的设备不支持更改应用图标',
			'settings.iconChangeFailed' => '更改图标失败',
			'settings.themeMode' => '主题模式',
			'settings.themeModeDescription' => '您可以选择应用的显示主题',
			'settings.themeLight' => '浅色',
			'settings.themeSystem' => '系统',
			'settings.themeDark' => '深色',
			'settings.appIconDefault' => '默认',
			'settings.appIconIcon' => '图标',
			'settings.appIconLogo' => '标志',
			'settings.delete' => '删除',
			'credits.title' => '鸣谢',
			'credits.section.development' => '开发',
			'credits.section.iconPeople' => '有趣的图标制作者们',
			'credits.section.testFeedback' => '测试与反馈',
			'credits.section.specialThanks' => '特别感谢',
			'download.shareFailure' => ({required Object error}) => '分享失败：${error}',
			'download.sharing' => ({required Object fileName}) => '正在准备分享 ${fileName}...',
			'instance.type.public' => '公开',
			'instance.type.hidden' => '好友+',
			'instance.type.friends' => '好友',
			'instance.type.private' => '邀请+',
			'instance.type.unknown' => '未知',
			_ => null,
		} ?? switch (path) {
			'status.active' => '在线',
			'status.joinMe' => '欢迎加入',
			'status.askMe' => '请问我',
			'status.busy' => '忙碌',
			'status.offline' => '离线',
			'status.unknown' => '状态未知',
			'location.private' => '私密',
			'location.playerCount' => ({required Object userCount, required Object capacity}) => '玩家数：${userCount} / ${capacity}',
			'location.instanceType' => ({required Object type}) => '实例类型：${type}',
			'location.noInfo' => '没有位置信息',
			'location.fetchError' => '获取位置信息失败',
			'location.privateLocation' => '您在一个私密地点',
			'location.inviteSending' => '发送邀请中...',
			'location.inviteSent' => '邀请已发送。您可以从通知中加入',
			'location.inviteFailed' => ({required Object error}) => '发送邀请失败：${error}',
			'location.inviteButton' => '向自己发送邀请',
			'location.isPrivate' => ({required Object number}) => '${number}人私密',
			'location.isActive' => ({required Object number}) => '${number}人在线',
			'location.isOffline' => ({required Object number}) => '${number}人离线',
			'location.isTraveling' => ({required Object number}) => '${number}人移动中',
			'location.isStaying' => ({required Object number}) => '${number}人停留中',
			'reminder.dialogTitle' => '设置提醒',
			'reminder.alreadySet' => '已设置',
			'reminder.set' => '设置',
			'reminder.cancel' => '取消',
			'reminder.delete' => '删除',
			'reminder.deleteAll' => '删除所有提醒',
			'reminder.deleteAllConfirm' => '这将删除所有已设置的活动提醒。此操作无法撤销。',
			'reminder.deleted' => '提醒已删除',
			'reminder.deletedAll' => '所有提醒已删除',
			'reminder.noReminders' => '没有已设置的提醒',
			'reminder.setFromEvent' => '您可以从活动页面设置通知',
			'reminder.eventStart' => ({required Object time}) => '${time} 开始',
			'reminder.notifyAt' => ({required Object time, required Object label}) => '${time} (${label})',
			'reminder.receiveNotification' => '您想在何时收到通知？',
			'friend.sortFilter' => '排序和筛选',
			'friend.filter' => '筛选',
			'friend.filterAll' => '显示全部',
			'friend.filterOnline' => '仅在线',
			'friend.filterOffline' => '仅离线',
			'friend.filterFavorite' => '仅收藏',
			'friend.sort' => '排序',
			'friend.sortStatus' => '按在线状态',
			'friend.sortName' => '按名称',
			'friend.sortLastLogin' => '按最后登录时间',
			'friend.sortAsc' => '升序',
			'friend.sortDesc' => '降序',
			'friend.close' => '关闭',
			'eventCalendarFilter.filterTitle' => '筛选活动',
			'eventCalendarFilter.clear' => '清除',
			'eventCalendarFilter.keyword' => '关键词搜索',
			'eventCalendarFilter.keywordHint' => '活动名称、说明、主办方等',
			'eventCalendarFilter.date' => '按日期筛选',
			'eventCalendarFilter.dateHint' => '可以显示特定日期范围的活动',
			'eventCalendarFilter.startDate' => '开始日期',
			'eventCalendarFilter.endDate' => '结束日期',
			'eventCalendarFilter.select' => '请选择',
			'eventCalendarFilter.time' => '按时间段筛选',
			'eventCalendarFilter.timeHint' => '可以显示特定时间段举办的活动',
			'eventCalendarFilter.startTime' => '开始时间',
			'eventCalendarFilter.endTime' => '结束时间',
			'eventCalendarFilter.genre' => '按类型筛选',
			'eventCalendarFilter.genreSelected' => ({required Object count}) => '已选择 ${count} 个类型',
			'eventCalendarFilter.apply' => '应用',
			'eventCalendarFilter.filterSummary' => '筛选器',
			'eventCalendarFilter.filterNone' => '未设置筛选器',
			_ => null,
		};
	}
}
