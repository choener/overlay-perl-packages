self: super: rec {

  perlPackages = super.perlPackages //
    { inherit StatisticsR;
      inherit DataStag;
      inherit BioPerl;
    };

  StatisticsR = super.buildPerlPackage rec {
    name = "Statistics-R-0.34";
    src = super.fetchurl {
      url = "mirror://cpan/authors/id/F/FA/FANGLY/${name}.tar.gz";
      sha256 = "782dd064876ac94680d97899f24fb0e727df42c05ba474ec096a9116438fbed4";
    };
    propagatedBuildInputs = [ self.perlPackages.IPCRun self.perlPackages.RegexpCommon ];
    nativeBuildInputs = [ self.R ];
    meta = {
      homepage = http://search.cpan.org/search?query=statistics%3A%3AR&mode=dist;
      description = "Perl interface with the R statistical program";
      license = with super.stdenv.lib.licenses; [ artistic1 gpl1Plus ];
    };
    doCheck = false;
  };
  DataStag = super.buildPerlPackage rec {
    name = "Data-Stag-0.14";
    src = super.fetchurl {
      url = "mirror://cpan/authors/id/C/CM/CMUNGALL/${name}.tar.gz";
      sha256 = "4ab122508d2fb86d171a15f4006e5cf896d5facfa65219c0b243a89906258e59";
    };
    propagatedBuildInputs = [ self.perlPackages.IOString ];
    meta = {
      description = "Structured Tags";
      license = super.stdenv.lib.licenses.unknown;
    };
    doCheck = false;
  };
  BioPerl = super.perlPackages.buildPerlModule rec {
    name = "BioPerl-1.007002";
    src = super.fetchurl {
      url = "mirror://cpan/authors/id/C/CJ/CJFIELDS/${name}.tar.gz";
      sha256 = "17aa3aaab2f381bbcaffdc370002eaf28f2c341b538068d6586b2276a76464a1";
    };
    buildInputs = with self.perlPackages; [ ModuleBuild TestMost URI ];
    propagatedBuildInputs = [ DataStag self.perlPackages.IOString ];
    meta = {
      description = "Bioinformatics Toolkit";
      license = with super.stdenv.lib.licenses; [ artistic1 gpl1Plus ];
    };
    doCheck = false;
  };
}
