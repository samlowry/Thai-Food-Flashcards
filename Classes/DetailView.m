#import "DetailView.h"
	//#import <QuartzCore/QuartzCore.h>
#import "UIImage+INResizeImageAllocator.h"
#import "UIImage+RoundedCorner.h"
#import "UIImage+Alpha.h"

@implementation DetailView

@synthesize entry;

- (void)applyDefaultStyle {
	self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"texture-background.png"]];
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    entry = nil;
    [self applyDefaultStyle];
    shiftFromTop_ = 0; //start drawing from the top
    shiftFromLeft_ = 0;
    shiftStep_ = 7;
    onelineLabelHeight_ = 26;
    buttonBorderWidthDeselected_ = 0.0; //px
    buttonBorderWidthDeselected_ = 2.0; //px
    preferredImageHeight_ =  410/2 - 15; //Image is 50% tall of whole card 
  }
  return self;
}

//- (BOOL)canBecomeFirstResponder {
//	return YES;
//}

- (void) drawDishImage {
	UIImage *styledImage = [UIImage imageNamed:[entry objectForKey:@"image"]];
    //set width and height of new image;

	UIImageView *tes = [[UIImageView alloc] initWithImage: styledImage];
	tes.frame = CGRectMake(0, 0, styledImage.size.width, styledImage.size.height);
	[self addSubview: tes];
	[tes release];
	
	//CGRect styledImageRect = CGRectMake(self.layer.borderWidth, 
//										self.layer.borderWidth, 
//										styledImage.size.width-(2*self.layer.borderWidth), 
//										styledImage.size.height);
//	imgWidth_ = styledImage.size.width-(2*self.layer.borderWidth) - self.layer.borderWidth;
//	imgHeight_ = styledImage.size.height - self.layer.borderWidth;
	shiftFromTop_ += styledImage.size.height + shiftStep_;
//	[styledImage drawInRect:styledImageRect];
	shiftFromLeft_ = 15;
}

- (void) drawThaiPhrase {
	CGRect thaiRect = CGRectMake(shiftFromLeft_, 
								 shiftFromTop_, 
								 self.frame.size.width-2*shiftFromLeft_, 
								 onelineLabelHeight_+10);
	UILabel *thaiPhraseLabel = [[[UILabel alloc] initWithFrame:thaiRect] autorelease];
	thaiPhraseLabel.textColor = [UIColor whiteColor];
	thaiPhraseLabel.textAlignment = UITextAlignmentCenter;
	thaiPhraseLabel.font = [UIFont boldSystemFontOfSize:30];
	thaiPhraseLabel.text = [entry objectForKey:@"thaiPhrase"];
	thaiPhraseLabel.backgroundColor = [UIColor clearColor];
	thaiPhraseLabel.adjustsFontSizeToFitWidth = YES;
	shiftFromTop_ += thaiPhraseLabel.frame.size.height + shiftStep_;
	shiftFromTop_ -= 5;
	[self addSubview:thaiPhraseLabel];
}

- (void) drawEnglishPhrase {
	CGRect englishRect = CGRectMake(shiftFromLeft_, 
									shiftFromTop_, 
									self.frame.size.width-2*shiftFromLeft_, 
									onelineLabelHeight_);
	UILabel *englishPhraseLabel = [[[UILabel alloc] initWithFrame:englishRect] autorelease];
	englishPhraseLabel.textColor = [UIColor whiteColor];
	englishPhraseLabel.font = [UIFont boldSystemFontOfSize:22];
	englishPhraseLabel.text = [entry objectForKey:@"englishPhrase"];
	englishPhraseLabel.textAlignment = UITextAlignmentCenter;
	englishPhraseLabel.backgroundColor = [UIColor clearColor];
	englishPhraseLabel.adjustsFontSizeToFitWidth = YES;
	shiftFromTop_ += englishPhraseLabel.frame.size.height + shiftStep_;
	shiftFromTop_ -= 15;
	[self addSubview:englishPhraseLabel];
	
}

