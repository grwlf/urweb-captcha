
table captchas : { Id : int, Data : blob, Answer : string }
sequence captchas_gen

structure C = Captcha

fun captcha_show (i:int) : transaction page =
  c <- oneRow1(SELECT C.Data FROM captchas AS C WHERE C.Id = {[i]});
  returnBlob c.Data (blessMime "image/gif")

fun captcha_check (ans:string) (i:int) : transaction bool =
  c <- oneRow1(SELECT C.Answer FROM captchas AS C WHERE C.Id = {[i]});
  dml(DELETE FROM captchas WHERE Id = {[i]});
  return (ans = c.Answer)

fun captcha_create {} : transaction int =
  c <- C.create {};
  i <- nextval captchas_gen;
  dml(INSERT INTO captchas (Id, Data, Answer) VALUES ({[i]}, {[C.get_gif c]}, {[C.get_string c]}));
  dml(DELETE FROM captchas WHERE Id < {[i-100]});
  return i

fun main {} : transaction page =
  cid <- captcha_create {};
  i <- source cid;
  s <- source "";
  return
  <xml><head/>
    <body>
      <h1>Captcha demo</h1>
      <p>
      <dyn signal={
        cid <- signal i;
        return <xml>
          <img src={url (captcha_show cid)} alt="captcha"/><br/>
          <ctextbox source={s}/><br/>
          <button value="Check" onclick={fn _ =>
            ans <- get s ;
            ok <- rpc(captcha_check ans cid);
            (if ok then alert "Correct!" else alert "Nope");
            cid' <- rpc(captcha_create {});
            set i cid'
          }/>
        </xml>
      }/>
      </p>

      <p>
      <button value="Try another" onclick={fn _ => cid' <- rpc(captcha_create {}); set i cid'; return {}}/>
      </p>

    </body>
  </xml>

