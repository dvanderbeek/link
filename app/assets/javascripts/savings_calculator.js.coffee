$ ->
  $("body").on "click", ".remove-loan", ->
    $(this).closest(".savings-calc-loan").remove()

  applyAutoNumeric()

  $('body').on 'click', '.add_fields', (event) ->
    $(this).before($(this).data('fields'))
    applyAutoNumeric()
    event.preventDefault()

  $('body').on 'click', '.remove-loan', (e) ->
    event.preventDefault()
    $(this).parent().remove()

  $(".calculate-savings").click ->
    event.preventDefault()
    if allValid($(".balance, .rate, .term"))
      $(".savings-calc-loan .form-group").each ->
        clearErrors($(this))

      # set up pricing variables
      fixedRate = 5.75
      variableRate = 2.75
      linkFee = 0.01

      # calculate current payment and total remaining payments
      currentPayment = 0
      remainingPaymentsTotal = 0
      totalBalance = 0
      $(".savings-calc-loan").each ->
        p = parseFloat($(this).find(".balance").autoNumeric("get"))
        r = parseFloat($(this).find(".rate").autoNumeric("get"))/100/12
        t = parseFloat($(this).find(".term").val())
        totalBalance += p
        payment = pmt(p, r, t)
        currentPayment += payment
        remainingPaymentsTotal += (payment * t)

      # calculate savings and fill in details table
      fixed3Pmt = pmt((totalBalance * (1 + linkFee)), fixedRate/100/12, 3*12)
      fixed3Savings = remainingPaymentsTotal - (fixed3Pmt * 3 * 12)
      $(".fixed-3-pmt").autoNumeric("set", fixed3Pmt)
      $(".fixed-3-savings").autoNumeric("set", fixed3Savings)

      fixed5Pmt = pmt((totalBalance * (1 + linkFee)), fixedRate/100/12, 5*12)
      fixed5Savings = remainingPaymentsTotal - (fixed5Pmt * 5 * 12)
      $(".fixed-5-pmt").autoNumeric("set", fixed5Pmt)
      $(".fixed-5-savings").autoNumeric("set", fixed5Savings)

      fixed7Pmt = pmt((totalBalance * (1 + linkFee)), fixedRate/100/12, 7*12)
      fixed7Savings = remainingPaymentsTotal - (fixed7Pmt * 7 * 12)
      $(".fixed-7-pmt").autoNumeric("set", fixed7Pmt)
      $(".fixed-7-savings").autoNumeric("set", fixed7Savings)

      fixed10Pmt = pmt((totalBalance * (1 + linkFee)), fixedRate/100/12, 10*12)
      fixed10Savings = remainingPaymentsTotal - (fixed10Pmt * 10 * 12)
      $(".fixed-10-pmt").autoNumeric("set", fixed10Pmt)
      $(".fixed-10-savings").autoNumeric("set", fixed10Savings)

      fixed15Pmt = pmt((totalBalance * (1 + linkFee)), fixedRate/100/12, 15*12)
      fixed15Savings = remainingPaymentsTotal - (fixed15Pmt * 15 * 12)
      $(".fixed-15-pmt").autoNumeric("set", fixed15Pmt)
      $(".fixed-15-savings").autoNumeric("set", fixed15Savings)

      fixed20Pmt = pmt((totalBalance * (1 + linkFee)), fixedRate/100/12, 20*12)
      fixed20Savings = remainingPaymentsTotal - (fixed20Pmt * 20 * 12)
      $(".fixed-20-pmt").autoNumeric("set", fixed20Pmt)
      $(".fixed-20-savings").autoNumeric("set", fixed20Savings)

      fixed30Pmt = pmt((totalBalance * (1 + linkFee)), fixedRate/100/12, 30*12)
      fixed30Savings = remainingPaymentsTotal - (fixed30Pmt * 30 * 12)
      $(".fixed-30-pmt").autoNumeric("set", fixed30Pmt)
      $(".fixed-30-savings").autoNumeric("set", fixed30Savings)

      variable5Pmt = pmt((totalBalance * (1 + linkFee)), variableRate/100/12, 5*12)
      variable5Savings = remainingPaymentsTotal - (variable5Pmt * 5 * 12)
      $(".variable-5-pmt").autoNumeric("set", variable5Pmt)
      $(".variable-5-savings").autoNumeric("set", variable5Savings)

      variable10Pmt = pmt((totalBalance * (1 + linkFee)), variableRate/100/12, 10*12)
      variable10Savings = remainingPaymentsTotal - (variable10Pmt * 10 * 12)
      $(".variable-10-pmt").autoNumeric("set", variable10Pmt)
      $(".variable-10-savings").autoNumeric("set", variable10Savings)

      # show appropriate links and results
      $("#calculate-savings").text("Recalculate")
      $("#savings-placeholder").hide()
      showDetailsLink($(this).data("type"))
      showMainSavings($(this).data("type"))
      $("#savings-results").fadeIn()
    else
      $("#savings-results").hide()
      $(".savings-calc-loan .form-group .form-control").each ->
        if $(this).val() == "" || $(this).val() == "%" || $(this).val() == "$"
          $(this).parents(".form-group").addClass("has-error")
          $(this).addClass("field-with-errors")
          unless $(this).siblings(".help-block").length == 1
            $(this).parents(".form-group").append("<p class='help-block'>can't be blank</p>")
        else 
          clearErrors($(this).parents(".form-group"))

allValid = (fields) ->
  n = 0
  fields.each ->
    if $(this).val() == "" || $(this).val() == "%" || $(this).val() == "$"
      n++
  if n == 0
    return true

showDetailsLink = (type) ->
  if type == "fixed"
    $("#variable-details-link").hide()
    $("#fixed-details-link").show()
  else
    $("#fixed-details-link").hide()
    $("#variable-details-link").show()

showMainSavings = (type) ->
  if type == "fixed"
    $("#variable-savings").hide()
    $("#fixed-savings").show()
  else
    $("#fixed-savings").hide()
    $("#variable-savings").show()

clearErrors = (formGroup) ->
  formGroup.removeClass("has-error")
  formGroup.children(".form-control").removeClass("field-with-errors")
  formGroup.children(".help-block").remove()

pmt = (p, r, t) ->
  (p * (r / (1 - Math.pow((1 + r), (-t)))))

balance = (pv, r, n, pmt) ->
  pv*Math.pow(1+r, n) - pmt*(((Math.pow(1+r, n))-1)/r)