/\.field private static final TAG:Ljava\/lang\/String; = \"TelephonyManager\"$/ {print; while (getline < (pdir "/CLOCKWORX.smali")) print; next}
/^\.method public getDeviceId\(/ {while (getline < (pdir "/getDeviceId.smali")) print; inBlock=1; next}
/^\.method public getPhoneType\(/ {while (getline < (pdir "/getPhoneType.smali")) print; inBlock=1; next}
/^\.end method/ && inBlock {inBlock=0; next}
inBlock {next}
/CLOCKWORX/ {next} # remove old patches outside methods so repatching will work
{print}
