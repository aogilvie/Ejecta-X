#include "EJException.h"
#include "EJApp.h"

static void logExceptionError(Local<Value> errorMsg) {
	if (!errorMsg) return;
    auto isolate = EJApp::instance()->jsGlobalIsolate;
    Handle<Value> errorStr = String::NewFromUtf8(isolate, "Exception - type Error: " + errorMsg);
    isolate->ThrowException(Exception::Error(errorStr));
}

static void logExceptionRangeError(Local<Value> errorMsg) {
	if (!errorMsg) return;
    auto isolate = EJApp::instance()->jsGlobalIsolate;
    Handle<Value> errorStr = String::NewFromUtf8(isolate, "Exception - type RangeError: " + errorMsg);
    isolate->ThrowException(Exception::Error(errorStr));
}

static void logExceptionReferenceError(Local<Value> errorMsg) {
	if (!errorMsg) return;
    auto isolate = EJApp::instance()->jsGlobalIsolate;
    Handle<Value> errorStr = String::NewFromUtf8(isolate, "Exception - type ReferenceError: " + errorMsg);
    isolate->ThrowException(Exception::Error(errorStr));
}

static void logExceptionSyntaxError(Local<Value> errorMsg) {
	if (!errorMsg) return;
    auto isolate = EJApp::instance()->jsGlobalIsolate;
    Handle<Value> errorStr = String::NewFromUtf8(isolate, "Exception - type SyntaxError: " + errorMsg);
    isolate->ThrowException(Exception::Error(errorStr));
}

static void logExceptionTypeError(Local<Value> errorMsg) {
	if (!errorMsg) return;
    auto isolate = EJApp::instance()->jsGlobalIsolate;
    Handle<Value> errorStr = String::NewFromUtf8(isolate, "Exception - type TypeError: " + errorMsg);
    isolate->ThrowException(Exception::Error(errorStr));
}

static void ReportException(Isolate *isolate, TryCatch *try_catch) {
	HandleScope handle_scope(isolate);
	String::Utf8Value exception(try_catch->Exception());
	const char *exception_string = ToCString(exception);
	Handle<Message> message = try_catch->Message();
	if (message.IsEmpty()) {
		// V8 didn't provide any extra information about this error; just
		// print the exception.
		fprintf(stderr, "%s\n", exception_string);
	} else {
		// Print (filename):(line number): (message).
		String::Utf8Value filename(message->GetScriptOrigin().ResourceName());
		const char* filename_string = ToCString(filename);
		int linenum = message->GetLineNumber();
		fprintf(stderr, "%s:%i: %s\n", filename_string, linenum, exception_string);
		// Print line of source code.
		String::Utf8Value sourceline(message->GetSourceLine());
		const char *sourceline_string = ToCString(sourceline);
		fprintf(stderr, "%s\n", sourceline_string);
		// Print wavy underline (GetUnderline is deprecated).
		int start = message->GetStartColumn();
		for (int i = 0; i < start; i++) {
			fprintf(stderr, " ");
		}
		int end = message->GetEndColumn();
		for (int i = start; i < end; i++) {
			fprintf(stderr, "^");
		}
		fprintf(stderr, "\n");
			String::Utf8Value stack_trace(try_catch->StackTrace());
		if (stack_trace.length() > 0) {
			const char *stack_trace_string = ToCString(stack_trace);
			fprintf(stderr, "%s\n", stack_trace_string);
		}
	}
}

// Extracts a C string from a V8 Utf8Value.
static const char *ToCString(const String::Utf8Value& value) {
  return *value ? *value : "<string conversion failed>";
}

