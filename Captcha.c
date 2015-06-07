#include "Captcha.h"

const int gifsize;
int captcha(unsigned char im[70*200], unsigned char l[6]);
void makegif(unsigned char im[70*200], unsigned char gif[gifsize]);

uw_Captcha_captcha uw_Captcha_create(uw_context ctx, uw_Basis_unit u)
{
    uw_Captcha_captcha c;
    c.blob.size = 700*200;
    c.blob.data = (char*)uw_malloc(ctx, c.blob.size);
    if(0 != captcha(c.blob.data, c.string) )
      uw_error (ctx, FATAL, "captcha returns non-zero code");
    return c;
}


uw_Basis_string uw_Captcha_get_string(uw_context ctx, uw_Captcha_captcha c)
{
  return c.string;
}

uw_Basis_blob uw_Captcha_get_gif(uw_context ctx, uw_Captcha_captcha c)
{
  uw_Basis_blob b;
  b.size = gifsize;
  b.data = (char*)uw_malloc(ctx, b.size);
  makegif(c.blob.data, b.data);
  return b;
}
