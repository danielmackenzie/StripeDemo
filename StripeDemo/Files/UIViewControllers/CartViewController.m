//  CartViewController.m

#import "CartViewController.h"
#import "Product.h"
#import "AppDelegate.h"
#import "ProductCell.h"

@interface CartViewController (Private)

- (void)updateCartTotal;

@end

@implementation CartViewController

#pragma mark - View LifeStyle

- (void)viewDidLoad; {
  [super viewDidLoad];
  
  _appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
}

- (void)viewWillAppear:(BOOL)animated; {
  [super viewWillAppear:animated];
  
  [self updateCartTotal];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section; {
  return _appDelegate.cartArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath; {
  static NSString * cellIdentifier = @"CartCell";
  ProductCell * cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if(cell == nil){
    [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
    cell = _cartCell;
  }
  cell.product = [_appDelegate.cartArray objectAtIndex:indexPath.row];
  return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath; {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  Product * product = [_appDelegate.cartArray objectAtIndex:indexPath.row];
  product.inCart = NO;
  [_appDelegate.cartArray removeObject:product];
  [tableView reloadData];
  [self updateCartTotal];
}

@end

@implementation CartViewController (Private)

- (void)updateCartTotal; {
  if(_appDelegate.cartArray.count == 0){
    _tableView.hidden = YES;
    _checkoutButton.enabled = NO;
    _checkoutButton.alpha = 0.5f;
    _totalLabel.text = @"Your cart is empty.";
  }
  else{
    _tableView.hidden = NO;
    _checkoutButton.enabled = YES;
    _checkoutButton.alpha = 1.0f;
    double sum = 0;
    
    for(int i = 0; i < _appDelegate.cartArray.count; i++){
      sum += ((Product *)[_appDelegate.cartArray objectAtIndex:i]).price;
    }
    _totalLabel.text = [NSString stringWithFormat:@"Total: $%.2f", sum];
    [_tableView reloadData];
  }
}

@end