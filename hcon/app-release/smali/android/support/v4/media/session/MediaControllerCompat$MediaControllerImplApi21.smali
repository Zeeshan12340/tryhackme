.class Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;
.super Ljava/lang/Object;
.source "MediaControllerCompat.java"

# interfaces
.implements Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImpl;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/support/v4/media/session/MediaControllerCompat;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "MediaControllerImplApi21"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21$ExtraCallback;,
        Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21$ExtraBinderRequestResultReceiver;
    }
.end annotation


# instance fields
.field private mCallbackMap:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Landroid/support/v4/media/session/MediaControllerCompat$Callback;",
            "Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21$ExtraCallback;",
            ">;"
        }
    .end annotation
.end field

.field protected final mControllerObj:Ljava/lang/Object;

.field private mExtraBinder:Landroid/support/v4/media/session/IMediaSession;

.field private mPendingCallbacks:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Landroid/support/v4/media/session/MediaControllerCompat$Callback;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/support/v4/media/session/MediaSessionCompat$Token;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "sessionToken"    # Landroid/support/v4/media/session/MediaSessionCompat$Token;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    .line 1622
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1612
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mCallbackMap:Ljava/util/HashMap;

    .line 1613
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mPendingCallbacks:Ljava/util/List;

    .line 1624
    invoke-virtual {p2}, Landroid/support/v4/media/session/MediaSessionCompat$Token;->getToken()Ljava/lang/Object;

    move-result-object v0

    .line 1623
    invoke-static {p1, v0}, Landroid/support/v4/media/session/MediaControllerCompatApi21;->fromToken(Landroid/content/Context;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mControllerObj:Ljava/lang/Object;

    .line 1625
    iget-object v0, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mControllerObj:Ljava/lang/Object;

    if-nez v0, :cond_0

    new-instance v0, Landroid/os/RemoteException;

    invoke-direct {v0}, Landroid/os/RemoteException;-><init>()V

    throw v0

    .line 1626
    :cond_0
    invoke-direct {p0}, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->requestExtraBinder()V

    .line 1627
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/support/v4/media/session/MediaSessionCompat;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "session"    # Landroid/support/v4/media/session/MediaSessionCompat;

    .prologue
    .line 1615
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1612
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mCallbackMap:Ljava/util/HashMap;

    .line 1613
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mPendingCallbacks:Ljava/util/List;

    .line 1617
    invoke-virtual {p2}, Landroid/support/v4/media/session/MediaSessionCompat;->getSessionToken()Landroid/support/v4/media/session/MediaSessionCompat$Token;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/media/session/MediaSessionCompat$Token;->getToken()Ljava/lang/Object;

    move-result-object v0

    .line 1616
    invoke-static {p1, v0}, Landroid/support/v4/media/session/MediaControllerCompatApi21;->fromToken(Landroid/content/Context;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mControllerObj:Ljava/lang/Object;

    .line 1618
    invoke-direct {p0}, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->requestExtraBinder()V

    .line 1619
    return-void
.end method

.method static synthetic access$000(Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;)Landroid/support/v4/media/session/IMediaSession;
    .locals 1
    .param p0, "x0"    # Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;

    .prologue
    .line 1606
    iget-object v0, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mExtraBinder:Landroid/support/v4/media/session/IMediaSession;

    return-object v0
.end method

.method static synthetic access$002(Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;Landroid/support/v4/media/session/IMediaSession;)Landroid/support/v4/media/session/IMediaSession;
    .locals 0
    .param p0, "x0"    # Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;
    .param p1, "x1"    # Landroid/support/v4/media/session/IMediaSession;

    .prologue
    .line 1606
    iput-object p1, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mExtraBinder:Landroid/support/v4/media/session/IMediaSession;

    return-object p1
.end method

.method static synthetic access$300(Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;)V
    .locals 0
    .param p0, "x0"    # Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;

    .prologue
    .line 1606
    invoke-direct {p0}, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->processPendingCallbacks()V

    return-void
.end method

.method private processPendingCallbacks()V
    .locals 6

    .prologue
    .line 1835
    iget-object v3, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mExtraBinder:Landroid/support/v4/media/session/IMediaSession;

    if-nez v3, :cond_0

    .line 1852
    :goto_0
    return-void

    .line 1838
    :cond_0
    iget-object v4, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mPendingCallbacks:Ljava/util/List;

    monitor-enter v4

    .line 1839
    :try_start_0
    iget-object v3, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mPendingCallbacks:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/support/v4/media/session/MediaControllerCompat$Callback;

    .line 1840
    .local v0, "callback":Landroid/support/v4/media/session/MediaControllerCompat$Callback;
    new-instance v2, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21$ExtraCallback;

    invoke-direct {v2, p0, v0}, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21$ExtraCallback;-><init>(Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;Landroid/support/v4/media/session/MediaControllerCompat$Callback;)V

    .line 1841
    .local v2, "extraCallback":Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21$ExtraCallback;
    iget-object v5, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mCallbackMap:Ljava/util/HashMap;

    invoke-virtual {v5, v0, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1842
    const/4 v5, 0x1

    iput-boolean v5, v0, Landroid/support/v4/media/session/MediaControllerCompat$Callback;->mHasExtraCallback:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1844
    :try_start_1
    iget-object v5, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mExtraBinder:Landroid/support/v4/media/session/IMediaSession;

    invoke-interface {v5, v2}, Landroid/support/v4/media/session/IMediaSession;->registerCallbackListener(Landroid/support/v4/media/session/IMediaControllerCallback;)V
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    .line 1845
    :catch_0
    move-exception v1

    .line 1846
    .local v1, "e":Landroid/os/RemoteException;
    :try_start_2
    const-string v3, "MediaControllerCompat"

    const-string v5, "Dead object in registerCallback."

    invoke-static {v3, v5, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1850
    .end local v0    # "callback":Landroid/support/v4/media/session/MediaControllerCompat$Callback;
    .end local v1    # "e":Landroid/os/RemoteException;
    .end local v2    # "extraCallback":Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21$ExtraCallback;
    :cond_1
    iget-object v3, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mPendingCallbacks:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->clear()V

    .line 1851
    monitor-exit v4

    goto :goto_0

    :catchall_0
    move-exception v3

    monitor-exit v4
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v3
.end method

.method private requestExtraBinder()V
    .locals 4

    .prologue
    .line 1830
    const-string v0, "android.support.v4.media.session.command.GET_EXTRA_BINDER"

    const/4 v1, 0x0

    new-instance v2, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21$ExtraBinderRequestResultReceiver;

    new-instance v3, Landroid/os/Handler;

    invoke-direct {v3}, Landroid/os/Handler;-><init>()V

    invoke-direct {v2, p0, v3}, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21$ExtraBinderRequestResultReceiver;-><init>(Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;Landroid/os/Handler;)V

    invoke-virtual {p0, v0, v1, v2}, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->sendCommand(Ljava/lang/String;Landroid/os/Bundle;Landroid/os/ResultReceiver;)V

    .line 1832
    return-void
.end method


# virtual methods
.method public addQueueItem(Landroid/support/v4/media/MediaDescriptionCompat;)V
    .locals 3
    .param p1, "description"    # Landroid/support/v4/media/MediaDescriptionCompat;

    .prologue
    .line 1709
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 1710
    .local v0, "params":Landroid/os/Bundle;
    const-string v1, "android.support.v4.media.session.command.ARGUMENT_MEDIA_DESCRIPTION"

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    .line 1711
    const-string v1, "android.support.v4.media.session.command.ADD_QUEUE_ITEM"

    const/4 v2, 0x0

    invoke-virtual {p0, v1, v0, v2}, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->sendCommand(Ljava/lang/String;Landroid/os/Bundle;Landroid/os/ResultReceiver;)V

    .line 1712
    return-void
.end method

.method public addQueueItem(Landroid/support/v4/media/MediaDescriptionCompat;I)V
    .locals 3
    .param p1, "description"    # Landroid/support/v4/media/MediaDescriptionCompat;
    .param p2, "index"    # I

    .prologue
    .line 1716
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 1717
    .local v0, "params":Landroid/os/Bundle;
    const-string v1, "android.support.v4.media.session.command.ARGUMENT_MEDIA_DESCRIPTION"

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    .line 1718
    const-string v1, "android.support.v4.media.session.command.ARGUMENT_INDEX"

    invoke-virtual {v0, v1, p2}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 1719
    const-string v1, "android.support.v4.media.session.command.ADD_QUEUE_ITEM_AT"

    const/4 v2, 0x0

    invoke-virtual {p0, v1, v0, v2}, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->sendCommand(Ljava/lang/String;Landroid/os/Bundle;Landroid/os/ResultReceiver;)V

    .line 1720
    return-void
.end method

.method public adjustVolume(II)V
    .locals 1
    .param p1, "direction"    # I
    .param p2, "flags"    # I

    .prologue
    .line 1810
    iget-object v0, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mControllerObj:Ljava/lang/Object;

    invoke-static {v0, p1, p2}, Landroid/support/v4/media/session/MediaControllerCompatApi21;->adjustVolume(Ljava/lang/Object;II)V

    .line 1811
    return-void
.end method

.method public dispatchMediaButtonEvent(Landroid/view/KeyEvent;)Z
    .locals 1
    .param p1, "event"    # Landroid/view/KeyEvent;

    .prologue
    .line 1672
    iget-object v0, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mControllerObj:Ljava/lang/Object;

    invoke-static {v0, p1}, Landroid/support/v4/media/session/MediaControllerCompatApi21;->dispatchMediaButtonEvent(Ljava/lang/Object;Landroid/view/KeyEvent;)Z

    move-result v0

    return v0
.end method

.method public getExtras()Landroid/os/Bundle;
    .locals 1

    .prologue
    .line 1743
    iget-object v0, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mControllerObj:Ljava/lang/Object;

    invoke-static {v0}, Landroid/support/v4/media/session/MediaControllerCompatApi21;->getExtras(Ljava/lang/Object;)Landroid/os/Bundle;

    move-result-object v0

    return-object v0
.end method

.method public getFlags()J
    .locals 2

    .prologue
    .line 1784
    iget-object v0, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mControllerObj:Ljava/lang/Object;

    invoke-static {v0}, Landroid/support/v4/media/session/MediaControllerCompatApi21;->getFlags(Ljava/lang/Object;)J

    move-result-wide v0

    return-wide v0
.end method

.method public getMediaController()Ljava/lang/Object;
    .locals 1

    .prologue
    .line 1825
    iget-object v0, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mControllerObj:Ljava/lang/Object;

    return-object v0
.end method

.method public getMetadata()Landroid/support/v4/media/MediaMetadataCompat;
    .locals 2

    .prologue
    .line 1696
    iget-object v1, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mControllerObj:Ljava/lang/Object;

    invoke-static {v1}, Landroid/support/v4/media/session/MediaControllerCompatApi21;->getMetadata(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 1697
    .local v0, "metadataObj":Ljava/lang/Object;
    if-eqz v0, :cond_0

    invoke-static {v0}, Landroid/support/v4/media/MediaMetadataCompat;->fromMediaMetadata(Ljava/lang/Object;)Landroid/support/v4/media/MediaMetadataCompat;

    move-result-object v1

    :goto_0
    return-object v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getPackageName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 1820
    iget-object v0, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mControllerObj:Ljava/lang/Object;

    invoke-static {v0}, Landroid/support/v4/media/session/MediaControllerCompatApi21;->getPackageName(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getPlaybackInfo()Landroid/support/v4/media/session/MediaControllerCompat$PlaybackInfo;
    .locals 7

    .prologue
    .line 1789
    iget-object v0, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mControllerObj:Ljava/lang/Object;

    invoke-static {v0}, Landroid/support/v4/media/session/MediaControllerCompatApi21;->getPlaybackInfo(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    .line 1790
    .local v6, "volumeInfoObj":Ljava/lang/Object;
    if-eqz v6, :cond_0

    new-instance v0, Landroid/support/v4/media/session/MediaControllerCompat$PlaybackInfo;

    .line 1791
    invoke-static {v6}, Landroid/support/v4/media/session/MediaControllerCompatApi21$PlaybackInfo;->getPlaybackType(Ljava/lang/Object;)I

    move-result v1

    .line 1792
    invoke-static {v6}, Landroid/support/v4/media/session/MediaControllerCompatApi21$PlaybackInfo;->getLegacyAudioStream(Ljava/lang/Object;)I

    move-result v2

    .line 1793
    invoke-static {v6}, Landroid/support/v4/media/session/MediaControllerCompatApi21$PlaybackInfo;->getVolumeControl(Ljava/lang/Object;)I

    move-result v3

    .line 1794
    invoke-static {v6}, Landroid/support/v4/media/session/MediaControllerCompatApi21$PlaybackInfo;->getMaxVolume(Ljava/lang/Object;)I

    move-result v4

    .line 1795
    invoke-static {v6}, Landroid/support/v4/media/session/MediaControllerCompatApi21$PlaybackInfo;->getCurrentVolume(Ljava/lang/Object;)I

    move-result v5

    invoke-direct/range {v0 .. v5}, Landroid/support/v4/media/session/MediaControllerCompat$PlaybackInfo;-><init>(IIIII)V

    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getPlaybackState()Landroid/support/v4/media/session/PlaybackStateCompat;
    .locals 4

    .prologue
    .line 1683
    iget-object v2, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mExtraBinder:Landroid/support/v4/media/session/IMediaSession;

    if-eqz v2, :cond_0

    .line 1685
    :try_start_0
    iget-object v2, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mExtraBinder:Landroid/support/v4/media/session/IMediaSession;

    invoke-interface {v2}, Landroid/support/v4/media/session/IMediaSession;->getPlaybackState()Landroid/support/v4/media/session/PlaybackStateCompat;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 1691
    :goto_0
    return-object v2

    .line 1686
    :catch_0
    move-exception v0

    .line 1687
    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "MediaControllerCompat"

    const-string v3, "Dead object in getPlaybackState."

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1690
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    iget-object v2, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mControllerObj:Ljava/lang/Object;

    invoke-static {v2}, Landroid/support/v4/media/session/MediaControllerCompatApi21;->getPlaybackState(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 1691
    .local v1, "stateObj":Ljava/lang/Object;
    if-eqz v1, :cond_1

    invoke-static {v1}, Landroid/support/v4/media/session/PlaybackStateCompat;->fromPlaybackState(Ljava/lang/Object;)Landroid/support/v4/media/session/PlaybackStateCompat;

    move-result-object v2

    goto :goto_0

    :cond_1
    const/4 v2, 0x0

    goto :goto_0
.end method

.method public getQueue()Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Landroid/support/v4/media/session/MediaSessionCompat$QueueItem;",
            ">;"
        }
    .end annotation

    .prologue
    .line 1702
    iget-object v1, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mControllerObj:Ljava/lang/Object;

    invoke-static {v1}, Landroid/support/v4/media/session/MediaControllerCompatApi21;->getQueue(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    .line 1703
    .local v0, "queueObjs":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Object;>;"
    if-eqz v0, :cond_0

    invoke-static {v0}, Landroid/support/v4/media/session/MediaSessionCompat$QueueItem;->fromQueueItemList(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    :goto_0
    return-object v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getQueueTitle()Ljava/lang/CharSequence;
    .locals 1

    .prologue
    .line 1738
    iget-object v0, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mControllerObj:Ljava/lang/Object;

    invoke-static {v0}, Landroid/support/v4/media/session/MediaControllerCompatApi21;->getQueueTitle(Ljava/lang/Object;)Ljava/lang/CharSequence;

    move-result-object v0

    return-object v0
.end method

.method public getRatingType()I
    .locals 3

    .prologue
    .line 1748
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x16

    if-ge v1, v2, :cond_0

    iget-object v1, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mExtraBinder:Landroid/support/v4/media/session/IMediaSession;

    if-eqz v1, :cond_0

    .line 1750
    :try_start_0
    iget-object v1, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mExtraBinder:Landroid/support/v4/media/session/IMediaSession;

    invoke-interface {v1}, Landroid/support/v4/media/session/IMediaSession;->getRatingType()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 1755
    :goto_0
    return v1

    .line 1751
    :catch_0
    move-exception v0

    .line 1752
    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "MediaControllerCompat"

    const-string v2, "Dead object in getRatingType."

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1755
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    iget-object v1, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mControllerObj:Ljava/lang/Object;

    invoke-static {v1}, Landroid/support/v4/media/session/MediaControllerCompatApi21;->getRatingType(Ljava/lang/Object;)I

    move-result v1

    goto :goto_0
.end method

.method public getRepeatMode()I
    .locals 3

    .prologue
    .line 1760
    iget-object v1, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mExtraBinder:Landroid/support/v4/media/session/IMediaSession;

    if-eqz v1, :cond_0

    .line 1762
    :try_start_0
    iget-object v1, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mExtraBinder:Landroid/support/v4/media/session/IMediaSession;

    invoke-interface {v1}, Landroid/support/v4/media/session/IMediaSession;->getRepeatMode()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 1767
    :goto_0
    return v1

    .line 1763
    :catch_0
    move-exception v0

    .line 1764
    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "MediaControllerCompat"

    const-string v2, "Dead object in getRepeatMode."

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1767
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getSessionActivity()Landroid/app/PendingIntent;
    .locals 1

    .prologue
    .line 1800
    iget-object v0, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mControllerObj:Ljava/lang/Object;

    invoke-static {v0}, Landroid/support/v4/media/session/MediaControllerCompatApi21;->getSessionActivity(Ljava/lang/Object;)Landroid/app/PendingIntent;

    move-result-object v0

    return-object v0
.end method

.method public getTransportControls()Landroid/support/v4/media/session/MediaControllerCompat$TransportControls;
    .locals 2

    .prologue
    .line 1677
    iget-object v1, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mControllerObj:Ljava/lang/Object;

    invoke-static {v1}, Landroid/support/v4/media/session/MediaControllerCompatApi21;->getTransportControls(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 1678
    .local v0, "controlsObj":Ljava/lang/Object;
    if-eqz v0, :cond_0

    new-instance v1, Landroid/support/v4/media/session/MediaControllerCompat$TransportControlsApi21;

    invoke-direct {v1, v0}, Landroid/support/v4/media/session/MediaControllerCompat$TransportControlsApi21;-><init>(Ljava/lang/Object;)V

    :goto_0
    return-object v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public isShuffleModeEnabled()Z
    .locals 3

    .prologue
    .line 1772
    iget-object v1, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mExtraBinder:Landroid/support/v4/media/session/IMediaSession;

    if-eqz v1, :cond_0

    .line 1774
    :try_start_0
    iget-object v1, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mExtraBinder:Landroid/support/v4/media/session/IMediaSession;

    invoke-interface {v1}, Landroid/support/v4/media/session/IMediaSession;->isShuffleModeEnabled()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 1779
    :goto_0
    return v1

    .line 1775
    :catch_0
    move-exception v0

    .line 1776
    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "MediaControllerCompat"

    const-string v2, "Dead object in isShuffleModeEnabled."

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1779
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public final registerCallback(Landroid/support/v4/media/session/MediaControllerCompat$Callback;Landroid/os/Handler;)V
    .locals 4
    .param p1, "callback"    # Landroid/support/v4/media/session/MediaControllerCompat$Callback;
    .param p2, "handler"    # Landroid/os/Handler;

    .prologue
    .line 1631
    iget-object v2, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mControllerObj:Ljava/lang/Object;

    .line 1632
    invoke-static {p1}, Landroid/support/v4/media/session/MediaControllerCompat$Callback;->access$100(Landroid/support/v4/media/session/MediaControllerCompat$Callback;)Ljava/lang/Object;

    move-result-object v3

    .line 1631
    invoke-static {v2, v3, p2}, Landroid/support/v4/media/session/MediaControllerCompatApi21;->registerCallback(Ljava/lang/Object;Ljava/lang/Object;Landroid/os/Handler;)V

    .line 1633
    iget-object v2, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mExtraBinder:Landroid/support/v4/media/session/IMediaSession;

    if-eqz v2, :cond_0

    .line 1634
    invoke-static {p1, p2}, Landroid/support/v4/media/session/MediaControllerCompat$Callback;->access$200(Landroid/support/v4/media/session/MediaControllerCompat$Callback;Landroid/os/Handler;)V

    .line 1635
    new-instance v1, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21$ExtraCallback;

    invoke-direct {v1, p0, p1}, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21$ExtraCallback;-><init>(Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;Landroid/support/v4/media/session/MediaControllerCompat$Callback;)V

    .line 1636
    .local v1, "extraCallback":Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21$ExtraCallback;
    iget-object v2, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mCallbackMap:Ljava/util/HashMap;

    invoke-virtual {v2, p1, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1637
    const/4 v2, 0x1

    iput-boolean v2, p1, Landroid/support/v4/media/session/MediaControllerCompat$Callback;->mHasExtraCallback:Z

    .line 1639
    :try_start_0
    iget-object v2, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mExtraBinder:Landroid/support/v4/media/session/IMediaSession;

    invoke-interface {v2, v1}, Landroid/support/v4/media/session/IMediaSession;->registerCallbackListener(Landroid/support/v4/media/session/IMediaControllerCallback;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1649
    .end local v1    # "extraCallback":Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21$ExtraCallback;
    :goto_0
    return-void

    .line 1640
    .restart local v1    # "extraCallback":Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21$ExtraCallback;
    :catch_0
    move-exception v0

    .line 1641
    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "MediaControllerCompat"

    const-string v3, "Dead object in registerCallback."

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .line 1644
    .end local v0    # "e":Landroid/os/RemoteException;
    .end local v1    # "extraCallback":Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21$ExtraCallback;
    :cond_0
    invoke-static {p1, p2}, Landroid/support/v4/media/session/MediaControllerCompat$Callback;->access$200(Landroid/support/v4/media/session/MediaControllerCompat$Callback;Landroid/os/Handler;)V

    .line 1645
    iget-object v3, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mPendingCallbacks:Ljava/util/List;

    monitor-enter v3

    .line 1646
    :try_start_1
    iget-object v2, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mPendingCallbacks:Ljava/util/List;

    invoke-interface {v2, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1647
    monitor-exit v3

    goto :goto_0

    :catchall_0
    move-exception v2

    monitor-exit v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v2
.end method

.method public removeQueueItem(Landroid/support/v4/media/MediaDescriptionCompat;)V
    .locals 3
    .param p1, "description"    # Landroid/support/v4/media/MediaDescriptionCompat;

    .prologue
    .line 1724
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 1725
    .local v0, "params":Landroid/os/Bundle;
    const-string v1, "android.support.v4.media.session.command.ARGUMENT_MEDIA_DESCRIPTION"

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    .line 1726
    const-string v1, "android.support.v4.media.session.command.REMOVE_QUEUE_ITEM"

    const/4 v2, 0x0

    invoke-virtual {p0, v1, v0, v2}, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->sendCommand(Ljava/lang/String;Landroid/os/Bundle;Landroid/os/ResultReceiver;)V

    .line 1727
    return-void
.end method

.method public removeQueueItemAt(I)V
    .locals 3
    .param p1, "index"    # I

    .prologue
    .line 1731
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 1732
    .local v0, "params":Landroid/os/Bundle;
    const-string v1, "android.support.v4.media.session.command.ARGUMENT_INDEX"

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 1733
    const-string v1, "android.support.v4.media.session.command.REMOVE_QUEUE_ITEM_AT"

    const/4 v2, 0x0

    invoke-virtual {p0, v1, v0, v2}, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->sendCommand(Ljava/lang/String;Landroid/os/Bundle;Landroid/os/ResultReceiver;)V

    .line 1734
    return-void
.end method

.method public sendCommand(Ljava/lang/String;Landroid/os/Bundle;Landroid/os/ResultReceiver;)V
    .locals 1
    .param p1, "command"    # Ljava/lang/String;
    .param p2, "params"    # Landroid/os/Bundle;
    .param p3, "cb"    # Landroid/os/ResultReceiver;

    .prologue
    .line 1815
    iget-object v0, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mControllerObj:Ljava/lang/Object;

    invoke-static {v0, p1, p2, p3}, Landroid/support/v4/media/session/MediaControllerCompatApi21;->sendCommand(Ljava/lang/Object;Ljava/lang/String;Landroid/os/Bundle;Landroid/os/ResultReceiver;)V

    .line 1816
    return-void
.end method

.method public setVolumeTo(II)V
    .locals 1
    .param p1, "value"    # I
    .param p2, "flags"    # I

    .prologue
    .line 1805
    iget-object v0, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mControllerObj:Ljava/lang/Object;

    invoke-static {v0, p1, p2}, Landroid/support/v4/media/session/MediaControllerCompatApi21;->setVolumeTo(Ljava/lang/Object;II)V

    .line 1806
    return-void
.end method

.method public final unregisterCallback(Landroid/support/v4/media/session/MediaControllerCompat$Callback;)V
    .locals 4
    .param p1, "callback"    # Landroid/support/v4/media/session/MediaControllerCompat$Callback;

    .prologue
    .line 1653
    iget-object v2, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mControllerObj:Ljava/lang/Object;

    invoke-static {p1}, Landroid/support/v4/media/session/MediaControllerCompat$Callback;->access$100(Landroid/support/v4/media/session/MediaControllerCompat$Callback;)Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/support/v4/media/session/MediaControllerCompatApi21;->unregisterCallback(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 1654
    iget-object v2, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mExtraBinder:Landroid/support/v4/media/session/IMediaSession;

    if-eqz v2, :cond_1

    .line 1656
    :try_start_0
    iget-object v2, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mCallbackMap:Ljava/util/HashMap;

    invoke-virtual {v2, p1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21$ExtraCallback;

    .line 1657
    .local v1, "extraCallback":Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21$ExtraCallback;
    if-eqz v1, :cond_0

    .line 1658
    iget-object v2, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mExtraBinder:Landroid/support/v4/media/session/IMediaSession;

    invoke-interface {v2, v1}, Landroid/support/v4/media/session/IMediaSession;->unregisterCallbackListener(Landroid/support/v4/media/session/IMediaControllerCallback;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1668
    .end local v1    # "extraCallback":Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21$ExtraCallback;
    :cond_0
    :goto_0
    return-void

    .line 1660
    :catch_0
    move-exception v0

    .line 1661
    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "MediaControllerCompat"

    const-string v3, "Dead object in unregisterCallback."

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .line 1664
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    iget-object v3, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mPendingCallbacks:Ljava/util/List;

    monitor-enter v3

    .line 1665
    :try_start_1
    iget-object v2, p0, Landroid/support/v4/media/session/MediaControllerCompat$MediaControllerImplApi21;->mPendingCallbacks:Ljava/util/List;

    invoke-interface {v2, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    .line 1666
    monitor-exit v3

    goto :goto_0

    :catchall_0
    move-exception v2

    monitor-exit v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v2
.end method
