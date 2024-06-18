.class Lcom/example/a11x256/frida_test/my_activity$2;
.super Ljava/lang/Object;
.source "my_activity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/example/a11x256/frida_test/my_activity;->send_data(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/example/a11x256/frida_test/my_activity;

.field final synthetic val$conn:Ljava/net/HttpURLConnection;

.field final synthetic val$data:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/example/a11x256/frida_test/my_activity;Ljava/net/HttpURLConnection;Ljava/lang/String;)V
    .locals 0
    .param p1, "this$0"    # Lcom/example/a11x256/frida_test/my_activity;

    .prologue
    .line 59
    iput-object p1, p0, Lcom/example/a11x256/frida_test/my_activity$2;->this$0:Lcom/example/a11x256/frida_test/my_activity;

    iput-object p2, p0, Lcom/example/a11x256/frida_test/my_activity$2;->val$conn:Ljava/net/HttpURLConnection;

    iput-object p3, p0, Lcom/example/a11x256/frida_test/my_activity$2;->val$data:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    .prologue
    .line 63
    :try_start_0
    new-instance v2, Ljava/io/DataOutputStream;

    iget-object v4, p0, Lcom/example/a11x256/frida_test/my_activity$2;->val$conn:Ljava/net/HttpURLConnection;

    invoke-virtual {v4}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v4

    invoke-direct {v2, v4}, Ljava/io/DataOutputStream;-><init>(Ljava/io/OutputStream;)V

    .line 64
    .local v2, "out":Ljava/io/DataOutputStream;
    iget-object v4, p0, Lcom/example/a11x256/frida_test/my_activity$2;->this$0:Lcom/example/a11x256/frida_test/my_activity;

    iget-object v5, p0, Lcom/example/a11x256/frida_test/my_activity$2;->val$data:Ljava/lang/String;

    invoke-virtual {v4, v5}, Lcom/example/a11x256/frida_test/my_activity;->enc(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/io/DataOutputStream;->writeBytes(Ljava/lang/String;)V

    .line 65
    new-instance v1, Ljava/io/BufferedReader;

    new-instance v4, Ljava/io/InputStreamReader;

    iget-object v5, p0, Lcom/example/a11x256/frida_test/my_activity$2;->val$conn:Ljava/net/HttpURLConnection;

    invoke-virtual {v5}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    invoke-direct {v1, v4}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 66
    .local v1, "in":Ljava/io/BufferedReader;
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v3

    .line 67
    .local v3, "text":Ljava/lang/String;
    iget-object v4, p0, Lcom/example/a11x256/frida_test/my_activity$2;->this$0:Lcom/example/a11x256/frida_test/my_activity;

    new-instance v5, Lcom/example/a11x256/frida_test/my_activity$2$1;

    invoke-direct {v5, p0, v3}, Lcom/example/a11x256/frida_test/my_activity$2$1;-><init>(Lcom/example/a11x256/frida_test/my_activity$2;Ljava/lang/String;)V

    invoke-virtual {v4, v5}, Lcom/example/a11x256/frida_test/my_activity;->runOnUiThread(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 77
    .end local v1    # "in":Ljava/io/BufferedReader;
    .end local v2    # "out":Ljava/io/DataOutputStream;
    .end local v3    # "text":Ljava/lang/String;
    :goto_0
    return-void

    .line 74
    :catch_0
    move-exception v0

    .line 75
    .local v0, "e":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0
.end method
