//
//  Great_KidsAppDelegate.h
//  Great Kids
//
//  Created by Dennis Gentry on 10/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Great_KidsViewController;

@interface Great_KidsAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet Great_KidsViewController *viewController;

@end
