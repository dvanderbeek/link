@applyAutoNumeric = ->
  $(".percent").autoNumeric
    aSign: "%"
    pSign: "s"

  $(".currency").autoNumeric
    aSign: "$"
    vMin: '-999999999.99'