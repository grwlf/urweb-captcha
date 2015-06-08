
open Captcha

fun main {} : transaction page =
  cid <- allocate {};
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
          <img src={url (blob cid)} alt="captcha"/><br/>
          <ctextbox source={s}/><br/>
          <button value="Check" onclick={fn _ =>
            ans <- get s ;
            ok <- rpc(check_free ans cid);
            (if ok then alert "Correct!" else alert "Nope");
            cid' <- rpc(allocate {});
            set i cid'
          }/>
        </xml>
      }/>
      </p>

      <p>
      <button value="Try another" onclick={fn _ => cid' <- rpc(allocate {}); set i cid'; return {}}/>
      </p>

    </body>
  </xml>

