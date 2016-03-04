package checks.block;

import checkstyle.checks.block.LeftCurlyCheck;

class LeftCurlyCheckTest extends CheckTestCase {

	public function testCorrectBraces() {
		var check = new LeftCurlyCheck();
		assertMsg(check, LeftCurlyTests.TEST, '');
		assertMsg(check, LeftCurlyTests.TEST4, '');
		assertMsg(check, LeftCurlyTests.TEST6, '');
		assertMsg(check, LeftCurlyTests.TEST8, '');
		assertMsg(check, LeftCurlyTests.TEST9, '');
		assertMsg(check, LeftCurlyTests.TEST14, '');
		assertMsg(check, LeftCurlyTests.EOL_CASEBLOCK, '');
		assertMsg(check, LeftCurlyTests.MACRO_REIFICATION, '');
	}

	public function testWrongBraces() {
		var check = new LeftCurlyCheck();
		assertMsg(check, LeftCurlyTests.TEST1, 'Left curly should be at EOL (only linebreak or comment after curly)');
		assertMsg(check, LeftCurlyTests.TEST2, 'Left curly should be at EOL (only linebreak or comment after curly)');
		assertMsg(check, LeftCurlyTests.TEST3, 'Left curly should be at EOL (only linebreak or comment after curly)');
		assertMsg(check, LeftCurlyTests.TEST3, 'Left curly should be at EOL (only linebreak or comment after curly)');
		assertMsg(check, LeftCurlyTests.TEST5, 'Left curly should be at EOL (only linebreak or comment after curly)');
		assertMsg(check, LeftCurlyTests.TEST7, 'Left curly should be at EOL (only linebreak or comment after curly)');
		assertMsg(check, LeftCurlyTests.TEST10, 'Left curly should be at EOL (only linebreak or comment after curly)');
		assertMsg(check, LeftCurlyTests.NL_CASEBLOCK, 'Left curly should be at EOL (only linebreak or comment after curly)');
		assertMsg(check, LeftCurlyTests.NLOW_CASEBLOCK, 'Left curly should be at EOL (only linebreak or comment after curly)');
	}

	public function testBraceOnNL() {
		var check = new LeftCurlyCheck();
		check.option = LeftCurlyCheck.NL;

		assertMsg(check, LeftCurlyTests.TEST, 'Left curly should be on new line (only whitespace before curly)');
		assertMsg(check, LeftCurlyTests.TEST13, '');

		check.tokens = [LeftCurlyCheck.OBJECT_DECL];
		assertMsg(check, LeftCurlyTests.TEST4, 'Left curly should be on new line (only whitespace before curly)');
		assertMsg(check, LeftCurlyTests.TEST14, 'Left curly should be on new line (only whitespace before curly)');

		check.tokens = [LeftCurlyCheck.IF];
		assertMsg(check, LeftCurlyTests.TEST1, '');
		assertMsg(check, LeftCurlyTests.TEST13, '');

		check.tokens = [LeftCurlyCheck.FOR];
		assertMsg(check, LeftCurlyTests.TEST5, '');
		assertMsg(check, LeftCurlyTests.TEST13, '');

		check.tokens = [LeftCurlyCheck.FUNCTION];
		assertMsg(check, LeftCurlyTests.TEST13, '');
	}

	public function testSwitch() {
		var check = new LeftCurlyCheck();
		check.option = LeftCurlyCheck.NL;
		assertMsg(check, LeftCurlyTests.TEST15, '');
		assertMsg(check, LeftCurlyTests.NL_CASEBLOCK, '');
		assertMsg(check, LeftCurlyTests.EOL_CASEBLOCK, 'Left curly should be on new line (only whitespace before curly)');
		assertMsg(check, LeftCurlyTests.NLOW_CASEBLOCK, 'Left curly should be on new line (only whitespace before curly)');
	}

	public function testNLOW() {
		var check = new LeftCurlyCheck();
		check.option = LeftCurlyCheck.NLOW;
		assertMsg(check, LeftCurlyTests.TEST, '');
		assertMsg(check, LeftCurlyTests.TEST12, '');
		assertMsg(check, LeftCurlyTests.TEST16, '');
		assertMsg(check, LeftCurlyTests.NLOW_CASEBLOCK, '');
		assertMsg(check, LeftCurlyTests.TEST17, 'Left curly should be at EOL (previous expression is not split over muliple lines)');
		assertMsg(check, LeftCurlyTests.TEST18, 'Left curly should be on new line (previous expression is split over muliple lines)');
		assertMsg(check, LeftCurlyTests.TEST19, 'Left curly should be on new line (previous expression is split over muliple lines)');
	}

	public function testReification() {
		var check = new LeftCurlyCheck();
		check.tokens = [LeftCurlyCheck.REIFICATION];
		assertMsg(check, LeftCurlyTests.MACRO_REIFICATION, 'Left curly should be at EOL (only linebreak or comment after curly)');
	}

