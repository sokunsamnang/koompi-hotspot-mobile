package app.loup.geolocation.data;

import java.lang.System;

@kotlin.Metadata(mv = {1, 1, 15}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000>\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\b\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0010\u0007\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u001b\n\u0002\u0010\u000e\n\u0002\b\u0003\b\u0087\b\u0018\u00002\u00020\u0001:\u0002,-B=\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0005\u0012\u0006\u0010\u0006\u001a\u00020\u0007\u0012\u0006\u0010\b\u001a\u00020\t\u0012\u0006\u0010\n\u001a\u00020\u000b\u0012\u0006\u0010\f\u001a\u00020\r\u0012\u0006\u0010\u000e\u001a\u00020\u000f\u00a2\u0006\u0002\u0010\u0010J\t\u0010\u001f\u001a\u00020\u0003H\u00c6\u0003J\t\u0010 \u001a\u00020\u0005H\u00c6\u0003J\t\u0010!\u001a\u00020\u0007H\u00c6\u0003J\t\u0010\"\u001a\u00020\tH\u00c6\u0003J\t\u0010#\u001a\u00020\u000bH\u00c6\u0003J\t\u0010$\u001a\u00020\rH\u00c6\u0003J\t\u0010%\u001a\u00020\u000fH\u00c6\u0003JO\u0010&\u001a\u00020\u00002\b\b\u0002\u0010\u0002\u001a\u00020\u00032\b\b\u0002\u0010\u0004\u001a\u00020\u00052\b\b\u0002\u0010\u0006\u001a\u00020\u00072\b\b\u0002\u0010\b\u001a\u00020\t2\b\b\u0002\u0010\n\u001a\u00020\u000b2\b\b\u0002\u0010\f\u001a\u00020\r2\b\b\u0002\u0010\u000e\u001a\u00020\u000fH\u00c6\u0001J\u0013\u0010\'\u001a\u00020\u000b2\b\u0010(\u001a\u0004\u0018\u00010\u0001H\u00d6\u0003J\t\u0010)\u001a\u00020\u0003H\u00d6\u0001J\t\u0010*\u001a\u00020+H\u00d6\u0001R\u0011\u0010\b\u001a\u00020\t\u00a2\u0006\b\n\u0000\u001a\u0004\b\u0011\u0010\u0012R\u0011\u0010\f\u001a\u00020\r\u00a2\u0006\b\n\u0000\u001a\u0004\b\u0013\u0010\u0014R\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\b\n\u0000\u001a\u0004\b\u0015\u0010\u0016R\u0011\u0010\n\u001a\u00020\u000b\u00a2\u0006\b\n\u0000\u001a\u0004\b\u0017\u0010\u0018R\u0011\u0010\u000e\u001a\u00020\u000f\u00a2\u0006\b\n\u0000\u001a\u0004\b\u0019\u0010\u001aR\u0011\u0010\u0006\u001a\u00020\u0007\u00a2\u0006\b\n\u0000\u001a\u0004\b\u001b\u0010\u001cR\u0011\u0010\u0004\u001a\u00020\u0005\u00a2\u0006\b\n\u0000\u001a\u0004\b\u001d\u0010\u001e\u00a8\u0006."}, d2 = {"Lapp/loup/geolocation/data/LocationUpdatesRequest;", "", "id", "", "strategy", "Lapp/loup/geolocation/data/LocationUpdatesRequest$Strategy;", "permission", "Lapp/loup/geolocation/data/Permission;", "accuracy", "Lapp/loup/geolocation/data/Priority;", "inBackground", "", "displacementFilter", "", "options", "Lapp/loup/geolocation/data/LocationUpdatesRequest$Options;", "(ILapp/loup/geolocation/data/LocationUpdatesRequest$Strategy;Lapp/loup/geolocation/data/Permission;Lapp/loup/geolocation/data/Priority;ZFLapp/loup/geolocation/data/LocationUpdatesRequest$Options;)V", "getAccuracy", "()Lapp/loup/geolocation/data/Priority;", "getDisplacementFilter", "()F", "getId", "()I", "getInBackground", "()Z", "getOptions", "()Lapp/loup/geolocation/data/LocationUpdatesRequest$Options;", "getPermission", "()Lapp/loup/geolocation/data/Permission;", "getStrategy", "()Lapp/loup/geolocation/data/LocationUpdatesRequest$Strategy;", "component1", "component2", "component3", "component4", "component5", "component6", "component7", "copy", "equals", "other", "hashCode", "toString", "", "Options", "Strategy", "geolocation_debug"})
@com.squareup.moshi.JsonClass(generateAdapter = true)
public final class LocationUpdatesRequest {
    private final int id = 0;
    @org.jetbrains.annotations.NotNull()
    private final app.loup.geolocation.data.LocationUpdatesRequest.Strategy strategy = null;
    @org.jetbrains.annotations.NotNull()
    private final app.loup.geolocation.data.Permission permission = null;
    @org.jetbrains.annotations.NotNull()
    private final app.loup.geolocation.data.Priority accuracy = null;
    private final boolean inBackground = false;
    private final float displacementFilter = 0.0F;
    @org.jetbrains.annotations.NotNull()
    private final app.loup.geolocation.data.LocationUpdatesRequest.Options options = null;
    
