/*
 *  main.m
 *  Delete Immediately
 *
 *  Created by Jacob Bandes-Storch on 8/30/09.
 *
 */

#import <Cocoa/Cocoa.h>
#import "DIAppController.h"

int main(int argc, char *argv[]) {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	[NSApplication sharedApplication];
	
	[[NSUserDefaults standardUserDefaults] registerDefaults:
	 [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES]
								 forKey:@"DIWarnBeforeDelete"]];
	
	DIAppController *controller = [[DIAppController alloc] init];
	[[NSApplication sharedApplication] setDelegate:controller];
	[NSApp run];
	[controller release];
	
	[pool release];
	return 0;
}
