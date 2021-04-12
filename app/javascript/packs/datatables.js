$(document).on('turbolinks:load', function () {
  if ($('[id^=DataTables_Table]').length == 0) {
    $('table').DataTable({ searching: false });
  }
});
