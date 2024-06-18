.class Lcom/example/a11x256/frida_test/my_activity$2$1;
.super Ljava/lang/Object;
.source "my_activity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/example/a11x256/frida_test/my_activity$2;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/example/a11x256/frida_test/my_activity$2;

.field final synthetic val$text:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/example/a11x256/frida_test/my_activity$2;Ljava/lang/String;)V
    .locals 0
    .param p1, "this$1"    # Lcom/example/a11x256/frida_test/my_activity$2;

    .prologue
    .line 67
    iput-object p1, p0, Lcom/example/a11x256/frida_test/my_activity$2$1;->this$1:Lcom/example/a11x256/frida_test/my_activity$2;

    iput-object p2, p0, Lcom/example/a11x256/frida_test/my_activity$2$1;->val$text:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 70
    iget-object v0, p0, Lcom/example/a11x256/frida_test/my_activity$2$1;->this$1:Lcom/example/a11x256/frida_test/my_activity$2;

    iget-object v0, v0, Lcom/example/a11x256/frida_test/my_activity$2;->this$0:Lcom/example/a11x256/frida_test/my_activity;

    const v1, 0x7f0b0061

    invoke-virtual {v0, v1}, Lcom/example/a11x256/frida_test/my_activity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iget-object v1, p0, Lcom/example/a11x256/frida_test/my_activity$2$1;->val$text:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 71
    iget-object v0, p0, Lcom/example/a11x256/frida_test/my_activity$2$1;->this$1:Lcom/example/a11x256/frida_test/my_activity$2;

    iget-object v0, v0, Lcom/example/a11x256/frida_test/my_activity$2;->this$0:Lcom/example/a11x256/frida_test/my_activity;

    iget-object v1, p0, Lcom/example/a11x256/frida_test/my_activity$2$1;->val$text:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/example/a11x256/frida_test/my_activity;->dec(Ljava/lang/String;)Ljava/lang/String;

    .line 72
    return-void
.end method
