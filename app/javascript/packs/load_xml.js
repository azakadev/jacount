const convert = require('xml-js');
const axios = require('axios');

const csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content");

var finalJSON = new Array();

load_xml();
button_listener();

function button_listener() {
  let button = document.getElementById('sendDataButton');
  button.addEventListener('click', function(event){
    event.preventDefault();

    axios.post(
      '/bills',
      JSON.stringify(finalJSON),
      {
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrf 
        },
        onUploadProgress: (progressEvent) => {
          const percentage = Math.round(
            (progressEvent.loaded * 100) / progressEvent.total
          );
          // percentLoader.open({ percentage, speed: 20 });
          console.log(percentage);
        }
      }).then((resp) => {
        console.log(resp);
      })
      .catch((error) => console.log(error));
  });
}

function load_xml() {
  var folder = document.getElementById("input_xml_load");
  const loadInfo = document.getElementById("loadInfo");

  folder.onchange = function() {
    disableSendButton(true);

    loadInfo.innerHTML = 'Validando archivos XML...';
    var files = validateXmlFiles(folder.files);
    setTimeout(() => { loadInfo.innerHTML = '¡Se validaron los archivos XML!'; }, 2000);
    

    setTimeout(() => { loadInfo.innerHTML ='Preparando archivos XML'; }, 2000);
    let len = files.length;

    for (let i=0; i<len; i+=1) {
      loadInfo.innerHTML = `${i*100/len}%`;

      read_xml(files[i], function(result){
        // console.log(result); // THIS WORKS OK
        var jsonVersion = convert.xml2json(result, {compact: false, spaces: 2});
        // var compacted = JSON.stringify(jsonVersion);
        // finalJSON.push(compacted);
        finalJSON.push(jsonVersion);
      });
    }
    setTimeout(() => { loadInfo.innerHTML = '¡Ahora puedes cargar los archivos XML!'; }, 2000);

    disableSendButton(false);
  }
}

function disableSendButton(confirm){
  let button = document.getElementById('sendDataButton');
  confirm ? button.disable = true :  button.disable = false; 
}


function read_xml(file, callback) {
  var reader = new FileReader();

  reader.onload = function() {
    callback(reader.result)
  }
  var result = reader.readAsText(file);
}

function validateXmlFiles(files) {
  let validXMLs = new Array();
  for(const item of files) {
    if ( item.type == "text/xml" ) {
      validXMLs.push(item);
    }
  }
  return validXMLs;
}