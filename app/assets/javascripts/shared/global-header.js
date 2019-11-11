$(function () {
  // hover時の色変更jsです

  // leftメニュー
  $('.pc-header-nav-root').hover(
    function () {
      $(this).find('span').css('color', '#0095ee')
    },
    function () {
      $(this).find('span').css('color', '#333')
    }
  )

  // rightメニュー
  $('.menu-link').hover(
    function () {
      $(this).children().css('color', '#0095ee')
    },
    function () {
      $(this).children().css('color', '#ccc')
      $(this).find('span').css('color', '#333')
    }
  )
})
