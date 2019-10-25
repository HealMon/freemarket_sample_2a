$(function () {
  $('#item_price').on('keyup', function () {
    var inputValue = $('#item_price').val()
    
    var sell_tex = "¥" + Math.round(inputValue * 0.1);
    var sell_return = "¥" + Math.round(inputValue * 0.9);

    $('#sell_tex div.l-right').text(sell_tex.replace(/(\d)(?=(\d\d\d)+$)/g, '$1,'));
    $('#sell_return div.l-right').text(sell_return.replace(/(\d)(?=(\d\d\d)+$)/g, '$1,'));
  })
});
