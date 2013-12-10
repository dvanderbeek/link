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

  $("#savings-calculator").submit ->
    event.preventDefault()
    if allValid($(".balance, .rate"))
      $(".savings-calc-loan .form-group").each ->
        clearErrors($(this))
      linkRate10 = 5.75
      linkFee = 0.01

      currentPayment = 0
      remainingPaymentsTotal = 0
      totalBalance = 0

      $(".savings-calc-loan").each ->
        p = parseFloat($(this).find(".balance").autoNumeric("get"))
        r = parseFloat($(this).find(".rate").autoNumeric("get"))/100/12
        t = 120
        totalBalance += p
        payment = pmt(p, r, t)
        currentPayment += payment
        remainingPaymentsTotal += (payment * t)

      linkPmt10 = pmt((totalBalance * (1 + linkFee)), linkRate10/100/12, 10*12)
      linkSavings10 = Math.max(0, remainingPaymentsTotal - (linkPmt10 * 10 * 12))

      $("#savings-ten").autoNumeric("set", linkSavings10)
      $("#calculate-savings").val("Recalculate")
      $("#savings-placeholder").hide()
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

clearErrors = (formGroup) ->
  formGroup.removeClass("has-error")
  formGroup.children(".form-control").removeClass("field-with-errors")
  formGroup.children(".help-block").remove()

pmt = (p, r, t) ->
  (p * (r / (1 - Math.pow((1 + r), (-t)))))

balance = (pv, r, n, pmt) ->
  pv*Math.pow(1+r, n) - pmt*(((Math.pow(1+r, n))-1)/r)