.method public getDeviceId()Ljava/lang/String;
    .locals 5

    .prologue

    .line 191
    const-string v0, "35828001"

    .line 192
    .local v0, fakeDevId:Ljava/lang/String;
    new-instance v1, Ljava/util/Random;
 
    invoke-direct {v1}, Ljava/util/Random;-><init>()V
 
    .line 193
    .local v1, randomGenerator:Ljava/util/Random;
    new-instance v2, Ljava/lang/StringBuilder;
 
    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V
 
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
 
    move-result-object v2
 
    const v3, 0xf4240
 
    invoke-virtual {v1, v3}, Ljava/util/Random;->nextInt(I)I

    move-result v3
 
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
 
    move-result-object v2
 
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
 
    move-result-object v0

    .line 203
    const-string v2, "TAG_CWX"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Generated:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "."

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 204
    return-object v0
.end method
