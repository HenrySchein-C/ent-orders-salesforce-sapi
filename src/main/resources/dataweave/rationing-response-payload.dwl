%dw 2.0
output application/json
var allSuccessRespCode = Mule::p('systems.rationing.constants.response.rationings.code.success')
var allSuccessRespMsg = Mule::p('systems.rationing.constants.response.rationings.msg.success')
var totalcount = sizeOf (vars.vSku.payload)
var technicalerrorcount = sizeOf (vars.vSku.payload filter ((obj, objindex) ->obj.error?))
var nontechnicalerrorcount = sizeOf (vars.vSku.payload filter ((obj, objindex) -> !isEmpty(obj.ERR_ERRCD)))
var allerrorRespMsg = Mule::p('systems.rationing.constants.response.rationings.msg.error')
var partialRespMsg = Mule::p('systems.rationing.constants.response.rationings.msg.partialerror')
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
    data:{
	rationingResponse:
	{
		accountInfo:
		{
			billTo: vars.vSku.payload[0].billTo,
			shipTo: vars.vSku.payload[0].shipTo
		},
		
		productEntries: vars.vSku.payload map(item,value)->
		{
			elapsedTime: (now()) - (vars.vCallStartTime),
			sku: item.ItemCode,
			unitOfMeasure: item.ItemUom,
			rationLimit: item.RatQty default 0,
			rationLimitUnitOfMeasure: item.rtnItemUom default '',
			rationLookBackInDays: item.RatLookBck default 0,
			quantityPurchased: item.QtyPurchased default 0,
			quantityPurchasedUnitOfMeasure: item.QtyPurUom default '',
			allowedQuantityInPrimaryUnitOfMeasure: item.QtyAllowedPri default 0,
			primaryUnitOfMeasure: item.QtyPurUom default '',
			allowedQuantityInSecondaryUnitOfMeasure:item.QtyAllowedSec default 0,
			secondaryUnitOfMeasure: item.QtySecUom default '',
			rationType: item.RatType default '',
			rationGroupName: item.RatGroup default '',
			source:"JDE",
			error:
			{
				code: if(item.ERR_ERRCD?)
					if(sizeOf(item.ERR_ERRCD)>0) item.ERR_ERRCD else ''
					else if (item.error?) item.error.code
					else '',
				message: if(item.ERR_ERRDES?)
				if(sizeOf(item.ERR_ERRDES)>0) item.ERR_ERRDES else ''
					else if(item.error?) item.error.details
					else ''
			}	
		}
	}
}
}
