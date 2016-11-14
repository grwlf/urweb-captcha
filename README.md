Prerequisites
-------------

1. [NIX](http://www.nixos.org/nix) package manager (`nix-build` tool and `nixpkgs` repo)
2. [urweb-build](http://github.com/grwlf/urweb-build) expression set


Installing and running the test
-------------------------------

  1. Make sure you have installed Nix and added `urweb-build` section to the
     contents of `$NIX_PATH` environment variable

  2. Follow the procedure:

         git clone https://github.com/grwlf/urweb-captcha --recursive
         cd urweb-captcha
         nix-build build.nix -A captcha-test

         ./result/mkdb.sh
         ./result/CaptchaTest.exe

         browser http://127.0.0.1:8080/Captcha1/main


Online Demo
-----------

Should be accessible [here](http://sthdwp.com/Captcha1/main)
