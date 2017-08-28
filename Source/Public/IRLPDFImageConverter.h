//
//  IRLPDFImageConverter.h
//
//  Created by Sorin Nistor on 4/21/11.
//  Copyright 2011 iPDFdev.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IRLPDFImageConverter : NSObject {

}

+ (NSData *) convertImageToPDF: (UIImage *) image;
+ (NSData *) convertImageToPDF: (UIImage *) image withResolution: (double) resolution;
+ (NSData *) convertImageToPDF: (UIImage *) image withHorizontalResolution: (double) horzRes verticalResolution: (double) vertRes;
+ (NSData *) convertImageToPDF: (UIImage *) image withResolution: (double) resolution maxBoundsRect: (CGRect) boundsRect pageSize: (CGSize) pageSize;

@end
