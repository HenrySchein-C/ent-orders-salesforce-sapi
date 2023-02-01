%dw 2.0
output application/java
var badRequest= 'APIKIT:BAD_REQUEST,HTTP:BAD_REQUEST,SFTP:ILLEGAL_CONTENT,DB:BAD_SQL_SYNTAX,AS400:ILLEGAL_PROGRAM_PARAMETER,ANYPOINT-MQ:ILLEGAL_BODY,SALESFORCE:INVALID_INPUT'
var notFound= 'APIKIT:NOT_FOUND,HTTP:NOT_FOUND,ANYPOINT-MQ:DESTINATION_NOT_FOUND,VM:EMPTY_QUEUE,SALESFORCE:NOT_FOUND'
var methodNotAllowed= 'APIKIT:METHOD_NOT_ALLOWED,HTTP:METHOD_NOT_ALLOWED'
var notAcceptable= 'APIKIT:NOT_ACCEPTABLE,HTTP:NOT_ACCEPTABLE,ANYPOINT-MQ:ACKING,ANYPOINT-MQ:NACKING'
var unsupportedMediaType= 'APIKIT:UNSUPPORTED_MEDIA_TYPE,HTTP:UNSUPPORTED_MEDIA_TYPE'
var notImplemented= 'APIKIT:NOT_IMPLEMENTED'
var forbidden= 'HTTP:FORBIDDEN,SFTP:ACCESS_DENIED,AS400:INVALID_LICENSE'
var unauthorized= 'HTTP:UNAUTHORIZED,SALESFORCE:MUTUAL_AUTHENTICATION_FAILED,DB:INVALID_CREDENTIALS'
var timeout= 'HTTP:TIMEOUT,ANYPOINT-MQ:TIMEOUT,VM:QUEUE_TIMEOUT,SALESFORCE:TIMEOUT'
var illegalPath= 'SFTP:ILLEGAL_PATH'
var fileAlreadyExists= 'SFTP:FILE_ALREADY_EXISTS'
var fileLock= 'SFTP:FILE_LOCK'
var badGateway= 'HTTP:BAD_GATEWAY'
var serviceUnavailable= 'HTTP:SERVICE_UNAVAILABLE'
var security= 'HTTP:SECURITY,HTTP:CLIENT_SECURITY'
var tooManyRequests= 'HTTP:TOO_MANY_REQUESTS,SALESFORCE:LIMIT_EXCEEDED'
---
if ((badRequest splitBy(',')) contains error.errorType.asString) Mule::p('errorCode.badRequest')
else if ((notFound splitBy(',')) contains error.errorType.asString) Mule::p('errorCode.notFound')
else if ((methodNotAllowed splitBy(',')) contains error.errorType.asString) Mule::p('errorCode.methodNotAllowed')
else if ((notAcceptable splitBy(',')) contains error.errorType.asString) Mule::p('errorCode.notAcceptable')
else if ((unsupportedMediaType splitBy(',')) contains error.errorType.asString) Mule::p('errorCode.unsupportedMediaType')
else if (error.errorType.asString == notImplemented) Mule::p('errorCode.notImplemented')
else if ((forbidden splitBy(',')) contains error.errorType.asString) Mule::p('errorCode.forbidden')
else if ((unauthorized splitBy(',')) contains error.errorType.asString) Mule::p('errorCode.unauthorized')
else if ((timeout splitBy(',')) contains error.errorType.asString) Mule::p('errorCode.timeout')
else if (error.errorType.asString == illegalPath) Mule::p('errorCode.illegalPath')
else if (error.errorType.asString == fileAlreadyExists) Mule::p('errorCode.fileAlreadyExists')
else if (error.errorType.asString == fileLock) Mule::p('errorCode.fileLock')
else if (error.errorType.asString == badGateway) Mule::p('errorCode.badGateway')
else if (error.errorType.asString == serviceUnavailable) Mule::p('errorCode.serviceUnavailable')
else if ((security splitBy(',')) contains error.errorType.asString) Mule::p('errorCode.security')
else if ((tooManyRequests splitBy(',')) contains error.errorType.asString) Mule::p('errorCode.tooManyRequests')
else Mule::p('errorCode.internalServerError')