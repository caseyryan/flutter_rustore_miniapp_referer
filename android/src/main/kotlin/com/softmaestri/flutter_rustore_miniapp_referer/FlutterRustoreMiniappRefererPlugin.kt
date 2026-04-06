package com.softmaestri.flutter_rustore_miniapp_referer

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


/** FlutterRustoreMiniappRefererPlugin */
class FlutterRustoreMiniappRefererPlugin :
    FlutterPlugin,
    MethodCallHandler {

    private lateinit var channel: MethodChannel
    private var context: Context? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel =
            MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_rustore_miniapp_referer")
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

            "getRefererInfo" -> {
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
                mockJson.put("refererId", "rustore_test_referer_123")
                mockJson.put("packageName", "com.softmaestri.flutter_rustore_miniapp_referer")
                result.success(mockJson.toString())
                return
            }

            val currentContext = context
            if (currentContext == null) {
                // Возвращаем структуру ошибки вместо result.error, чтобы сохранить единообразие JSON
                result.success(mapOf("success" to false, "error" to "Android Context is null"))
                return
            }

            // Создание клиента и сам вызов
            val client = InstallReferrerClient(currentContext)

            client.getInstallReferrer()
                .addOnSuccessListener { installReferrer ->
                    try {
                        if (installReferrer != null) {
                            val json = JSONObject()
                            json.put("success", true)
                            json.put("refererId", installReferrer.referrerId)
                            json.put("packageName", installReferrer.packageName)
                            result.success(json.toString())
                        } else {
                            // Реферер может быть null по правилам RuStore (если уже запрашивали)
                            result.success(
                                mapOf(
                                    "success" to false,
                                    "error" to "Referrer is null (already consumed or not found)"
                                )
                            )
                        }
                    } catch (e: Exception) {
                        result.success(
                            mapOf(
                                "success" to false,
                                "error" to "JSON parsing error: ${e.message}"
                            )
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
                    result.success(mapOf("success" to false, "error" to errorMessage))
                }

        } catch (e: Exception) {
            // Этот блок поймает всё, что может пойти не так в основном потоке (синхронно)
            val crashPrevention = mapOf(
                "success" to false,
                "error" to "Unexpected plugin crash: ${e.message}"
            )
            result.success(crashPrevention)
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        context = null
    }
}
