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
  MoEngage.setAppGroupID("group.com.alphadevs.MoEngage.NotificationServices")
  MOFlutterInitializer.sharedInstance.initializeWithAppID("USWINCHCY9D2ZRV2XSAZBC0M", withLaunchOptions: launchOptions)
  FirebaseApp.configure()
  GMSServices.provideAPIKey("AIzaSyC8GcSwDzPq7gW_vKmsTNv9Xqr9WvwfA5E")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
