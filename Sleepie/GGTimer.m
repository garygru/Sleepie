//
//  GGTimer.m
//
//  Created by Gary on 1/8/11.
//  2015 Gary Grutzek.
//
#import "GGTimer.h"
#import "AppDelegate.h"

@implementation GGTimer

- (id)init
{
	self = [super init];
	if(self)
		return self;
	return nil;
}

- (void)runSleepTimer:(double) seconds
{
	endTime = CFAbsoluteTimeGetCurrent() + seconds;
	
	if ([sleepTimer isValid]) {
		[sleepTimer invalidate];
	}
	
	// schedule timer
	sleepTimer = [NSTimer scheduledTimerWithTimeInterval:0.2
												  target:self
												selector:@selector(updateTime:)
												userInfo:nil
												 repeats:YES];
	// save some power
	[sleepTimer setTolerance:0.05];
}

-(void)abortSleepTimer
{
	if ([sleepTimer isValid]) {
		[sleepTimer invalidate];
	}
	AppDelegate *delegate = [[NSApplication sharedApplication] delegate];
	[delegate updateTimeLabels: 0.0];
}

-(void)updateTime:(id)sender
{
	CFAbsoluteTime remainingTime = endTime - CFAbsoluteTimeGetCurrent();
	AppDelegate *delegate = [[NSApplication sharedApplication] delegate];
	[delegate updateTimeLabels: remainingTime];
	
	if (remainingTime <= 0.) {
		[self abortSleepTimer];
		[delegate setLabelsEditable:YES];
		[self gotoSleep];
	}
}

- (void)gotoSleep
{
	// NSLog(@"Sleep");
	[self killSystemActivityTimer];
	NSAppleScript* script = [[NSAppleScript alloc] initWithSource:@"tell application \"Finder\"\n sleep\n end tell\n"];
	[script executeAndReturnError:nil];
}

- (void)runSystemActivityTimer
{
	
	if ([activityTimer isValid])
		[activityTimer invalidate];
	
	activityTimer = [NSTimer scheduledTimerWithTimeInterval:30
													 target:self
												   selector:@selector(systemActivity:)
												   userInfo:nil
													repeats:YES];
	
	[activityTimer setTolerance:1.0];
	//[[NSRunLoop mainRunLoop] addTimer:activityTimer forMode:NSRunLoopCommonModes];
}

- (void)systemActivity:(id)sender
{
	UpdateSystemActivity(OverallAct);
}

- (void)killSystemActivityTimer
{
	if ([activityTimer isValid])
		[activityTimer invalidate];
	activityTimer = nil;
}

@end
