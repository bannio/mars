attachRowLinkHandler =->
  $('tr.rowlink').click ->
    window.location = $(this).data("rowlink")
    
jQuery ->
  $('#sortable-table tbody').sortable(
    axis: 'y'
    handle: '.handle'
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
  )

jQuery ->
  $(document).on "page:load", attachRowLinkHandler
  $(document).ready attachRowLinkHandler
  
