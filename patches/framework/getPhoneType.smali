.method public getPhoneType()I
    .locals 2

    .prologue

    .line 318
    const-string v0, "CLOCKWORX"
 
    const-string v1, "Returning 1."
 
    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 319
    const/4 v0, 0x1
    
    return v0
.end method
