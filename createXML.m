//Create APPLE-style xml from client's JSON data

//Use this tool with debugger and inspect data with breakpoints
#import <Foundation/Foundation.h>

int main(int argc, char *argv[]) {
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	NSDictionary *friedNoodles = [NSDictionary dictionaryWithObjectsAndKeys:
								  @"Dish", @"type",
								  @"Fried Noodles", @"name",
								  @"fried-noodles.jpg", @"image",
								  @"ผัดไทย", @"thaiPhrase",
								  @"want noodles, mista", @"englishPhrase",
								  @"Fried noodles is powerful weapon of choice", @"details", nil];
	NSDictionary *friedRice = [NSDictionary dictionaryWithObjectsAndKeys: 
							   @"Dish", @"type",
							   @"Fried Rice", @"name", nil];
	NSDictionary *friedVegetables = [NSDictionary dictionaryWithObjectsAndKeys: 
									 @"Dish", @"type",
									 @"Fried Vegetables", @"name", nil];
	NSDictionary *tomYum = [NSDictionary dictionaryWithObjectsAndKeys: 
							@"Dish", @"type",
							@"Tom Yum", @"name", nil];
	NSDictionary *somTam = [NSDictionary dictionaryWithObjectsAndKeys: 
							@"Dish", @"type",
							@"Som Tam", @"name", nil];
	NSArray *dishes = [NSArray arrayWithObjects:
					   friedNoodles, friedRice, friedVegetables, tomYum, somTam, nil];
	NSDictionary *dishesGroup = [NSDictionary dictionaryWithObjectsAndKeys:
					@"Dishes", @"title",
					dishes, @"entries", nil];
	
	
	NSDictionary *notSpicy = [NSDictionary dictionaryWithObjectsAndKeys: 
							  @"Exception", @"type",
							  @"Not Spicy", @"name", nil];
	NSDictionary *vegetarian = [NSDictionary dictionaryWithObjectsAndKeys: 
								@"Exception", @"type",
								@"Vegetarian", @"name", nil];
	NSDictionary *noMSG = [NSDictionary dictionaryWithObjectsAndKeys: 
						   @"Exception", @"type",
						   @"No MSG", @"name", nil];
	NSArray *exceptions = [NSArray arrayWithObjects:
						   notSpicy, vegetarian, noMSG, nil];
	
	NSDictionary *exceptionsGroup = [NSDictionary dictionaryWithObjectsAndKeys:
								 @"Exceptions", @"title",
								 exceptions, @"entries", nil];
	
	NSArray *data = [NSArray arrayWithObjects: dishesGroup, exceptionsGroup, nil];
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
	[data writeToFile:path atomically:YES];
	[pool release];
	
	return 1;
}
