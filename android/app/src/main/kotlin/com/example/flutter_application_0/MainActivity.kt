package com.example.flutter_application_0

import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlin.collections.HashMap

class MainActivity: FlutterActivity() {

    val CHANNEL :String = "com.funny_flutter.todo_list.channel";

    override fun configureFlutterEngine(@NonNull flutterEngine :FlutterEngine){
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,CHANNEL).setMethodCallHandler { methodCall, result ->
            run {
                if (methodCall.method.equals("getCurrentLocation")) {
                    result.success(getCurrentPosition());
                } else {
                    result.notImplemented();
                }

            }
        };


    }

    fun getCurrentPosition():HashMap<String,String>{

        var hashMap  = HashMap<String,String>();
        hashMap.put("latitude","39.92");
        hashMap.put("longitude","116.46");
        hashMap.put("description","纽约");
        return hashMap;
    }

    

}
