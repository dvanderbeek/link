$ ->
  $("body").on "click", ".remove-loan", ->
    $(this).closest(".savings-calc-loan").remove()

  applyAutoNumeric()

  $('body').on 'click', '.add_fields', (event) ->
    $(this).before($(this).data('fields'))
    applyAutoNumeric()
    event.preventDefault()

  $("#close-savings-results").click ->
    $(this).hide()
    $("#savings-results").slideUp()

  $("#savings-calculator").submit ->
    event.preventDefault()

    if($(".savings-calc-loan").length == 1 && ($(".balance").val() == "" || $(".rate").val() == ""))
      $("#savings-results").hide()
      $("#insufficient-data").fadeIn()
    else
      $("#insufficient-data").hide()
      linkRate10 = 5.75
      linkFee = 0.01
      # Calculate monthly and total payments for current loans
      currentPayment = 0
      remainingPaymentsTotal = 0
      totalBalance = 0

      $(".savings-calc-loan").each ->
        p = parseFloat($(this).find(".balance").autoNumeric("get"))
        r = parseFloat($(this).find(".rate").autoNumeric("get"))/100/12
        # t = parseInt($(this).find(".term").val())

        # Compare vs. loans refinanced with 10 year term at existing rate
        t = 120
        totalBalance += p
        payment = pmt(p, r, t)
        currentPayment += payment
        remainingPaymentsTotal += (payment * t)

      # Calculate monthly payments for Link loan
      # 10 years
      linkPmt10 = pmt((totalBalance * (1 + linkFee)), linkRate10/100/12, 10*12)

      # Calculate savings
      # 10 years
      linkSavings10 = Math.max(0, remainingPaymentsTotal - (linkPmt10 * 10 * 12))

      # fill in table & show it
      $("#current-payment").autoNumeric("set", currentPayment)
      $("#remaining-balance").autoNumeric("set", totalBalance)
      $("#remaining-payments").autoNumeric("set", remainingPaymentsTotal)
      $("#pmt-ten").autoNumeric("set", linkPmt10)
      $("#savings-ten").autoNumeric("set", linkSavings10)
      $("#calculate-savings").val("Recalculate")
      $("#close-savings-results").show()
      $("#savings-results").fadeIn()

pmt = (p, r, t) ->
  (p * (r / (1 - Math.pow((1 + r), (-t)))))

balance = (pv, r, n, pmt) ->
  pv*Math.pow(1+r, n) - pmt*(((Math.pow(1+r, n))-1)/r)