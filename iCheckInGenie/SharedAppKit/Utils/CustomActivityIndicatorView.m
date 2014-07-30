//  CustomActivityIndicatorView.h
//  eat24 hours
//
// Copyright 2011, Krishna Limited.

#import "CustomActivityIndicatorView.h"
#import <QuartzCore/QuartzCore.h>

@implementation CustomActivityIndicatorView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
		self.alpha = .6;
		self.layer.cornerRadius = 10;
		self.layer.masksToBounds = YES;
		
    }
    return self;
}

-(id) initWithText:(NSString*) sText {
	CGSize scrSize = [UIScreen mainScreen].bounds.size;
	CGPoint scrOrigin = [UIScreen mainScreen].bounds.origin;

	int w = [sText length] * 8 + 40;
	int h = 30;
	
	if(w > scrSize.width){
		w = scrSize.width-10;
	}
	
	int xOffset = (scrSize.width-w)/2;
	
	int x = scrOrigin.x + xOffset;
	
	int yOffset = (scrSize.height - h)/2;
	int y = scrOrigin.y + yOffset;
	
	[self initWithFrame:CGRectMake(x, y, w, h)];
	
	//self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	UIActivityIndicatorView* actView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	CGRect rr = actView.frame;
	rr.origin.x = 10;
	rr.origin.y = (h - rr.size.height)/2;
	[actView startAnimating];
	actView.frame = rr;
	[self addSubview:actView];
	
	CGFloat lblHeight = 20.0;
	
	//CGSize textSize = [sText sizeWithFont:[UIFont systemFontOfSize:txtLabel.font.pointSize]];
	UILabel* lbl = [[UILabel alloc] initWithFrame:CGRectMake(rr.origin.x + rr.size.width+10, h-lblHeight-5, w-(rr.origin.x+rr.size.width), lblHeight)];
	//lbl.frame = CGRectMake(rr.origin.x + rr.size.width+10, h-lblHeight-5, textSize.width, lblHeight);	
	[lbl setText:sText];
	[lbl setTextColor:[UIColor whiteColor]];
	[lbl setBackgroundColor:[UIColor clearColor]];
	[lbl setFont:[UIFont fontWithName:@"Helvetica" size:16]];
	[self addSubview:lbl];
	[actView release];
	[lbl release];
 	return self;
}

- (void)dealloc {
    [super dealloc];
}

@end
