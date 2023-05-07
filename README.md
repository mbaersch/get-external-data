# Get External Data 

**Custom Variable Template for Server-Side Google Tag Manager**

Variable for receiving file contents / data from external url or simple APIs using a GET request

[![Template Status](https://img.shields.io/badge/Community%20Template%20Gallery%20Status-published-green)](https://tagmanager.google.com/gallery/#/owners/mbaersch/templates/get-external-data) ![Repo Size](https://img.shields.io/github/repo-size/mbaersch/get-external-data) ![License](https://img.shields.io/github/license/mbaersch/get-external-data)

---


## Usage
Define any URL as input value. The variable will call that URL in a GET request and return the response body as value. If the result is a JSON string, you can use https://github.com/mbaersch/extract-json to extract a single key from the response. 
