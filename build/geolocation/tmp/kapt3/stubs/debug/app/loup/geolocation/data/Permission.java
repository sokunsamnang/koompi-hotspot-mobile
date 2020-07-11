package app.loup.geolocation.data;

import java.lang.System;

@kotlin.Metadata(mv = {1, 1, 15}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0010\n\u0002\b\u0002\n\u0002\u0010\u000e\n\u0002\b\u0006\b\u0086\u0001\u0018\u00002\b\u0012\u0004\u0012\u00020\u00000\u0001:\u0001\tB\u0007\b\u0002\u00a2\u0006\u0002\u0010\u0002R\u0011\u0010\u0003\u001a\u00020\u00048F\u00a2\u0006\u0006\u001a\u0004\b\u0005\u0010\u0006j\u0002\b\u0007j\u0002\b\b\u00a8\u0006\n"}, d2 = {"Lapp/loup/geolocation/data/Permission;", "", "(Ljava/lang/String;I)V", "manifestValue", "", "getManifestValue", "()Ljava/lang/String;", "Coarse", "Fine", "Adapter", "geolocation_debug"})
public enum Permission {
    /*public static final*/ Coarse /* = new Coarse() */,
    /*public static final*/ Fine /* = new Fine() */;
    
    @org.jetbrains.annotations.NotNull()
    public final java.lang.String getManifestValue() {
        return null;
    }
    
    Permission() {
    }
    
    @kotlin.Metadata(mv = {1, 1, 15}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000\u001a\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\b\u0003\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010\u0003\u001a\u00020\u00042\u0006\u0010\u0005\u001a\u00020\u0006H\u0007J\u0010\u0010\u0007\u001a\u00020\u00062\u0006\u0010\b\u001a\u00020\u0004H\u0007\u00a8\u0006\t"}, d2 = {"Lapp/loup/geolocation/data/Permission$Adapter;", "", "()V", "fromJson", "Lapp/loup/geolocation/data/Permission;", "json", "", "toJson", "value", "geolocation_debug"})
    public static final class Adapter {
        
        @org.jetbrains.annotations.NotNull()
        @com.squareup.moshi.FromJson()
        public final app.loup.geolocation.data.Permission fromJson(@org.jetbrains.annotations.NotNull()
        java.lang.String json) {
            return null;
        }
        
        @org.jetbrains.annotations.NotNull()
        @com.squareup.moshi.ToJson()
        public final java.lang.String toJson(@org.jetbrains.annotations.NotNull()
        app.loup.geolocation.data.Permission value) {
            return null;
        }
        
        public Adapter() {
            super();
        }
    }
}