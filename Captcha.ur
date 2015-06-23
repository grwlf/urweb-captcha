
(* Low-level operations *)
open Captcha_ffi



(* Hi-level operations *)
table captchas : { Id : int, Data : blob, Answer : string }
sequence captchas_gen

fun blob (i:int) : transaction page =
  c <- oneRow1(SELECT C.Data FROM captchas AS C WHERE C.Id = {[i]});
  returnBlob c.Data (blessMime "image/gif")

fun check_free (ans:string) (i:int) : transaction bool =
  mb <- oneOrNoRows1(SELECT C.Answer FROM captchas AS C WHERE C.Id = {[i]});
  case mb of
  |Some c =>
    dml(DELETE FROM captchas WHERE Id = {[i]});
    return (ans = c.Answer)
  |None =>
    return False


fun allocate_opts (o:{GCdepth: int}) : transaction int =
  c <- create {};
  i <- nextval captchas_gen;
  dml(INSERT INTO captchas (Id, Data, Answer) VALUES ({[i]}, {[get_gif c]}, {[get_string c]}));
  dml(DELETE FROM captchas WHERE Id < {[i-o.GCdepth]});
  return i

fun allocate {} = allocate_opts {GCdepth = 100}
