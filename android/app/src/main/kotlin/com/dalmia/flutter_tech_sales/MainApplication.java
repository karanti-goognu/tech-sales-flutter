package com.dalmia.flutter_tech_sales;


import com.moengage.core.LogLevel;
import com.moengage.core.MoEngage;
import com.moengage.core.MoEngage.Builder;
import com.moengage.flutter.MoEInitializer;
import com.moengage.pushbase.MoEPushHelper;
import io.flutter.app.FlutterApplication;

public class MainApplication extends FlutterApplication {

    @Override
    public void onCreate() {
        super.onCreate();
        MoEngage.Builder builder = new Builder(this, "USWINCHCY9D2ZRV2XSAZBC0M")
                .setNotificationSmallIcon(R.mipmap.ic_launcher)
                .setNotificationLargeIcon(R.mipmap.ic_launcher)
                .optOutDefaultInAppDisplay()
                .enableLogs(LogLevel.VERBOSE)
                .enablePushKitTokenRegistration();

        MoEInitializer.initialize(getApplicationContext(), builder);
        // optional, required in-case notification customisation is required.
        MoEPushHelper.getInstance().setMessageListener(new CustomPushListener());
    }
}

