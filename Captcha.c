#include "Captcha.h"

const int gifsize;
int captcha(unsigned char im[70*200], unsigned char l[6]);
void makegif(unsigned char im[70*200], unsigned char gif[gifsize]);

uw_Captcha uw_Captcha_create(uw_context ctx)
{
    uw_Captcha c;
    c.blob.size = 700*200;
    c.blob.data = (char*)uw_malloc(ctx, c.blob.size);
    unsigned char gif[gifsize];
    if(0 != captcha(c.blob.data, c.string) )
      uw_error (ctx, FATAL, "captcha returns non-zero code");

    return c;
}


