%dw 2.0
output application/json
---
{
	"response" : {
		"httpStatus": Mule::p('http.response.code.success'),
        "status": if(isEmpty(payload)) Mule::p('http.constants.response.success') else Mule::p('http.constants.response.success'),
        "message" : "Payload was sucessfully inserted into salesforce",
        "correlationId": vars.vCorrelationId,
        "timestamp": now()
	}}