package checkstyle.checks.type;

import checkstyle.LintMessage.SeverityLevel;
import haxe.macro.Expr;
import haxeparser.Data;
import checkstyle.utils.ComplexTypeUtils;

@name("Dynamic")
@desc("Checks for use of Dynamic type")
class DynamicCheck extends Check {

	override function actualRun() {
		ComplexTypeUtils.walkFile (checker.ast, callbackComplexType);
	}

	function callbackComplexType(t:ComplexType, name:String, pos:Position) {
		if (t == null) return;
		if (isPosSuppressed (pos)) return;
		switch (t) {
			case TPath(p):
				if (p.name == "Dynamic") error (name, pos);
			default:
		}
	}

	function error(name:String, pos:Position) {
		logPos('Dynamic type used: ${name}', pos, severity);
	}
}