@applyAutoNumeric = ->
  $(".percent").autoNumeric
    aSign: "%"
    pSign: "s"

  $(".currency").autoNumeric
    aSign: "$"