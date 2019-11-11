$(function () {
  
  $('#tosaben-btn').on('change', function () {
    // スイッチの状態を取り出す
    // $("#tosaben-btn input").prop("checked", false) 
    console.log($("#tosaben-btn input").prop("checked"))
    
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
        // 1つめは通信成功時のコールバック
        function (data) {
          location.href = "./";
        },
        // 2つめは通信失敗時のコールバック
        function () {
          location.href = "./";
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
        // 1つめは通信成功時のコールバック
        function (data) {
          location.href = "./";
        },
        // 2つめは通信失敗時のコールバック
        function () {
          location.href = "./";
        });
    }
  })
})