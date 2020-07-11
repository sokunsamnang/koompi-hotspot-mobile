package app.loup.geolocation.location;

import java.lang.System;

@android.annotation.SuppressLint(value = {"MissingPermission"})
@kotlin.Metadata(mv = {1, 1, 15}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000\u00a2\u0001\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0002\b\u0005\n\u0002\u0018\u0002\n\u0002\b\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0002\b\u0006\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0002\b\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0004\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0007\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0002\b\u0007\n\u0002\u0010\b\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0002\b\u0006\n\u0002\u0018\u0002\n\u0002\b\u0004\b\u0007\u0018\u00002\u00020\u0001:\u0003PQRB\r\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004J\u0019\u0010,\u001a\u00020\u001d2\u0006\u0010-\u001a\u00020\"H\u0086@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010.J\u0010\u0010/\u001a\u0002002\u0006\u00101\u001a\u000202H\u0002J\u0006\u00103\u001a\u00020\u001dJ\u0011\u00104\u001a\u00020 H\u0086@\u00f8\u0001\u0000\u00a2\u0006\u0002\u00105J\u000e\u00106\u001a\u00020 2\u0006\u00101\u001a\u000202J\u0019\u00107\u001a\u00020 2\u0006\u00101\u001a\u000202H\u0086@\u00f8\u0001\u0000\u00a2\u0006\u0002\u00108J\u0013\u00109\u001a\u0004\u0018\u00010:H\u0082@\u00f8\u0001\u0000\u00a2\u0006\u0002\u00105J\u0013\u0010;\u001a\u0004\u0018\u00010 H\u0082@\u00f8\u0001\u0000\u00a2\u0006\u0002\u00105J\u0011\u0010<\u001a\u00020=H\u0082@\u00f8\u0001\u0000\u00a2\u0006\u0002\u00105J\u0010\u0010>\u001a\u00020\u001d2\u0006\u0010?\u001a\u00020 H\u0002J\u0006\u0010@\u001a\u00020\u001dJ\u001a\u0010A\u001a\u00020\u001d2\u0012\u0010B\u001a\u000e\u0012\u0004\u0012\u00020 \u0012\u0004\u0012\u00020\u001d0\u001fJ\u000e\u0010C\u001a\u00020\u001d2\u0006\u0010D\u001a\u00020EJ\u0011\u0010F\u001a\u00020\u0012H\u0082@\u00f8\u0001\u0000\u00a2\u0006\u0002\u00105J\u0019\u0010G\u001a\u00020 2\u0006\u00101\u001a\u00020HH\u0086@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010IJ\u0019\u0010J\u001a\u00020\u00122\u0006\u00101\u001a\u000202H\u0082@\u00f8\u0001\u0000\u00a2\u0006\u0002\u00108J\u0006\u0010K\u001a\u00020\u001dJ\u0011\u0010L\u001a\u00020\u0012H\u0082@\u00f8\u0001\u0000\u00a2\u0006\u0002\u00105J\b\u0010M\u001a\u00020\u001dH\u0002J\u0019\u0010N\u001a\u00020O2\u0006\u00101\u001a\u000202H\u0082@\u00f8\u0001\u0000\u00a2\u0006\u0002\u00108J\u0019\u0010N\u001a\u00020O2\u0006\u00101\u001a\u00020HH\u0082@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010IR\u001c\u0010\u0005\u001a\u0004\u0018\u00010\u0006X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\b\u0007\u0010\b\"\u0004\b\t\u0010\nR\u0011\u0010\u000b\u001a\u00020\f\u00a2\u0006\b\n\u0000\u001a\u0004\b\r\u0010\u000eR\u000e\u0010\u0002\u001a\u00020\u0003X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u000f\u001a\u0004\u0018\u00010\u0010X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u0011\u001a\u00020\u00128BX\u0082\u0004\u00a2\u0006\u0006\u001a\u0004\b\u0013\u0010\u0014R\u0014\u0010\u0015\u001a\u00020\u00128BX\u0082\u0004\u00a2\u0006\u0006\u001a\u0004\b\u0016\u0010\u0014R\u000e\u0010\u0017\u001a\u00020\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0018\u001a\u00020\u0019X\u0082\u0004\u00a2\u0006\u0002\n\u0000R \u0010\u001a\u001a\u0014\u0012\u0010\u0012\u000e\u0012\u0004\u0012\u00020\u001d\u0012\u0004\u0012\u00020\u001d0\u001c0\u001bX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001c\u0010\u001e\u001a\u0010\u0012\u0004\u0012\u00020 \u0012\u0004\u0012\u00020\u001d\u0018\u00010\u001fX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0014\u0010!\u001a\b\u0012\u0004\u0012\u00020\"0\u001bX\u0082\u0004\u00a2\u0006\u0002\n\u0000R \u0010#\u001a\u0014\u0012\u0010\u0012\u000e\u0012\u0004\u0012\u00020\u001d\u0012\u0004\u0012\u00020\u001d0\u001c0\u001bX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0011\u0010$\u001a\u00020%\u00a2\u0006\b\n\u0000\u001a\u0004\b&\u0010\'R\u0016\u0010(\u001a\n\u0012\u0004\u0012\u00020\u001d\u0018\u00010)X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010*\u001a\u00020+X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u0082\u0002\u0004\n\u0002\b\u0019\u00a8\u0006S"}, d2 = {"Lapp/loup/geolocation/location/LocationClient;", "", "context", "Landroid/content/Context;", "(Landroid/content/Context;)V", "activity", "Landroid/app/Activity;", "getActivity", "()Landroid/app/Activity;", "setActivity", "(Landroid/app/Activity;)V", "activityResultListener", "Lio/flutter/plugin/common/PluginRegistry$ActivityResultListener;", "getActivityResultListener", "()Lio/flutter/plugin/common/PluginRegistry$ActivityResultListener;", "currentLocationRequest", "Lcom/google/android/gms/location/LocationRequest;", "hasInBackgroundLocationRequest", "", "getHasInBackgroundLocationRequest", "()Z", "hasLocationRequest", "getHasLocationRequest", "isPaused", "locationCallback", "Lcom/google/android/gms/location/LocationCallback;", "locationSettingsCallbacks", "Ljava/util/ArrayList;", "Lapp/loup/geolocation/location/LocationClient$Callback;", "", "locationUpdatesCallback", "Lkotlin/Function1;", "Lapp/loup/geolocation/data/Result;", "locationUpdatesRequests", "Lapp/loup/geolocation/data/LocationUpdatesRequest;", "permissionCallbacks", "permissionResultListener", "Lio/flutter/plugin/common/PluginRegistry$RequestPermissionsResultListener;", "getPermissionResultListener", "()Lio/flutter/plugin/common/PluginRegistry$RequestPermissionsResultListener;", "permissionSettingsCallback", "Lkotlin/Function0;", "providerClient", "Lcom/google/android/gms/location/FusedLocationProviderClient;", "addLocationUpdatesRequest", "request", "(Lapp/loup/geolocation/data/LocationUpdatesRequest;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;", "currentServiceStatus", "Lapp/loup/geolocation/location/LocationClient$ServiceStatus;", "permission", "Lapp/loup/geolocation/data/Permission;", "deregisterLocationUpdatesCallback", "enableLocationServices", "(Lkotlin/coroutines/Continuation;)Ljava/lang/Object;", "isLocationOperational", "lastKnownLocation", "(Lapp/loup/geolocation/data/Permission;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;", "lastLocation", "Landroid/location/Location;", "lastLocationIfAvailable", "locationAvailability", "Lcom/google/android/gms/location/LocationAvailability;", "onLocationUpdatesResult", "result", "pause", "registerLocationUpdatesCallback", "callback", "removeLocationUpdatesRequest", "id", "", "requestEnablingLocation", "requestLocationPermission", "Lapp/loup/geolocation/data/PermissionRequest;", "(Lapp/loup/geolocation/data/PermissionRequest;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;", "requestPermission", "resume", "tryShowSettings", "updateLocationRequest", "validateServiceStatus", "Lapp/loup/geolocation/location/LocationClient$ValidateServiceStatus;", "Callback", "ServiceStatus", "ValidateServiceStatus", "geolocation_debug"})
public final class LocationClient {
    @org.jetbrains.annotations.Nullable()
    private android.app.Activity activity;
    @org.jetbrains.annotations.NotNull()
    private final io.flutter.plugin.common.PluginRegistry.RequestPermissionsResultListener permissionResultListener = null;
    @org.jetbrains.annotations.NotNull()
    private final io.flutter.plugin.common.PluginRegistry.ActivityResultListener activityResultListener = null;
    private final com.google.android.gms.location.FusedLocationProviderClient providerClient = null;
    private final java.util.ArrayList<app.loup.geolocation.location.LocationClient.Callback<kotlin.Unit, kotlin.Unit>> permissionCallbacks = null;
    private kotlin.jvm.functions.Function0<kotlin.Unit> permissionSettingsCallback;
    private final java.util.ArrayList<app.loup.geolocation.location.LocationClient.Callback<kotlin.Unit, kotlin.Unit>> locationSettingsCallbacks = null;
    private kotlin.jvm.functions.Function1<? super app.loup.geolocation.data.Result, kotlin.Unit> locationUpdatesCallback;
    private final java.util.ArrayList<app.loup.geolocation.data.LocationUpdatesRequest> locationUpdatesRequests = null;
    private com.google.android.gms.location.LocationRequest currentLocationRequest;
    private boolean isPaused;
    private final com.google.android.gms.location.LocationCallback locationCallback = null;
    private final android.content.Context context = null;
    
