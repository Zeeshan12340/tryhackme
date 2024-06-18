.class public Lcom/example/ctf1/MainActivity;
.super Landroidx/appcompat/app/AppCompatActivity;
.source "MainActivity.java"


# instance fields
.field private button:Landroid/widget/Button;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 10
    invoke-direct {p0}, Landroidx/appcompat/app/AppCompatActivity;-><init>()V

    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 15
    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V

    .line 16
    const v0, 0x7f09001c

    invoke-virtual {p0, v0}, Lcom/example/ctf1/MainActivity;->setContentView(I)V

    .line 18
    const v0, 0x7f070022

    invoke-virtual {p0, v0}, Lcom/example/ctf1/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/example/ctf1/MainActivity;->button:Landroid/widget/Button;

    .line 19
    iget-object v0, p0, Lcom/example/ctf1/MainActivity;->button:Landroid/widget/Button;

    new-instance v1, Lcom/example/ctf1/MainActivity$1;

    invoke-direct {v1, p0}, Lcom/example/ctf1/MainActivity$1;-><init>(Lcom/example/ctf1/MainActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 25
    return-void
.end method

.method public openActivity2()V
    .locals 2

    .line 27
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/example/ctf1/Main2Activity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 28
    .local v0, "intent":Landroid/content/Intent;
    invoke-virtual {p0, v0}, Lcom/example/ctf1/MainActivity;->startActivity(Landroid/content/Intent;)V

    .line 29
    return-void
.end method
