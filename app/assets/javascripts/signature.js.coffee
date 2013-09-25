$ ->
  $('body').on "keyup", ".live", ->
    $($(this).data("target")).html($(this).val())

    