//
//  SimpleImageDownLoad.m
//  JumpDates
//
//  Created by Sandeep Singh on 06/09/11.
//  Copyright 2011 2Ergo. All rights reserved.
//

#import "SimpleImageDownLoad.h"	


@implementation SimpleImageDownLoad

-(id)init
{
	self = [super init];
    if (self)
	{
		if(!active)
		{
			active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
			active.hidesWhenStopped = YES;
		}
		[active stopAnimating];
		//InitCode
	}
	return self;
}
-(void)setImageWithUrlString:(NSString*) imageUrl forImageView:(UIImageView*)image
{

		imageView =    image;
	[imageView retain];
		
			NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];

			if(picLocalPath)
				[picLocalPath release];

			picLocalPath = [documentsPath stringByAppendingPathComponent:[[imageUrl componentsSeparatedByString:@"/"]lastObject]];
			[picLocalPath retain];

		BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:picLocalPath];
		if(fileExists)
		{
			imageView.image = [UIImage imageWithContentsOfFile:picLocalPath];
			return ;
		}
		imageData = nil;
		if(!imageUrl)
			return;
		picUrlReq = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:imageUrl]];
		
		NSURLConnection* connection = [NSURLConnection connectionWithRequest:picUrlReq delegate:self];
		
		
		active.center = CGPointMake (imageView.frame.size.width/2, imageView.frame.size.height/2);
		[imageView addSubview:active];
		
		[active startAnimating]; 
		
		[connection start];		
	
}


- (void)dealloc {
	
	if(imageData)
		[imageData release];
	if(picUrlReq)
		[picUrlReq release];
	if(picLocalPath)
		[picLocalPath release];
	if(active)
		[active release];
	[imageView release];
	    [super dealloc];
}


#pragma mark <#label#>
#pragma mark Connection methods
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	if(!imageData)
		imageData = [[NSMutableData alloc] initWithData:data];
	else 
		[imageData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	[active stopAnimating];
	//[active release];
	[imageData writeToFile:picLocalPath atomically:YES]; 
	if([imageView isKindOfClass:[UIImageView class]])
		imageView.image = [UIImage imageWithData:imageData];
	
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	
}

@end
