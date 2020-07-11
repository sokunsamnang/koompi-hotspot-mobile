package app.loup.geolocation.location;

import java.lang.System;

@kotlin.Metadata(mv = {1, 1, 15}, bv = {1, 0, 3}, k = 1, d1 = {"\u00002\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\b\u0002\n\u0002\u0010\b\n\u0002\b\u0003\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0002\b\u0002\b\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\b\u0002\u00a2\u0006\u0002\u0010\u0002J\u0016\u0010\u0003\u001a\u00020\u00042\u0006\u0010\u0005\u001a\u00020\u00042\u0006\u0010\u0006\u001a\u00020\u0004J\u000e\u0010\u0007\u001a\u00020\b2\u0006\u0010\t\u001a\u00020\nJ\u0016\u0010\u000b\u001a\u00020\b2\u0006\u0010\t\u001a\u00020\n2\u0006\u0010\f\u001a\u00020\rJ\u0016\u0010\u000e\u001a\u00020\b2\u0006\u0010\u000f\u001a\u00020\u00102\u0006\u0010\f\u001a\u00020\rJ\u000e\u0010\u0011\u001a\u00020\b2\u0006\u0010\t\u001a\u00020\n\u00a8\u0006\u0012"}, d2 = {"Lapp/loup/geolocation/location/LocationHelper;", "", "()V", "getBestPriority", "", "p1", "p2", "isLocationEnabled", "", "context", "Landroid/content/Context;", "isPermissionDeclared", "permission", "Lapp/loup/geolocation/data/Permission;", "isPermissionDeclined", "activity", "Landroid/app/Activity;", "isPermissionGranted", "geolocation_debug"})
public final class LocationHelper {
    public static final app.loup.geolocation.location.LocationHelper INSTANCE = null;
    
    public final boolean isPermissionDeclared(@org.jetbrains.annotations.NotNull()
    android.content.Context context, @org.jetbrains.annotations.NotNull()
    app.loup.geolocation.data.Permission permission) {
        return false;
    }
    
    public final boolean isLocationEnabled(@org.jetbrains.annotations.NotNull()
    android.content.Context context) {
        return false;
    }
    
    public final boolean isPermissionDeclined(@org.jetbrains.annotations.NotNull()
    android.app.Activity activity, @org.jetbrains.annotations.NotNull()
    app.loup.geolocation.data.Permission permission) {
        return false;
    }
    
    /**
     * Android doesn't make any difference between coarse and fine for permission.
     */
    public final boolean isPermissionGranted(@org.jetbrains.annotations.NotNull()
    android.content.Context context) {
        return false;
    }
    
    public final int getBestPriority(int p1, int p2) {
        return 0;
    }
    
    private LocationHelper() {
        super();
    }
}