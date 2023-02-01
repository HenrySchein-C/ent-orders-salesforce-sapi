%dw 2.0
output application/java
---
now() >> Mule::p('systems.restriction.constants.response.timezone')