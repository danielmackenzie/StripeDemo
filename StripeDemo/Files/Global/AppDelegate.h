//  AppDelegate.h

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
  UIWindow * _window;
  NSMutableArray  * _cartArray;
}

@property (strong, nonatomic) UIWindow * window;
@property (nonatomic, retain) NSMutableArray  * cartArray;

@end