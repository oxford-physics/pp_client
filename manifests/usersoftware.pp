class pp_client::usersoftware {
  #Generic SL5/ SL6 list
  $user_package_list_generic = [ 'nedit', 'gnuplot',  'fftw2', 'fftw2-devel', 'gsl', 'gsl-devel', 'gcc-c++', 'ipython', 'numpy', 'scipy',  'hdf5.x86_64', 'hdf5-devel.x86_64', 'libX11-devel', 'libXext-devel', 'compat-libstdc++-33', 'gmp-devel.x86_64', 'dejagnu', 'kmod-openafs',  'cvs',  'openmotif-devel', 'zsh', 'boost-devel', 'lapack', 'subversion', 'gcc-gfortran', 'compat-gcc-34-c++', 'compat-gcc-34-g77',  'pcre.x86_64', 'xrootd-client', 'compat-libstdc++-296', 'blas-devel', 'openldap-clients',  'glibc-devel.x86_64', 'glibc-devel', 'java-1.6.0-openjdk',   'xfig', 'transfig',  'rpm-build', 'ctags', 'cscope', 'gdb', 'glib2-devel','a2ps',  'cmake',  'ncurses-devel', 'db4-devel', 'bison', 'flex', 'libacl-devel', 'librsync-devel', 'expat-devel', 'paw', 'openssl-devel', 'python-imaging', 'tk-devel', 'environment-modules', 'openmpi-devel',  'texinfo', 'latex2html', 'ImageMagick', 'gcc', 'sharutils', 'python-numeric',  'tkinter', 'openmpi', 'unifdef', 'quilt', 'compat-gcc-34',  'python-matplotlib', 'cfitsio-devel', 'perl-Astro-FITS-CFITSIO', 'lapack-devel', 'wxPython-devel', 'libXpm-devel',  'bzr', 'bzip2-devel', 'libXt-devel.x86_64',  'libXaw-devel.x86_64', 'libSM-devel.x86_64',   'ruby', 'ruby-libs', 'python-setuptools', 'mysql', 'mysql-devel', 'libxml2-devel', 'libpng-devel', 'libtiff-devel', 'openldap-devel', 'libgfortran', 'libtool', 'automake', 'autoconf',  'python-devel', 'nsca-client', 'blas', 'libXaw',    'rcs', 'perl-Digest-SHA1', 'perl-Jcode', 'perl-Locale-Maketext-Lexicon', 'perl-Unicode-Map', 'perl-Unicode-Map8', 'perl-Unicode-MapUTF8', 'perl-Unicode-String', 'libSM-devel' ]
 $user_package_list_SL6 = [ "libcurl-devel" , "fftw", "fftw-devel", "aspell","aspell-en" ,  "git", "git-all", "libreoffice" , "libreoffice-langpack-en", "pcre", "libXt-devel",   "gnuplot44", "libXaw-devel"  ]
#notes libre offcie installed
# checkstyle-optional, aspell-de, checkstyle-doc, tetex-xdvi, openoffice.org-impress, pcre.i386, , checkstyle-demo,   checkstyle, checkstyle-javadoc, aspell-de, libXaw-devel.i386, tetex-latex,  tetex-xdvi, tetex-latex, libjpeg-devel
#emi-ui,ca-policy-lcg, HEP_OSlibs_SL5, ca-policy-egi-core, 
#e2fsprogs
  #User software section###
    ensure_packages ( $user_package_list_generic )
    ensure_packages ( $user_package_list_SL6 )


#Modules setup
  file { '/etc/profile.d/zzmodulespath.sh' :
  source  => "puppet:///modules/$module_name/modulespath.sh",
  ensure  => 'present',
  mode    => '0644',
  owner   => 'root',
  group   => 'root',
  }

  file { '/etc/profile.d/zzmodulespath.csh' :
  source  => "puppet:///modules/$module_name/modulespath.csh",
  ensure  => 'present',
  mode    => '0644',
  owner   => 'root',
  group   => 'root',
  }

  file { '/etc/profile.d/zznag.csh' :
  source  => "puppet:///modules/$module_name/nag.csh",
  ensure  => 'present',
  mode    => '0644',
  owner   => 'root',
  group   => 'root',
  }
  file { '/etc/profile.d/zznag.sh' :
  source  => "puppet:///modules/$module_name/nag.sh",
  ensure  => 'present',
  mode    => '0644',
  owner   => 'root',
  group   => 'root',
  }
}
