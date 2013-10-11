$ ->
  $(".flash").delay(3000).fadeOut()

  $(window).scroll ->
    colorNavbar()

colorNavbar = ->
  scrollTop = $(window).scrollTop()

  if scrollTop <= 0
    $(".navbar").removeClass("scrolled")
  else
    $(".navbar").addClass("scrolled")
