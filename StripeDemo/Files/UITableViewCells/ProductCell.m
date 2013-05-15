//  ProductCell.m

#import "ProductCell.h"
#import "Product.h"
#import "AppDelegate.h"

@implementation ProductCell

#pragma mark - Getters

- (Product *)product; {
  return _product;
}

#pragma mark - Setters

- (void)setProduct:(Product *)aProduct; {
  _product = aProduct;
  UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:aProduct.image]]];
  [_image setImage:image];
  [_name setText:aProduct.name];
  [_price setText:[NSString stringWithFormat:@"$%4.2f", aProduct.price]];
}

#pragma mark - Init

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier; {
  if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])){
    
  }
  return self;
}

- (id)initWithProduct:(Product *)aProduct; {
  if((self = [super init])){
    self.product = aProduct;
  }
  return self;
}

#pragma mark - Methods

- (void)disableButton; {
  _button.userInteractionEnabled = NO;
  _button.alpha = 0.5f;
  [_button setTitle:@"In Cart" forState:UIControlStateNormal];
  _product.inCart = YES;
}

- (IBAction)itemButtonPressed:(UIButton *)aButton; {
  AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
  [appDelegate.cartArray addObject:_product];
  [self disableButton];
}

@end