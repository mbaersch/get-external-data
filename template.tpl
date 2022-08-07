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
  "description": "read file contents / data from a github repo or any external source using a GET request.",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "file_path",
    "displayName": "Path / URL",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_SERVER___

const sendHttpGet = require("sendHttpGet");

var url = data.file_path;

return sendHttpGet(
  url, 
  {timeout: 500,}
).then(
  function(result) {
    if (result.statusCode === 200) {
      return require('decodeUriComponent')(result.body);
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
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 7.8.2022, 14:47:05
