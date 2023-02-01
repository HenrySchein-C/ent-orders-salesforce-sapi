%dw 2.0
output application/json
import substringBefore from dw::core::Strings
---
{
   "error":{
      "correlationId": vars.vCorrelationId default correlationId,
      "appName": Mule::p('app.name'),
      "timestamp": now(),
      "errorCode": vars.vHttpStatus,
      "errorMessage": error.description
   }
}