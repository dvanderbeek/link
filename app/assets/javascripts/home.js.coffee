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

  $("body").on "click", "#variable-savings-calculator-link", ->
    if $("a[href='#savings-calculator']").length > 0
      $("#variable-modal").modal("hide")
      return true
    else
      return true

  $("body").on "click", "#fixed-savings-calculator-link", ->
    if $("a[href='#savings-calculator']").length > 0
      $("#fixed-modal").modal("hide")
      return true
    else
      return true

colorNavbar = ->
  scrollTop = $(window).scrollTop()

  if scrollTop <= 0
    $(".navbar").removeClass("scrolled")
  else
    $(".navbar").addClass("scrolled")