###
### Start Backup Manager service so Android setup wizard will work after installing gapps
###
    :mod_backup_try_start
    const-string v5, "SystemServer"

    const-string v9, "Backup Service"

    invoke-static {v5, v9}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 334
    const-string v5, "backup"

    new-instance v9, Lcom/android/server/BackupManagerService;

    invoke-direct {v9, v6}, Lcom/android/server/BackupManagerService;-><init>(Landroid/content/Context;)V

    invoke-static {v5, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :mod_backup_try_end
    .catch Ljava/lang/Throwable; {:mod_backup_try_start .. :mod_backup_try_end} :mod_backup_catch

    goto/16 :mod_backup_end

    :mod_backup_catch

    move-exception v5

    move-object/from16 v27, v5

    .restart local v27       #e:Ljava/lang/Throwable;
    const-string v5, "SystemServer"

    const-string v9, "Failure starting Backup Service"

    move-object v0, v5

    move-object v1, v9

    move-object/from16 v2, v27

    invoke-static {v0, v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :mod_backup_end
###
