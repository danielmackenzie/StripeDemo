//  Product.h

#import <Foundation/Foundation.h>

@interface Product : NSObject {
  BOOL       _inCart;
  double     _price;
  NSString * _name;
  NSString * _image;
}

@property (nonatomic, assign) BOOL inCart;
@property (nonatomic, assign) double price;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * image;

- (id)initWithName:(NSString *)aName price:(double)aPrice image:(NSString *)aImage;

@end