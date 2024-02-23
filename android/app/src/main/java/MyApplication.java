package com.lohcy.study_app_2; // Change this to your actual package name

import android.app.Application;
import android.content.Context;
import androidx.multidex.MultiDex;

public class MyApplication extends Application {
    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        MultiDex.install(this); // Enables MultiDex
    }
}
