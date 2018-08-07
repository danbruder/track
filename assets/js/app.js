import 'jquery-ujs';
import Turbolinks from 'turbolinks';
import feather from 'feather-icons';
import selectize from 'selectize';
import 'selectize/dist/css/selectize.css';
import 'selectize/dist/css/selectize.default.css';

// Start Turbolinks
Turbolinks.start();

// Document ready callback
$(document).on('turbolinks:load', function() {
  // Replace feather icons
  feather.replace();

  // Initialize select options
  var options = {};
  $('select').selectize(options);
});
