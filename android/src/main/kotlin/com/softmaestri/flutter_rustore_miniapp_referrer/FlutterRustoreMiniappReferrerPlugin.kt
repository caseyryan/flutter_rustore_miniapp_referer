package com.softmaestri.flutter_rustore_miniapp_referrer

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONObject
import ru.rustore.sdk.core.exception.RuStoreException
import ru.rustore.sdk.core.exception.RuStoreNotInstalledException
import ru.rustore.sdk.core.exception.RuStoreOutdatedException
import ru.rustore.sdk.install.referrer.InstallReferrerClient
import ru.rustore.sdk.install.referrer.model.InstallReferrerException

/** FlutterRustoreMiniappReferrerPlugin */
class FlutterRustoreMiniappReferrerPlugin :
    FlutterPlugin,
    MethodCallHandler {

    private lateinit var channel: MethodChannel
    private var context: Context? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel =
            MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_rustore_miniapp_referrer")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(
        call: MethodCall,
        result: Result
    ) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }

            "getReferrerInfo" -> {
                val isDebug = call.argument<Boolean>("debug") ?: false
                fetchInstallReferrer(result, isDebug)
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    private fun fetchInstallReferrer(result: Result, isDebug: Boolean) {
        try {

            if (isDebug) {
                val mockJson = JSONObject()
                mockJson.put("success", true)
                mockJson.put("referrerId", "rustore_test_referrer_123")
                mockJson.put("packageName", "com.softmaestri.flutter_rustore_miniapp_referrer")
                result.success(mockJson.toString())
                return
            }

            val currentContext = context
            if (currentContext == null) {
                result.success(
                    JSONObject()
                        .put("success", false)
                        .put("error", "Android Context is null")
                        .toString()
                )
                return
            }

            val client = InstallReferrerClient(currentContext)

            client.getInstallReferrer()
                .addOnSuccessListener { installReferrer ->
                    try {
                        if (installReferrer != null) {
                            val json = JSONObject()
                            json.put("success", true)
                            json.put("referrerId", installReferrer.referrerId)
                            json.put("packageName", installReferrer.packageName)
                            result.success(json.toString())
                        } else {
                            result.success(
                                JSONObject()
                                    .put("success", false)
                                    .put("error", "Referrer is null (already consumed or not found)")
                                    .toString()
                            )
                        }
                    } catch (e: Exception) {
                        result.success(
                            JSONObject()
                                .put("success", false)
                                .put("error", "JSON parsing error: ${e.message}")
                                .toString()
                        )
                    }
                }
                .addOnFailureListener { throwable ->
                    val errorMessage = when (throwable) {
                        is RuStoreNotInstalledException -> "RuStore не установлен на устройстве"
                        is RuStoreOutdatedException -> "Версия RuStore устарела"
                        is InstallReferrerException.ClientNotCreated -> "Не удалось создать запрос к RuStore"
                        is RuStoreException -> "Ошибка RuStore: ${throwable.message}"
                        else -> "Неизвестная ошибка: ${throwable.message ?: "нет текста"}"
                    }

                    result.success(
                        JSONObject()
                            .put("success", false)
                            .put("error", errorMessage)
                            .toString()
                    )
                }

        } catch (e: Exception) {
            result.success(
                JSONObject()
                    .put("success", false)
                    .put("error", "Unexpected plugin crash: ${e.message}")
                    .toString()
            )
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        context = null
    }
}