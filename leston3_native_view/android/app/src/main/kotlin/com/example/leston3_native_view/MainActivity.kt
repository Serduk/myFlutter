package com.example.leston3_native_view

import android.content.Context
import android.os.Bundle
import android.widget.TextView

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val reg = registrarFor("NativeView")


        reg.platformViewRegistry()
                .registerViewFactory("textView", NativeViewFactory(reg.messenger()))

        GeneratedPluginRegistrant.registerWith(this)
    }
}

class NativeViewFactory(private val messenger: BinaryMessenger)
    : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, id: Int, arg: Any?): PlatformView {
        return NativeView(context, id, arg, messenger)
    }
}

class NativeView(context: Context, id: Int, arg: Any?, messenger: BinaryMessenger) : PlatformView,
        MethodChannel.MethodCallHandler {

    init {
        MethodChannel(messenger, "textView_$id").setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "setText" -> {
                textView.text = call.arguments as String
                result.success(null)
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    private val textView = TextView(context).apply {
        text = arg?.let { it.toString() } ?: "Hello from Android"
    }

    override fun getView() = textView

    override fun dispose() = Unit
}