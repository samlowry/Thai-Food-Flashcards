//Read APPLE-style xml from our plist

//Use this tool with debugger and inspect data with breakpoints
#import <Foundation/Foundation.h>

int main(int argc, char *argv[]) {
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
	NSArray *data = [NSArray arrayWithContentsOfFile:path];	
	[pool release];
  return 1;
}
