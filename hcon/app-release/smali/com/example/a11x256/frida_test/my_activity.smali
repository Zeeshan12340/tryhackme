.class public Lcom/example/a11x256/frida_test/my_activity;
.super Landroid/support/v7/app/AppCompatActivity;
.source "my_activity.java"


# instance fields
.field conn:Ljava/net/HttpURLConnection;

.field message_tv:Landroid/widget/TextView;

.field password_et:Landroid/widget/EditText;

.field username_et:Landroid/widget/EditText;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0}, Landroid/support/v7/app/AppCompatActivity;-><init>()V

    return-void
.end method


# virtual methods
.method dec(Ljava/lang/String;)Ljava/lang/String;
    .locals 10
    .param p1, "data"    # Ljava/lang/String;

    .prologue
    .line 118
    :try_start_0
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v6

    const/4 v7, 0x0

    invoke-static {v6, v7}, Landroid/util/Base64;->decode([BI)[B

    move-result-object v0

    .line 119
    .local v0, "decoded_data":[B
    const-string v5, "SEARCHTHESECRETKEY"

    .line 120
    .local v5, "pre_shared_key":Ljava/lang/String;
    const-string v2, "SEARCHTHESECRETIV"

    .line 121
    .local v2, "generated_iv":Ljava/lang/String;
    const-string v6, "AES/CBC/PKCS5PADDING"

    invoke-static {v6}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;)Ljavax/crypto/Cipher;

    move-result-object v3

    .line 122
    .local v3, "my_cipher":Ljavax/crypto/Cipher;
    const/4 v6, 0x2

    new-instance v7, Ljavax/crypto/spec/SecretKeySpec;

    const-string v8, "UTF-8"

    invoke-virtual {v5, v8}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v8

    const-string v9, "AES"

    invoke-direct {v7, v8, v9}, Ljavax/crypto/spec/SecretKeySpec;-><init>([BLjava/lang/String;)V

    new-instance v8, Ljavax/crypto/spec/IvParameterSpec;

    const-string v9, "UTF-8"

    invoke-virtual {v2, v9}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v9

    invoke-direct {v8, v9}, Ljavax/crypto/spec/IvParameterSpec;-><init>([B)V

    invoke-virtual {v3, v6, v7, v8}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;Ljava/security/spec/AlgorithmParameterSpec;)V

    .line 123
    new-instance v4, Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljavax/crypto/Cipher;->doFinal([B)[B

    move-result-object v6

    invoke-direct {v4, v6}, Ljava/lang/String;-><init>([B)V
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljavax/crypto/NoSuchPaddingException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/security/InvalidAlgorithmParameterException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljavax/crypto/BadPaddingException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Ljavax/crypto/IllegalBlockSizeException; {:try_start_0 .. :try_end_0} :catch_6

    .line 140
    .end local v0    # "decoded_data":[B
    .end local v2    # "generated_iv":Ljava/lang/String;
    .end local v3    # "my_cipher":Ljavax/crypto/Cipher;
    .end local v5    # "pre_shared_key":Ljava/lang/String;
    :goto_0
    return-object v4

    .line 125
    :catch_0
    move-exception v1

    .line 126
    .local v1, "e":Ljava/io/UnsupportedEncodingException;
    invoke-virtual {v1}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    .line 140
    .end local v1    # "e":Ljava/io/UnsupportedEncodingException;
    :goto_1
    const-string v4, ""

    goto :goto_0

    .line 127
    :catch_1
    move-exception v1

    .line 128
    .local v1, "e":Ljavax/crypto/NoSuchPaddingException;
    invoke-virtual {v1}, Ljavax/crypto/NoSuchPaddingException;->printStackTrace()V

    goto :goto_1

    .line 129
    .end local v1    # "e":Ljavax/crypto/NoSuchPaddingException;
    :catch_2
    move-exception v1

    .line 130
    .local v1, "e":Ljava/security/InvalidAlgorithmParameterException;
    invoke-virtual {v1}, Ljava/security/InvalidAlgorithmParameterException;->printStackTrace()V

    goto :goto_1

    .line 131
    .end local v1    # "e":Ljava/security/InvalidAlgorithmParameterException;
    :catch_3
    move-exception v1

    .line 132
    .local v1, "e":Ljava/security/NoSuchAlgorithmException;
    invoke-virtual {v1}, Ljava/security/NoSuchAlgorithmException;->printStackTrace()V

    goto :goto_1

    .line 133
    .end local v1    # "e":Ljava/security/NoSuchAlgorithmException;
    :catch_4
    move-exception v1

    .line 134
    .local v1, "e":Ljava/security/InvalidKeyException;
    invoke-virtual {v1}, Ljava/security/InvalidKeyException;->printStackTrace()V

    goto :goto_1

    .line 135
    .end local v1    # "e":Ljava/security/InvalidKeyException;
    :catch_5
    move-exception v1

    .line 136
    .local v1, "e":Ljavax/crypto/BadPaddingException;
    invoke-virtual {v1}, Ljavax/crypto/BadPaddingException;->printStackTrace()V

    goto :goto_1

    .line 137
    .end local v1    # "e":Ljavax/crypto/BadPaddingException;
    :catch_6
    move-exception v1

    .line 138
    .local v1, "e":Ljavax/crypto/IllegalBlockSizeException;
    invoke-virtual {v1}, Ljavax/crypto/IllegalBlockSizeException;->printStackTrace()V

    goto :goto_1
.end method

.method enc(Ljava/lang/String;)Ljava/lang/String;
    .locals 9
    .param p1, "data"    # Ljava/lang/String;

    .prologue
    .line 90
    :try_start_0
    const-string v3, "SEARCHTHESECRETKEY"

    .line 91
    .local v3, "pre_shared_key":Ljava/lang/String;
    const-string v1, "SEARCHTHESECRETIV"

    .line 92
    .local v1, "generated_iv":Ljava/lang/String;
    const-string v5, "AES/CBC/PKCS5PADDING"

    invoke-static {v5}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;)Ljavax/crypto/Cipher;

    move-result-object v2

    .line 93
    .local v2, "my_cipher":Ljavax/crypto/Cipher;
    const/4 v5, 0x1

    new-instance v6, Ljavax/crypto/spec/SecretKeySpec;

    const-string v7, "UTF-8"

    invoke-virtual {v3, v7}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v7

    const-string v8, "AES"

    invoke-direct {v6, v7, v8}, Ljavax/crypto/spec/SecretKeySpec;-><init>([BLjava/lang/String;)V

    new-instance v7, Ljavax/crypto/spec/IvParameterSpec;

    const-string v8, "UTF-8"

    invoke-virtual {v1, v8}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v8

    invoke-direct {v7, v8}, Ljavax/crypto/spec/IvParameterSpec;-><init>([B)V

    invoke-virtual {v2, v5, v6, v7}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;Ljava/security/spec/AlgorithmParameterSpec;)V

    .line 94
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v5

    invoke-virtual {v2, v5}, Ljavax/crypto/Cipher;->doFinal([B)[B

    move-result-object v4

    .line 96
    .local v4, "x":[B
    sget-object v5, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v6, Ljava/lang/String;

    const/4 v7, 0x0

    invoke-static {v4, v7}, Landroid/util/Base64;->encode([BI)[B

    move-result-object v7

    invoke-direct {v6, v7}, Ljava/lang/String;-><init>([B)V

    invoke-virtual {v5, v6}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 97
    new-instance v5, Ljava/lang/String;

    const/4 v6, 0x0

    invoke-static {v4, v6}, Landroid/util/Base64;->encode([BI)[B

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/lang/String;-><init>([B)V
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/security/InvalidAlgorithmParameterException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljavax/crypto/NoSuchPaddingException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljavax/crypto/BadPaddingException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Ljavax/crypto/IllegalBlockSizeException; {:try_start_0 .. :try_end_0} :catch_6

    .line 113
    .end local v1    # "generated_iv":Ljava/lang/String;
    .end local v2    # "my_cipher":Ljavax/crypto/Cipher;
    .end local v3    # "pre_shared_key":Ljava/lang/String;
    .end local v4    # "x":[B
    :goto_0
    return-object v5

    .line 98
    :catch_0
    move-exception v0

    .line 99
    .local v0, "e":Ljava/security/NoSuchAlgorithmException;
    invoke-virtual {v0}, Ljava/security/NoSuchAlgorithmException;->printStackTrace()V

    .line 113
    .end local v0    # "e":Ljava/security/NoSuchAlgorithmException;
    :goto_1
    const/4 v5, 0x0

    goto :goto_0

    .line 100
    :catch_1
    move-exception v0

    .line 101
    .local v0, "e":Ljava/security/InvalidKeyException;
    invoke-virtual {v0}, Ljava/security/InvalidKeyException;->printStackTrace()V

    goto :goto_1

    .line 102
    .end local v0    # "e":Ljava/security/InvalidKeyException;
    :catch_2
    move-exception v0

    .line 103
    .local v0, "e":Ljava/security/InvalidAlgorithmParameterException;
    invoke-virtual {v0}, Ljava/security/InvalidAlgorithmParameterException;->printStackTrace()V

    goto :goto_1

    .line 104
    .end local v0    # "e":Ljava/security/InvalidAlgorithmParameterException;
    :catch_3
    move-exception v0

    .line 105
    .local v0, "e":Ljavax/crypto/NoSuchPaddingException;
    invoke-virtual {v0}, Ljavax/crypto/NoSuchPaddingException;->printStackTrace()V

    goto :goto_1

    .line 106
    .end local v0    # "e":Ljavax/crypto/NoSuchPaddingException;
    :catch_4
    move-exception v0

    .line 107
    .local v0, "e":Ljavax/crypto/BadPaddingException;
    invoke-virtual {v0}, Ljavax/crypto/BadPaddingException;->printStackTrace()V

    goto :goto_1

    .line 108
    .end local v0    # "e":Ljavax/crypto/BadPaddingException;
    :catch_5
    move-exception v0

    .line 109
    .local v0, "e":Ljava/io/UnsupportedEncodingException;
    invoke-virtual {v0}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    goto :goto_1

    .line 110
    .end local v0    # "e":Ljava/io/UnsupportedEncodingException;
    :catch_6
    move-exception v0

    .line 111
    .local v0, "e":Ljavax/crypto/IllegalBlockSizeException;
    invoke-virtual {v0}, Ljavax/crypto/IllegalBlockSizeException;->printStackTrace()V

    goto :goto_1
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 38
    invoke-super {p0, p1}, Landroid/support/v7/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V

    .line 39
    const v0, 0x7f04001b

    invoke-virtual {p0, v0}, Lcom/example/a11x256/frida_test/my_activity;->setContentView(I)V

    .line 40
    const v0, 0x7f0b0061

    invoke-virtual {p0, v0}, Lcom/example/a11x256/frida_test/my_activity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/example/a11x256/frida_test/my_activity;->message_tv:Landroid/widget/TextView;

    .line 41
    const v0, 0x7f0b005e

    invoke-virtual {p0, v0}, Lcom/example/a11x256/frida_test/my_activity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/example/a11x256/frida_test/my_activity;->username_et:Landroid/widget/EditText;

    .line 42
    const v0, 0x7f0b005f

    invoke-virtual {p0, v0}, Lcom/example/a11x256/frida_test/my_activity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/example/a11x256/frida_test/my_activity;->password_et:Landroid/widget/EditText;

    .line 43
    const v0, 0x7f0b0060

    invoke-virtual {p0, v0}, Lcom/example/a11x256/frida_test/my_activity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    new-instance v1, Lcom/example/a11x256/frida_test/my_activity$1;

    invoke-direct {v1, p0}, Lcom/example/a11x256/frida_test/my_activity$1;-><init>(Lcom/example/a11x256/frida_test/my_activity;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 50
    return-void
.end method

.method send_data(Ljava/lang/String;)V
    .locals 6
    .param p1, "data"    # Ljava/lang/String;

    .prologue
    .line 53
    const/4 v2, 0x0

    .line 55
    .local v2, "url":Ljava/net/URL;
    :try_start_0
    new-instance v3, Ljava/net/URL;

    const-string v4, "http://192.168.85.131:8080"

    invoke-direct {v3, v4}, Ljava/net/URL;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/net/MalformedURLException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    .line 56
    .end local v2    # "url":Ljava/net/URL;
    .local v3, "url":Ljava/net/URL;
    :try_start_1
    invoke-virtual {v3}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v0

    check-cast v0, Ljava/net/HttpURLConnection;

    .line 57
    .local v0, "conn":Ljava/net/HttpURLConnection;
    const-string v4, "POST"

    invoke-virtual {v0, v4}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    .line 58
    const/4 v4, 0x1

    invoke-virtual {v0, v4}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V

    .line 59
    new-instance v4, Ljava/lang/Thread;

    new-instance v5, Lcom/example/a11x256/frida_test/my_activity$2;

    invoke-direct {v5, p0, v0, p1}, Lcom/example/a11x256/frida_test/my_activity$2;-><init>(Lcom/example/a11x256/frida_test/my_activity;Ljava/net/HttpURLConnection;Ljava/lang/String;)V

    invoke-direct {v4, v5}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 78
    invoke-virtual {v4}, Ljava/lang/Thread;->start()V
    :try_end_1
    .catch Ljava/net/MalformedURLException; {:try_start_1 .. :try_end_1} :catch_3
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_2

    move-object v2, v3

    .line 86
    .end local v0    # "conn":Ljava/net/HttpURLConnection;
    .end local v3    # "url":Ljava/net/URL;
    .restart local v2    # "url":Ljava/net/URL;
    :goto_0
    return-void

    .line 80
    :catch_0
    move-exception v1

    .line 81
    .local v1, "e":Ljava/net/MalformedURLException;
    :goto_1
    invoke-virtual {v1}, Ljava/net/MalformedURLException;->printStackTrace()V

    goto :goto_0

    .line 82
    .end local v1    # "e":Ljava/net/MalformedURLException;
    :catch_1
    move-exception v1

    .line 83
    .local v1, "e":Ljava/io/IOException;
    :goto_2
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0

    .line 82
    .end local v1    # "e":Ljava/io/IOException;
    .end local v2    # "url":Ljava/net/URL;
    .restart local v3    # "url":Ljava/net/URL;
    :catch_2
    move-exception v1

    move-object v2, v3

    .end local v3    # "url":Ljava/net/URL;
    .restart local v2    # "url":Ljava/net/URL;
    goto :goto_2

    .line 80
    .end local v2    # "url":Ljava/net/URL;
    .restart local v3    # "url":Ljava/net/URL;
    :catch_3
    move-exception v1

    move-object v2, v3

    .end local v3    # "url":Ljava/net/URL;
    .restart local v2    # "url":Ljava/net/URL;
    goto :goto_1
.end method
