#include <v8.h>
#include "EJCocoa/NSObject.h"
#include <string>

using namespace v8;

class EJException : public NSObject {
	
public:

	static void logExceptionError(Local<Value> errorMsg);
	static void ReportException(Isolate *isolate, TryCatch *try_catch);
	static const char *ToCString(const String::Utf8Value& value);
};