    public final int getId() {
        return 0;
    }
    
    @org.jetbrains.annotations.NotNull()
    public final app.loup.geolocation.data.LocationUpdatesRequest.Strategy getStrategy() {
        return null;
    }
    
    @org.jetbrains.annotations.NotNull()
    public final app.loup.geolocation.data.Permission getPermission() {
        return null;
    }
    
    @org.jetbrains.annotations.NotNull()
    public final app.loup.geolocation.data.Priority getAccuracy() {
        return null;
    }
    
    public final boolean getInBackground() {
        return false;
    }
    
    public final float getDisplacementFilter() {
        return 0.0F;
    }
    
    @org.jetbrains.annotations.NotNull()
    public final app.loup.geolocation.data.LocationUpdatesRequest.Options getOptions() {
        return null;
    }
    
    public LocationUpdatesRequest(int id, @org.jetbrains.annotations.NotNull()
    app.loup.geolocation.data.LocationUpdatesRequest.Strategy strategy, @org.jetbrains.annotations.NotNull()
    app.loup.geolocation.data.Permission permission, @org.jetbrains.annotations.NotNull()
    app.loup.geolocation.data.Priority accuracy, boolean inBackground, float displacementFilter, @org.jetbrains.annotations.NotNull()
    app.loup.geolocation.data.LocationUpdatesRequest.Options options) {
        super();
    }
    
    public final int component1() {
        return 0;
    }
    
    @org.jetbrains.annotations.NotNull()
    public final app.loup.geolocation.data.LocationUpdatesRequest.Strategy component2() {
        return null;
    }
    
    @org.jetbrains.annotations.NotNull()
    public final app.loup.geolocation.data.Permission component3() {
        return null;
    }
    
    @org.jetbrains.annotations.NotNull()
    public final app.loup.geolocation.data.Priority component4() {
        return null;
    }
    
    public final boolean component5() {
        return false;
    }
    
    public final float component6() {
        return 0.0F;
    }
    
    @org.jetbrains.annotations.NotNull()
    public final app.loup.geolocation.data.LocationUpdatesRequest.Options component7() {
        return null;
    }
    
    @org.jetbrains.annotations.NotNull()
    public final app.loup.geolocation.data.LocationUpdatesRequest copy(int id, @org.jetbrains.annotations.NotNull()
    app.loup.geolocation.data.LocationUpdatesRequest.Strategy strategy, @org.jetbrains.annotations.NotNull()
    app.loup.geolocation.data.Permission permission, @org.jetbrains.annotations.NotNull()
    app.loup.geolocation.data.Priority accuracy, boolean inBackground, float displacementFilter, @org.jetbrains.annotations.NotNull()
    app.loup.geolocation.data.LocationUpdatesRequest.Options options) {
        return null;
    }
    
