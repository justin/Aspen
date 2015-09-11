#import "AspenHelpers.h"
#import <Aspen/Aspen-Swift.h>

void AspenVerbose(NSString *message, ...)
{
    va_list args;
    va_start(args, message);
    va_end(args);
    NSString *formattedMessage = [[NSString alloc] initWithFormat:message arguments:args];

    [Aspen verbose:formattedMessage];
}

void AspenInfo(NSString *message, ...)
{
    va_list args;
    va_start(args, message);
    va_end(args);
    NSString *formattedMessage = [[NSString alloc] initWithFormat:message arguments:args];

    [Aspen info:formattedMessage];
}

void AspenWarn(NSString *message, ...)
{
    va_list args;
    va_start(args, message);
    va_end(args);
    NSString *formattedMessage = [[NSString alloc] initWithFormat:message arguments:args];
    
    [Aspen warn:formattedMessage];
}

void AspenError(NSString *message, ...)
{
    va_list args;
    va_start(args, message);
    va_end(args);
    NSString *formattedMessage = [[NSString alloc] initWithFormat:message arguments:args];

    [Aspen error:formattedMessage];
}