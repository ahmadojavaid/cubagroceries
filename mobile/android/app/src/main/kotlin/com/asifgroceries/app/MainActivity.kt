package com.asifgroceries.app

import android.app.NotificationChannel
import android.app.NotificationManager
import android.media.AudioAttributes
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        createNotificationChannels()
    }

    private fun createNotificationChannels() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val manager = getSystemService(NotificationManager::class.java)

            // Default channel for order updates etc.
            val defaultChannel = NotificationChannel(
                "default",
                "General Notifications",
                NotificationManager.IMPORTANCE_DEFAULT
            ).apply {
                description = "Order updates and general notifications"
            }
            manager.createNotificationChannel(defaultChannel)

            // Rider job alert channel — high importance with custom alert sound
            val alarmSound = android.net.Uri.parse(
                "android.resource://${packageName}/${R.raw.rider_alert}"
            )

            val riderChannel = NotificationChannel(
                "rider_job_alert",
                "New Delivery Jobs",
                NotificationManager.IMPORTANCE_HIGH
            ).apply {
                description = "Alert when a new delivery job is assigned to you"
                setSound(
                    alarmSound,
                    AudioAttributes.Builder()
                        .setUsage(AudioAttributes.USAGE_NOTIFICATION_RINGTONE)
                        .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                        .build()
                )
                enableVibration(true)
                vibrationPattern = longArrayOf(0, 500, 200, 500, 200, 500)
            }
            manager.createNotificationChannel(riderChannel)
        }
    }
}
