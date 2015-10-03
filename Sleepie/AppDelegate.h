//
//  AppDelegate.h
//  Sleepie
//
//  Created by Gary Grutzek on 10.06.15.
//  Copyright (c) 2015 Gary Grutzek. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GGTimer.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
	
	GGTimer *sleepTimer;
	
	__weak IBOutlet NSTextField *hourLabel;
	__weak IBOutlet NSTextField *minuteLabel;
	__weak IBOutlet NSTextField *secondsLabel;
}


- (IBAction)StartTimer:(id)sender;
- (IBAction)stopTimer:(id)sender;
- (void)updateTimeLabels:(double)remainingSeconds;
- (void)setLabelsEditable:(BOOL)editable;

@end

