import Flutter
import UIKit

public class FlutterRustoreMiniappReferrerPlugin: NSObject, FlutterPlugin {

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "flutter_rustore_miniapp_referrer",
      binaryMessenger: registrar.messenger()
    )
    let instance = FlutterRustoreMiniappReferrerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {

    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)

    case "getReferrerInfo":

      let args = call.arguments as? [String: Any]
      let isDebug = args?["debug"] as? Bool ?? false

      if isDebug {
        let mockResponse: [String: Any] = [
          "success": true,
          "referrerId": "rustore_test_referrer_123",
          "packageName": Bundle.main.bundleIdentifier ?? "unknown"
        ]

        do {
          let jsonData = try JSONSerialization.data(withJSONObject: mockResponse, options: [])
          let jsonString = String(data: jsonData, encoding: .utf8)
          result(jsonString)
        } catch {
          result("{\"success\":false,\"error\":\"Serialization error\"}")
        }
        return
      }

      let response: [String: Any] = [
        "success": false,
        "error": "Not supported yet"
      ]

      do {
        let jsonData = try JSONSerialization.data(withJSONObject: response, options: [])
        let jsonString = String(data: jsonData, encoding: .utf8)
        result(jsonString)
      } catch {
        result("{\"success\":false,\"error\":\"Serialization error\"}")
      }

    default:
      result(FlutterMethodNotImplemented)
    }
  }
}