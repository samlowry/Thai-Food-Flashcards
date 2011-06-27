//
//  ScrollingViewController.h
//  Scrolling
//
//  Created by David Janes on 09-09-25.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollingViewController : UIViewController
<UIScrollViewDelegate>
{
	IBOutlet UIScrollView* scrollView;
	IBOutlet UIPageControl* pageControl;
	
	NSInteger section;
	NSInteger page;
}
@property (nonatomic, retain) UIView *scrollView;
@property (nonatomic, retain) UIPageControl* pageControl;

@property NSInteger section;
@property NSInteger page;

- (ScrollingViewController*)initWithSection:(NSInteger)newSection page:(NSInteger)newPage;

/* for pageControl */
- (IBAction)changePage:(id)sender;

/* internal */
- (void) setupPage;
- (void) currentPage: (UIScrollView *) _scrollView;

- (void) drawBackButtonWithFrame:(CGRect) frame;
- (void) drawBorderImageWithFrame:(CGRect) frame;

@end

