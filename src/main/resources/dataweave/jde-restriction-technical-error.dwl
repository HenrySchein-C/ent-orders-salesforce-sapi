%dw 2.0
import * from dw::util::Timer
output application/json
---
{
	"shipTo": vars.vProcessingPayload.restrictionsRequest.accountInfo.shipTo,
	"billTo": vars.vProcessingPayload.restrictionsRequest.accountInfo.billTo,
	
    zipCode: vars.vProcessingPayload.restrictionsRequest.addressOverrideInfo.zipCode,
    StateCode: vars.vProcessingPayload.restrictionsRequest.addressOverrideInfo.stateCode,
    countryCode: vars.vProcessingPayload.restrictionsRequest.addressOverrideInfo.countryCode,
    itemCode :payload.sku,    
        
	"error" : {
		"isTechnical" : true,
		"code" : error.errorType.asString,
		"details" : error.description default ''
	}
}