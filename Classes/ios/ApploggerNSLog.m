//
//  AppLoggerNSLog.m
//  Pods
//
//  Created by Mirko Olsiewicz on 01.05.14.
//
//

#import "ApploggerNSLog.h"
#import "ApploggerManager.h"

@implementation AppLoggerNSLog

void logMessage(const char *functionName, NSString *format, ...)
{
    // Type to hold information about variable arguments.
    va_list ap;
    
    // Initialize a variable argument list.
    va_start (ap, format);
    
    // NSLog only adds a newline to the end of the NSLog format if
    // one is not already there.
    // Here we are utilizing this feature of NSLog()
    if (![format hasSuffix: @"\n"])
    {
        format = [format stringByAppendingString: @"\n"];
    }
    
    NSString *body = [[NSString alloc] initWithFormat:format arguments:ap];
    
    // End using variable argument list.
    va_end (ap);
    
    // create the timestamp string
    NSString* timeStamp = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];

    fprintf(stderr, "%s %s %s", [timeStamp UTF8String],
            functionName, [body UTF8String]);
    
    // Log to applogger in the www
    //dispatch_sync(dispatch_get_main_queue(), ^{
        AppLoggerLogMessage *message = [[AppLoggerLogMessage alloc] init];
        message.message = body;
        message.methodName = [NSString stringWithFormat:@"%s", functionName];
        [[ApploggerManager sharedApploggerManager] addLogMessage:message];
        
    //});

}
@end