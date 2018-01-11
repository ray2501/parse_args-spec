%{!?directory:%define directory /usr}

%define buildroot %{_tmppath}/%{name}

Name:          parse_args
Summary:       A fast argument parser for Tcl
Version:       0.3
Release:       0
License:       Tcl
Group:         Development/Libraries/Tcl
Source:        %{name}-%{version}.tar.gz
Patch0:        makefile.patch
URL:           https://github.com/RubyLane/parse_args
BuildRequires: autoconf
BuildRequires: make
BuildRequires: tcl-devel >= 8.5
Requires:      tcl >= 8.5
BuildRoot:     %{buildroot}

%description
A fast argument parser based on the patterns established by
core Tcl commands like [lsort], [lsearch], [glob], [regex], etc.

%prep
%setup -q -n %{name}-%{version}
%patch0

%build
autoconf
./configure \
	--prefix=%{directory} \
	--exec-prefix=%{directory} \
	--libdir=%{directory}/%{_lib}
make 

%install
make DESTDIR=%{buildroot} pkglibdir=%{tcl_archdir}/%{name}%{version} install

%clean
rm -rf %buildroot

%files
%defattr(-,root,root)
%{tcl_archdir}

