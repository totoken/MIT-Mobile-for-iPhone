#import <QuartzCore/QuartzCore.h>

#import "QRReaderDetailViewController.h"
#import "QRReaderResult.h"
#import "QRReaderResultTransform.h"

@interface QRReaderDetailViewController ()
@property (nonatomic,retain) QRReaderResult *scanResult;
@property (nonatomic,retain) UIImageView *qrImage;
@property (nonatomic,retain) UITextView *textView;
@property (nonatomic,retain) UIButton *actionButton;
@property (nonatomic,retain) UIButton *shareButton;
@end

@implementation QRReaderDetailViewController
@synthesize scanResult = _scanResult;
@synthesize qrImage = _qrImage;
@synthesize textView = _textView;
@synthesize actionButton = _actionButton;
@synthesize shareButton = _shareButton;

+ (QRReaderDetailViewController*)detailViewControllerForResult:(QRReaderResult*)result {
    QRReaderDetailViewController *reader = [[self alloc] initWithNibName:@"QRReaderDetailViewController"
                                                                  bundle:nil];
    reader.scanResult = result;
    return [reader autorelease];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.scanResult = nil;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.scanResult.image) {
        self.qrImage.image = self.scanResult.image;
    } else {
        self.qrImage.image = [UIImage imageNamed:@"qrreader/qr-missing-image"];
    }
    
    self.qrImage.layer.borderColor = [[UIColor blackColor] CGColor];
    self.qrImage.layer.borderWidth = 2.0;
    
    if ([[QRReaderResultTransform sharedTransform] scanHasTitle:self.scanResult.text]) {
        [self.textView setText:[[QRReaderResultTransform sharedTransform] titleForScan:self.scanResult.text]];
        [self.actionButton setTitle:@"View events"
                           forState:UIControlStateNormal];
        [self.actionButton setImage:[UIImage imageNamed:@"global/action-calendar"]
                          forState:UIControlStateNormal];
        [self.actionButton setImage:[UIImage imageNamed:@"global/action-calendar-highlighted"]
                          forState:UIControlStateHighlighted];
    } else {
        [self.textView setText:self.scanResult.text];
        [self.actionButton setTitle:@"Open URL"
                           forState:UIControlStateNormal];
        [self.actionButton setImage:[UIImage imageNamed:@"global/action-external"]
                          forState:UIControlStateNormal];
        [self.actionButton setImage:[UIImage imageNamed:@"global/action-external-highlighted"]
                          forState:UIControlStateHighlighted];
    }
    
    [self.shareButton setTitle:@"Share this link"
                      forState:UIControlStateNormal];
    [self.shareButton setImage:[UIImage imageNamed:@"global/action-share"]
                      forState:UIControlStateNormal];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.qrImage = nil;
    self.textView = nil;
    self.actionButton = nil;
    self.shareButton = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark IBAction methods
- (IBAction)pressedShareButton:(id)sender {
    
}

- (IBAction)pressedActionButton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.scanResult.text]];
}


#pragma mark -
#pragma mark ShareItemDelegate (MIT)
- (NSString*)actionSheetTitle {
    
}

- (NSString*)emailSubject {
    
}

- (NSString*)emailBody {
    
}

- (NSString*)fbDialogPrompt {
    
}

- (NSString*)fbDialogAttachment {
    
}

- (NSString*)twitterUrl {
    
}

- (NSString*)twitterTitle {
    
}
@end
