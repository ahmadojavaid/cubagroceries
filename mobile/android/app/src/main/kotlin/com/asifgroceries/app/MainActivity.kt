package com.asifgroceries.app

import android.app.NotificationChannel
import android.app.NotificationManager
import android.media.AudioAttributes
import android.media.MediaPlayer
import android.net.Uri
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.asifgroceries.app/alert"
    private var mediaPlayer: MediaPlayer? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        createNotificationChannels()

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "playAlert" -> {
                    playAlertSound()
                    result.success(null)
                }
                "stopAlert" -> {
                    stopAlertSound()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun playAlertSound() {
        stopAlertSound()
        try {
            val uri = Uri.parse("android.resource://${packageName}/raw/rider_alert")
            mediaPlayer = MediaPlayer().apply {
                setDataSource(this@MainActivity, uri)
                setAudioAttributes(
                    AudioAttributes.Builder()
                        .setUsage(AudioAttributes.USAGE_NOTIFICATION_RINGTONE)
                        .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                        .build()
                )
                isLooping = true
                prepare()
                start()
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun stopAlertSound() {
        mediaPlayer?.let {
            if (it.isPlaying) it.stop()
            it.release()
        }
        mediaPlayer = null
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
            val alarmSound = Uri.parse(
                "android.resource://${packageName}/raw/rider_alert"
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
