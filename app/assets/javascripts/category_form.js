$(function () {
    function appendOption(category){
        var html = `<option value="${category.name}" data-category="${category.id}">${category.name}</option>`;
        return html;
      }
      // 子カテゴリーの表示作成
        function appendChidrenBox(insertHTML){
        var childSelectHtml = '';
        childSelectHtml = `<select class="select-default" id="child_category" name="category_id">
                                <option value="---" data-category="---">---</option>
                                ${insertHTML}
                          </select>`;
        $('#category').append(childSelectHtml);
      }
        // 孫カテゴリーの表示作成
        function appendGrandchidrenBox(insertHTML){
        var grandchildSelectHtml = '';
        grandchildSelectHtml = ` <select class="select-default" id="grandchild_category" name="category_id">
                                    <option value="---" data-category="---">---</option>
                                    ${insertHTML}
                                </select> `;
        $('#category').append(grandchildSelectHtml);
      }

  $("#parent-form").on("change", function () {
    // 親ボックスのidを取得してそのidをAjax通信でコントローラーへ送る
    var parentValue = document.getElementById("parent-form").value;
    //　("parent-form")は親ボックスのid属性
    if (parentValue != "---") { //親カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/items/search_children',
        type: "GET",
        data: {
          parent_id: parentValue // 親ボックスの値をparent_idという変数にする。
        },
        dataType: 'json'
      })
        .done(function (children) {
          console.log(children) // responseの中身をログ出力
          $('#child_category').remove();
          var insertHTML = '';
          children.forEach(function (child) {
            insertHTML += appendOption(child);
          })
          appendChidrenBox(insertHTML);
        })
        .fail(function () {
          alert('カテゴリー取得に失敗しました');
        })
    }
  });

  // 子カテゴリー選択後のイベント
  // $('#child_category').on("change", function () {
  $('.sell-select-box').on('change', '#child_category', function () {
    // var childId = $('#child_category option:selected').data('category'); //選択された子カテゴリーのidを取得
    var childId = $("#child_category option:selected").data('category');
    if (childId != "---") { //子カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/items/search_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function (grandchildren) {
        if (grandchildren.length != 0) {
          debugger
            $('#grandchild_category').remove(); //子が変更された時、孫以下を削除するする
            var insertHTML = '';
            grandchildren.forEach(function (grandchild) {
              insertHTML += appendOption(grandchild);
            });
            appendGrandchidrenBox(insertHTML);
          }
        })
        .fail(function () {
          alert('カテゴリー取得に失敗しました');
        })
    } else {
      $('#grandchild_category').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
    }
  });

});

