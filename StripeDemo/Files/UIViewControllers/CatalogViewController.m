//  CatalogViewController.m

#import "CatalogViewController.h"
#import "Product.h"
#import "ProductCell.h"

@implementation CatalogViewController

#pragma mark - View LifeStyle

- (void)viewDidLoad; {
  [super viewDidLoad];
  
  Product * product;
  _catalog = [[NSMutableArray alloc] init];
  
  product = [[Product alloc] initWithName:@"Assassin's Creed 3" price:59.99f image:@"http://upload.wikimedia.org/wikipedia/en/2/29/Assassin%27s_Creed_III_Game_Cover.jpg"];
  [_catalog addObject:product];
  
  product = [[Product alloc] initWithName:@"Battlefield 3" price:59.99f image:@"http://upload.wikimedia.org/wikipedia/en/6/69/Battlefield_3_Game_Cover.jpg"];
  [_catalog addObject:product];
  
  product = [[Product alloc] initWithName:@"Borderlands 2" price:64.99f image:@"http://upload.wikimedia.org/wikipedia/en/7/77/Borderlands2boxart3.jpg"];
  [_catalog addObject:product];
  
  product = [[Product alloc] initWithName:@"Call of Duty 4" price:34.99f image:@"http://upload.wikimedia.org/wikipedia/en/5/5f/Call_of_Duty_4_Modern_Warfare.jpg"];
  [_catalog addObject:product];
  
  product = [[Product alloc] initWithName:@"Mass Effect 3" price:59.99f image:@"http://upload.wikimedia.org/wikipedia/en/b/b0/Mass_Effect_3_Game_Cover.jpg"];
  [_catalog addObject:product];
  
}

- (void)viewWillAppear:(BOOL)animated; {
  [super viewWillAppear:animated];
  
  [_tableView reloadData];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section; {
  return _catalog.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath; {
  static NSString * cellIdentifier = @"ProductCell";
  ProductCell * cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if(cell == nil){
    [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
    cell = _productCell;
  }
  cell.product = [_catalog objectAtIndex:indexPath.row];
  
  if(cell.product.inCart){
    [cell disableButton];
  }
  return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath; {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end