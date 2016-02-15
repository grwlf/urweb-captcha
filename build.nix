{ libraries ? {}
, pkgs ? import <nixpkgs> {}
, uwb ? import <urweb-build> {inherit libraries pkgs;}
} :


let

  libcaptcha = pkgs.stdenv.mkDerivation {
    name = "libcaptcha";
    src = ./lib/captcha;
    buildCommand = ''
      . $stdenv/setup
      export PATH="$PATH:${pkgs.imagemagick}/bin/"
      cp -r $src/* .
      ls -l
      make
      cp libcaptcha.a $out
    '';
  };

in

with uwb;
rec {

  captcha = mkLib {

    name = "Captcha";

    statements = [
      (sys "list")
      (ffi ./Captcha_ffi.urs)
      (include ./Captcha_ffi.h)
      (obj-c ./Captcha_ffi.c)
      (link libcaptcha)
      (src1 ./Captcha.ur)
    ];
  };

  tests = [(
    mkExe {
      name = "CaptchaTest";
      dbms = "sqlite";

      libraries = {
        inherit captcha;
      };

      statements = [
        (rule "safeGet Captcha1/captcha_show")
        (rule "safeGet Captcha1/main")
        (rule "allow mime image/gif")
        (sys "list")
        (sys "char")
        (sys "string")
        (src1 ./test/Captcha1.ur)
      ];
    }
  )];

}


