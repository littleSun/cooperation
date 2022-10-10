package com.gtbluesky.cooperation

import android.app.Application
import io.flutter.FlutterInjector
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineGroup
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel

object Cooperation {
    private var engine: FlutterEngine? = null
    private var methodChannel: MethodChannel? = null

    fun install(engine: FlutterEngine) {
        this.engine = engine
        methodChannel = MethodChannel(engine.dartExecutor, "cooperation_channel")
    }

    fun install(
        context: Application,
        engineGroup: FlutterEngineGroup,
        library: String? = null,
        entryPoint: String = "main"
    ) {
        val flutterLoader = FlutterInjector.instance().flutterLoader()
        val dartEntrypoint = if (library == null) {
            DartExecutor.DartEntrypoint(flutterLoader.findAppBundlePath(), entryPoint)
        } else {
            DartExecutor.DartEntrypoint(flutterLoader.findAppBundlePath(), library, entryPoint)
        }
        val engine = engineGroup.createAndRunEngine(context, dartEntrypoint)
        install(engine)
//        GeneratedPluginRegister.registerGeneratedPlugins(engine)
    }

    fun uninstall() {
        methodChannel = null
        engine?.destroy()
        engine = null
    }

    fun call(
        method: String,
        arguments: Map<String, Any>? = null,
        result: MethodChannel.Result? = null
    ) {
        methodChannel?.invokeMethod(method, arguments, result)
    }
}