$(function(){
  var form = $("#card_form");
  Payjp.setPublicKey("pk_test_55f5e28faf3100e66fe78af6"); // 公開鍵のセット
  $("#card_btn").on("click", function (e) {
    e.preventDefault();
    
    var card = {
      number: $("#card_number").val(),
      cvc: $("#card_cvc").val(),
      exp_month: $("#card_month").val(),
      exp_year: $("#card_year").val()
    };
    Payjp.createToken(card, function (status, response) {
      //↑先ほどのcard情報がトークンという暗号化したものとして返ってくる
      form.find("input[type=submit]").prop("disabled", true);
      if (status == 200) {//←うまくいった場合200になるので
        $("#card_number").removeAttr("name");
        $("#card_cvc").removeAttr("name");
        $("#card_month").removeAttr("name");
        $("#card_year").removeAttr("name");
        //↑このremoveAttr("name")はデータを保持しないように消している
        var payjphtml = `<input type="hidden" name="payjpToken" value=${response.id}>`
        form.append(payjphtml);
        //↑これはdbにトークンを保存するのでjsで作ったトークンをセットしてる
        // form.submit();
        document.inputForm.submit();
        alert("登録が完了しました");
        //↑そしてここでsubmit！！これでrailsのアクションにいく！もちろん上でトークンをセットしているのでparamsの中には{payjpToken="トークン"}という情報が入っている
      } else {
        alert("カード情報が正しくありません。");
      }
    });
  });
});




