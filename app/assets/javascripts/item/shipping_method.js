$(function () {
    function appendOption(shipping_method){
        var html = `<option value="${shipping_method.id}" data-category="${shipping_method.id}">${shipping_method.name}</option>`;
        return html;
      }
      // 子カテゴリーの表示作成
        function appendShippingMethodBox(insertHTML){
        var childSelectHtml = '';
          childSelectHtml = `
                              <div id="appended-group">
                                <label>配送の方法</label>
                                <span class="form-group--require">必須</span>
                                <div class="select-wrap">
                                    <select class="select-default" id="shipping_method" name="item[shipping_method_id]">
                                    <option value="---" data-category="---">---</option>
                                    ${insertHTML}
                                    </select>
                                </div>
                              </div>
                                `;
        $('#delivery').append(childSelectHtml);
      }

  $("#item_shipping_charge_id").on("change", function () {
    // 親ボックスのidを取得してそのidをAjax通信でコントローラーへ送る
    var ShippingChargeValue = document.getElementById("item_shipping_charge_id").value;
    //　("parent-form")は親ボックスのid属性

    if (ShippingChargeValue != "---") { //親カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/items/search_shipping_charge',
        type: "GET",
        data: {
          shipping_charge_id: ShippingChargeValue // 親ボックスの値をparent_idという変数にする。
        },
        dataType: 'json'
      })
        .done(function (children) {
          var insertHTML = '';
          $('#appended-group').remove();
          
          if (ShippingChargeValue === "1") {
            children.forEach(function (child) { // 今は同じ
              insertHTML += appendOption(child);
            })
          } else {
              for(var i=0; i<4; i++) {
                insertHTML += appendOption(children[i]);
              }
          }
          appendShippingMethodBox(insertHTML);
        })
        .fail(function () {
          alert('取得に失敗しました');
        })
    }
  });


});
