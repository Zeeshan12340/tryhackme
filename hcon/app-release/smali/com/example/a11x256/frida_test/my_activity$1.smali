.class Lcom/example/a11x256/frida_test/my_activity$1;
.super Ljava/lang/Object;
.source "my_activity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/example/a11x256/frida_test/my_activity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/example/a11x256/frida_test/my_activity;


# direct methods
.method constructor <init>(Lcom/example/a11x256/frida_test/my_activity;)V
    .locals 0
    .param p1, "this$0"    # Lcom/example/a11x256/frida_test/my_activity;

    .prologue
    .line 43
    iput-object p1, p0, Lcom/example/a11x256/frida_test/my_activity$1;->this$0:Lcom/example/a11x256/frida_test/my_activity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 46
    iget-object v0, p0, Lcom/example/a11x256/frida_test/my_activity$1;->this$0:Lcom/example/a11x256/frida_test/my_activity;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/example/a11x256/frida_test/my_activity$1;->this$0:Lcom/example/a11x256/frida_test/my_activity;

    iget-object v2, v2, Lcom/example/a11x256/frida_test/my_activity;->username_et:Landroid/widget/EditText;

    invoke-virtual {v2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ":"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/example/a11x256/frida_test/my_activity$1;->this$0:Lcom/example/a11x256/frida_test/my_activity;

    iget-object v2, v2, Lcom/example/a11x256/frida_test/my_activity;->password_et:Landroid/widget/EditText;

    invoke-virtual {v2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/example/a11x256/frida_test/my_activity;->send_data(Ljava/lang/String;)V

    .line 47
    return-void
.end method
