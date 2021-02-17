package com.dalmia.flutter_tech_sales;


import com.moengage.core.LogLevel;
import com.moengage.core.MoEngage;
import com.moengage.flutter.MoEInitializer;

import io.flutter.app.FlutterApplication;

public class MainApplication extends FlutterApplication {

    @Override
    public void onCreate() {
        super.onCreate();
        MoEngage.Builder builder = new MoEngage.Builder(this, "6XHHUKUOKFE6Q5MLTT8UH5RW")
                .setNotificationSmallIcon(R.mipmap.ic_launcher)
                .setNotificationLargeIcon(R.mipmap.ic_launcher)
                .optOutDefaultInAppDisplay()
                .enableLogs(LogLevel.VERBOSE)
                .enablePushKitTokenRegistration();
        MoEInitializer.initialize(getApplicationContext(),builder);
        // optional, required in-case notification customisation is required.
    }
}

