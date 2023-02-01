%dw 2.0
output application/json
import substringBefore from dw::core::Strings
---
{
   "error":{
      "correlationId": vars.vCorrelationId default correlationId,
      "appName": Mule::p('app.name'),
      "timestamp": now() >> Mule::p('systems.restriction.constants.response.timezone'),
      "errorCode":error.errorType.asString,
		"errorDescription":error.errorDescription     
   }
}