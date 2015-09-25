//
//  GGTimer.h
//
//  Created by Gary Grutzek on 1/8/11.
//  Copyright 2015 Gary Grutzek
//

#import <Cocoa/Cocoa.h>

@interface GGTimer : NSObject {
	
	NSTimer *activityTimer;
	NSTimer *sleepTimer;
	
	CFAbsoluteTime endTime;
}

- (id)init;
- (void)runSleepTimer:(double)seconds;
- (void)abortSleepTimer;
- (void)updateTime:(id)sender;
- (void)gotoSleep;
- (void)runSystemActivityTimer;
- (void)killSystemActivityTimer;

@end