	public function testIgnoreEmptySingleline() {
		var check = new LeftCurlyCheck();
		check.ignoreEmptySingleline = false;
		assertMsg(check, LeftCurlyTests.NO_FIELDS_CLASS, 'Left curly should be at EOL (only linebreak or comment after curly)');
		assertMsg(check, LeftCurlyTests.NO_FIELDS_MACRO, 'Left curly should be at EOL (only linebreak or comment after curly)');

		check.ignoreEmptySingleline = true;
		assertMsg(check, LeftCurlyTests.NO_FIELDS_CLASS, '');
		assertMsg(check, LeftCurlyTests.NO_FIELDS_MACRO, '');
	}
}

class LeftCurlyTests {
	public static inline var TEST:String = "
	class Test {
		function test() {
			if (true) {
				return;
			}

			if (true) return;
			else {
				return;
			}

			if (true) { // comment
				return;
			}
			else if (false) { /* comment */
				return;
			}

			for (i in 0...10) {
				return i;
			}

			while (true) {
				return;
			}
		}
		@SuppressWarnings('checkstyle:LeftCurly')
		function test1()
		{
			if (true)
			{
				return;
			}

			for (i in 0...10)
			{
				return i;
			}

			while (true)
			{
				return;
			}
		}
	}";

	public static inline var TEST1:String = "
	class Test {
		function test() {
			if (true)
			{
				return;
			}
		}
	}";

	public static inline var TEST2:String = "
	class Test {
		function test() {
			if (true)
			{ // comment
				return;
			}
			else
				return;
		}
	}";

	public static inline var TEST3:String = "
	class Test {
		function test()
		{
			if (true) {
				return;
			}
			else {
				return;
			}
		}
	}";

	public static inline var TEST4:String = "
	class Test {
		function test() {
			if (true) return { x:1,
				y:2,
				z:3 };
		}
	}";

	public static inline var TEST5:String = "
	class Test {
		function test() {
			for (i in 0...10)
			{
				return i;
			}
		}
	}";

	public static inline var TEST6:String = "
	class Test {
		function test() {
			for (i in 0...10) if (i < 5) {
				return i;
			}
		}
	}";

	public static inline var TEST7:String = "
	class Test {
		function test() {
			while (true) { return i; }
		}
	}";

	public static inline var TEST8:String = "
	class Test {
		function test() {
			while (true) {
				return i;
			}
		}
	}";

	public static inline var TEST9:String = "
	class Test {
		function test() {
			for (i in 0....10) return i;
		}
	}";

	public static inline var TEST10:String = "
	class Test
	{
		function test() {
			if (true) return;
		}
	}";

	public static inline var TEST12:String = "
	class Test {
		function test() {
			var struct = {x:10, y:10, z:20};
		}
	}";

	public static inline var TEST13:String = "
	class Test
	{
		function test()
		{
			if (true)
			{ // comment
				return;
			}
			else
			{
				if (false)
				{
					return;
				}
			}
		}
	}";

	public static inline var TEST14:String = "
	typedef Test = {
		x:Int,
		y:Int,
		z:Int,
		point:{x:Int, y:Int, z:Int}
	}";

	public static inline var TEST15:String = "
	class Test
	{
		public function test(val:Bool):String
		{
			switch(val)
			{
				case true: // do nothing
				default:
					return 'test abc ${val}';
			}
		}
	}";

	public static inline var TEST16:String = "
	class Test {
		public function test(val:Int,
				val2:Int):String
		{
			switch(val * 10 -
					val / 10)
			{
				case 0: // do nothing
				default:
			}
		}
	}";

	public static inline var TEST17:String = "
	class Test {
		public function test(val:Int, val2:Int):String
		{
			switch(val * 10 - val / 10)
			{
				case 1: // do nothing
				default:
			}
		}
	}";

	public static inline var TEST18:String = "
	class Test {
		public function test(val:Int,
				val2:Int):String {
			switch(val * 10 -
					val / 10)
			{
				case 0: // do nothing
				default:
			}
		}
	}";

	public static inline var TEST19:String = "
	class Test {
		public function test(val:Int,
				val2:Int):String
		{
			switch(val * 10 -
					val / 10) {
				case 0: // do nothing
				default:
			}
		}
	}";

	public static inline var NL_CASEBLOCK:String = "
	class Test
	{
		public function test(val:Int,
				val2:Int):String
		{
			switch(val)
			{
				case 0:
				{
					// do nothing
				}
				default:
			}
		}
	}";

	public static inline var EOL_CASEBLOCK:String = "
	class Test {
		public function test(val:Int,
				val2:Int):String {
			switch(val) {
				case 0: {
					// do nothing
				}
				default:
			}
		}
	}";

	public static inline var NLOW_CASEBLOCK:String = "
	class Test {
		public function test(val:Int,
				val2:Int):String
		{
			switch(val) {
				case (true ||
					!false):
				{
					// do nothing
				}
				default:
			}
		}
	}";

	public static inline var MACRO_REIFICATION:String = "
	class Test {
		public function test(val:Int) {
			var str = 'Hello, world';
			var expr = macro for (i in 0...10) trace($v{str});
			var e = macro ${str}.toLowerCase();
		}
	}";

	public static inline var NO_FIELDS_CLASS:String = "
	class Test {}
	";

	public static inline var NO_FIELDS_MACRO:String = "
	class Test {
		var definition = macro class Font extends flash.text.Font {};
	}";
}