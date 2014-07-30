//
//  SimpleImageDownLoad.h
//  JumpDates
//
//  Created by Sandeep Singh on 06/09/11.
//  Copyright 2011 2Ergo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SimpleImageDownLoad : NSObject {
	NSMutableData*			imageData;
	NSMutableURLRequest* picUrlReq;
	NSString*			picLocalPath;
	UIImageView*		imageView;
	UIActivityIndicatorView* active;

}
-(void)setImageWithUrlString:(NSString*) imageUrl forImageView:(UIImageView*)image;
@end
