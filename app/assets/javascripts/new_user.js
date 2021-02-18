$(function(){
  addUserValidations();

  $('#user_avatar').change(function(){
    if ($(this).val() != ""){
      $("#file-name").text($(this).val().replace(/C:\\fakepath\\/i, ''));
      $("#btn-remove-avatar").removeClass("hidden");
    }
  })
  $("a#btn-remove-avatar").click(function(){
    var fileControl = $("#user_avatar").clone(true);
    $("#user_avatar").replaceWith(fileControl);
    $("#btn-remove-avatar").addClass("hidden");
    $("#file-name").text("");
  })
});

function addUserValidations(){
  $("form.user-form").validate({
    onkeyup: false,
    rules: {
      "user[full_name]": {
        maxlength: 100
      },
      "user[karma]": {
        number: true,
        range: [0, 5000]
      },
      "user[contact_attributes][city]": {
        maxlength: 100
      },
      "user[contact_attributes][phone]": {
        maxlength: 15
      },
      "user[email]": {
        email: true,
        required: true,
        maxlength: 255
      },
      "user[contact_attributes][address]": {
        maxlength: 255
      },
      "user[contact_attributes][skype]": {
        maxlength: 32
      },
      "user[contact_attributes][facebook_link]": {
        url: true,
        maxlength: 2048
      },
      "user[contact_attributes][vkontakte_link]": {
        url: true,
        maxlength: 2048
      },
      "user[contact_attributes][twitter_link]": {
        url: true,
        maxlength: 2048
      },
      "user[contact_attributes][linkedin_link]": {
        url: true,
        maxlength: 2048
      },
      "user[contact_attributes][website_link]": {
        url: true,
        maxlength: 2048
      },
      "user[about]": {
        maxlength: 5000
      },
      "user[additional_info]": {
        maxlength: 5000
      },
      "user[password]": {
        required: true,
        rangelength: [8, 128]
      },
      "user[password_confirmation]": {
        equalTo: "#user_password"
      }
    },
    messages: {
      "user[karma]": "Karma must be from 0 to 5000"
    }
  });
}