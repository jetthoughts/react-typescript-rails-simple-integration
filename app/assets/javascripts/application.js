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
  function checkFormValidity() {
    var form = $("#wikiForm")[0]
    if (form.checkValidity()) {
      // alert('validated');
      console.log('wikiForm valid!')
      return true;
    } else {
      form.reportValidity();
      return false;
    }
  }

  $("#load").on('click', () => {
    // $("#sec").val(sample_section)
    // $("#temp").val(sample_template)
    $("#dep").val(sample_depth || 0)

    $("#sec").val($("#sec2").text())
    $("#temp").val($("#temp2").text())
    // $("#lay").val('default').click()
    $("#lay").val('default').click()
  });

  // $("#run").click(() => {
  $("#run").on('click', () => {
    if (!checkFormValidity()) {
      return
    }

    console.log('Processing...')
    // postData('/index.json', getFormData($('form')))
    // postData('/index', getFormData($('form')))
    // $("#tog").click();

    let current_button = $("#run").html();

    let reset_button = () => {
      $("#run").prop("disabled", false);
      $("#run").html(current_button);
    }

    // disable button
    $("#run").prop("disabled", true);
    // add spinner to button
    $("#run").html(
      `<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Loading...`
    );

    postData('/', getFormData($('form')))
      .then(data => {
        console.log(data); // JSON data parsed by `data.json()` call
        a = data;
        //for debugging
        // $("#res").text(JSON.stringify(data));

        // $("#editor").text(JSON.stringify(data));
        // $("#editor").text(JSON.stringify(data));
        output = data['output']
        // editor1 = loadAce('editor1', 'mode1', 'ace/mode/text');
        $("#out").html(output);
        editor1.setValue(output);
        // editor1.setValue(output);
        // editor1.resize();

        // // json = JSON.stringify(data['input'] || {}, null, '\t')
        // delete data['output'];
        // json = JSON.stringify(data || {}, null, '\t')
        // // json = data
        // editor2 = loadAce('editor2', 'mode2', 'ace/mode/json');
        // editor2.setValue(json);

        // editor.resize();
        // editor.renderer.updateFull();

        // $("#tog").click();
        // $("#tog").collapse('show');
        $("#rescard").collapse('show');
        // $("#rescard").focusin()
        // }).then(data => {
        // reset_button();
      }).finally(() => {
      editor1.resize();
      editor1.renderer.updateFull();
      reset_button()
    });

    // var data = await postData('/', getFormData($('form'))); // todo: wynw!?
  });


  // ---------
// Ace
//   editor1 = loadAce('editor1', 'mode1', 'ace/mode/text');
  editor1 = loadAce('editor', 'mode', 'ace/mode/xquery');

  // https://jsfiddle.net/xlaptop2001/y70gL3kv/ // todo: ace file loader and saver
  // default_editor = loadAce('editor', 'mode', 'ace/mode/javascript');

  function loadAce(editor_div_id, mode_id, default_mode) {
    var editor = ace.edit(editor_div_id);
    editor.getSession().setUseWorker(false);
    editor.setTheme("ace/theme/monokai");
    editor.getSession().setMode(default_mode);
    // editor.resize();
    // editor.renderer.updateFull();

    // editor.setValue(JSON.stringify(jsonDoc, null, '\t'));
    $('#' + mode_id).on('change', function (ev) {
      var mode = $('#mode option:selected').attr('value');
      console.log(mode)
      editor.getSession().setMode(mode);
    });

    $('#' + mode_id).val(default_mode)
    return editor
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
