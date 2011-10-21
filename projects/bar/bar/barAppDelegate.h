//
//  barAppDelegate.h
//  bar
//
//  Created by Dennis Gentry on 10/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class barViewController;

@interface barAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet barViewController *viewController;

@end
