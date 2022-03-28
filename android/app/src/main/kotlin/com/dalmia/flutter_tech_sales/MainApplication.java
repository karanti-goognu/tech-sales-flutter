package com.dalmia.flutter_tech_sales;


import com.moengage.core.LogLevel;
import com.moengage.core.MoEngage;
import com.moengage.core.MoEngage.Builder;
import com.moengage.core.config.FcmConfig;
import com.moengage.core.config.LogConfig;
import com.moengage.core.config.MiPushConfig;
import com.moengage.core.config.NotificationConfig;
import com.moengage.core.config.PushKitConfig;
import com.moengage.flutter.MoEInitializer;
import com.moengage.pushbase.MoEPushHelper;
import io.flutter.app.FlutterApplication;

public class MainApplication extends FlutterApplication {

    @Override
    public void onCreate() {
        super.onCreate();

        ///dev
/*
        MoEngage.Builder moEngage1 = new MoEngage.Builder(this, "BUXZWEVMQCDYOX748PC4WB7J")
                .configureNotificationMetaData(new NotificationConfig(R.drawable.ic_notification, R.mipmap.ic_launcher, -1, null, true,false, true))
                .configureLogs(new LogConfig(LogLevel.VERBOSE, true))
                .configureFcm(new FcmConfig(true))
                .configurePushKit(new PushKitConfig(true))
                .configureMiPush(new MiPushConfig("2882303761518042309", "5601804211309", true));

 */
        ///prod

        MoEngage.Builder moEngage1 = new MoEngage.Builder(this, "ZDXR0OQ3GAV6US1P2LPNOPJT")
                .configureNotificationMetaData(new NotificationConfig(R.drawable.ic_notification, R.mipmap.ic_launcher, -1, null, true,false, true))
                .configureLogs(new LogConfig(LogLevel.VERBOSE, true))
                .configureFcm(new FcmConfig(true))
                .configurePushKit(new PushKitConfig(true))
                .configureMiPush(new MiPushConfig("2882303761518042309", "5601804211309", true));


          MoEInitializer.initialize(getApplicationContext(), moEngage1);
        // optional, required in-case notification customisation is required.
        MoEPushHelper.getInstance().setMessageListener(new CustomPushListener());
    }
}

