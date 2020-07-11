package app.loup.geolocation;

import java.lang.System;

@kotlin.Metadata(mv = {1, 1, 15}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000X\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0002\b\u0003\n\u0002\u0010\u0000\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0010\b\n\u0000\n\u0002\u0018\u0002\n\u0000\u0018\u00002\u00020\u00012\u00020\u0002B\r\u0012\u0006\u0010\u0003\u001a\u00020\u0004\u00a2\u0006\u0002\u0010\u0005J\u0010\u0010\u0006\u001a\u00020\u00072\u0006\u0010\b\u001a\u00020\tH\u0002J\u0010\u0010\n\u001a\u00020\u00072\u0006\u0010\u000b\u001a\u00020\fH\u0002J\u0018\u0010\r\u001a\u00020\u00072\u0006\u0010\u000e\u001a\u00020\u000f2\u0006\u0010\u000b\u001a\u00020\fH\u0002J\u0018\u0010\u0010\u001a\u00020\u00072\u0006\u0010\u000e\u001a\u00020\u000f2\u0006\u0010\u000b\u001a\u00020\fH\u0002J\u0012\u0010\u0011\u001a\u00020\u00072\b\u0010\u0012\u001a\u0004\u0018\u00010\u0013H\u0016J\u001a\u0010\u0014\u001a\u00020\u00072\b\u0010\u0012\u001a\u0004\u0018\u00010\u00132\u0006\u0010\u0015\u001a\u00020\u0016H\u0016J\u0018\u0010\u0017\u001a\u00020\u00072\u0006\u0010\u0018\u001a\u00020\u00192\u0006\u0010\u000b\u001a\u00020\fH\u0016J\u0010\u0010\u001a\u001a\u00020\u00072\u0006\u0010\u001b\u001a\u00020\u001cH\u0002J\u0018\u0010\u001d\u001a\u00020\u00072\u0006\u0010\u000e\u001a\u00020\u001e2\u0006\u0010\u000b\u001a\u00020\fH\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u001f"}, d2 = {"Lapp/loup/geolocation/Handler;", "Lio/flutter/plugin/common/MethodChannel$MethodCallHandler;", "Lio/flutter/plugin/common/EventChannel$StreamHandler;", "locationClient", "Lapp/loup/geolocation/location/LocationClient;", "(Lapp/loup/geolocation/location/LocationClient;)V", "addLocationUpdatesRequest", "", "request", "Lapp/loup/geolocation/data/LocationUpdatesRequest;", "enableLocationSettings", "result", "Lio/flutter/plugin/common/MethodChannel$Result;", "isLocationOperational", "permission", "Lapp/loup/geolocation/data/Permission;", "lastKnownLocation", "onCancel", "arguments", "", "onListen", "events", "Lio/flutter/plugin/common/EventChannel$EventSink;", "onMethodCall", "call", "Lio/flutter/plugin/common/MethodCall;", "removeLocationUpdatesRequest", "id", "", "requestLocationPermission", "Lapp/loup/geolocation/data/PermissionRequest;", "geolocation_debug"})
public final class Handler implements io.flutter.plugin.common.MethodChannel.MethodCallHandler, io.flutter.plugin.common.EventChannel.StreamHandler {
    private final app.loup.geolocation.location.LocationClient locationClient = null;
    
    private final void isLocationOperational(app.loup.geolocation.data.Permission permission, io.flutter.plugin.common.MethodChannel.Result result) {
    }
    
    private final void requestLocationPermission(app.loup.geolocation.data.PermissionRequest permission, io.flutter.plugin.common.MethodChannel.Result result) {
    }
    
    private final void enableLocationSettings(io.flutter.plugin.common.MethodChannel.Result result) {
    }
    
    private final void lastKnownLocation(app.loup.geolocation.data.Permission permission, io.flutter.plugin.common.MethodChannel.Result result) {
    }
    
    private final void addLocationUpdatesRequest(app.loup.geolocation.data.LocationUpdatesRequest request) {
    }
    
    private final void removeLocationUpdatesRequest(int id) {
    }
    
    @java.lang.Override()
    public void onMethodCall(@org.jetbrains.annotations.NotNull()
    io.flutter.plugin.common.MethodCall call, @org.jetbrains.annotations.NotNull()
    io.flutter.plugin.common.MethodChannel.Result result) {
    }
    
    @java.lang.Override()
    public void onListen(@org.jetbrains.annotations.Nullable()
    java.lang.Object arguments, @org.jetbrains.annotations.NotNull()
    io.flutter.plugin.common.EventChannel.EventSink events) {
    }
    
    @java.lang.Override()
    public void onCancel(@org.jetbrains.annotations.Nullable()
    java.lang.Object arguments) {
    }
    
    public Handler(@org.jetbrains.annotations.NotNull()
    app.loup.geolocation.location.LocationClient locationClient) {
        super();
    }
}