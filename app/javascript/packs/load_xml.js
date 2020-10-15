var convert = require('xml-js');

const csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content");

var finalJSON = new Array();

load_xml();
button_listener();

function button_listener() {
  button = document.getElementById('sendDataButton');
  button.addEventListener('click', function(event){
    event.preventDefault();
    console.log('Button was clicked');

    fetch('/bills', {
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrf 
      },
      body: JSON.stringify(finalJSON)
    }).then(function(response){
      return response.json();
    }).then(function(data){
      console.log('data = ', data);
    })
    .catch(function(err){
      console.error(err);
    });
  });
}

function load_xml() {
  var folder = document.getElementById("input_xml_load");

  folder.onchange = function() {
    disableSendButton(true);
    var files = validateXmlFiles(folder.files);
    len = files.length;

    for (i=0; i<len; i+=1) {
      read_xml(files[i], function(result){
        // console.log(result); // THIS WORKS OK
        var jsonVersion = convert.xml2json(result, {compact: false, spaces: 2});
        // var compacted = JSON.stringify(jsonVersion);
        // finalJSON.push(compacted);
        finalJSON.push(jsonVersion);
      });
    }
    disableSendButton(false);
  }
}

function disableSendButton(confirm){
  button = document.getElementById('sendDataButton');
  confirm ? button.disable = true :  button.disable = false; 
}


function read_xml(file, callback) {
  console.log("executing read_xml function");
  var reader = new FileReader();

  reader.onload = function() {
    callback(reader.result)
  }

  var result = reader.readAsText(file);
}

function validateXmlFiles(files) {
  var validXMLs = new Array();
  for(item of files) {
    if ( item.type = "text/xml" ) {
      validXMLs.push(item);
    }
  }
  return validXMLs;
}