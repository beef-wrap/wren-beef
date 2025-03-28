using System;
using System.Collections;
using System.Diagnostics;
using System.IO;

using static wren.wren;

namespace example;

static class Program
{
	static void writeFn(WrenVM* vm, char8* text)
	{
		Debug.WriteLine(StringView(text));
	}

	static void errorFn(WrenVM* vm, WrenErrorType errorType, char8* module, int32 line, char8* msg)
	{
		switch (errorType)
		{
		case .WREN_ERROR_COMPILE:
			Debug.WriteLine($"[{module} line {line}] [Error] {msg}", module, line, msg);
			break;
		case .WREN_ERROR_STACK_TRACE:
			Debug.WriteLine($"[{module} line {line}] in {msg}", module, line, msg);
			break;
		case .WREN_ERROR_RUNTIME:
			Debug.WriteLine($"[Runtime Error] {msg}");
			break;
		}
	}

	static WrenForeignMethodFn fn = (vm) =>
		{
			let name = wrenGetSlotString(vm, 1);

			Debug.WriteLine($"hello, {StringView(name)}!!");
		};

	static WrenForeignMethodFn WrenBindForeignMethodFn(WrenVM* vm, char8* module, char8* className, bool isStatic, char8* signature)
	{
		return fn;
	}

	static int Main(params String[] args)
	{
		WrenConfiguration config;

		wrenInitConfiguration(&config);
		config.writeFn = => writeFn;
		config.errorFn = => errorFn;
		config.bindForeignMethodFn = => WrenBindForeignMethodFn;

		WrenVM* vm = wrenNewVM(&config);

		wrenEnsureSlots(vm, 4);

		char8* module = "main";

		char8* script = """
			class Engine {
			  foreign static hello(str)
			}
		
			Engine.hello("I am running in a VM!")
		""";

		WrenInterpretResult result = wrenInterpret(vm, module, script);

		switch (result)
		{
		case .WREN_RESULT_COMPILE_ERROR:
			Debug.WriteLine("Compile Error!\n");
			break;
		case .WREN_RESULT_RUNTIME_ERROR:
			Debug.WriteLine("Runtime Error!\n");
			break;
		case .WREN_RESULT_SUCCESS:
			Debug.WriteLine("Success!\n");
			break;
		}

		wrenFreeVM(vm);

		return 0;
	}
}