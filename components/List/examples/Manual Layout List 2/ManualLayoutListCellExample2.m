/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "ManualLayoutListCellExample2.h"

#import "ManualLayoutListItemCell2.h"
#import "MaterialIcons+ic_info.h"
#import "MaterialTypographyScheme.h"

static NSString *const kManualLayoutListItemCell2ReuseIdentifier = @"kManualLayoutListItemCell2ReuseIdentifier";

static const CGFloat kSmallestCellHeight = 40.f;
static const CGFloat kSmallArbitraryCellWidth = 200.f;

@interface ManualLayoutListCellExample2 ()

@end

@implementation ManualLayoutListCellExample2

@synthesize collectionViewLayout = _collectionViewLayout;

- (instancetype)init {
  UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
  flowLayout.minimumInteritemSpacing = 0;
  flowLayout.minimumLineSpacing = 1;
  flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
  flowLayout.estimatedItemSize = CGSizeMake(kSmallArbitraryCellWidth, kSmallestCellHeight);
  return [self initWithCollectionViewLayout:flowLayout];
}

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
  self = [super initWithCollectionViewLayout:layout];
  if (self) {
    _collectionViewLayout = layout;
    _typographyScheme = [[MDCTypographyScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.collectionView setCollectionViewLayout:self.collectionViewLayout];
  self.collectionView.backgroundColor = UIColor.whiteColor;
  self.collectionView.alwaysBounceVertical = YES;
  self.automaticallyAdjustsScrollViewInsets = NO;
  self.parentViewController.automaticallyAdjustsScrollViewInsets = NO;
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
  }
#endif
  // Register cell class.
  [self.collectionView registerClass:[ManualLayoutListItemCell2 class]
          forCellWithReuseIdentifier:kManualLayoutListItemCell2ReuseIdentifier];

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(contentSizeCategoryDidChange:)
                                               name:UIContentSizeCategoryDidChangeNotification
                                             object:nil];
}

// Handles UIContentSizeCategoryDidChangeNotifications
- (void)contentSizeCategoryDidChange:(__unused NSNotification *)notification {
  [self.collectionView reloadData];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  ManualLayoutListItemCell2 *cell =
  [collectionView dequeueReusableCellWithReuseIdentifier:kManualLayoutListItemCell2ReuseIdentifier
                                            forIndexPath:indexPath];

  CGFloat cellWidth = CGRectGetWidth(self.collectionView.bounds);
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    cellWidth -=
    (collectionView.adjustedContentInset.left + collectionView.adjustedContentInset.right);
  }
#endif
  cell.cellWidth = cellWidth;

  cell.typographyScheme = _typographyScheme;
  cell.mdc_adjustsFontForContentSizeCategory = YES;

  if (indexPath.item % 2 == 0) {
    UIImage *image2 = [UIImage imageNamed:@"Cake"];
    cell.trailingImage = image2;
  }

  if (indexPath.item == 36) {
    NSLog(@"32");
  }

  NSArray *array = @[@"Sed ut perspiciatis unde omnis iste natus error",
                     @"Sed ut perspiciatis",
                     @"Sed ut perspiciatis unde omnis iste natus",
                     @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium",
                     @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium",
                     @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis",
                     @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut",
                     @"Sed ut"
                     ];

  NSInteger permutationIdx = (indexPath.item % 8);
  if (permutationIdx == 0) {
    UIImage *image = [UIImage imageNamed:@"Favorite"];
    cell.leadingImage = image;
    cell.titleText = array[(indexPath.item + 1) % 8];
    cell.detailText = array[(indexPath.item + 2) % 8];
  } else if (permutationIdx == 1) {
    UIImage *image = [UIImage imageNamed:@"Favorite"];
    cell.leadingImage = image;
    cell.titleText = array[(indexPath.item + 1) % 8];
  } else if (permutationIdx == 2) {
    UIImage *image = [UIImage imageNamed:@"Favorite"];
    cell.leadingImage = image;
  } else if (permutationIdx == 3) {
  } else if (permutationIdx == 4) {
    cell.detailText = array[(indexPath.item + 2) % 8];
  } else if (permutationIdx == 5) {
    cell.titleText = array[(indexPath.item + 1) % 8];
    cell.detailText = array[(indexPath.item + 2) % 8];
  } else if (permutationIdx == 6) {
    UIImage *image = [UIImage imageNamed:@"Favorite"];
    cell.leadingImage = image;
    cell.detailText = array[(indexPath.item + 2) % 8];
  } else if (permutationIdx == 7) {
    cell.titleText = array[(indexPath.item + 1) % 8];
  }

  return cell;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];
  [self.collectionView.collectionViewLayout invalidateLayout];
  [self.collectionView reloadData];
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

  [self.collectionView.collectionViewLayout invalidateLayout];

  [coordinator animateAlongsideTransition:nil completion:^(__unused id context) {
    [self.collectionView.collectionViewLayout invalidateLayout];
  }];
}

#pragma mark - CatalogByConvention

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Lists", @"Manual Layout Based List 2" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

+ (NSString *)catalogDescription {
  return @"Manual Layout Based List 2";
}

+ (BOOL)catalogIsPresentable {
  return YES;
}

+ (BOOL)catalogIsDebug {
  return NO;
}

@end