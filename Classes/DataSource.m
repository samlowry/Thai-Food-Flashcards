#import "DataSource.h"

@implementation DataSource

@synthesize data;

@synthesize selectedSectionIndex=selectedSectionIndex_;
@synthesize selectedRowIndex=selectedRowIndex_;

+ (DataSource *)instance  {
	static DataSource *instance;
	
	@synchronized(self) {
		if(!instance) {
			instance = [[DataSource alloc] init];
		}
	}
	
	return instance;
}

- (DataSource*)init {
	self = [super init];
    if(self != nil) {
      [self loadData];
      selectedSectionIndex_ = 0;
      selectedRowIndex_ = 0;
    }
    return self;
}

- (NSInteger)numDataPages {
	NSInteger count = 0;
	for (NSDictionary *group in self.data) {
		NSArray *entries = [NSArray arrayWithArray:[group objectForKey:@"entries"]];
		if(entries != nil) {
            count += [entries count];
		}
	}
	return count;
}

- (NSDictionary *)dataForPage:(NSInteger)pageIndex
{
	NSInteger count = 0;
	
	for (NSDictionary *group in self.data) {
		NSArray *entries = [NSArray arrayWithArray:[group objectForKey:@"entries"]];
		if(entries != nil) {
            if(pageIndex > count && pageIndex < [entries count]) {
				return [entries objectAtIndex:(pageIndex-count)];
			}
			else {
				count += [entries count];
			}
		}
	}
	return nil;
}

- (NSInteger)numGroups {
    return [self.data count];
}

- (NSInteger)numEntriesInGroup:(NSInteger)groupIndex {
    NSDictionary *groupData = [self.data objectAtIndex:groupIndex];
	if(groupData != nil) {
		NSArray *entries = [NSArray arrayWithArray:[groupData objectForKey:@"entries"]];
		if(entries != nil) {
            return [entries count];
		}
	}
    return 0;
}

- (NSString*)titleForGroup:(NSInteger)groupIndex {
    NSDictionary *group = [NSDictionary dictionaryWithDictionary:[self.data objectAtIndex:groupIndex]];
    if(group != nil) {
        return [NSString stringWithString:[group objectForKey:@"title"]];
    }
    return @"Untitled";
}

- (NSDictionary *)dataForGroup:(NSInteger)groupIndex page:(NSInteger)pageIndex {
    NSDictionary *groupData = [self.data objectAtIndex:groupIndex];
	if(groupData != nil) {
		NSArray *entries = [NSArray arrayWithArray:[groupData objectForKey:@"entries"]];
		if(entries != nil) {
            return [NSDictionary dictionaryWithDictionary:[entries objectAtIndex:pageIndex]];
		}
	}
    return nil;
}

- (void)loadData {
	NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
	NSFileManager *fm = [[NSFileManager alloc] init];
	if([fm fileExistsAtPath:path]) {
		self.data = [NSArray arrayWithContentsOfFile:path];	
	}
	else {
		self.data = [self testData];
	}
	[fm release];
}

- (NSArray*) testData {
    NSDictionary *friedSomething = [NSDictionary dictionaryWithObjectsAndKeys:
								  @"Test type", @"type",
								  @"Fried Something", @"name",
								  @"fried-noodles.jpg", @"image",
								  @"ผัดไทย", @"thaiPhrase",
								  @"nom nom nom", @"englishPhrase",
								  @"Test description phrase", @"details", nil];
	
	NSArray *testType = [NSArray arrayWithObjects: friedSomething, nil];
	NSDictionary *testGroup = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"Test type", @"title",
                                 testType, @"entries", nil];
	
	NSArray *testData = [NSArray arrayWithObjects: testGroup, nil];
    
    return testData;
}

@end
