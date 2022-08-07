___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Get External Data",
  "categories": [
    "UTILITY"
  ],
  "description": "read file contents / data from a github repo or any external source using a GET request. Optional caching in templateDataStorage",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "filePath",
    "displayName": "Path / URL",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "cacheTime",
    "displayName": "Cache Time (ms)",
    "simpleValueType": true,
    "valueHint": "0 \u003d no caching",
    "valueValidators": [
      {
        "type": "NON_NEGATIVE_NUMBER"
      }
    ],
    "defaultValue": 0
  }
]


___SANDBOXED_JS_FOR_SERVER___

const sendHttpGet = require("sendHttpGet");
const JSON = require("JSON");
const templateDataStorage = require("templateDataStorage");
const getTimestampMillis = require("getTimestampMillis"); 

const url = data.filePath;
const cacheKey = require('sha256Sync')(url, {outputEncoding: 'hex'});
const cacheTime = data.cacheTime;

if (cacheTime > 0) {
  var cachedUrlResult = templateDataStorage.getItemCopy(cacheKey);
  if (cachedUrlResult) {
    var cacheJSON = JSON.parse(cachedUrlResult);
    if (cacheJSON && (getTimestampMillis() - (cacheJSON.timestamp||0) < cacheTime)) {
      return cacheJSON.result;
    } 
  }
}

return sendHttpGet(
  url, 
  {timeout: 500,}
).then(
  function(result) {
    if (result.statusCode === 200) {
      const res = require('decodeUriComponent')(result.body);
      if (cacheTime > 0) { 
        var cacheContent = JSON.stringify({timestamp: getTimestampMillis(), result: res});
        templateDataStorage.setItemCopy(cacheKey, cacheContent);
      }  
      return res;
    }
  }, function() {return undefined;}
);


___SERVER_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "send_http",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedUrls",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_template_storage",
        "versionId": "1"
      },
      "param": []
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 7.8.2022, 14:47:05
