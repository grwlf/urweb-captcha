#ifndef CAPTCHA_H
#define CAPTCHA_H

#include <urweb/urweb.h>

#define FFI(x) uw_Captcha_ffi_##x

struct FFI(captcha) {
  uw_Basis_blob blob;
  char string[6];
};

typedef struct FFI(captcha) FFI(captcha);

FFI(captcha) FFI(create)(uw_context ctx, uw_Basis_unit u);
uw_Basis_string FFI(get_string)(uw_context ctx, FFI(captcha) c);
uw_Basis_blob FFI(get_gif)(uw_context ctx, FFI(captcha) c);

#endif
