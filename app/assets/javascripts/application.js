// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

// require popper
//= require jquery3
//= require jquery_ujs
// require bootstrap-sprockets
// require bootstrap

// $("#res").load("/previews/show")
$("#res").load("/previews/edit")

// $("#wiki").load("/welcome")

function getFormData(form) {
  var unindexed_array = form.serializeArray();
  var indexed_array = {};
  // var object_array = [];
  // $.map(unindexed_array, function (n, i) {
  //   key = n['name'];
  //   val = n['value'];
  //
  // });
  $.map(unindexed_array, function (n, i) {
    indexed_array[n['name']] = n['value'];
  });

  return indexed_array;
}

// fetch('/',getFormData($('form')))
//   .then(data => data.json())
//   .then(json => console.log(json));


// https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch
// Example POST method implementation:
async function postData(url = '', data = {}) {
  // Default options are marked with *
  const response = await fetch(url, {
    method: 'POST', // *GET, POST, PUT, DELETE, etc.
    mode: 'cors', // no-cors, *cors, same-origin
    cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
    credentials: 'same-origin', // include, *same-origin, omit
    headers: {
      'Content-Type': 'application/json'
      // 'Content-Type': 'application/x-www-form-urlencoded',
    },
    redirect: 'follow', // manual, *follow, error
    referrerPolicy: 'no-referrer', // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
    body: JSON.stringify(data) // body data type must match "Content-Type" header
  });
  return response.json(); // parses JSON response into native JavaScript objects
  // return response; // parses JSON response into native JavaScript objects
}

// postData('/', getFormData($('form')))
//   .then(data => {
//     console.log(data); // JSON data parsed by `data.json()` call
//   });
a = {}
$(document).ready(function () {
  $("#run").click(() => {
    console.log('Processing!')
    // postData('/index.json', getFormData($('form')))
    // postData('/index', getFormData($('form')))
    // $("#tog").click();

    // disable button
    $(this).prop("disabled", true);
    // add spinner to button
    $(this).html(
      `<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Loading...`
    );

    postData('/', getFormData($('form')))
      .then(data => {
        console.log(data); // JSON data parsed by `data.json()` call
        a = data;
        $("#res").text(JSON.stringify(data));
        // $("#editor").text(JSON.stringify(data));
        // $("#editor").text(JSON.stringify(data));
        $("#out").text(data['output']);
        editor.setValue(JSON.stringify(data['input'] || {}, null, '\t'));
        // $("#tog").click();
        // $("#tog").collapse('show');
        $("#rescard").collapse('show');
        // $("#rescard").focusin()
      }).then(data => {
      $(this).prop("disabled", false);
    });

    // var data = await postData('/', getFormData($('form'))); // todo: wynw!?
  });


  // ---------
// Ace

  // https://jsfiddle.net/xlaptop2001/y70gL3kv/ // todo: ace file loader and saver
  loadAce();

  function loadAce() {
    editor = ace.edit("editor");
    editor.getSession().setUseWorker(false);
    editor.setTheme("ace/theme/monokai");
    editor.getSession().setMode("ace/mode/json");

    // editor.setValue(JSON.stringify(jsonDoc, null, '\t'));
    $('#mode').on('change', function (ev) {
      var mode = $('#mode option:selected').attr('value');
      console.log(mode)
      editor.getSession().setMode(mode);
    });
  }


});

// $(document).ready(function () {
//   var formBasic = function () {
//     var formData = $("#wikiForm").serialize();
//     $.ajax({
//       type: 'post',
//       data: formData,
//       dataType: 'json',
//       url: '/textedit/wiki',
//
//       error: function () {
//         alert("There was an error processing this page.");
//         return false;
//       },
//
//       complete: function (output) {
//         $('#wikiFormResults').html(output.responseText);
//       }
//     });
//     return false;
//   };
//
//   $("#basic-submit").on("click", function (e) {
//     e.preventDefault();
//     formBasic();
//   });
// });

// $(function () {
//   $(".btn").click(function () {
//     // $(this).button('loading').delay(1000).queue(function() {
//     //   $(this).button('reset');
//     //   $(this).dequeue();
//     // });
//     console.log('kod')
//     // $(this).button('loading').button('reset')
//
//     var formBasic = function () {
//       var formData = $("#wikiForm").serialize();
//       $.ajax({
//         type: 'post',
//         data: formData,
//         dataType: 'json',
//         url: '/textedit/wiki',
//
//         error: function () {
//           alert("There was an error processing this page.");
//           return false;
//         },
//
//         complete: function (output) {
//           $('#wikiFormResults').html(output.responseText);
//         }
//       });
//       return false;
//     };
//
//     $(this).on("click", function (e) {
//       e.preventDefault();
//       formBasic();
//     });
//   });
// });


// {"utf8": "✓",
//   "authenticity_token":"K7IIWO4FUOpNMwpNEosMzD9tUHeAewXbpc98GL6Tr4YbzwhExvC/flu3fu8WX3TImfkIqX/e4nAYOPbsze1y0A==",
//   "wikiinput": {
//   "filename": "",
//   "config": "1",
//   "template": "123",
//   "sections": "kod\r\n\r\n    sar"
//     }}
//
//   "textedit": {"wikiinput[filename]": "", "wikiinput[config]": "1", "wikiinput[template]": "123", "wikiinput[sections]": "kod\r\n\r\n    sar"}}
