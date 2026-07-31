package com.nullbase.vrchat

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.view.View
import android.widget.RemoteViews
import org.json.JSONArray
import org.json.JSONObject
import java.time.Instant
import java.time.ZoneId
import java.time.format.DateTimeFormatter

class FriendStatusWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
    ) {
        updateAll(context, appWidgetIds)
    }

    companion object {
        const val PREFS_NAME = "friend_status_widget"
        const val DATA_KEY = "friends"

        fun updateAll(context: Context, appWidgetIds: IntArray) {
            val manager = AppWidgetManager.getInstance(context)
            val friends = readFriends(context)
            appWidgetIds.forEach { widgetId ->
                manager.updateAppWidget(widgetId, buildViews(context, friends))
            }
        }

        private fun buildViews(context: Context, friends: List<FriendStatus>): RemoteViews {
            val views = RemoteViews(context.packageName, R.layout.friend_status_widget)
            val launchIntent = context.packageManager.getLaunchIntentForPackage(context.packageName)
                ?: Intent(context, MainActivity::class.java)
            val pendingIntent = PendingIntent.getActivity(
                context,
                0,
                launchIntent,
                PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT,
            )
            views.setOnClickPendingIntent(R.id.widget_root, pendingIntent)

            if (friends.isEmpty()) {
                views.setViewVisibility(R.id.widget_empty, View.VISIBLE)
                views.setViewVisibility(R.id.widget_rows, View.GONE)
                views.setTextViewText(R.id.widget_updated_at, "Open VRCN")
                return views
            }

            views.setViewVisibility(R.id.widget_empty, View.GONE)
            views.setViewVisibility(R.id.widget_rows, View.VISIBLE)
            listOf(R.id.widget_row_1, R.id.widget_row_2, R.id.widget_row_3).forEachIndexed { index, rowId ->
                if (index >= friends.size) {
                    views.setViewVisibility(rowId, View.GONE)
                } else {
                    val friend = friends[index]
                    views.setViewVisibility(rowId, View.VISIBLE)
                    views.setTextViewText(rowId, "${friend.indicator} ${friend.name}  ${friend.statusLabel}")
                    views.setTextColor(rowId, friend.color)
                }
            }

            views.setTextViewText(R.id.widget_updated_at, friends.first().updatedAtLabel)
            return views
        }

        private fun readFriends(context: Context): List<FriendStatus> {
            val payload = context
                .getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
                .getString(DATA_KEY, null)
                ?: return emptyList()

            return runCatching {
                val items = JSONArray(payload)
                List(items.length()) { index ->
                    FriendStatus.fromJson(items.getJSONObject(index))
                }
            }.getOrDefault(emptyList())
        }
    }
}

private data class FriendStatus(
    val name: String,
    val status: String,
    val statusLabel: String,
    val updatedAt: String,
) {
    val indicator: String
        get() = if (status == "offline") "○" else "●"

    val color: Int
        get() = when (status) {
            "joinMe" -> Color.rgb(59, 130, 246)
            "askMe" -> Color.rgb(245, 158, 11)
            "busy" -> Color.rgb(239, 68, 68)
            "offline" -> Color.rgb(148, 163, 184)
            else -> Color.rgb(34, 197, 94)
        }

    val updatedAtLabel: String
        get() = runCatching {
            val formatter = DateTimeFormatter.ofPattern("HH:mm")
                .withZone(ZoneId.systemDefault())
            "Updated ${formatter.format(Instant.parse(updatedAt))}"
        }.getOrDefault("Updated")

    companion object {
        fun fromJson(json: JSONObject): FriendStatus {
            return FriendStatus(
                name = json.optString("name", "Friend"),
                status = json.optString("status", "offline"),
                statusLabel = json.optString("statusLabel", "Offline"),
                updatedAt = json.optString("updatedAt", ""),
            )
        }
    }
}
