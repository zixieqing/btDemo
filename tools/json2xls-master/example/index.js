var json2xls = require('../lib/json2xls');
var fs = require('fs');
var path = require("path");

var jsonInput = __dirname +"/jsonFiles"
var jsonOutput = __dirname +"/output"


function startParse(jsonFile){
    var data = require(jsonFile);
    const keys = Object.keys(data); 
    var xls = json2xls(data[keys[0]],{});
    var outputJsonFile = path.join(jsonOutput, keys[0] + '.xlsx')
    fs.writeFileSync(outputJsonFile, xls, 'binary');
}

function readJsonFile(jsonDir){
    var files = fs.readdirSync(jsonDir);
    files.forEach(function (file, index) {
        var filePath = path.join(jsonDir, file)
        if (fs.statSync(filePath).isDirectory()) {
            readJsonFile(filePath)
        } else {
            if (path.extname(filePath) == ".json"){
                startParse(filePath)
            }
        }
    })
}

readJsonFile(jsonInput)

