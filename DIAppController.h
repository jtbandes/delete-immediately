//
//  DIAppController.h
//  Delete Immediately
//
//  Created by Jacob Bandes-Storch on 8/30/09.
//

#import <Cocoa/Cocoa.h>

@interface DIAppController : NSObject <NSApplicationDelegate> {

}

- (void)deleteImmediately:(NSPasteboard *)pasteboard
				 userData:(NSString *)userData
					error:(NSString **)error;
@end
