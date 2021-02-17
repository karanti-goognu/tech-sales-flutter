package com.dalmia.flutter_tech_sales;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import com.moengage.core.Logger;
import com.moengage.plugin.base.PluginPushCallback;

/**
 * @author Shailesh Diwakar
 * Date: 2021/02/16
 */
public class CustomPushListener extends PluginPushCallback {

  private static final String TAG = "CustomPushListener";

  @Override public void onHandleRedirection(Activity activity, Bundle payload) {
    super.onHandleRedirection(activity, payload);
    Logger.v(TAG + " onHandleRedirection() : ");
  }

  @Override public void onNotificationReceived(Context context, Bundle payload) {
    super.onNotificationReceived(context, payload);
    Logger.v(TAG + " onNotificationReceived() : ");
  }
}
