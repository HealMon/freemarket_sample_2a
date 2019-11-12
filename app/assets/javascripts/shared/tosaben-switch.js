$(function () {
  
  $('#tosaben-btn').on('change', function () {
    var curentUrl = location.href;
    var isMypage = curentUrl.indexOf("mypage") == 22; // mypageの記述があればtrue
    
    if ($("#tosaben-btn input").prop("checked") == false) {
      $.ajax({
        type: "post",
        url: "/user/tosaben",
        data: {
          tosaben: false
        },
        dataType: 'json'
      })
      .then(
        function (data) {
          if (isMypage) { // マイページの場合マイページにリダイレクト
            location.href = "./mypage";
          } else {
            location.href = "./";
          }
        },
        function () {
          alert('土佐弁には変えれなーよ')
        });
    } else {
      $.ajax({
        type: "post",
        url: "/user/tosaben",
        data: {
          tosaben: true
        },
        dataType: 'json'
      })
      .then(
        function (data) {
          if (isMypage) {
            location.href = "./mypage";
          } else {
            location.href = "./";
          }
        },
        function () {
          alert('土佐弁には変えれなーよ')
        });
    }
  })
})