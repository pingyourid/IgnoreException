//
//  IgnoreException.m
//  UncaughtExceptions
//
//  Created by zhangbin on 15/3/30.
//
//

#import "IgnoreException.h"
#import <UIKit/UIKit.h>

@implementation IgnoreException

+ (void)installIgnoreException
{
    NSSetUncaughtExceptionHandler(&handleObjcException);
    signal(SIGABRT, handleMachException);
    signal(SIGILL, handleMachException);
    signal(SIGSEGV, handleMachException);
    signal(SIGFPE, handleMachException);
    signal(SIGBUS, handleMachException);
    signal(SIGPIPE, handleMachException);
}

+ (void)unInstallIgnoreException
{
    NSSetUncaughtExceptionHandler(NULL);
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
}

void handleObjcException(NSException *exception)
{
    [[IgnoreException new] performSelectorOnMainThread:@selector(handleException) withObject:nil waitUntilDone:YES];
}

void handleMachException(int signal)
{
    [[IgnoreException new] performSelectorOnMainThread:@selector(handleException) withObject:nil waitUntilDone:YES];
}

- (void)handleException
{
    //restart a runloop
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
   
    while (1) {
        for (NSString *mode in (__bridge NSArray *)allModes)
        {
            CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
        }
    }
}

@end
