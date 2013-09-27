# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $(".flash").delay(3000).fadeOut()

  $("#savings-calculator-add-loan").click ->
    $(this).before("<div class='row savings-calc-loan'><div class='col-xs-4'><input class='form-control' id='loan_balance' name='loan_balance' type='text' value=''></div><div class='col-xs-4'><input class='form-control' id='loan_rate' name='loan_rate' type='text' value=''></div><div class='col-xs-4'><input class='form-control' id='loan_term' name='loan_term' type='text' value=''></div></div>")
    event.preventDefault()

