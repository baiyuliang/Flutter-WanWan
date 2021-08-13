package com.byl.wanwan

import android.os.Bundle
import com.byl.wanwan.plugin.RongIMServerPlugin
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        flutterEngine!!.plugins.add(RongIMServerPlugin(this))
    }
}
