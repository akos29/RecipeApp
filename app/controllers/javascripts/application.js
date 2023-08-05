$(document).on("change", ".toggle-button", function() {
  var form = $(this).closest("form");
  $.ajax({
    url: form.attr("action"),
    type: "PATCH",
    data: form.serialize(),
    dataType: "script"
  });
});