jQuery(function() {
  $("a[rel=popover]").popover();
  $(".tooltip").tooltip();
  $("a[rel=tooltip]").tooltip();

  $("#search").typeahead();

    $(".alert").alert();
    window.setTimeout(function() { $(".alert").alert('close'); }, 5000);
});
