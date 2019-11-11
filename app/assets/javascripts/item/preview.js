$(function () {
    $('#uploder').on('change',function(e){
        var files = e.target.files;
        var d = (new $.Deferred()).resolve();
        $.each(files,function(i,file){
          d = d.then(function() {
              return Uploader.upload(file)})
            .then(function (data) {
              
              return previewImage(file, data.image_id);
          });
        });
        $('#uploder').val('');
      });
      
      // 編集
      $('.images_field').on('click','.btn-edit', function(e){
        e.preventDefault();
        $(this).parent().find('.edit-image-file-input').trigger("click");
      });
    
      $('.images_field').on('change','.edit-image-file-input', function(e){
        var file = e.target.files[0];
        var image_box = $(this).parent().parent();
        Uploader.upload(file).done(function(data){
          replaceImage(file, data.image_id, image_box);
        });
      });
    
      $('.images_field').on('click', '.btn-delete', function (e) {
        e.preventDefault();
        $(this).parent().parent().remove();
        var imageCount = $('.sell-image-container .image-box').length
        if (imageCount < 5) { 
          $('.sell-image-drop-box-0').css('display', 'block')
        } 
      });
    
      var replaceImage = function(imageFile, image_id, element){
        var reader = new FileReader();
        var img = element.find('img');
        var input = element.find('.item-images-input');
        var filename = element.find('p');
        reader.onload = function(e){
          input.attr({value: image_id});
          filename.html(imageFile.name);
          img.attr("src", e.target.result);
        };
        reader.readAsDataURL(imageFile);
      }
    
      // 画像追加処理（プレビューを表示）
      var previewImage = function(imageFile, image_id){
        var reader = new FileReader();
        var img = new Image();
        var def =$.Deferred();
        reader.onload = function(e){
          var image_box = $('<div>',{class: 'image-box'});
          image_box.append(img);
          image_box.append($('<input>').attr({
                name: "item[images][]",
                value: image_id,
                style: "display: none;",
                type: "hidden",
                class: "item-images-input"}));
          html = `<div class="sell-upload-button">
                    <a href="" class= "btn-edit">編集</a>
                    <input name="edit-image[]" style="display: none" type="file" class="edit-image-file-input file-input"></input>
                    <a href="" class="btn-delete">削除</a>
                  </div>`
          image_box.append(html);
          $('.upup').append(image_box);
          img.src = e.target.result;
          def.resolve();
        };
        reader.readAsDataURL(imageFile);

        var imageCount = $('.sell-image-container .image-box').length
        if (imageCount >= 4) { // ５つ以上なら
          $('.sell-image-drop-box-0').css('display', 'none')
        } 
        return def.promise();
      }
    
      var Uploader = {
        upload: function(imageFile){
          var def =$.Deferred();
          var formData = new FormData();
          formData.append('image', imageFile);
          $.ajax({
            type: "POST",
            url: '/items/upload_image',
            data: formData,
            dataType: 'json',
            processData: false,
            contentType: false,
            success: def.resolve
          })
          return def.promise();
        }
      }
})


