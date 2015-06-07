{-# LANGUAGE ScopedTypeVariables #-}
module Cake_Captcha where

import Development.Cake3
import Development.Cake3.Ext.UrWeb
import Cake_Captcha_P

lib = uwlib (file "lib.urp") $ do
  [libcaptcha] <- liftMake $ externalMake (file "lib/captcha/libcaptcha.a")
  ffi (file "Captcha.urs")
  include (file "Captcha.h")
  src (file "Captcha.c")
  link libcaptcha

(test, test_db) = uwapp_postgres (file "test/Captcha1.urp") $ do
  library lib
  safeGet "Captcha1/captcha_show"
  safeGet "Captcha1/main"
  allow mime "image/gif"
  ur (sys "list")
  ur (sys "char")
  ur (sys "string")
  ur (file "test/Captcha1.ur")

main = writeDefaultMakefiles $ do
  prebuild [cmd| for l in lib/*;  do test -f $$$$l/.git || { echo $$$$l is empty. Have you forgot to 'git submodule update --init' ? ; exit 1; }; done |]

  rule $ do
    phony "lib"
    depend lib

  rule $ do
    phony "test"
    depend test
    depend test_db

  rule $ do
    phony "all"
    depend test
    depend test_db

