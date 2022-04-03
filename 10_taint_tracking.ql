
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph

import cpp

class NetWorkByteSwap extends Expr{
    NetWorkByteSwap(){
        exists(MacroInvocation macro | macro.getMacroName().regexpMatch("ntoh(s|l|ll)")  and this= macro.getExpr())
    }
}
class Config extends TaintTracking::Configuration{
    Config() {this = "NetworkMemFuncLength"}
    override predicate isSource(DataFlow::Node source) {
        source.asExpr() instanceof NetWorkByteSwap
    }
    override predicate isSink(DataFlow::Node sink ) {
        exists(FunctionCall funcall | funcall.getTarget().hasName("memcpy") and sink.asExpr() = funcall.getArgument(2) )
    }
}

from Config cfg,DataFlow::PathNode source,DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink,source,sink,"Network byte swap flows to memcpy"