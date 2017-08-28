//
//  UIViewController+TransparentNavigationController.h
//  demo
//
//  Created by Young Kim on 2017-08-26.
//  Copyright © 2017 iRLMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TransparentNavigationController)
/** Makes the current navigation bar transparent and returns a context holding
 * the original settings.
 */
- (void) makeNavigationBarTransparent;

/**
 * Restores the current navigation bar to its original settings.
 */
- (void) restoreNavigationBar;

@end
