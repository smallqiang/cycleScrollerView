//
//  cycleScrollerAppDelegate.h
//  cycleScroller
//
//  Created by KISSEI COMTEC on 11/08/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class cycleScrollerViewController;

@interface cycleScrollerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    cycleScrollerViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet cycleScrollerViewController *viewController;

@end

