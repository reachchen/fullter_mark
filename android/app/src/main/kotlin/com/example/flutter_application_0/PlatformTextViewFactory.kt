package com.example.flutter_application_0

import android.content.Context
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class PlatformTextViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(p0: Context, p1: Int, p2: Any): PlatformView {
        return PlatformTextView(p0, p1, p2 as Object);
    }

}
