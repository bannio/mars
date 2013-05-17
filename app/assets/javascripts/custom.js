$(document).ready(function(){
  $('select').select2({
	placeholder: "Please Select",
	width: 'resolve'
  });
  $("input.date_picker").datepicker({ dateFormat: "yy-mm-dd", changeMonth: true, changeYear: true });
});

// $(function() {
// 	$('#companies_search input').keyup(function() {
// 		$.get($('#companies_search').attr('action'), $('#companies_search').serialize(), null, 'script');
// 		return false;
// 	});
// });

// $(function() {
// 	$('#contacts_search input').keyup(function() {
// 		$.get($('#contacts_search').attr('action'), $('#contacts_search').serialize(), null, 'script');
// 		return false;
// 	});
// });
