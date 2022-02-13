## Create Input
aws iotevents create-input  --cli-input-json file://definition.json

## Input Data
aws iotevents-data batch-put-message --cli-input-json file://test.json

Data must be in [base 64](https://en.wikipedia.org/wiki/Base64)