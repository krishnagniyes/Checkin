//
//  ICGLeadRetrievalScanController.m
//  iCheckInGenie
//
//  Created by Krishna on 12/02/14.
//  Copyright (c) 2014 Gniyes Inc.. All rights reserved.
//

#import "ICGLeadRetrievalScanController.h"
@import AVFoundation;

@interface ICGLeadRetrievalScanController () <AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureSession *_session;
    AVCaptureDevice *_device;
    AVCaptureDeviceInput *_input;
    AVCaptureMetadataOutput *_output;
    AVCaptureVideoPreviewLayer *_prevLayer;
    
    UIView *_highlightView;
}

-(void) loadBeepSound;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;


@end

@implementation ICGLeadRetrievalScanController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadBeepSound];
    
//    [self customIndicator];
    _highlightView = [[UIView alloc] init];
    _highlightView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _highlightView.layer.borderColor = [UIColor greenColor].CGColor;
    _highlightView.layer.borderWidth = 3;
    [self.view addSubview:_highlightView];
    _session = [[AVCaptureSession alloc] init];
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
    if (_input) {
        [_session addInput:_input];
    } else {
        NSLog(@"Error: %@", error);
    }
    
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [_session addOutput:_output];
    
    _output.metadataObjectTypes = [_output availableMetadataObjectTypes];
    
    _prevLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _prevLayer.frame = CGRectMake(((self.view.frame.size.width - 280) /2)  , (self.view.frame.size.height / 2) , 280, 100);;
    _prevLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    _prevLayer.cornerRadius = 7.0;
    
    [self.view.layer addSublayer:_prevLayer];
    [_session startRunning];
    [self.view bringSubviewToFront:_highlightView];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    CGRect highlightViewRect = CGRectZero;
    AVMetadataMachineReadableCodeObject *barCodeObject;
    NSString *detectionString = nil;
    NSArray *barCodeTypes = @[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode];
    
    for (AVMetadataObject *metadata in metadataObjects) {
        
        for (NSString *type in barCodeTypes) {
            if ([metadata.type isEqualToString:type])
            {
                barCodeObject = (AVMetadataMachineReadableCodeObject *)[_prevLayer transformedMetadataObjectForMetadataObject:(AVMetadataMachineReadableCodeObject *)metadata];
                highlightViewRect = barCodeObject.bounds;
                detectionString = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
                break;
            }
        }
        if(detectionString != nil)
            break;
    }
    
    if (detectionString != nil)
    {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        NSLog(@"String = %@", detectionString);
        [_session stopRunning];
        [_audioPlayer play] ;
        _highlightView.frame = _prevLayer.frame;
        return;
    }
    
    //    _highlightView.frame = highlightViewRect;
    
}

- (void) customIndicator
{
    //Create the first status image and the indicator view
    UIImage *statusImage = [UIImage imageNamed:@"torch.png"];
    UIImageView *activityImageView = [[UIImageView alloc]
                                      initWithImage:statusImage];
    
    UILabel *label = (UILabel*)[self.view viewWithTag:400];
    
    activityImageView.frame =  CGRectMake(label.frame.origin.x , label.frame.origin.y + 40, 20, 20);
    
    
    //Set the duration of the animation (play with it
    //until it looks nice for you)
    activityImageView.animationDuration = 0.8;
    
    // Create an animation that rotates something around its Z axis.
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
	// M_PI_2 = 360 degree rotation.
	animation.toValue = [NSNumber numberWithDouble:M_PI_2];
    
	// Have it take half a second to complete a single rotation.
	animation.duration = 0.5f;
    
	// Make it cumulative with the previously applied transformations, otherwise once the 'toValue' is reached it'd be finished.
	animation.cumulative = YES;
    
	// Have it repeat more often than you can possibly ever witness personally.
	animation.repeatCount = HUGE_VALF;
    
	// Add the animation to your imageView.
	[activityImageView.layer addAnimation:animation forKey:@"activityIndicatorAnimation"];
    //Start the animation
    //    [activityImageView startAnimating];
    [self.view addSubview:activityImageView];
}

-(void)loadBeepSound {
    NSString *beepFilePath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"mp3"];
    NSURL *beepURL = [NSURL URLWithString:beepFilePath];
    NSError *error;
    
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:beepURL error:&error];
    if (error) {
        NSLog(@"Could not play beep file.");
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        [_audioPlayer prepareToPlay];
    }
}

- (void)openTourch
{
    [self setView:[[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]]];
    
	AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
	// If torch supported, add button to toggle flashlight on/off
	if ([device hasTorch] == YES)
	{
        _flashlightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 70, 48, 48)];
        [_flashlightButton setBackgroundImage:[UIImage imageNamed:@"tree.png"] forState:UIControlStateNormal];
        [_flashlightButton addTarget:self action:@selector(buttonPressed:) forControlEvents: UIControlEventTouchUpInside];
        
        [[self view] addSubview:_flashlightButton];
	}
    
}

/*---------------------------------------------------------------------------
 *
 *--------------------------------------------------------------------------*/
- (void)buttonPressed:(UIButton *)button
{
    [self openTourch];

    if (button == _flashlightButton)
    {
        if (_isFlashlightOn == NO)
        {
            _isFlashlightOn = YES;
            [_flashlightButton setBackgroundImage:[UIImage imageNamed:@"menu icon.png"] forState:UIControlStateNormal];
            
        }
        else
        {
            _isFlashlightOn = NO;
            [_flashlightButton setBackgroundImage:[UIImage imageNamed:@"tree.png"] forState:UIControlStateNormal];
        }
        
		[self toggleFlashlight];
        
    }
}

- (void)toggleFlashlight
{
    if (_device.torchMode == AVCaptureTorchModeOff)
    {
        // Start session configuration
        [_session beginConfiguration];
        [_device lockForConfiguration:nil];
        
		// Set torch to on
        [_device setTorchMode:AVCaptureTorchModeOn];
        
        [_device unlockForConfiguration];
        [_session commitConfiguration];
        
        // Start the session
        [_session startRunning];
    }
    else
    {
        //        [_session stopRunning];
        //        _session = nil;
    }
}    

- (IBAction)openFlash:(id)sender {
    
    UIButton * button = (UIButton *)sender;
    if (button == _flashlightButton)
    {
        if (_isFlashlightOn == NO)
        {
            _isFlashlightOn = YES;
            [_flashlightButton setBackgroundImage:[UIImage imageNamed:@"sort.png"] forState:UIControlStateNormal];
            
        }
        else
        {
            _isFlashlightOn = NO;
            [_flashlightButton setBackgroundImage:[UIImage imageNamed:@"tree.png"] forState:UIControlStateNormal];
        }
        
		[self toggleFlashlight];
        
    }
    

}

@end
