$(document).on('turbolinks:load', function () {
  if ($('[id^=DataTables_Table]').length === 0) {
    $('table.data_table').DataTable({
      searching: false,
      stripeClasses: [],
      bLengthChange: false,
    });
  }
});
