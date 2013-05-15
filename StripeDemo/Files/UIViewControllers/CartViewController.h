//  CartViewController.h

#import <UIKit/UIKit.h>

@class AppDelegate;
@class ProductCell;

@interface CartViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
  AppDelegate          * _appDelegate;
  IBOutlet UILabel     * _totalLabel;
  IBOutlet UIButton    * _checkoutButton;
  IBOutlet UITableView * _tableView;
  IBOutlet ProductCell * _cartCell;
}

@end