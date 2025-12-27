package com.example.login_page

import android.content.ComponentName
import android.content.pm.PackageManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "icon_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "changeIcon") {
                    val icon = call.arguments as String
                    switchIcon(icon)
                    result.success(true)
                } else {
                    result.notImplemented()
                }
            }
    }

    private fun switchIcon(icon: String) {
        val pm = packageManager
        val pkg = packageName

        listOf("IconOne", "IconTwo", "IconThree", "IconFour").forEach {
            pm.setComponentEnabledSetting(
                ComponentName(pkg, "$pkg.$it"),
                if (it == icon)
                    PackageManager.COMPONENT_ENABLED_STATE_ENABLED
                else
                    PackageManager.COMPONENT_ENABLED_STATE_DISABLED,
                PackageManager.DONT_KILL_APP
            )
        }
    }
}

