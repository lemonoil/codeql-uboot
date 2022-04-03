

import cpp
from FunctionCall call, Function func
where 
    call.getTarget().hasName("memcpy")
select call