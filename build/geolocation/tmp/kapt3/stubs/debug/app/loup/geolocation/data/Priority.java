package app.loup.geolocation.data;

import java.lang.System;

@kotlin.Metadata(mv = {1, 1, 15}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0010\n\u0002\b\u0002\n\u0002\u0010\b\n\u0002\b\b\b\u0086\u0001\u0018\u00002\b\u0012\u0004\u0012\u00020\u00000\u0001:\u0001\u000bB\u0007\b\u0002\u00a2\u0006\u0002\u0010\u0002R\u0011\u0010\u0003\u001a\u00020\u00048F\u00a2\u0006\u0006\u001a\u0004\b\u0005\u0010\u0006j\u0002\b\u0007j\u0002\b\bj\u0002\b\tj\u0002\b\n\u00a8\u0006\f"}, d2 = {"Lapp/loup/geolocation/data/Priority;", "", "(Ljava/lang/String;I)V", "androidValue", "", "getAndroidValue", "()I", "NoPower", "Low", "Balanced", "High", "Adapter", "geolocation_debug"})
public enum Priority {
    /*public static final*/ NoPower /* = new NoPower() */,
    /*public static final*/ Low /* = new Low() */,
    /*public static final*/ Balanced /* = new Balanced() */,
    /*public static final*/ High /* = new High() */;
    
    public final int getAndroidValue() {
        return 0;
    }
    
    Priority() {
    }
    
    @kotlin.Metadata(mv = {1, 1, 15}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000\u001a\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\b\u0003\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010\u0003\u001a\u00020\u00042\u0006\u0010\u0005\u001a\u00020\u0006H\u0007J\u0010\u0010\u0007\u001a\u00020\u00062\u0006\u0010\b\u001a\u00020\u0004H\u0007\u00a8\u0006\t"}, d2 = {"Lapp/loup/geolocation/data/Priority$Adapter;", "", "()V", "fromJson", "Lapp/loup/geolocation/data/Priority;", "json", "", "toJson", "value", "geolocation_debug"})
    public static final class Adapter {
        
        @org.jetbrains.annotations.NotNull()
        @com.squareup.moshi.FromJson()
        public final app.loup.geolocation.data.Priority fromJson(@org.jetbrains.annotations.NotNull()
        java.lang.String json) {
            return null;
        }
        
        @org.jetbrains.annotations.NotNull()
        @com.squareup.moshi.ToJson()
        public final java.lang.String toJson(@org.jetbrains.annotations.NotNull()
        app.loup.geolocation.data.Priority value) {
            return null;
        }
        
        public Adapter() {
            super();
        }
    }
}