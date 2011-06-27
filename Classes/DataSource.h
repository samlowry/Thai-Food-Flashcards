#import <Foundation/Foundation.h>


@interface DataSource : NSObject {

 @private
  NSArray *data;
  
  //selected section
  NSUInteger selectedSectionIndex_;
  //selected index
  NSUInteger selectedRowIndex_;   
}

@property (nonatomic, retain) NSArray *data;

@property (assign) NSUInteger selectedSectionIndex;
@property (assign) NSUInteger selectedRowIndex;

+ (DataSource*) instance;
- (NSInteger)numDataPages;
- (NSDictionary *)dataForPage:(NSInteger)pageIndex;
- (NSInteger)numGroups;
- (NSInteger)numEntriesInGroup:(NSInteger)groupIndex;
- (NSString*)titleForGroup:(NSInteger)groupIndex;
- (NSDictionary *)dataForGroup:(NSInteger)groupIndex page:(NSInteger)pageIndex;

- (void) loadData;
- (NSArray*) testData;

@end
