
import cpp

class NetworkByteSwap extends Expr{
    NetworkByteSwap(){
        exists(MacroInvocation macro | macro.getMacroName().regexpMatch("ntoh.*") and macro.getExpr() = this )

    }
}


from NetworkByteSwap x
select x, "Network byte swap"
