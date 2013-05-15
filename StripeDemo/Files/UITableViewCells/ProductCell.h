//  ProductCell.h

#import <UIKit/UIKit.h>

@class Product;

@interface ProductCell : UITableViewCell {
  Product              * _product;
  IBOutlet UILabel     * _name;
  IBOutlet UILabel     * _price;
  IBOutlet UIButton    * _button;
  IBOutlet UIImageView * _image;
}

@property (nonatomic, retain) Product * product;

- (id)initWithProduct:(Product *)aProduct;
- (void)disableButton;
- (IBAction)itemButtonPressed:(UIButton *)aButton;

@end