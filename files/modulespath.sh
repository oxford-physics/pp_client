DIST=''
test  -f /etc/lsb-release && grep precise /etc/lsb-release >/dev/null && DIST=ubuntu_precise
test  -f /etc/issue && grep "Scientific Linux release 6" /etc/issue > /dev/null && DIST=el6
test  -f /etc/issue && grep "Red Hat Enterprise Linux Server release 6" /etc/issue > /dev/null && DIST=el6
export DIST

#prepends to module path, so use in reverse order
module use /network/software/modules
test -d  /network/software/linux-x86_64/arc/modules-tested && module use /network/software/linux-x86_64/arc/modules-tested

if [[ $DIST ]]; then
#   export MODULEPATH=$MODULEPATH:/local/software/modules:/network/software/$DIST/modules:/network/software/modules
   module use /network/software/$DIST/modules
fi
test -d /local/software/modules && module use /local/software/modules

