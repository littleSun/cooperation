package com.gtbluesky.cooperation_example

import android.app.Application
import com.gtbluesky.cooperation.Cooperation
import io.flutter.embedding.engine.FlutterEngineGroup

class MyApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        val engineGroup = FlutterEngineGroup(this)
        Cooperation.install(this, engineGroup, "package:cooperation_example/entry.dart", "entry")
    }
}