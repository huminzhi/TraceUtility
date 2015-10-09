//
//  main.m
//  TraceUtility
//
//  Created by Maggie on 7/9/15.
//  Copyright (c) 2015 Qusic. All rights reserved.
//

#import "InstrumentsPrivateHeader.h"

#define NSPrint(format, ...) CFShow((__bridge CFStringRef)[NSString stringWithFormat:format, ## __VA_ARGS__])

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Required. Each instrument is a plugin and we have to load them before we can process their data.
        PFTLoadPlugins();

        // Open a trace document.
        XRTrace *trace = [[XRTrace alloc]initForCommandLine:NO];
        NSError *error;
        NSString *tracePath = @"/Users/mhu/Instruments.trace";
        if (argc >= 2) {
            tracePath = [NSString stringWithUTF8String:argv[1]];
        }
        [trace loadDocument:[NSURL fileURLWithPath:tracePath] error:&error];
        if (error) {
            NSLog(@"Error: %@", error);
            return 1;
        }

        // Each trace document consists of data from several different instruments.
        for (XRInstrument *instrument in trace.basicInstruments.allInstruments) {
            NSPrint(@"%@: %@ - %@ (%@ %@ %@)\n", instrument.type.name, instrument.target.displayName, instrument.target.device.deviceDisplayName, instrument.target.device.productType, instrument.target.device.productVersion, instrument.target.device.buildVersion);

            // You can have multiple runs for each instrument.
            for (XRRun *run in instrument.allRuns) {

                // Here is only one example for runs of the instrument Time Profiler. However it is not difficult for other instruments once we get started.
                if ([run isKindOfClass:NSClassFromString(@"XRLeaksRun")]) {
                    NSArray *leaks = [(XRLeaksRun *)run allLeaks];
                    [leaks enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        XRLeak *leak = (XRLeak *)obj;
                        NSPrint(@"Leaked Object:%lu, Address:0x%lx", leak.size, leak.address);
                    }];
                }
                NSPrint(@"\n");
            }

        }
    }
    return 0;
}
