#import "ScrollingViewController.h"
#import "DataSource.h"
#import "DetailView.h"

@implementation ScrollingViewController
@synthesize scrollView;
@synthesize pageControl;
@synthesize section, page;

- (ScrollingViewController*)initWithSection:(NSInteger)newSection page:(NSInteger)newPage {
	self = [super init];
	if (self != nil) {
        scrollView = nil;
		self.section = newSection;
		self.page = newPage;
	}
	return self;
}

#pragma mark -
#pragma mark UIView boilerplate
- (void)viewDidLoad {
	[self setupPage];
	[super viewDidLoad];
}

#pragma mark -
#pragma mark The Guts
- (void)setupPage {
	[self.scrollView setBackgroundColor:[UIColor blackColor]];
	[scrollView setCanCancelContentTouches:NO];
	
	scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	scrollView.clipsToBounds = YES;
	scrollView.scrollEnabled = YES;
	scrollView.pagingEnabled = YES;
	
    NSArray *entries = [[[DataSource instance].data objectAtIndex:self.section] objectForKey:@"entries"];
    self.pageControl.numberOfPages = [entries count];
    
	[scrollView setContentSize:CGSizeMake(scrollView.frame.size.width * [entries count], scrollView.frame.size.height)];
	
	CGRect frame = CGRectMake (scrollView.frame.size.width * self.page, 0, scrollView.frame.size.width, scrollView.frame.size.height);
    [scrollView scrollRectToVisible:frame animated:NO];

	[self performSelector:@selector(loadCurrentPage:) withObject:[entries objectAtIndex:page]];
	[self performSelector:@selector(loadPageControlViews:) withObject:entries afterDelay:0.2f];
	
	[self currentPage: scrollView];
}

- (void) currentPage: (UIScrollView *) _scrollView {
	CGFloat pageWidth = _scrollView.frame.size.width;
	int newPage = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	pageControl.currentPage = newPage;
}
	 

- (void) loadCurrentPage: (NSDictionary *) entry {	
	CGFloat cx = scrollView.frame.size.width * page;
	
	CGRect rect = CGRectMake(cx + 15, 15, 290, 410);
	DetailView *detailView = [[DetailView alloc] initWithFrame:rect];
	[detailView setEntry:entry];
	[scrollView addSubview:detailView];
	[detailView release];
	
	[self drawBorderImageWithFrame:rect];
	
	[self drawBackButtonWithFrame:rect];
}

- (void) loadPageControlViews: (NSArray *) entries {
	CGFloat cx = 0;
	
	for(NSDictionary *entry in entries) {
		if([entries indexOfObject:entry] != page) {
			CGRect rect = CGRectMake(cx + 15, 15, 290, 410);
			DetailView *detailView = [[DetailView alloc] initWithFrame:rect];
			[detailView setEntry:entry];
			[scrollView addSubview:detailView];
			[detailView release];
			
			[self drawBorderImageWithFrame:rect];
			
			[self drawBackButtonWithFrame:rect];
			
			cx += 320;
		}
		else {
			cx += 320;
		}
    }
}

- (void) drawBorderImageWithFrame:(CGRect) frame {
	UIImageView *border = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x - 12,
																		frame.origin.y - 12, 
																		frame.size.width + 24, 
																		frame.size.height + 56)];
	[border setImage:[UIImage imageNamed:@"frame.png"]];
	[scrollView addSubview:border];
	[border release];
}

- (void) drawBackButtonWithFrame:(CGRect) frame {
	//create close button
	CGFloat closeBtnSize = 32;
	
	CGRect closeBtnRect = CGRectMake(frame.origin.x - 10, frame.origin.y - 10, closeBtnSize, closeBtnSize);
	
	UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[closeBtn setFrame:closeBtnRect];
	[closeBtn setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
	[closeBtn  addTarget:self action:@selector(goBack) forControlEvents:(UIControlEventTouchDown)];
	closeBtn.showsTouchWhenHighlighted = YES;
	[scrollView addSubview:closeBtn];
}

- (void)goBack {
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UIScrollViewDelegate stuff
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView {
	
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView {
    [self currentPage: _scrollView];
}

#pragma mark -
#pragma mark PageControl stuff
- (IBAction)changePage:(id)sender {
	 //	Change the scroll view
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * pageControl.currentPage;
    frame.origin.y = 0;
	
    [scrollView scrollRectToVisible:frame animated:YES];
}

#pragma mark -
#pragma mark Memory management


- (void)dealloc {
	for (UIView *v in self.view.subviews) [v removeFromSuperview];
	[scrollView release];
	[pageControl release];
	[super dealloc];
}

@end