- (void) drawName {
	shiftFromTop_ += 10;
	CGRect nameRect = CGRectMake(shiftFromLeft_, 
								 shiftFromTop_, 
								 self.frame.size.width-2*shiftFromLeft_, 
								 onelineLabelHeight_);
	UILabel *nameLabel = [[[UILabel alloc] initWithFrame:nameRect] autorelease];
	nameLabel.font = [UIFont italicSystemFontOfSize:20];
	nameLabel.textColor = [UIColor whiteColor];
	nameLabel.text = [entry objectForKey:@"name"];
	nameLabel.textAlignment = UITextAlignmentCenter;
	nameLabel.backgroundColor = [UIColor clearColor];
	nameLabel.adjustsFontSizeToFitWidth = YES;
	shiftFromTop_ += nameLabel.frame.size.height + shiftStep_;
    shiftFromTop_ -= 0;
	[self addSubview:nameLabel];
}

- (void) drawButtons {
  
	if (([entry objectForKey:@"buttons"] != nil)) {
		
		CGFloat buttonWidth = 32;
		CGFloat buttonsShiftStep = shiftStep_;
		
		NSInteger totalButtons = [[entry objectForKey:@"buttons"] count];
		
		CGFloat buttonsWidth = buttonWidth * totalButtons + buttonsShiftStep * (totalButtons - 1);
		
		CGRect buttonsFrame = CGRectMake(10, 
										 shiftFromTop_, 
										 buttonsWidth, 
										 buttonWidth);
		CGFloat innerButtonShift = 0;
		
		buttons_ = [[UIView alloc] initWithFrame:buttonsFrame];
		
		for (NSString* filename in [entry objectForKey:@"buttons"]) {
			
			UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
			button.enabled = YES;
			button.frame = CGRectMake(innerButtonShift, 0, buttonWidth, buttonWidth);
			[button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
			
			UIImage *image = [UIImage imageNamed:filename];
			
			//image for default state
			UIImage *normalImage = [image imageWithAlpha];
			[button setImage:normalImage forState:UIControlStateNormal];
			
			//image for selected state
			NSString* name = [[filename lastPathComponent] stringByDeletingPathExtension];
			NSString* extension = [filename pathExtension];
			NSString *selected = [name stringByAppendingFormat:@"Selected.%@", extension];
			UIImage *selectedImage = [UIImage imageNamed:selected];
			[button setImage:selectedImage forState:UIControlStateSelected];			
			[buttons_ addSubview:button];
			
			innerButtonShift += shiftStep_;
			innerButtonShift += buttonWidth;
		}
		
		[self addSubview:buttons_];
		shiftFromTop_ += shiftStep_;
		shiftFromTop_ += buttonWidth;
	}
}

#define fequal(a,b) (fabs((a) - (b)) < FLT_EPSILON)
#define fequalzero(a) (fabs(a) < FLT_EPSILON)

- (void)buttonClick:(UIButton*)button {
	if ([button isSelected]) {
		[button setSelected:NO];
	}
	else {
		[button setSelected:YES];
		for (id each in [buttons_ subviews]) {
			if (![each isEqual:button]) {
				[each setSelected:NO];
			}
		}
	}
}

//- (void)setBorder:(UIButton*)button {
//	UIColor *whiteColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.9];
//	button.layer.borderColor = [whiteColor CGColor];
//	button.layer.borderWidth = buttonBorderWidthSelected_; //px
//}
//
//- (void)removeBorder:(UIButton*)button {
//	button.layer.borderWidth = buttonBorderWidthDeselected_;
//}


- (void) drawDetails {
	CGRect detailsRect = CGRectMake(shiftFromLeft_, 
									shiftFromTop_, 
									self.frame.size.width-2*shiftFromLeft_,
									3.5*onelineLabelHeight_);
	UILabel *detailsLabel = [[[UILabel alloc] initWithFrame:detailsRect] autorelease];
	detailsLabel.textAlignment = UITextAlignmentLeft;
	detailsLabel.textColor = [UIColor whiteColor];
	detailsLabel.font = [UIFont systemFontOfSize:13];
	detailsLabel.text = [entry objectForKey:@"details"];
	detailsLabel.backgroundColor = [UIColor clearColor];
	detailsLabel.lineBreakMode = UILineBreakModeWordWrap;
	detailsLabel.numberOfLines = 0;
	shiftFromTop_ += detailsLabel.frame.size.height + shiftStep_ - 20;
	[detailsLabel sizeToFit];
	[self addSubview:detailsLabel];
}

- (void)drawRect:(CGRect)rect {	
	[self drawDishImage];
	[self drawThaiPhrase];
	[self drawEnglishPhrase];
	[self drawName];
	[self drawDetails];
	[self drawButtons];
}

- (void)dealloc {
	[entry release];
	[super dealloc];
}

@end
