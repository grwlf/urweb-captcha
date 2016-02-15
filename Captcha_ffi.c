#include "Captcha_ffi.h"

const int gifsize;
int captcha(unsigned char im[70*200], unsigned char l[6]);
void makegif(unsigned char im[70*200], unsigned char gif[gifsize]);

FFI(captcha) FFI(create)(uw_context ctx, uw_Basis_unit u)
{
    FFI(captcha) c;
    c.blob.size = 700*200;
    c.blob.data = (char*)uw_malloc(ctx, c.blob.size);
    if(0 != captcha(c.blob.data, c.string) )
      uw_error (ctx, FATAL, "captcha returns non-zero code");
    return c;
}


uw_Basis_string FFI(get_string)(uw_context ctx, FFI(captcha) c)
{
  uw_Basis_string s;
  s = (char*)uw_malloc(ctx, 7);
  strncpy(s, c.string, 6);
  s[6] = 0;
  return s;
}

uw_Basis_blob FFI(get_gif)(uw_context ctx, FFI(captcha) c)
{
  uw_Basis_blob b;
  b.size = gifsize;
  b.data = (char*)uw_malloc(ctx, b.size);
  makegif(c.blob.data, b.data);
  return b;
}
