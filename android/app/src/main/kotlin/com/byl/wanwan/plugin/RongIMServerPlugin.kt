package com.byl.wanwan.plugin

import android.app.Activity
import android.os.Handler
import android.os.Looper
import android.os.Message
import android.text.TextUtils
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.rong.models.response.TokenResult

import io.rong.models.user.UserModel

import io.rong.RongCloud
import io.rong.methods.user.User
import java.lang.Exception


class RongIMServerPlugin(activity: Activity) : FlutterPlugin, MethodChannel.MethodCallHandler {

    private var channel: MethodChannel? = null
    private var activity: Activity = activity

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        Log.e("RongIMRegPlugin", "onAttachedToEngine")
        channel = MethodChannel(binding.binaryMessenger, "rongim/server")
        channel!!.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        Log.e("RongIMRegPlugin", "onDetachedFromEngine")
        channel!!.setMethodCallHandler(null)
        channel = null
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val rongCloud = RongCloud.getInstance("lmxuhwagl6d2d", "rQ6GYmPscQ1RV")
        when (call.method) {
            "register" -> {
                Log.e("RongIMRegPlugin", "onMethodCall:register")
                val map = HashMap<String, Any>()
                val id = call.argument<String>("id")!!.toString()
                val name = call.argument<String>("name")!!.toString()
                val avatar = call.argument<String>("avatar")!!.toString()
                val user: User = rongCloud.user
                val userModel = UserModel()
                    .setId(id)
                    .setName(name)
                    .setPortrait(avatar)
                Thread {
                    try {
                        val tokenResult = user.register(userModel)
                        if (!TextUtils.isEmpty(tokenResult.token)) {
                            map["code"] = 200
                            map["token"] = tokenResult.token
                            map["error"] = "注册成功"
                            Log.e("RongIMRegPlugin", "注册成功:  $tokenResult")
                        } else {
                            map["code"] = -1
                            map["error"] = "注册失败"
                        }
                    } catch (e: Exception) {
                        e.printStackTrace()
                        map["code"] = -1
                        map["error"] = e.message.toString()
                    }
                    activity.runOnUiThread {
                        result.success(map)
                    }
                }.start()
            }
            "user" -> {
                Log.e("RongIMRegPlugin", "onMethodCall:user")
                val map = HashMap<String, Any>()
                val id = call.argument<String>("id")!!.toString()
                val user: User = rongCloud.user
                val userModel = UserModel().setId(id)
                Thread {
                    try {
                        val userResult = user.get(userModel)
                        if (!TextUtils.isEmpty(userResult.userName)) {
                            map["code"] = 200
                            map["name"] = userResult.userName
                            map["avatar"] = userResult.userPortrait
                            Log.e("RongIMRegPlugin", "获取用户成功:  $userModel")
                        } else {
                            map["code"] = -1
                            map["error"] = "该用户不存在"
                        }
                    } catch (e: Exception) {
                        e.printStackTrace()
                        map["code"] = -1
                        map["error"] = e.message.toString()
                    }
                    activity.runOnUiThread {
                        result.success(map)
                    }
                }.start()
            }
        }
    }

}