#import <UIKit/UIKit.h>

@interface PageViewController : UIViewController
{
	NSInteger pageIndex;
	BOOL textViewNeedsUpdate;
	UILabel *label;
	UITextView *textView;
}

@property NSInteger pageIndex;

@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet UITextView *textView;

- (void)updateTextViews:(BOOL)force;

@end

