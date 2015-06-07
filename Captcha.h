#ifndef CAPTCHA_H
#define CAPTCHA_H

#include <urweb/urweb.h>

struct uw_Captcha_captcha {
  uw_Basis_blob blob;
  char string[6];
};

typedef struct uw_Captcha_captcha uw_Captcha_captcha;

uw_Captcha_captcha uw_Captcha_create(uw_context ctx, uw_Basis_unit u);
uw_Basis_string uw_Captcha_get_string(uw_context ctx, uw_Captcha_captcha c);
uw_Basis_blob uw_Captcha_get_gif(uw_context ctx, uw_Captcha_captcha c);

#endif
