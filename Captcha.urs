(* int captcha(unsigned char im[70*200], unsigned char l[6]); *)
type captcha

val create : transaction captcha

val get_string : captcha -> string

val get_blob : captcha -> blob
