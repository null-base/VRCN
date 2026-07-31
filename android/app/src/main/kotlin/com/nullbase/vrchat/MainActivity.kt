package com.nullbase.vrchat

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.plugin.common.MethodChannel
import org.json.JSONArray

class MainActivity : FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "vrcn/friend_status_widget",
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "update" -> {
                    val friends = call.argument<List<Map<String, Any?>>>("friends").orEmpty()
                    val payload = JSONArray(friends).toString()
                    getSharedPreferences(FriendStatusWidgetProvider.PREFS_NAME, Context.MODE_PRIVATE)
                        .edit()
                        .putString(FriendStatusWidgetProvider.DATA_KEY, payload)
                        .apply()
                    updateWidgets()
                    result.success(null)
                }
                "clear" -> {
                    getSharedPreferences(FriendStatusWidgetProvider.PREFS_NAME, Context.MODE_PRIVATE)
                        .edit()
                        .remove(FriendStatusWidgetProvider.DATA_KEY)
                        .apply()
                    updateWidgets()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun updateWidgets() {
        val manager = AppWidgetManager.getInstance(this)
        val provider = ComponentName(this, FriendStatusWidgetProvider::class.java)
        FriendStatusWidgetProvider.updateAll(this, manager.getAppWidgetIds(provider))
    }
}
