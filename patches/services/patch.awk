/    :goto_/  { if ((getline tmp1) > 0) {
                  print $0
                  lines = 1
                  if (substr(tmp1,1,14) == "    :try_start") {
                    lines = 2
                    if ((getline tmp2) > 0 && tmp2 == "    const-string v5, \"SystemServer\"") {
                      lines = 3
                      if ((getline tmp3) > 0 && tmp3 == "") {
                        lines = 4
                        if ((getline tmp4) > 0){
                          if (tmp4 == "    const-string v9, \"AppWidget Service\"") {
                            while (getline < (pdir "/StartBackupManager.smali")) print;
                          } else if (tmp4 == "    const-string v9, \"Backup Service\"") {
                            lines = 0;
                            while ((getline tmp) > 0 && substr(tmp,1,10) != "    :goto_") { }
                            while (getline < (pdir "/StartBackupManager.smali")) print;
                          }
                        }
                      }
                    }
                  }
                  if (lines > 0) print tmp1
                  if (lines > 1) print tmp2
                  if (lines > 2) print tmp3
                  if (lines > 3) print tmp4
                } else {
                  print $0
                }
                next
              }
{print}