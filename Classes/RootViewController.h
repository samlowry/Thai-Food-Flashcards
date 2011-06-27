#import <UIKit/UIKit.h>

@class ThaiDishesAppDelegate;

@interface RootViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource> {
	NSMutableArray *numsEntriesInGroups;
	NSMutableArray *titles;
	NSMutableArray *rowNames;
	NSMutableArray *headerViews;
}

@property (readonly) ThaiDishesAppDelegate *appDelegate;

@end
