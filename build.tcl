#!/usr/bin/tclsh

set arch "x86_64"
set base "parse_args-0.3.2"

if {[file exists $base]} {
    file delete -force $base
}

set var [list git clone https://github.com/RubyLane/parse_args.git $base]
exec >@stdout 2>@stderr {*}$var

cd $base

set var2 [list git checkout 887774eceb2fb14b7db9df91974e8ec081203707]
exec >@stdout 2>@stderr {*}$var2

set var2 [list git reset --hard]
exec >@stdout 2>@stderr {*}$var2

file delete -force .git

cd ..

if {[file exists $base]} {
    file delete -force $base/.git
}

set var2 [list tar czvf ${base}.tar.gz $base]
exec >@stdout 2>@stderr {*}$var2

if {[file exists build]} {
    file delete -force build
}

file mkdir build/BUILD build/RPMS build/SOURCES build/SPECS build/SRPMS
file copy -force $base.tar.gz build/SOURCES
file copy -force makefile.patch build/SOURCES

set buildit [list rpmbuild --target $arch --define "_topdir [pwd]/build" -bb parse_args.spec]
exec >@stdout 2>@stderr {*}$buildit

# Remove our source code
file delete -force $base
file delete -force $base.tar.gz

