//
//  fooAppDelegate.h
//  foo
//
//  Created by Dennis Gentry on 10/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class fooViewController;

@interface fooAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet fooViewController *viewController;

@end
