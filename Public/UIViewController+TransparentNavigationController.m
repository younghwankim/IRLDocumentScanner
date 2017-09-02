//
//  UIViewController+TransparentNavigationController.m
//  demo
//
//  Created by Young Kim on 2017-08-26.
//  Copyright © 2017 iRLMobile. All rights reserved.
//

#import "UIViewController+TransparentNavigationController.h"
#import <objc/runtime.h>


@interface VSSNavigationBarContext:NSObject

/** Backup of nav bar image used to restore on push. */
@property UIImage *originalNavBarBackgroundImage;
/** Backup of nav bar shadow image used to restore on push. */
@property UIImage *originalNavBarShadowImage;
/** Backup of nav bar color used to restore on push. */
@property UIColor *originalNavBarColour;
@property NSDictionary *originalTitleAttributes;
@property UIColor *originalNavBarTintColour;

@end

@implementation VSSNavigationBarContext

- (id) init {
    self=[super init];
    if (self){
        self.originalNavBarBackgroundImage=nil;
        self.originalNavBarShadowImage=nil;
        self.originalNavBarColour=nil;
        self.originalTitleAttributes=nil;
        self.originalNavBarTintColour=nil;
    }
    return self;
}

@end

static char const * const ObjectTagKey = "NavBarContextTag";



@implementation UIViewController (TransparentNavigationController)

- (VSSNavigationBarContext *) getContext
{
    VSSNavigationBarContext *context=(VSSNavigationBarContext *)objc_getAssociatedObject(self, &ObjectTagKey);
    return context;
}

- (void) makeNavigationBarTransparent{
    VSSNavigationBarContext *context=(VSSNavigationBarContext *)objc_getAssociatedObject(self, &ObjectTagKey);
    if (context == nil){
        context=[[VSSNavigationBarContext alloc] init];
        
        context.originalNavBarBackgroundImage=[self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
        context.originalNavBarShadowImage=self.navigationController.navigationBar.shadowImage;
        context.originalNavBarColour=self.navigationController.view.backgroundColor;
        context.originalTitleAttributes=self.navigationController.navigationBar.titleTextAttributes;
        context.originalNavBarTintColour=self.navigationController.navigationBar.tintColor;
        
        // Store the original settings
        objc_setAssociatedObject(self, &ObjectTagKey, context, OBJC_ASSOCIATION_RETAIN);
    }
    
    //
    // Make transparent
    //
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
        self.navigationController.navigationBar.translucent = YES;
    }
    else{
        self.navigationController.navigationBar.translucent = NO;
    }
    self.navigationController.view.backgroundColor = [UIColor clearColor];
}

- (void) restoreNavigationBar
{
    VSSNavigationBarContext *context=(VSSNavigationBarContext *)objc_getAssociatedObject(self, &ObjectTagKey);
    if (context != nil){
        // Restore original
        [self.navigationController.navigationBar setBackgroundImage:context.originalNavBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = context.originalNavBarShadowImage;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
            self.navigationController.navigationBar.translucent = YES;
        }
        else{
            self.navigationController.navigationBar.translucent = NO;
        }
        self.navigationController.view.backgroundColor = context.originalNavBarColour;
        self.navigationController.navigationBar.titleTextAttributes = context.originalTitleAttributes;
        self.navigationController.navigationBar.tintColor = context.originalNavBarTintColour;
    }
}
@end