    @org.jetbrains.annotations.NotNull()
    @java.lang.Override()
    public java.lang.String toString() {
        return null;
    }
    
    @java.lang.Override()
    public int hashCode() {
        return 0;
    }
    
    @java.lang.Override()
    public boolean equals(@org.jetbrains.annotations.Nullable()
    java.lang.Object p0) {
        return false;
    }
    
    @kotlin.Metadata(mv = {1, 1, 15}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000\f\n\u0002\u0018\u0002\n\u0002\u0010\u0010\n\u0002\b\u0006\b\u0086\u0001\u0018\u00002\b\u0012\u0004\u0012\u00020\u00000\u0001:\u0001\u0006B\u0007\b\u0002\u00a2\u0006\u0002\u0010\u0002j\u0002\b\u0003j\u0002\b\u0004j\u0002\b\u0005\u00a8\u0006\u0007"}, d2 = {"Lapp/loup/geolocation/data/LocationUpdatesRequest$Strategy;", "", "(Ljava/lang/String;I)V", "Current", "Single", "Continuous", "Adapter", "geolocation_debug"})
    public static enum Strategy {
        /*public static final*/ Current /* = new Current() */,
        /*public static final*/ Single /* = new Single() */,
        /*public static final*/ Continuous /* = new Continuous() */;
        
        Strategy() {
        }
        
        @kotlin.Metadata(mv = {1, 1, 15}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000\u001a\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\b\u0003\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010\u0003\u001a\u00020\u00042\u0006\u0010\u0005\u001a\u00020\u0006H\u0007J\u0010\u0010\u0007\u001a\u00020\u00062\u0006\u0010\b\u001a\u00020\u0004H\u0007\u00a8\u0006\t"}, d2 = {"Lapp/loup/geolocation/data/LocationUpdatesRequest$Strategy$Adapter;", "", "()V", "fromJson", "Lapp/loup/geolocation/data/LocationUpdatesRequest$Strategy;", "json", "", "toJson", "value", "geolocation_debug"})
        public static final class Adapter {
            
            @org.jetbrains.annotations.NotNull()
            @com.squareup.moshi.FromJson()
            public final app.loup.geolocation.data.LocationUpdatesRequest.Strategy fromJson(@org.jetbrains.annotations.NotNull()
            java.lang.String json) {
                return null;
            }
            
            @org.jetbrains.annotations.NotNull()
            @com.squareup.moshi.ToJson()
            public final java.lang.String toJson(@org.jetbrains.annotations.NotNull()
            app.loup.geolocation.data.LocationUpdatesRequest.Strategy value) {
                return null;
            }
            
            public Adapter() {
                super();
            }
        }
    }
    
    @kotlin.Metadata(mv = {1, 1, 15}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000(\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\t\n\u0002\b\u0005\n\u0002\u0010\b\n\u0002\b\u0014\n\u0002\u0010\u000b\n\u0002\b\u0003\n\u0002\u0010\u000e\n\u0000\b\u0087\b\u0018\u00002\u00020\u0001BA\u0012\b\u0010\u0002\u001a\u0004\u0018\u00010\u0003\u0012\b\u0010\u0004\u001a\u0004\u0018\u00010\u0003\u0012\b\u0010\u0005\u001a\u0004\u0018\u00010\u0003\u0012\b\u0010\u0006\u001a\u0004\u0018\u00010\u0003\u0012\b\u0010\u0007\u001a\u0004\u0018\u00010\u0003\u0012\b\u0010\b\u001a\u0004\u0018\u00010\t\u00a2\u0006\u0002\u0010\nJ\u0010\u0010\u0015\u001a\u0004\u0018\u00010\u0003H\u00c6\u0003\u00a2\u0006\u0002\u0010\fJ\u0010\u0010\u0016\u001a\u0004\u0018\u00010\u0003H\u00c6\u0003\u00a2\u0006\u0002\u0010\fJ\u0010\u0010\u0017\u001a\u0004\u0018\u00010\u0003H\u00c6\u0003\u00a2\u0006\u0002\u0010\fJ\u0010\u0010\u0018\u001a\u0004\u0018\u00010\u0003H\u00c6\u0003\u00a2\u0006\u0002\u0010\fJ\u0010\u0010\u0019\u001a\u0004\u0018\u00010\u0003H\u00c6\u0003\u00a2\u0006\u0002\u0010\fJ\u0010\u0010\u001a\u001a\u0004\u0018\u00010\tH\u00c6\u0003\u00a2\u0006\u0002\u0010\u0013JV\u0010\u001b\u001a\u00020\u00002\n\b\u0002\u0010\u0002\u001a\u0004\u0018\u00010\u00032\n\b\u0002\u0010\u0004\u001a\u0004\u0018\u00010\u00032\n\b\u0002\u0010\u0005\u001a\u0004\u0018\u00010\u00032\n\b\u0002\u0010\u0006\u001a\u0004\u0018\u00010\u00032\n\b\u0002\u0010\u0007\u001a\u0004\u0018\u00010\u00032\n\b\u0002\u0010\b\u001a\u0004\u0018\u00010\tH\u00c6\u0001\u00a2\u0006\u0002\u0010\u001cJ\u0013\u0010\u001d\u001a\u00020\u001e2\b\u0010\u001f\u001a\u0004\u0018\u00010\u0001H\u00d6\u0003J\t\u0010 \u001a\u00020\tH\u00d6\u0001J\t\u0010!\u001a\u00020\"H\u00d6\u0001R\u0015\u0010\u0006\u001a\u0004\u0018\u00010\u0003\u00a2\u0006\n\n\u0002\u0010\r\u001a\u0004\b\u000b\u0010\fR\u0015\u0010\u0005\u001a\u0004\u0018\u00010\u0003\u00a2\u0006\n\n\u0002\u0010\r\u001a\u0004\b\u000e\u0010\fR\u0015\u0010\u0004\u001a\u0004\u0018\u00010\u0003\u00a2\u0006\n\n\u0002\u0010\r\u001a\u0004\b\u000f\u0010\fR\u0015\u0010\u0002\u001a\u0004\u0018\u00010\u0003\u00a2\u0006\n\n\u0002\u0010\r\u001a\u0004\b\u0010\u0010\fR\u0015\u0010\u0007\u001a\u0004\u0018\u00010\u0003\u00a2\u0006\n\n\u0002\u0010\r\u001a\u0004\b\u0011\u0010\fR\u0015\u0010\b\u001a\u0004\u0018\u00010\t\u00a2\u0006\n\n\u0002\u0010\u0014\u001a\u0004\b\u0012\u0010\u0013\u00a8\u0006#"}, d2 = {"Lapp/loup/geolocation/data/LocationUpdatesRequest$Options;", "", "interval", "", "fastestInterval", "expirationTime", "expirationDuration", "maxWaitTime", "numUpdates", "", "(Ljava/lang/Long;Ljava/lang/Long;Ljava/lang/Long;Ljava/lang/Long;Ljava/lang/Long;Ljava/lang/Integer;)V", "getExpirationDuration", "()Ljava/lang/Long;", "Ljava/lang/Long;", "getExpirationTime", "getFastestInterval", "getInterval", "getMaxWaitTime", "getNumUpdates", "()Ljava/lang/Integer;", "Ljava/lang/Integer;", "component1", "component2", "component3", "component4", "component5", "component6", "copy", "(Ljava/lang/Long;Ljava/lang/Long;Ljava/lang/Long;Ljava/lang/Long;Ljava/lang/Long;Ljava/lang/Integer;)Lapp/loup/geolocation/data/LocationUpdatesRequest$Options;", "equals", "", "other", "hashCode", "toString", "", "geolocation_debug"})
    @com.squareup.moshi.JsonClass(generateAdapter = true)
    public static final class Options {
        @org.jetbrains.annotations.Nullable()
        private final java.lang.Long interval = null;
        @org.jetbrains.annotations.Nullable()
        private final java.lang.Long fastestInterval = null;
        @org.jetbrains.annotations.Nullable()
        private final java.lang.Long expirationTime = null;
        @org.jetbrains.annotations.Nullable()
        private final java.lang.Long expirationDuration = null;
        @org.jetbrains.annotations.Nullable()
        private final java.lang.Long maxWaitTime = null;
        @org.jetbrains.annotations.Nullable()
        private final java.lang.Integer numUpdates = null;
        
        @org.jetbrains.annotations.Nullable()
        public final java.lang.Long getInterval() {
            return null;
        }
        
        @org.jetbrains.annotations.Nullable()
        public final java.lang.Long getFastestInterval() {
            return null;
        }
        
        @org.jetbrains.annotations.Nullable()
        public final java.lang.Long getExpirationTime() {
            return null;
        }
        
        @org.jetbrains.annotations.Nullable()
        public final java.lang.Long getExpirationDuration() {
            return null;
        }
        
        @org.jetbrains.annotations.Nullable()
        public final java.lang.Long getMaxWaitTime() {
            return null;
        }
        
        @org.jetbrains.annotations.Nullable()
        public final java.lang.Integer getNumUpdates() {
            return null;
        }
        
        public Options(@org.jetbrains.annotations.Nullable()
        java.lang.Long interval, @org.jetbrains.annotations.Nullable()
        java.lang.Long fastestInterval, @org.jetbrains.annotations.Nullable()
        java.lang.Long expirationTime, @org.jetbrains.annotations.Nullable()
        java.lang.Long expirationDuration, @org.jetbrains.annotations.Nullable()
        java.lang.Long maxWaitTime, @org.jetbrains.annotations.Nullable()
        java.lang.Integer numUpdates) {
            super();
        }
        
        @org.jetbrains.annotations.Nullable()
        public final java.lang.Long component1() {
            return null;
        }
        
        @org.jetbrains.annotations.Nullable()
        public final java.lang.Long component2() {
            return null;
        }
        
        @org.jetbrains.annotations.Nullable()
        public final java.lang.Long component3() {
            return null;
        }
        
        @org.jetbrains.annotations.Nullable()
        public final java.lang.Long component4() {
            return null;
        }
        
        @org.jetbrains.annotations.Nullable()
        public final java.lang.Long component5() {
            return null;
        }
        
        @org.jetbrains.annotations.Nullable()
        public final java.lang.Integer component6() {
            return null;
        }
        
        @org.jetbrains.annotations.NotNull()
        public final app.loup.geolocation.data.LocationUpdatesRequest.Options copy(@org.jetbrains.annotations.Nullable()
        java.lang.Long interval, @org.jetbrains.annotations.Nullable()
        java.lang.Long fastestInterval, @org.jetbrains.annotations.Nullable()
        java.lang.Long expirationTime, @org.jetbrains.annotations.Nullable()
        java.lang.Long expirationDuration, @org.jetbrains.annotations.Nullable()
        java.lang.Long maxWaitTime, @org.jetbrains.annotations.Nullable()
        java.lang.Integer numUpdates) {
            return null;
        }
        
        @org.jetbrains.annotations.NotNull()
        @java.lang.Override()
        public java.lang.String toString() {
            return null;
        }
        
        @java.lang.Override()
        public int hashCode() {
            return 0;
        }
        
        @java.lang.Override()
        public boolean equals(@org.jetbrains.annotations.Nullable()
        java.lang.Object p0) {
            return false;
        }
    }
}