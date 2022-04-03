
import cpp
from MacroInvocation macroInv
where macroInv.getMacroName().regexpMatch("ntoh.*")
select macroInv.getExpr()