    @org.jetbrains.annotations.Nullable()
    public final android.app.Activity getActivity() {
        return null;
    }
    
    public final void setActivity(@org.jetbrains.annotations.Nullable()
    android.app.Activity p0) {
    }
    
    @org.jetbrains.annotations.NotNull()
    public final io.flutter.plugin.common.PluginRegistry.RequestPermissionsResultListener getPermissionResultListener() {
        return null;
    }
    
    @org.jetbrains.annotations.NotNull()
    public final io.flutter.plugin.common.PluginRegistry.ActivityResultListener getActivityResultListener() {
        return null;
    }
    
    private final boolean getHasLocationRequest() {
        return false;
    }
    
    private final boolean getHasInBackgroundLocationRequest() {
        return false;
    }
    
    @org.jetbrains.annotations.Nullable()
    public final java.lang.Object enableLocationServices(@org.jetbrains.annotations.NotNull()
    kotlin.coroutines.Continuation<? super app.loup.geolocation.data.Result> p0) {
        return null;
    }
    
    @org.jetbrains.annotations.NotNull()
    public final app.loup.geolocation.data.Result isLocationOperational(@org.jetbrains.annotations.NotNull()
    app.loup.geolocation.data.Permission permission) {
        return null;
    }
    
    @org.jetbrains.annotations.Nullable()
    public final java.lang.Object requestLocationPermission(@org.jetbrains.annotations.NotNull()
    app.loup.geolocation.data.PermissionRequest permission, @org.jetbrains.annotations.NotNull()
    kotlin.coroutines.Continuation<? super app.loup.geolocation.data.Result> p1) {
        return null;
    }
    
