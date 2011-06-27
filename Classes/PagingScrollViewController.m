#import "PagingScrollViewController.h"
#import "PageViewController.h"
#import "DataSource.h"
#import "DetailViewController.h"

@implementation PagingScrollViewController

@synthesize view, scrollView, pageControl;

- (void)applyNewIndex:(NSInteger)newIndex pageController:(PageViewController *)pageController
{
	NSInteger pageCount = [[DataSource instance] numDataPages];
	BOOL outOfBounds = newIndex >= pageCount || newIndex < 0;

	if (!outOfBounds)
	{
		CGRect pageFrame = pageController.view.frame;
		pageFrame.origin.y = 0;
		pageFrame.origin.x = scrollView.frame.size.width * newIndex;
		pageController.view.frame = pageFrame;
	}
	else
	{
		CGRect pageFrame = pageController.view.frame;
		pageFrame.origin.y = scrollView.frame.size.height;
		pageController.view.frame = pageFrame;
	}

	pageController.pageIndex = newIndex;
}

- (void)viewDidLoad
{ 
    currentPage = [[DetailViewController alloc] init];
    nextPage = [[DetailViewController alloc] init];
	[scrollView addSubview:currentPage.view];
	[scrollView addSubview:nextPage.view];

	NSInteger widthCount = [[DataSource instance] numDataPages];
	if (widthCount == 0)
	{
		widthCount = 1;
	}
	
    scrollView.contentSize =
		CGSizeMake(
			scrollView.frame.size.width * widthCount,
			scrollView.frame.size.height);
	scrollView.contentOffset = CGPointMake(0, 0);

	pageControl.numberOfPages = [[DataSource instance] numDataPages];
	pageControl.currentPage = 0;
	
	[self applyNewIndex:0 pageController:currentPage];
	[self applyNewIndex:1 pageController:nextPage];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
	
	NSInteger lowerNumber = floor(fractionalPage);
	NSInteger upperNumber = lowerNumber + 1;
	
	if (lowerNumber == currentPage.pageIndex)
	{
		if (upperNumber != nextPage.pageIndex)
		{
			[self applyNewIndex:upperNumber pageController:nextPage];
		}
	}
	else if (upperNumber == currentPage.pageIndex)
	{
		if (lowerNumber != nextPage.pageIndex)
		{
			[self applyNewIndex:lowerNumber pageController:nextPage];
		}
	}
	else
	{
		if (lowerNumber == nextPage.pageIndex)
		{
			[self applyNewIndex:upperNumber pageController:currentPage];
		}
		else if (upperNumber == nextPage.pageIndex)
		{
			[self applyNewIndex:lowerNumber pageController:currentPage];
		}
		else
		{
			[self applyNewIndex:lowerNumber pageController:currentPage];
			[self applyNewIndex:upperNumber pageController:nextPage];
		}
	}
	
	[currentPage updateTextViews:NO];
	[nextPage updateTextViews:NO];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)newScrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
	NSInteger nearestNumber = lround(fractionalPage);

	if (currentPage.pageIndex != nearestNumber)
	{
		PageViewController *swapController = currentPage;
		currentPage = nextPage;
		nextPage = swapController;
	}

	[currentPage updateTextViews:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)newScrollView {
	[self scrollViewDidEndScrollingAnimation:newScrollView];
	pageControl.currentPage = currentPage.pageIndex;
}

- (IBAction)changePage:(id)sender {
	NSInteger pageIndex = pageControl.currentPage;
	// update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * pageIndex;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
}

- (void)dealloc {
	[currentPage release];
	[nextPage release];
	[super dealloc];
}

@end
