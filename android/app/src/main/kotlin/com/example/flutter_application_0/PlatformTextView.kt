package com.example.flutter_application_0
import android.content.Context
import android.view.View
import android.widget.TextView
import io.flutter.plugin.platform.PlatformView

class PlatformTextView(context:Context,id:Int,args:Object):PlatformView{

    var textView:TextView?;

    init {
        textView = TextView(context);
    }

    override fun getView(): TextView? {
        return this.textView;
    }

    override fun dispose() {
        this.textView =null;
    }

}