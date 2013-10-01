$ ->
  $("body").on "click", ".remove-loan", ->
    $(this).closest(".savings-calc-loan").remove()

  $(".remove-loan").first().hide()

  applyAutoNumeric()

  $('body').on 'click', '.add_fields', (event) ->
    $(this).before($(this).data('fields'))
    applyAutoNumeric()
    event.preventDefault()

  $("#close-savings-results").click ->
    $("#savings-results").slideUp()

  $("#calculate-savings").click ->
    linkRate5 = 5.75
    linkRate10 = 5.75
    linkRate15 = 5.75
    linkFee = 0.01
    # Calculate monthly and total payments for current loans
    currentPayment = 0
    remainingPaymentsTotal = 0
    totalBalance = 0

    #TODO VALIDATE FIELDS

    $(".savings-calc-loan").each ->
      p = parseFloat($(this).find(".balance").autoNumeric("get"))
      r = parseFloat($(this).find(".rate").autoNumeric("get"))/100/12
      t = parseInt($(this).find(".term").val())
      totalBalance += p
      payment = pmt(p, r, t)
      currentPayment += payment
      remainingPaymentsTotal += (payment * t)

    # Calculate monthly payments for Link loan
    # 5 years
    linkPmt5 = pmt((totalBalance * (1 + linkFee)), linkRate5/100/12, 5*12)
    # 10 years
    linkPmt10 = pmt((totalBalance * (1 + linkFee)), linkRate10/100/12, 10*12)
    # 15 years
    linkPmt15 = pmt((totalBalance * (1 + linkFee)), linkRate15/100/12, 15*12)

    # Calculate savings
    # 5 years
    linkSavings5 = Math.max(0, remainingPaymentsTotal - (linkPmt5 * 5 * 12))
    # 10 years
    linkSavings10 = Math.max(0, remainingPaymentsTotal - (linkPmt10 * 10 * 12))
    # 15 years
    linkSavings15 = Math.max(0, remainingPaymentsTotal - (linkPmt15 * 15 * 12))

    # fill in table & show it
    $("#current-payment").autoNumeric("set", currentPayment)
    $("#remaining-balance").autoNumeric("set", totalBalance)
    $("#remaining-payments").autoNumeric("set", remainingPaymentsTotal)
    $("#pmt-five").autoNumeric("set", linkPmt5)
    $("#pmt-ten").autoNumeric("set", linkPmt10)
    $("#pmt-fifteen").autoNumeric("set", linkPmt15)
    $("#savings-five").autoNumeric("set", linkSavings5)
    $("#savings-ten").autoNumeric("set", linkSavings10)
    $("#savings-fifteen").autoNumeric("set", linkSavings15)
    $("#calculate-savings").text("Recalculate Your Savings")
    $("#savings-results").fadeIn()

pmt = (p, r, t) ->
  (p * (r / (1 - Math.pow((1 + r), (-t)))))

balance = (pv, r, n, pmt) ->
  pv*Math.pow(1+r, n) - pmt*(((Math.pow(1+r, n))-1)/r)