{-# LANGUAGE ScopedTypeVariables #-}
module Cake_Captcha where

import Development.Cake3
import Development.Cake3.Ext.UrWeb
import Cake_Captcha_P

captchamake = rule $ do
  shell [cmd| git -C $(cwd) submodule update --init |]
  shell [cmd| git -C $(cwd)/lib/captcha checkout -f |]
  shell [cmd| touch -c @(file "lib/captcha/Makefile")|]

libcaptcha = rule $ do
  depend captchamake
  shell [cmd| make -C $(cwd)/lib/captcha |]
  shell [cmd| touch -c @(file "lib/captcha/libcaptcha.a")|]

lib = uwlib (file "lib.urp") $ do
  ffi (file "Captcha_ffi.urs")
  include (file "Captcha_ffi.h")
  src (file "Captcha_ffi.c")
  [libcaptcha] <- liftMake $ libcaptcha
  link libcaptcha
  ur (file "Captcha.ur")

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

