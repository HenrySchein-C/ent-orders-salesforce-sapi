%dw 2.0
output application/json
var allSuccessRespCode = Mule::p('systems.restriction.constants.response.restrictions.code.success')
var allSuccessRespMsg = Mule::p('systems.restriction.constants.response.restrictions.msg.success')
var totalcount = sizeOf (payload.payload)
var technicalerrorcount = sizeOf (payload.payload filter ((obj, objindex) -> obj.error?))
var nontechnicalerrorcount = sizeOf (payload.payload filter ((obj, objindex) -> !isEmpty(obj.itmStatusCode)))
var allerrorRespMsg = Mule::p('systems.restriction.constants.response.restrictions.msg.error')
var partialRespMsg = Mule::p('systems.restriction.constants.response.restrictions.msg.partialerror')
---

{
    "meta": {
        "httpStatusCode": allSuccessRespCode,
        "message": if(technicalerrorcount+nontechnicalerrorcount==0) allSuccessRespMsg
        	else if(totalcount==technicalerrorcount+nontechnicalerrorcount) allerrorRespMsg
        		else partialRespMsg,
        "correlationId": correlationId,
        "timestamp": now(),
        "totalFlowElapsedTime": now() - vars.vCallStartTime
        
    }, 
    data:   {
	restrictionsResponse:
	{
		accountInfo:
		{
			billTo: payload.payload[0].billTo,
			shipTo: payload.payload[0].shipTo
		},
		addressOverrideInfo:
		{
			"zipCode": payload.payload[0].zipCode,
			"stateCode": payload.payload[0].StateCode,
			"countryCode": payload.payload[0].countryCode
		},
		productEntries: payload.payload map(item,value)->
		{
			elapsedTime: (now()) - (vars.vCallStartTime),
			sku: item.itemCode,
			isRestricted: if(item.IsRestricted == "Y") true else false,
			restrictionType: item.resType default '',
			restrictionName: item.resName default '',
			source:  "JDE",
			restrictionCode: item.resCode default '',
			restrictionMessage: item.resMsg default '',
			error:
			{
				code: if(item.itmStatusCode?)
				if(sizeOf(item.itmStatusCode)>0) item.itmStatusCode else ''
					else if (item.error?) item.error.code
						else '',
						
				message: if(item.itmStatusMsg?)
				if(sizeOf(item.itmStatusMsg)>0) item.itmStatusMsg else ''
					else if(item.error?) item.error.details
						else '',
						
			}  
			
		}
	}
	
}
}
