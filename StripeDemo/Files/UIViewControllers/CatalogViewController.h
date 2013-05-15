//  CatalogViewController.h

#import <UIKit/UIKit.h>

@class ProductCell;

@interface CatalogViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
  NSMutableArray       * _catalog;
  IBOutlet UITableView * _tableView;
  IBOutlet ProductCell * _productCell;
}

@end