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
      
  FirebaseApp.configure()
  UNUserNotificationCenter.current().delegate = self
  GMSServices.provideAPIKey("AIzaSyC8GcSwDzPq7gW_vKmsTNv9Xqr9WvwfA5E")
  GeneratedPluginRegistrant.register(with: self)
      
    var sdkConfig : MOSDKConfig
   // let yourAppID = "BUXZWEVMQCDYOX748PC4WB7J"// dev
    let yourAppID = "ZDXR0OQ3GAV6US1P2LPNOPJT"
    
    if let config = MoEngage.sharedInstance().getDefaultSDKConfiguration() {
        sdkConfig = config
        sdkConfig.moeAppID = yourAppID
     }
     else{
        sdkConfig = MOSDKConfig.init(appID: yourAppID)
     }

    // Set Correct Data Center here
    sdkConfig.moeDataCenter = DATA_CENTER_01
    sdkConfig.appGroupID = "group.com.dalmia.techsale.MoEngage"
//    sdkConfig.appGroupID = "group.com.dalmia.techsale.MoEngage.NotificationServices"
    sdkConfig.optOutIDFATracking = false
    sdkConfig.optOutIDFVTracking = false
    sdkConfig.optOutDataTracking = false
    sdkConfig.optOutPushNotification = false
    sdkConfig.optOutInAppCampaign = false
    MoEngage.enableSDKLogs(true)
      
   MOFlutterInitializer.sharedInstance.initializeWithSDKConfig(sdkConfig, andLaunchOptions: launchOptions)
    
  return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            //This is to only to display Alert and enable notification sound
        completionHandler([.sound,.alert])
    }
            
}


