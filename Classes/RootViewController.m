#import "RootViewController.h"
#import "AppDelegate.h"
#import "DataSource.h"
#import "PagingScrollViewController.h"

#import "ScrollingViewController.h"


@implementation RootViewController

- (ThaiDishesAppDelegate *)appDelegate {
	ThaiDishesAppDelegate *appDelegate = (ThaiDishesAppDelegate *)[[UIApplication sharedApplication] delegate];
	return appDelegate;
}

- (void)viewDidLoad {
	[self.navigationController setNavigationBarHidden:YES animated:YES];
	self.navigationItem.title = @"Thai Dishes";
	[super viewDidLoad];
	
	numsEntriesInGroups = [[NSMutableArray alloc] init];
	titles = [[NSMutableArray alloc] init];
	rowNames = [[NSMutableArray alloc] init];
	headerViews = [[NSMutableArray alloc] init];
	
	for(int i = 0; i < [[DataSource instance] numGroups]; i++) {
		[numsEntriesInGroups addObject:[NSNumber numberWithInt: [[DataSource instance] numEntriesInGroup:i]]];
		[titles addObject:[[DataSource instance] titleForGroup:i]];
		
		UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, self.tableView.bounds.size.width, 22.0)];
		headerView.backgroundColor = [UIColor colorWithRed:0.26 green:0.06 blue:0.04 alpha:1];	

		UILabel * headerLabel = [[UILabel alloc] initWithFrame: CGRectMake(10.0, 0.0, 300.0, 22.0)];
		headerLabel.backgroundColor = [UIColor clearColor];
		headerLabel.textColor = [UIColor whiteColor];
		headerLabel.font = [UIFont boldSystemFontOfSize:17];
		headerLabel.text = [titles lastObject];
		[headerView addSubview:headerLabel];
		[headerLabel release];
		
		[headerViews addObject:headerView];
		[headerView release];
	}
	
	for(int i = 0; i < [numsEntriesInGroups count]; i++) {
		NSMutableArray *tmp = [NSMutableArray array];
		
		for(int j = 0; j < [[numsEntriesInGroups objectAtIndex:i] intValue]; j++)
			[tmp addObject: [[[DataSource instance] dataForGroup:i page:j] objectForKey:@"name"]];
		[rowNames addObject:tmp];
	}
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
	
  NSUInteger selectedSectionIndex = [[DataSource instance] selectedSectionIndex];
  NSUInteger selectedRowIndex = 0;
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedRowIndex inSection:selectedSectionIndex];
  [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {  
	return [headerViews objectAtIndex:section];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 22.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [numsEntriesInGroups count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[numsEntriesInGroups objectAtIndex:section] intValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d", indexPath.section, indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		
		cell.textLabel.text = [[rowNames objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]; 
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[[DataSource instance] setSelectedSectionIndex:indexPath.section];
	[[DataSource instance] setSelectedRowIndex:indexPath.row];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
		
	ScrollingViewController *scrollingViewController = [[ScrollingViewController alloc] initWithSection:indexPath.section page:indexPath.row];
	
	[scrollingViewController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
	[self presentModalViewController:scrollingViewController animated:YES];	
	[scrollingViewController release];
}

- (void)dealloc {
	[numsEntriesInGroups release];
	[titles release];
	[rowNames release];
	[headerViews release];

	[super dealloc];
}


@end

