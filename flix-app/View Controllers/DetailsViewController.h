//
//  DetailsViewController.h
//  flix-app
//
//  Created by gfloresv on 6/26/20.
//  Copyright © 2020 gfloresv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (nonatomic, strong) Movie *movie;
@end

NS_ASSUME_NONNULL_END
