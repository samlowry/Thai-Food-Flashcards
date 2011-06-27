#import <UIKit/UIKit.h>

@interface DetailView : UIView {
	NSDictionary *entry;
	CGFloat shiftFromTop_;
	CGFloat shiftFromLeft_;
	CGFloat imgWidth_;
	CGFloat imgHeight_;
	CGFloat shiftStep_;
	CGFloat onelineLabelHeight_;
	CGFloat preferredImageHeight_;
	
	//needed for buttons selection
	CGFloat buttonBorderWidthSelected_;
	CGFloat buttonBorderWidthDeselected_;
	
	//buttons
	UIView *buttons_;
}

@property (nonatomic, retain) NSDictionary *entry;

- (void)applyDefaultStyle;

@end
