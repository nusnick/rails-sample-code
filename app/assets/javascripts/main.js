function remove_fields(link){
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content){
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parent().before(content.replace(regexp, new_id));
  $(".fields .form-control").rules("add", {maxlength: 255});
  $("#solution_tasks_attributes_" + new_id + "_title").focus();
}