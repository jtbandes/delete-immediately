//
//  DIAppController.m
//  Delete Immediately
//
//  Created by Jacob Bandes-Storch on 8/30/09.
//

#import "DIAppController.h"

@implementation DIAppController

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[NSApp setServicesProvider:self];
}

- (void)deleteImmediately:(NSPasteboard *)pasteboard
				 userData:(NSString *)userData
					error:(NSString **)error {
	NSArray *items = nil;
	NSArray *urlItems = [pasteboard readObjectsForClasses:[NSArray arrayWithObject:[NSURL class]]
												  options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES]
																					  forKey:NSPasteboardURLReadingFileURLsOnlyKey]];
	NSMutableArray *new = [NSMutableArray array];
	for (NSURL *url in urlItems) {
		[new addObject:[url path]];
	}
	items = new;
	if (items && [items count] > 0) {
		NSString *messageText;
		NSString *infoText = NSLocalizedString(@"INFO_SINGLE", @"Deletion info (singular)");
		if  ([items count] > 1) {
			infoText = NSLocalizedString(@"INFO_MULTIPLE", @"Deletion info (plural)");
			messageText = NSLocalizedString(@"CONFIRM_DELETE_MULTIPLE", @"Confirm multiple file deletion");
		} else {
			messageText = [NSString stringWithFormat:
						   NSLocalizedString(@"CONFIRM_DELETE_SINGLE", @"Confirm single file deletion (with name)"),
						   [[NSFileManager defaultManager] displayNameAtPath:[items objectAtIndex:0]]];
		}
		if ([[NSUserDefaults standardUserDefaults] boolForKey:@"DIWarnBeforeDelete"]) {
			NSAlert *alert = [NSAlert alertWithMessageText:messageText
											 defaultButton:NSLocalizedString(@"CONFIRM_DELETE", @"Confirm delete button")
										   alternateButton:NSLocalizedString(@"DENY_DELETE", @"Deny deletion button")
											   otherButton:nil
								 informativeTextWithFormat:infoText];
			// [alert setShowsSuppressionButton:YES];
			// [[alert suppressionButton] setTitle:@"Don’t show this warning again"];
			
			[NSApp activateIgnoringOtherApps:YES];
			if ([alert runModal] != NSAlertDefaultReturn) {
				return; // Don't delete
			}
			// Suppression checkbox has no effect if the delete is cancelled
			// if ([[alert suppressionButton] state] == NSOnState) {
			// 	[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"DIWarnBeforeDelete"];
			// }
		}
		for (NSString *path in items) {	
			NSError *error;
			if (![[NSFileManager defaultManager] removeItemAtPath:path error:&error]) {
				[NSApp activateIgnoringOtherApps:YES];
				NSLog(@"Error deleting file at path %@! Error: %@", path, error);
				[[NSAlert alertWithError:error] runModal];
			}
			// This doesn't really seem to work. Oh well.
			// According to the docs, we're not "normally" supposed to invoke it manually,
			// but I'm taking that to mean nothing will break outright, and it might work sometimes.
			[NSApp deactivate];
		}
	} else {
		NSLog(@"Data not available for public.file-url or NSFilenamesPboardType! Available types: %@", [pasteboard types]);
	}
}

@end