    @org.jetbrains.annotations.Nullable()
    public final java.lang.Object lastKnownLocation(@org.jetbrains.annotations.NotNull()
    app.loup.geolocation.data.Permission permission, @org.jetbrains.annotations.NotNull()
    kotlin.coroutines.Continuation<? super app.loup.geolocation.data.Result> p1) {
        return null;
    }
    
    @org.jetbrains.annotations.Nullable()
    public final java.lang.Object addLocationUpdatesRequest(@org.jetbrains.annotations.NotNull()
    app.loup.geolocation.data.LocationUpdatesRequest request, @org.jetbrains.annotations.NotNull()
    kotlin.coroutines.Continuation<? super kotlin.Unit> p1) {
        return null;
    }
    
    public final void removeLocationUpdatesRequest(int id) {
    }
    
    public final void registerLocationUpdatesCallback(@org.jetbrains.annotations.NotNull()
    kotlin.jvm.functions.Function1<? super app.loup.geolocation.data.Result, kotlin.Unit> callback) {
    }
    
    public final void deregisterLocationUpdatesCallback() {
    }
    
    public final void resume() {
    }
    
    public final void pause() {
    }
    
    private final void onLocationUpdatesResult(app.loup.geolocation.data.Result result) {
    }
    
    private final void updateLocationRequest() {
    }
    
    private final app.loup.geolocation.location.LocationClient.ServiceStatus currentServiceStatus(app.loup.geolocation.data.Permission permission) {
        return null;
    }
    
    public LocationClient(@org.jetbrains.annotations.NotNull()
    android.content.Context context) {
        super();
    }
    
