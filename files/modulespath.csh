test  -f /etc/lsb-release &&  grep precise /etc/lsb-release >/dev/null && set DIST=ubuntu_precise
test  -f /etc/issue &&  grep "Scientific Linux release 6" /etc/issue > /dev/null && set DIST=el6
test  -f /etc/issue && grep "Red Hat Enterprise Linux Server release 6" /etc/issue > /dev/null && set DIST=el6
setenv DIST $DIST
#prepends to module path, so use in reverse order
set CURPATH=/network/software/modules
test -d $CURPATH && setenv MODULEPATH ${CURPATH}:${MODULEPATH}
set CURPATH=/network/software/el6/arc/modules-tested
test -d $CURPATH && setenv MODULEPATH ${CURPATH}:${MODULEPATH}
set CURPATH=/network/software/linux-x86_64/arc/modules-tested
test -d $CURPATH && setenv MODULEPATH ${CURPATH}:${MODULEPATH}
set CURPATH=/network/software/linux-x86_64/modules
test -d $CURPATH && setenv MODULEPATH ${CURPATH}:${MODULEPATH}
if ($?DIST) then
     set CURPATH=/network/software/$DIST/modules
     test -d $CURPATH && setenv MODULEPATH ${CURPATH}:${MODULEPATH}
endif

set CURPATH=/local/software/modules
test -d $CURPATH && setenv MODULEPATH ${CURPATH}:${MODULEPATH}

setenv PROFILESOURCED 1

