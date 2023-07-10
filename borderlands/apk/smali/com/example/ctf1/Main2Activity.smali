.class public Lcom/example/ctf1/Main2Activity;
.super Landroidx/appcompat/app/AppCompatActivity;
.source "Main2Activity.java"


# instance fields
.field apiKey:Ljava/lang/String;

.field apiPath:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 8
    invoke-direct {p0}, Landroidx/appcompat/app/AppCompatActivity;-><init>()V

    return-void
.end method


# virtual methods
.method protected decrypt(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "encrypted_key"    # Ljava/lang/String;
    .param p2, "encryption_key"    # Ljava/lang/String;

    .line 23
    const-string v0, "NOT_IMPLEMENTED"

    return-object v0
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 14
    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V

    .line 15
    const v0, 0x7f09001d

    invoke-virtual {p0, v0}, Lcom/example/ctf1/Main2Activity;->setContentView(I)V

    .line 17
    const v0, 0x7f0b0028

    invoke-virtual {p0, v0}, Lcom/example/ctf1/Main2Activity;->getString(I)Ljava/lang/String;

    move-result-object v0

    const-string v1, "#TODO"

    invoke-virtual {p0, v0, v1}, Lcom/example/ctf1/Main2Activity;->decrypt(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/example/ctf1/Main2Activity;->apiKey:Ljava/lang/String;

    .line 18
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "/api.php?documentid={}&apikey="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/example/ctf1/Main2Activity;->apiKey:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/example/ctf1/Main2Activity;->apiPath:Ljava/lang/String;

    .line 19
    return-void
.end method
