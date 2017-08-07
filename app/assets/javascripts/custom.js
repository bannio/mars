var Mars = {

    onReady: function () {
      $('select').select2({
            placeholder: "Please Select",
            width: 'resolve'
        });

      $("input.date_picker").datepicker(
            {dateFormat: "yy-mm-dd", changeMonth: true, changeYear: true}
        );
      $('#sortable-table tbody').sortable({
            axis: 'y',
            handle: '.handle',
            update: function () {
                return $.post($(this).data('update-url'), $(this).sortable('serialize'));
            }
        });
      $('tr.rowlink').click(function () {
            return window.location = $(this).data("rowlink");
        });
    }
};

$(document).on('turbolinks:load', Mars.onReady);