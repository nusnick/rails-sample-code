$(function(){
  $("form.solution-spec-form").validate({
    rules: {
      "solution_specialization[title]": {
        required: true
      }
    }
  })
})
