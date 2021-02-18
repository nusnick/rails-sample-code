$(function(){
  $("#solution_image").change(function(){
    $("#file-name").text($(this).val().replace(/C:\\fakepath\\/i, ''));
    $("#btn-remove-solution-image").removeClass("hidden");
  });

  $("a#btn-remove-solution-image").click(function(){
    var fileControl = $("#solution_image").clone(true);
    $("#solution_image").replaceWith(fileControl);
    $("#btn-remove-solution-image").addClass('hidden');
    $("#file-name").text("");
  });

  $("form.solution-form").validate({
    rules: {
      "solution[title]": {
        required: true,
        maxlength: 255
      },
      "solution[favor]": {
        maxlength: 255
      },
      "solution[teaser]": {
        maxlength: 5000
      },
      "solution[full_text]": {
        maxlength: 5000
      },
      "solution[tasks_attributes][0][title]":{
        maxlength: 255
      }
    }
  });

  $("#solution_author_id").select2({
    placeholder: "Search author",
    minimumInputLength: 3,
    ajax: {
        url: "/solutions/search_authors",
        dataType: 'json',
        data: function(term){
          return{
            q: term
          };
        },
        results: function (data) {
          return {
            results: $.map(data, function(user, i){
              return {id :user.id, text: user.name}
            })
          }
        }
    },
    initSelection: function(element, callback) {
      var id = $(element).val();
      var text = $(element).attr('user');
      var data = { id: id, text: text };
      callback(data);
    }
  });
  if ($("#solution_specialization_tokens").attr('specs') == undefined){
    var tags = "[]"
  }
  else{
    var tags = $("#solution_specialization_tokens").attr('specs');
  }

  console.log();

  $("#solution_specialization_tokens").select2({
    tags: true,
    tokenSeparators: [",", " "],
    multiple: true,
    minimumResultsForSearch: 99,
    ajax: {
        url: "/solution_specializations?type=published",
        dataType: 'json',
        data: function(term){
          return{
            q: term
          };
        },
        results: function (data) {
          return {
            results: $.map(data, function(spec, i){
              return {id :spec.id, text: spec.name}
            })
          }
        },
        initSelection: function(element, callback) {
          var specs = jQuery.parseJSON($(element).attr('specs'));
          callback(data);
        }
    }
  }).select2('data', JSON.parse(tags));

  if( $("#solution_specialization_tokens").attr('read_only') == "true"){
    $("#solution_specialization_tokens").select2("enable", false);
  }


  $("#spec_id").select2({
    placeholder: "Specialization",
    minimumInputLength: 0,
    ajax: {
        url: "/solution_specializations?add_more=true",
        dataType: 'json',
        data: function (term) {
            return {
                q: term, //search term
                type: "all"
            };
        },
        results: function (data) {
          console.log(data);
          return {
            results: $.map(data, function(spec, i){
              return {id :spec.id, text: spec.title}
            })
          }
        }
    },
    initSelection: function(element, callback) {
      var id = $(element).val();
      var text = $(element).attr('spec');
      var data = { id: id, text: text };
      callback(data);
    }
  });

})