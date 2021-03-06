window.addEventListener('DOMContentLoaded', function(){

  //id名が"payment_card_submit-button"というボタンが押されたら取得
  let submit = document.getElementById("payment_card_submit-button");

  Payjp.setPublicKey('pk_test_34af90abbdf1dd334fa81321'); //公開鍵の記述


    submit.addEventListener('click', function(e){ //ボタンが押されたらトークン作成開始。

    e.preventDefault(); //ボタンを1度無効化

    let card = {
        number: document.getElementById("payment_card_no").value,
        cvc: document.getElementById("payment_card_cvc").value,
        exp_month: document.getElementById("payment_card_month").value,
        exp_year: document.getElementById("payment_card_year").value
    };
    
    Payjp.createToken(card, function(status, response) {  // トークンを生成
      if (status === 200) { //成功した場合(status === 200はリクエストが成功している状況です。)
        //データを自サーバにpostしないようにremoveAttr("name")で削除
        console.log($("#payment_card_no"))
        $("#payment_card_no").removeAttr("name");
        $("#payment_card_cvc").removeAttr("name");
        $("#payment_card_month").removeAttr("name");
        $("#payment_card_year").removeAttr("name"); 
        $("#charge-form").append(
          $('<input type="hidden" name="payjp_token">').val(response.id)
        ); //取得したトークンを送信できる状態にします
        document.inputForm.submit();
        alert("登録が完了しました"); //正常処理完了確認用。createビューがあればつけなくてもOKかな
      } else {
        alert("カード情報が正しくありません。"); //エラー確認用
      }
    });
  });
});