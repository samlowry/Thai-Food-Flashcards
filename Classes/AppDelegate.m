#import "AppDelegate.h"
#import "RootViewController.h"
#import	"PageViewController.h"
#import "PagingScrollViewController.h"
#import "RootViewController.h"

@implementation AppDelegate

@synthesize window;
@synthesize rootViewController=rootViewController_;

#pragma mark -
#pragma mark Application lifecycle


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
  [[UIApplication sharedApplication] setStatusBarHidden:NO];
  [application setStatusBarStyle:UIStatusBarStyleBlackOpaque];   
  self.rootViewController = [[RootViewController alloc] 
                             initWithNibName:@"RootViewController" 
                             bundle:[NSBundle mainBundle]];  
  CGRect theRect = self.rootViewController.view.frame;
  theRect = CGRectOffset(theRect, 0.0, 20.0);
  self.rootViewController.view.frame = theRect;
  [self.window addSubview:self.rootViewController.view];
  [self.window makeKeyAndVisible];

  return YES;
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[window release];
	[super dealloc];
}


@end