    @kotlin.Metadata(mv = {1, 1, 15}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000\u001a\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u0002\n\u0002\b\u0006\b\u0002\u0018\u0000*\u0006\b\u0000\u0010\u0001 \u0000*\u0006\b\u0001\u0010\u0002 \u00002\u00020\u0003B-\u0012\u0012\u0010\u0004\u001a\u000e\u0012\u0004\u0012\u00028\u0000\u0012\u0004\u0012\u00020\u00060\u0005\u0012\u0012\u0010\u0007\u001a\u000e\u0012\u0004\u0012\u00028\u0001\u0012\u0004\u0012\u00020\u00060\u0005\u00a2\u0006\u0002\u0010\bR\u001d\u0010\u0007\u001a\u000e\u0012\u0004\u0012\u00028\u0001\u0012\u0004\u0012\u00020\u00060\u0005\u00a2\u0006\b\n\u0000\u001a\u0004\b\t\u0010\nR\u001d\u0010\u0004\u001a\u000e\u0012\u0004\u0012\u00028\u0000\u0012\u0004\u0012\u00020\u00060\u0005\u00a2\u0006\b\n\u0000\u001a\u0004\b\u000b\u0010\n\u00a8\u0006\f"}, d2 = {"Lapp/loup/geolocation/location/LocationClient$Callback;", "T", "E", "", "success", "Lkotlin/Function1;", "", "failure", "(Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;)V", "getFailure", "()Lkotlin/jvm/functions/Function1;", "getSuccess", "geolocation_debug"})
    static final class Callback<T extends java.lang.Object, E extends java.lang.Object> {
        @org.jetbrains.annotations.NotNull()
        private final kotlin.jvm.functions.Function1<T, kotlin.Unit> success = null;
        @org.jetbrains.annotations.NotNull()
        private final kotlin.jvm.functions.Function1<E, kotlin.Unit> failure = null;
        
        @org.jetbrains.annotations.NotNull()
        public final kotlin.jvm.functions.Function1<T, kotlin.Unit> getSuccess() {
            return null;
        }
        
        @org.jetbrains.annotations.NotNull()
        public final kotlin.jvm.functions.Function1<E, kotlin.Unit> getFailure() {
            return null;
        }
        
        public Callback(@org.jetbrains.annotations.NotNull()
        kotlin.jvm.functions.Function1<? super T, kotlin.Unit> success, @org.jetbrains.annotations.NotNull()
        kotlin.jvm.functions.Function1<? super E, kotlin.Unit> failure) {
            super();
        }
    }
    
    @kotlin.Metadata(mv = {1, 1, 15}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000\u001a\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u000b\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0002\b\u0006\b\u0002\u0018\u00002\u00020\u0001B#\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\b\b\u0002\u0010\u0004\u001a\u00020\u0003\u0012\n\b\u0002\u0010\u0005\u001a\u0004\u0018\u00010\u0006\u00a2\u0006\u0002\u0010\u0007R\u0013\u0010\u0005\u001a\u0004\u0018\u00010\u0006\u00a2\u0006\b\n\u0000\u001a\u0004\b\b\u0010\tR\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\b\n\u0000\u001a\u0004\b\u0002\u0010\nR\u0011\u0010\u0004\u001a\u00020\u0003\u00a2\u0006\b\n\u0000\u001a\u0004\b\u000b\u0010\n\u00a8\u0006\f"}, d2 = {"Lapp/loup/geolocation/location/LocationClient$ServiceStatus;", "", "isReady", "", "needsAuthorization", "failure", "Lapp/loup/geolocation/data/Result;", "(ZZLapp/loup/geolocation/data/Result;)V", "getFailure", "()Lapp/loup/geolocation/data/Result;", "()Z", "getNeedsAuthorization", "geolocation_debug"})
    static final class ServiceStatus {
        private final boolean isReady = false;
        private final boolean needsAuthorization = false;
        @org.jetbrains.annotations.Nullable()
        private final app.loup.geolocation.data.Result failure = null;
        
        public final boolean isReady() {
            return false;
        }
        
        public final boolean getNeedsAuthorization() {
            return false;
        }
        
        @org.jetbrains.annotations.Nullable()
        public final app.loup.geolocation.data.Result getFailure() {
            return null;
        }
        
        public ServiceStatus(boolean isReady, boolean needsAuthorization, @org.jetbrains.annotations.Nullable()
        app.loup.geolocation.data.Result failure) {
            super();
        }
    }
    
    @kotlin.Metadata(mv = {1, 1, 15}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000\u0018\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0005\b\u0002\u0018\u00002\u00020\u0001B\u0019\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\n\b\u0002\u0010\u0004\u001a\u0004\u0018\u00010\u0005\u00a2\u0006\u0002\u0010\u0006R\u0013\u0010\u0004\u001a\u0004\u0018\u00010\u0005\u00a2\u0006\b\n\u0000\u001a\u0004\b\u0007\u0010\bR\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\b\n\u0000\u001a\u0004\b\u0002\u0010\t\u00a8\u0006\n"}, d2 = {"Lapp/loup/geolocation/location/LocationClient$ValidateServiceStatus;", "", "isValid", "", "failure", "Lapp/loup/geolocation/data/Result;", "(ZLapp/loup/geolocation/data/Result;)V", "getFailure", "()Lapp/loup/geolocation/data/Result;", "()Z", "geolocation_debug"})
    static final class ValidateServiceStatus {
        private final boolean isValid = false;
        @org.jetbrains.annotations.Nullable()
        private final app.loup.geolocation.data.Result failure = null;
        
        public final boolean isValid() {
            return false;
        }
        
        @org.jetbrains.annotations.Nullable()
        public final app.loup.geolocation.data.Result getFailure() {
            return null;
        }
        
        public ValidateServiceStatus(boolean isValid, @org.jetbrains.annotations.Nullable()
        app.loup.geolocation.data.Result failure) {
            super();
        }
    }
}