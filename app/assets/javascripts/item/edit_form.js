$(function () {
    function appendOption(category){
        var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
        return html;
      }
      // 子カテゴリーの表示作成
        function appendChidrenBox(insertHTML){
        var childSelectHtml = '';
        childSelectHtml = `<select class="select-default" id="child_category" name="item[category_id][]">
                                <option value="---" data-category="---">---</option>
                                ${insertHTML}
                          </select>`;
        $('#category').append(childSelectHtml);
      }
        // 孫カテゴリーの表示作成
        function appendGrandchidrenBox(insertHTML){
        var grandchildSelectHtml = '';
        grandchildSelectHtml = ` <select class="select-default" id="grandchild_category" name="item[category_id][]">
                                    <option value="---" data-category="---">---</option>
                                    ${insertHTML}
                                </select> `;
        $('#category').append(grandchildSelectHtml);
      }
        
    function appendSizeOption(size){
      var html = `<option value="${size.id}" data-category="${size.id}">${size.size}</option>`;
      return html;
    }
    // サイズの表示作成
    function appendSizeBox(insertHTML){
      var sizeSelectHtml = '';
      sizeSelectHtml = `
        <div class="form_group" id="size_remove">
          <label>サイズ</label>
          <span class="form-group--require">必須</span>
          <div class="select-wrap">
            <select class="select-default" id="size_category" name="item[size_id]">
            <option value="---" data-category="---">---</option>
            ${insertHTML}
            </select>
          </div>
        </div>`;
      
      $('#size').append(sizeSelectHtml);
  }

  $("#item_grand_category_id").on("change", function () {
    // 親ボックスのidを取得してそのidをAjax通信でコントローラーへ送る
    var parentValue = document.getElementById("item_grand_category_id").value;
    
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
          $('#item_parent_category_id').remove();
          $('#item_category_id').remove();
          $('#size_remove').remove();
          $('#child_category').remove();
          $('#grandchild_category').remove();
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
  $('.select-wrap').on('change', '#item_parent_category_id', function () {
    var childId = $("#item_parent_category_id option:selected").data('category');
    if (childId != "---") { //子カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/items/search_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function (grandchildren) {
        if (grandchildren.length != 0) {
            $('#item_category_id').remove(); //子が変更された時、孫以下を削除するする
            $('#size_remove').remove();
            $('#grandchild_category').remove();

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

  // 孫カテゴリー選択後のイベント
  $('.select-wrap').on('change', '#grandchild_category', function () {
    var grandchildId = $("#grandchild_category option:selected").data('category');
    console.log(grandchildId)
    if (grandchildId != "---") { //子カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/items/get_size',
        type: 'GET',
        data: { grandchild_id: grandchildId },
        dataType: 'json'
      })
        .done(function (sizes) {
          if (sizes.length != 0) {
            $('#size_remove').remove(); //子が変更された時、孫以下を削除するする
            var insertHTML = '';
            sizes.forEach(function (size) {
              insertHTML += appendSizeOption(size);
            });
            appendSizeBox(insertHTML);
          }
        })
        .fail(function () {
          alert('カテゴリー取得に失敗しました');
        })
    } else {
      $('#size_category').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
    }
  });
});
