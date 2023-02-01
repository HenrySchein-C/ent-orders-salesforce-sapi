%dw 2.0
import * from dw::util::Timer
output application/json
---
{
	"shipTo": vars.vProcessingPayload.rationingRequest.accountInfo.shipTo,
	"billTo": vars.vProcessingPayload.rationingRequest.accountInfo.billTo,
	
            ItemCode: payload.sku,
            
            "ItemUom": payload.unitOfMeasure,
            
        
	"error" : {
		"isTechnical" : true,
		"code" : error.errorType.asString,
		"details" : error.description default ''
	}
}