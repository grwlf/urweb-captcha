{-# LANGUAGE ScopedTypeVariables #-}
module Cake_Captcha where

import Development.Cake3
import Development.Cake3.Ext.UrWeb
import Cake_Captcha_P



lib = uwlib (file "lib.urp") $ do
  ffi (file "Captcha.urs")
  include (file "Captcha.h")
  src (file "Captcha.c")

(test, test_db) = uwapp_postgres (file "test/Captcha1.urp") $ do
  library lib
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


