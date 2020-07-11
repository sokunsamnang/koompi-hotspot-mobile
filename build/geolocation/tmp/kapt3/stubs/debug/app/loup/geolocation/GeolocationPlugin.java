package app.loup.geolocation;

import java.lang.System;

@kotlin.Metadata(mv = {1, 1, 15}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000D\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\b\u0004\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\b\n\n\u0002\u0018\u0002\n\u0002\b\u0007\u0018\u0000 #2\u00020\u00012\u00020\u00022\u00020\u0003:\u0002#$B\u0005\u00a2\u0006\u0002\u0010\u0004J\u0010\u0010\u000b\u001a\u00020\f2\u0006\u0010\r\u001a\u00020\u0006H\u0002J\b\u0010\u000e\u001a\u00020\fH\u0002J\u001c\u0010\u000f\u001a\u00020\f2\b\u0010\u0010\u001a\u0004\u0018\u00010\u00112\b\u0010\u0012\u001a\u0004\u0018\u00010\u0013H\u0016J\u0012\u0010\u0014\u001a\u00020\f2\b\u0010\u0010\u001a\u0004\u0018\u00010\u0011H\u0016J\u0012\u0010\u0015\u001a\u00020\f2\b\u0010\u0010\u001a\u0004\u0018\u00010\u0011H\u0016J\u0012\u0010\u0016\u001a\u00020\f2\b\u0010\u0010\u001a\u0004\u0018\u00010\u0011H\u0016J\u001c\u0010\u0017\u001a\u00020\f2\b\u0010\u0010\u001a\u0004\u0018\u00010\u00112\b\u0010\u0018\u001a\u0004\u0018\u00010\u0013H\u0016J\u0012\u0010\u0019\u001a\u00020\f2\b\u0010\u0010\u001a\u0004\u0018\u00010\u0011H\u0016J\u0012\u0010\u001a\u001a\u00020\f2\b\u0010\u0010\u001a\u0004\u0018\u00010\u0011H\u0016J\u0010\u0010\u001b\u001a\u00020\f2\u0006\u0010\r\u001a\u00020\u0006H\u0016J\u0012\u0010\u001c\u001a\u00020\f2\b\b\u0001\u0010\u001d\u001a\u00020\u001eH\u0016J\b\u0010\u001f\u001a\u00020\fH\u0016J\b\u0010 \u001a\u00020\fH\u0016J\u0012\u0010!\u001a\u00020\f2\b\b\u0001\u0010\r\u001a\u00020\u001eH\u0016J\u0010\u0010\"\u001a\u00020\f2\u0006\u0010\r\u001a\u00020\u0006H\u0016R\u0010\u0010\u0005\u001a\u0004\u0018\u00010\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\bX\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\nX\u0082.\u00a2\u0006\u0002\n\u0000\u00a8\u0006%"}, d2 = {"Lapp/loup/geolocation/GeolocationPlugin;", "Lio/flutter/embedding/engine/plugins/FlutterPlugin;", "Lio/flutter/embedding/engine/plugins/activity/ActivityAware;", "Landroid/app/Application$ActivityLifecycleCallbacks;", "()V", "activityBinding", "Lio/flutter/embedding/engine/plugins/activity/ActivityPluginBinding;", "handler", "Lapp/loup/geolocation/Handler;", "locationClient", "Lapp/loup/geolocation/location/LocationClient;", "attachToActivity", "", "binding", "detachFromActivity", "onActivityCreated", "activity", "Landroid/app/Activity;", "savedInstanceState", "Landroid/os/Bundle;", "onActivityDestroyed", "onActivityPaused", "onActivityResumed", "onActivitySaveInstanceState", "outState", "onActivityStarted", "onActivityStopped", "onAttachedToActivity", "onAttachedToEngine", "flutterPluginBinding", "Lio/flutter/embedding/engine/plugins/FlutterPlugin$FlutterPluginBinding;", "onDetachedFromActivity", "onDetachedFromActivityForConfigChanges", "onDetachedFromEngine", "onReattachedToActivityForConfigChanges", "Companion", "Intents", "geolocation_debug"})
public final class GeolocationPlugin implements io.flutter.embedding.engine.plugins.FlutterPlugin, io.flutter.embedding.engine.plugins.activity.ActivityAware, android.app.Application.ActivityLifecycleCallbacks {
    private app.loup.geolocation.location.LocationClient locationClient;
    private app.loup.geolocation.Handler handler;
    private io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding activityBinding;
    public static final app.loup.geolocation.GeolocationPlugin.Companion Companion = null;
    
    private final void attachToActivity(io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding binding) {
    }
    
    private final void detachFromActivity() {
    }
    
    @java.lang.Override()
    public void onAttachedToEngine(@org.jetbrains.annotations.NotNull()
    @androidx.annotation.NonNull()
    io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding flutterPluginBinding) {
    }
    
    @java.lang.Override()
    public void onDetachedFromEngine(@org.jetbrains.annotations.NotNull()
    @androidx.annotation.NonNull()
    io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding binding) {
    }
    
    @java.lang.Override()
    public void onAttachedToActivity(@org.jetbrains.annotations.NotNull()
    io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding binding) {
    }
    
    @java.lang.Override()
    public void onDetachedFromActivity() {
    }
    
    @java.lang.Override()
    public void onReattachedToActivityForConfigChanges(@org.jetbrains.annotations.NotNull()
    io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding binding) {
    }
    
    @java.lang.Override()
    public void onDetachedFromActivityForConfigChanges() {
    }
    
    @java.lang.Override()
    public void onActivityPaused(@org.jetbrains.annotations.Nullable()
    android.app.Activity activity) {
    }
    
    @java.lang.Override()
    public void onActivityResumed(@org.jetbrains.annotations.Nullable()
    android.app.Activity activity) {
    }
    
    @java.lang.Override()
    public void onActivityStarted(@org.jetbrains.annotations.Nullable()
    android.app.Activity activity) {
    }
    
    @java.lang.Override()
    public void onActivityDestroyed(@org.jetbrains.annotations.Nullable()
    android.app.Activity activity) {
    }
    
    @java.lang.Override()
    public void onActivitySaveInstanceState(@org.jetbrains.annotations.Nullable()
    android.app.Activity activity, @org.jetbrains.annotations.Nullable()
    android.os.Bundle outState) {
    }
    
    @java.lang.Override()
    public void onActivityStopped(@org.jetbrains.annotations.Nullable()
    android.app.Activity activity) {
    }
    
    @java.lang.Override()
    public void onActivityCreated(@org.jetbrains.annotations.Nullable()
    android.app.Activity activity, @org.jetbrains.annotations.Nullable()
    android.os.Bundle savedInstanceState) {
    }
    
    public GeolocationPlugin() {
        super();
    }
    
    public static final void registerWith(@org.jetbrains.annotations.NotNull()
    io.flutter.plugin.common.PluginRegistry.Registrar registrar) {
    }
    
    @kotlin.Metadata(mv = {1, 1, 15}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\b\u0002\n\u0002\u0010\b\n\u0002\b\u0003\b\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\b\u0002\u00a2\u0006\u0002\u0010\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0007"}, d2 = {"Lapp/loup/geolocation/GeolocationPlugin$Intents;", "", "()V", "EnableLocationSettingsRequestId", "", "LocationPermissionRequestId", "LocationPermissionSettingsRequestId", "geolocation_debug"})
    public static final class Intents {
        public static final int LocationPermissionRequestId = 12234;
        public static final int LocationPermissionSettingsRequestId = 12230;
        public static final int EnableLocationSettingsRequestId = 12237;
        public static final app.loup.geolocation.GeolocationPlugin.Intents INSTANCE = null;
        
        private Intents() {
            super();
        }
    }
    
    @kotlin.Metadata(mv = {1, 1, 15}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000,\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\b\u0002\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0000\b\u0086\u0003\u0018\u00002\u00020\u0001B\u0007\b\u0002\u00a2\u0006\u0002\u0010\u0002J \u0010\u0003\u001a\u00020\u00042\u0006\u0010\u0005\u001a\u00020\u00062\u0006\u0010\u0007\u001a\u00020\b2\u0006\u0010\t\u001a\u00020\nH\u0002J\u0010\u0010\u000b\u001a\u00020\u00042\u0006\u0010\f\u001a\u00020\rH\u0007\u00a8\u0006\u000e"}, d2 = {"Lapp/loup/geolocation/GeolocationPlugin$Companion;", "", "()V", "register", "", "instance", "Lapp/loup/geolocation/GeolocationPlugin;", "context", "Landroid/content/Context;", "binaryMessenger", "Lio/flutter/plugin/common/BinaryMessenger;", "registerWith", "registrar", "Lio/flutter/plugin/common/PluginRegistry$Registrar;", "geolocation_debug"})
    public static final class Companion {
        
        public final void registerWith(@org.jetbrains.annotations.NotNull()
        io.flutter.plugin.common.PluginRegistry.Registrar registrar) {
        }
        
        private final void register(app.loup.geolocation.GeolocationPlugin instance, android.content.Context context, io.flutter.plugin.common.BinaryMessenger binaryMessenger) {
        }
        
        private Companion() {
            super();
        }
    }
}