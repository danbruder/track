import 'jquery-ujs';
import Turbolinks from 'turbolinks';
import feather from 'feather-icons';
import selectize from 'selectize';

// Start Turbolinks
Turbolinks.start();

// Document ready callback
$(document).on('turbolinks:load', function() {
  // Replace feather icons
  feather.replace();

  // Initialize select options
  var options = {
    create: false,
  };
  $('select').selectize(options);

  // Toggle bill rates on timesheet
  $('.timesheet-toggle-edit-bill-rates').click(function() {
    if ($('.timesheet-edit-bill-rates').hasClass('dn')) {
      $('.timesheet-edit-bill-rates')
        .removeClass('dn')
        .addClass('flex');
      $('.timesheet-toggle-edit-bill-rates').text('hide');
    } else {
      $('.timesheet-edit-bill-rates')
        .removeClass('flex')
        .addClass('dn');
      $('.timesheet-toggle-edit-bill-rates').text('Override Bill Rates');
    }
  });
});
