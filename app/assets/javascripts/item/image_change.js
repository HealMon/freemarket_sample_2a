$(function () {
  $('.owl-dot').first().addClass("active"); //リストの最初の画像をｚactiveにする

  // 画像切替
  $('.owl-dot').hover(
    function () {
      const hoverImage = $(this).find('img').attr('src')
      $('.owl-item-inner img').attr('src', hoverImage) 
    },
  )

  // activeな画像がハッキリと描写される
  $('.owl-dot').hover(
    function () {
      $('.owl-dot').removeClass("active");
      $(this).addClass("active");
    }
  )
})