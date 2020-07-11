package app.loup.geolocation.data;

import java.lang.System;

@kotlin.Metadata(mv = {1, 1, 15}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000(\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u000b\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0002\b\r\n\u0002\u0010\b\n\u0000\n\u0002\u0010\u000e\n\u0002\b\u0003\b\u0087\b\u0018\u0000 \u00172\u00020\u0001:\u0002\u0017\u0018B%\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\n\b\u0002\u0010\u0004\u001a\u0004\u0018\u00010\u0001\u0012\n\b\u0002\u0010\u0005\u001a\u0004\u0018\u00010\u0006\u00a2\u0006\u0002\u0010\u0007J\t\u0010\r\u001a\u00020\u0003H\u00c6\u0003J\u000b\u0010\u000e\u001a\u0004\u0018\u00010\u0001H\u00c6\u0003J\u000b\u0010\u000f\u001a\u0004\u0018\u00010\u0006H\u00c6\u0003J+\u0010\u0010\u001a\u00020\u00002\b\b\u0002\u0010\u0002\u001a\u00020\u00032\n\b\u0002\u0010\u0004\u001a\u0004\u0018\u00010\u00012\n\b\u0002\u0010\u0005\u001a\u0004\u0018\u00010\u0006H\u00c6\u0001J\u0013\u0010\u0011\u001a\u00020\u00032\b\u0010\u0012\u001a\u0004\u0018\u00010\u0001H\u00d6\u0003J\t\u0010\u0013\u001a\u00020\u0014H\u00d6\u0001J\t\u0010\u0015\u001a\u00020\u0016H\u00d6\u0001R\u0013\u0010\u0004\u001a\u0004\u0018\u00010\u0001\u00a2\u0006\b\n\u0000\u001a\u0004\b\b\u0010\tR\u0013\u0010\u0005\u001a\u0004\u0018\u00010\u0006\u00a2\u0006\b\n\u0000\u001a\u0004\b\n\u0010\u000bR\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\b\n\u0000\u001a\u0004\b\u0002\u0010\f\u00a8\u0006\u0019"}, d2 = {"Lapp/loup/geolocation/data/Result;", "", "isSuccessful", "", "data", "error", "Lapp/loup/geolocation/data/Result$Error;", "(ZLjava/lang/Object;Lapp/loup/geolocation/data/Result$Error;)V", "getData", "()Ljava/lang/Object;", "getError", "()Lapp/loup/geolocation/data/Result$Error;", "()Z", "component1", "component2", "component3", "copy", "equals", "other", "hashCode", "", "toString", "", "Companion", "Error", "geolocation_debug"})
@com.squareup.moshi.JsonClass(generateAdapter = true)
public final class Result {
    private final boolean isSuccessful = false;
    @org.jetbrains.annotations.Nullable()
    private final java.lang.Object data = null;
    @org.jetbrains.annotations.Nullable()
    private final app.loup.geolocation.data.Result.Error error = null;
    public static final app.loup.geolocation.data.Result.Companion Companion = null;
    
    public final boolean isSuccessful() {
        return false;
    }
    
    @org.jetbrains.annotations.Nullable()
    public final java.lang.Object getData() {
        return null;
    }
    
    @org.jetbrains.annotations.Nullable()
    public final app.loup.geolocation.data.Result.Error getError() {
        return null;
    }
    
    public Result(boolean isSuccessful, @org.jetbrains.annotations.Nullable()
    java.lang.Object data, @org.jetbrains.annotations.Nullable()
    app.loup.geolocation.data.Result.Error error) {
        super();
    }
    
    public final boolean component1() {
        return false;
    }
    
    @org.jetbrains.annotations.Nullable()
    public final java.lang.Object component2() {
        return null;
    }
    
    @org.jetbrains.annotations.Nullable()
    public final app.loup.geolocation.data.Result.Error component3() {
        return null;
    }
    
    @org.jetbrains.annotations.NotNull()
    public final app.loup.geolocation.data.Result copy(boolean isSuccessful, @org.jetbrains.annotations.Nullable()
    java.lang.Object data, @org.jetbrains.annotations.Nullable()
    app.loup.geolocation.data.Result.Error error) {
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
    
    @kotlin.Metadata(mv = {1, 1, 15}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000\"\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u000e\n\u0002\b\u0003\n\u0002\u0010\u000b\n\u0002\b\u000f\n\u0002\u0010\b\n\u0002\b\u0004\b\u0087\b\u0018\u00002\u00020\u0001:\u0002\u0019\u001aB)\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\b\u0010\u0004\u001a\u0004\u0018\u00010\u0003\u0012\b\u0010\u0005\u001a\u0004\u0018\u00010\u0003\u0012\u0006\u0010\u0006\u001a\u00020\u0007\u00a2\u0006\u0002\u0010\bJ\t\u0010\u000f\u001a\u00020\u0003H\u00c6\u0003J\u000b\u0010\u0010\u001a\u0004\u0018\u00010\u0003H\u00c6\u0003J\u000b\u0010\u0011\u001a\u0004\u0018\u00010\u0003H\u00c6\u0003J\t\u0010\u0012\u001a\u00020\u0007H\u00c6\u0003J5\u0010\u0013\u001a\u00020\u00002\b\b\u0002\u0010\u0002\u001a\u00020\u00032\n\b\u0002\u0010\u0004\u001a\u0004\u0018\u00010\u00032\n\b\u0002\u0010\u0005\u001a\u0004\u0018\u00010\u00032\b\b\u0002\u0010\u0006\u001a\u00020\u0007H\u00c6\u0001J\u0013\u0010\u0014\u001a\u00020\u00072\b\u0010\u0015\u001a\u0004\u0018\u00010\u0001H\u00d6\u0003J\t\u0010\u0016\u001a\u00020\u0017H\u00d6\u0001J\t\u0010\u0018\u001a\u00020\u0003H\u00d6\u0001R\u0011\u0010\u0006\u001a\u00020\u0007\u00a2\u0006\b\n\u0000\u001a\u0004\b\t\u0010\nR\u0013\u0010\u0005\u001a\u0004\u0018\u00010\u0003\u00a2\u0006\b\n\u0000\u001a\u0004\b\u000b\u0010\fR\u0013\u0010\u0004\u001a\u0004\u0018\u00010\u0003\u00a2\u0006\b\n\u0000\u001a\u0004\b\r\u0010\fR\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\b\n\u0000\u001a\u0004\b\u000e\u0010\f\u00a8\u0006\u001b"}, d2 = {"Lapp/loup/geolocation/data/Result$Error;", "", "type", "", "playServices", "message", "fatal", "", "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V", "getFatal", "()Z", "getMessage", "()Ljava/lang/String;", "getPlayServices", "getType", "component1", "component2", "component3", "component4", "copy", "equals", "other", "hashCode", "", "toString", "PlayServices", "Type", "geolocation_debug"})
    @com.squareup.moshi.JsonClass(generateAdapter = true)
    public static final class Error {
        @org.jetbrains.annotations.NotNull()
        private final java.lang.String type = null;
        @org.jetbrains.annotations.Nullable()
        private final java.lang.String playServices = null;
        @org.jetbrains.annotations.Nullable()
        private final java.lang.String message = null;
        private final boolean fatal = false;
        
        @org.jetbrains.annotations.NotNull()
        public final java.lang.String getType() {
            return null;
        }
        
        @org.jetbrains.annotations.Nullable()
        public final java.lang.String getPlayServices() {
            return null;
        }
        
        @org.jetbrains.annotations.Nullable()
        public final java.lang.String getMessage() {
            return null;
        }
        
        public final boolean getFatal() {
            return false;
        }
        
        public Error(@org.jetbrains.annotations.NotNull()
        java.lang.String type, @org.jetbrains.annotations.Nullable()
        java.lang.String playServices, @org.jetbrains.annotations.Nullable()
        java.lang.String message, boolean fatal) {
            super();
        }
        
        @org.jetbrains.annotations.NotNull()
        public final java.lang.String component1() {
            return null;
        }
        
        @org.jetbrains.annotations.Nullable()
        public final java.lang.String component2() {
            return null;
        }
        
        @org.jetbrains.annotations.Nullable()
        public final java.lang.String component3() {
            return null;
        }
        
        public final boolean component4() {
            return false;
        }
        
        @org.jetbrains.annotations.NotNull()
        public final app.loup.geolocation.data.Result.Error copy(@org.jetbrains.annotations.NotNull()
        java.lang.String type, @org.jetbrains.annotations.Nullable()
        java.lang.String playServices, @org.jetbrains.annotations.Nullable()
        java.lang.String message, boolean fatal) {
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
        
        @kotlin.Metadata(mv = {1, 1, 15}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\b\u0002\n\u0002\u0010\u000e\n\u0002\b\u0006\b\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\b\u0002\u00a2\u0006\u0002\u0010\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\b\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\n"}, d2 = {"Lapp/loup/geolocation/data/Result$Error$Type;", "", "()V", "LocationNotFound", "", "PermissionDenied", "PermissionNotGranted", "PlayServicesUnavailable", "Runtime", "ServiceDisabled", "geolocation_debug"})
        public static final class Type {
            @org.jetbrains.annotations.NotNull()
            public static final java.lang.String Runtime = "runtime";
            @org.jetbrains.annotations.NotNull()
            public static final java.lang.String LocationNotFound = "locationNotFound";
            @org.jetbrains.annotations.NotNull()
            public static final java.lang.String PermissionNotGranted = "permissionNotGranted";
            @org.jetbrains.annotations.NotNull()
            public static final java.lang.String PermissionDenied = "permissionDenied";
            @org.jetbrains.annotations.NotNull()
            public static final java.lang.String ServiceDisabled = "serviceDisabled";
            @org.jetbrains.annotations.NotNull()
            public static final java.lang.String PlayServicesUnavailable = "playServicesUnavailable";
            public static final app.loup.geolocation.data.Result.Error.Type INSTANCE = null;
            
            private Type() {
                super();
            }
        }
        
        @kotlin.Metadata(mv = {1, 1, 15}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000\u001a\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\b\u0002\n\u0002\u0010\u000e\n\u0002\b\u0006\n\u0002\u0010\b\n\u0000\b\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\b\u0002\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\t\u001a\u00020\u00042\u0006\u0010\n\u001a\u00020\u000bR\u000e\u0010\u0003\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\b\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\f"}, d2 = {"Lapp/loup/geolocation/data/Result$Error$PlayServices;", "", "()V", "Disabled", "", "Invalid", "Missing", "Updating", "VersionUpdateRequired", "fromConnectionResult", "value", "", "geolocation_debug"})
        public static final class PlayServices {
            @org.jetbrains.annotations.NotNull()
            public static final java.lang.String Missing = "missing";
            @org.jetbrains.annotations.NotNull()
            public static final java.lang.String Updating = "updating";
            @org.jetbrains.annotations.NotNull()
            public static final java.lang.String VersionUpdateRequired = "versionUpdateRequired";
            @org.jetbrains.annotations.NotNull()
            public static final java.lang.String Disabled = "disabled";
            @org.jetbrains.annotations.NotNull()
            public static final java.lang.String Invalid = "invalid";
            public static final app.loup.geolocation.data.Result.Error.PlayServices INSTANCE = null;
            
            @org.jetbrains.annotations.NotNull()
            public final java.lang.String fromConnectionResult(int value) {
                return null;
            }
            
            private PlayServices() {
                super();
            }
        }
    }
    
    @kotlin.Metadata(mv = {1, 1, 15}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000\"\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\b\u0003\n\u0002\u0010\u000b\n\u0002\b\u0003\b\u0086\u0003\u0018\u00002\u00020\u0001B\u0007\b\u0002\u00a2\u0006\u0002\u0010\u0002J0\u0010\u0003\u001a\u00020\u00042\u0006\u0010\u0005\u001a\u00020\u00062\n\b\u0002\u0010\u0007\u001a\u0004\u0018\u00010\u00062\n\b\u0002\u0010\b\u001a\u0004\u0018\u00010\u00062\b\b\u0002\u0010\t\u001a\u00020\nJ\u000e\u0010\u000b\u001a\u00020\u00042\u0006\u0010\f\u001a\u00020\u0001\u00a8\u0006\r"}, d2 = {"Lapp/loup/geolocation/data/Result$Companion;", "", "()V", "failure", "Lapp/loup/geolocation/data/Result;", "type", "", "playServices", "message", "fatal", "", "success", "data", "geolocation_debug"})
    public static final class Companion {
        
        @org.jetbrains.annotations.NotNull()
        public final app.loup.geolocation.data.Result success(@org.jetbrains.annotations.NotNull()
        java.lang.Object data) {
            return null;
        }
        
        @org.jetbrains.annotations.NotNull()
        public final app.loup.geolocation.data.Result failure(@org.jetbrains.annotations.NotNull()
        java.lang.String type, @org.jetbrains.annotations.Nullable()
        java.lang.String playServices, @org.jetbrains.annotations.Nullable()
        java.lang.String message, boolean fatal) {
            return null;
        }
        
        private Companion() {
            super();
        }
    }
}