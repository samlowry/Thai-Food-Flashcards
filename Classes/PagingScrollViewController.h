#import <UIKit/UIKit.h>

@class PageViewController;

@interface PagingScrollViewController : UIViewController
{
	UIView *view;
	UIScrollView *scrollView;
	UIPageControl *pageControl;
	
	PageViewController *currentPage;
	PageViewController *nextPage;

}

@property (nonatomic, retain) IBOutlet UIView *view;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;

- (IBAction)changePage:(id)sender;

@end
