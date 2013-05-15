//  AppDelegate.m

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize cartArray = _cartArray;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions; {
  _cartArray = [[NSMutableArray alloc] init];
  return YES;
}

@end