import UIKit
import Flutter
import Firebase
import GoogleMaps
import moengage_flutter
import MoEngage

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    var sdkConfig : MOSDKConfig
     let yourAppID = "USWINCHCY9D2ZRV2XSAZBC0M"
    if let config = MoEngage.sharedInstance().getDefaultSDKConfiguration() {
        sdkConfig = config
        sdkConfig.moeAppID = yourAppID
     }
     else{
        sdkConfig = MOSDKConfig.init(appID: yourAppID)
     }
    sdkConfig.appGroupID = "group.com.alphadevs.MoEngage.NotificationServices"
     sdkConfig.moeDataCenter = DATA_CENTER_01
    MOFlutterInitializer.sharedInstance.initializeWithSDKConfig(sdkConfig, andLaunchOptions: launchOptions)
  FirebaseApp.configure()
  GMSServices.provideAPIKey("AIzaSyC8GcSwDzPq7gW_vKmsTNv9Xqr9WvwfA5E")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
