//
//  AppDelegate.m
//  Sleepie
//
//  Created by Gary Grutzek on 10.06.15.
//  Copyright (c) 2015 Gary Grutzek. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	sleepTimer = [[GGTimer alloc] init];
	[sleepTimer runSystemActivityTimer];
	
	[hourLabel setStringValue:@"00"];
	[minuteLabel setStringValue:@"00"];
	[secondsLabel setStringValue:@"00"];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(textDidChange:)
												 name:NSTextDidChangeNotification
											   object:nil];
	
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
	[sleepTimer killSystemActivityTimer];
	[sleepTimer abortSleepTimer];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication
{
	for (NSWindow *win in[NSApp windows]) {
		if ([win isVisible]) {
			return NO;
		}
	}
	return YES;
}


- (IBAction)StartTimer:(id)sender
{
	int hour = [hourLabel intValue];
	int minute = [minuteLabel intValue];
	int seconds = [secondsLabel intValue];
	
	double timeInterval = (double)(hour*3600)+(minute*60)+seconds;
	
	if (timeInterval > 0) {
		[self setLabelsEditable:NO];
		[sleepTimer runSleepTimer:timeInterval];
	}
}

- (IBAction)stopTimer:(id)sender
{
	[sleepTimer abortSleepTimer];
	[self setLabelsEditable:YES];
}

- (void) setLabelsEditable:(BOOL)editable
{
	[hourLabel setEditable:editable];
	[minuteLabel setEditable:editable];
	[secondsLabel setEditable:editable];
	[hourLabel setSelectable:editable];
	[minuteLabel setSelectable:editable];
	[secondsLabel setSelectable:editable];
	if (editable) {
		[hourLabel setStringValue:@"00"];
		[minuteLabel setStringValue:@"00"];
		[secondsLabel setStringValue:@"00"];
	}
}

- (void)updateTimeLabels:(double)remainingSeconds
{
	int hours = ((int)remainingSeconds)/3600;
	int minutes = ((int)remainingSeconds%3600)/60;
	int seconds = ((int)remainingSeconds%60);
	
	[hourLabel setStringValue:[NSString stringWithFormat:@"%0.2d", hours]];
	[minuteLabel setStringValue:[NSString stringWithFormat:@"%0.2d", minutes]];
	[secondsLabel setStringValue:[NSString stringWithFormat:@"%0.2d", seconds]];
}

- (void)textDidChange:(NSNotification*)notification
{
	if ([[hourLabel stringValue] length] > 2) {
		NSString* value = [NSString stringWithString:[hourLabel stringValue]];
		[hourLabel setStringValue:[value substringToIndex:2]];
	}
	if ([[minuteLabel stringValue] length] > 2) {
		NSString* value = [NSString stringWithString:[minuteLabel stringValue]];
		[minuteLabel setStringValue:[value substringToIndex:2]];
	}
	if ([[secondsLabel stringValue] length] > 2) {
		NSString* value = [NSString stringWithString:[secondsLabel stringValue]];
		[secondsLabel setStringValue:[value substringToIndex:2]];
	}
}


@end
