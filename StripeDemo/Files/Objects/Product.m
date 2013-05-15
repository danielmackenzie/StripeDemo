//  Product.m

#import "Product.h"

@implementation Product

@synthesize name = _name;
@synthesize image = _image;
@synthesize price = _price;
@synthesize inCart = _inCart;

#pragma mark - Init

- (id)init; {
  if((self = [super init])){
    
  }
  return self;
}

- (id)initWithName:(NSString *)aName price:(double)aPrice image:(NSString *)aImage; {
  if((self = [self init])){
    _name = aName;
    _image = aImage;
    _price = aPrice;
    _inCart = NO;
  }
  return self;
}

@end