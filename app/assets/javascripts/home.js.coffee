$ ->
  $(".flash").delay(3000).fadeOut()

  $(window).scroll ->
    colorNavbar()

  uv = document.createElement("script")
  uv.type = "text/javascript"
  uv.async = true
  uv.src = "//widget.uservoice.com/Rq6yqgh9QumgClpNu1XTOQ.js"
  s = document.getElementsByTagName("script")[0]
  s.parentNode.insertBefore uv, s

colorNavbar = ->
  scrollTop = $(window).scrollTop()

  if scrollTop <= 0
    $(".navbar").removeClass("scrolled")
  else
    $(".navbar").addClass("scrolled")