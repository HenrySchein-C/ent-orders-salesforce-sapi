%dw 2.0
output application/json
import substringBefore from dw::core::Strings
---
{
	"meta": {
        "httpStatusCode": if(error.errorType.asString == Mule::p('operations.constants.errorType.badRequest')) Mule::p('operations.constants.errorCode.badRequest')
			else if(error.errorType.asString == Mule::p('operations.constants.errorType.notFound')) Mule::p('operations.constants.errorCode.notFound')           
			else if (error.errorType.asString == Mule::p('operations.constants.errorType.methodNotAllowed')) Mule::p('operations.constants.errorCode.methodNotAllowed')           
			else if (error.errorType.asString == Mule::p('operations.constants.errorType.notAcceptable')) Mule::p('operations.constants.errorCode.notAcceptable')           
			else if (error.errorType.asString == Mule::p('operations.constants.errorType.unsupportedMediaType')) Mule::p('operations.constants.errorCode.unsupportedMediaType')          
			else if (error.errorType.asString == Mule::p('operations.constants.errorType.notImplemented')) Mule::p('operations.constants.errorCode.notImplemented')
			else Mule::p('operations.constants.errorCode.internalServerError'),
		"code": error.errorType.asString,
        "message": "'E and T salesforce SAPI Error occurred",
        "correlationId": vars.vCorrelationId default correlationId,
      	"appName": Mule::p('app.name'),
      	"timestamp": now()
        
    }, 
   "error":{
      
      "errorCode":error.errorType.asString,
		"errorMessage":error.description     
   }
}