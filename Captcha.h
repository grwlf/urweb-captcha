#ifndef CAPTCHA_H
#define CAPTCHA_H

#include <urweb.h>

struct uw_Captcha {
  uw_Basis_blob blob;
  char string[6];
};

typedef struct uw_Captcha uw_Captcha;

uw_Captcha uw_Captcha_create(uw_context ctx);
uw_Basis_string uw_Captcha_get_text(uw_context ctx, uw_Captcha c);
uw_Basis_blob uw_Captcha_get_blob(uw_context ctx, uw_Captcha c);

#endif
