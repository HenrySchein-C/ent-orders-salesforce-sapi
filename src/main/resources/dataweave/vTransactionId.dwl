%dw 2.0
output application/java
---
if(payload.rationingRequest?)'billToId: ' ++ (payload.rationingRequest.accountInfo.billTo default '') ++ ' ShipToId: ' ++ (payload.rationingRequest.accountInfo.shipTo default '')
else if(payload.restrictionsRequest?)'billToId: ' ++ (payload.restrictionsRequest.accountInfo.billTo default '') ++ ' ShipToId: ' ++ (payload.restrictionsRequest.accountInfo.shipTo default '')
else
"NA"