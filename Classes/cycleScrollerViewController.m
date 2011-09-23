//
//  cycleScrollerViewController.m
//  cycleScroller
//
//  Created by KISSEI COMTEC on 11/08/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cycleScrollerViewController.h"

@implementation cycleScrollerViewController
@synthesize scView;
@synthesize pageCon;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	imgViewArray = [[NSMutableArray alloc] init];
	mImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 280, 420)];
	currentPage_ = 0;
	totalPages_ = 6;

	//将所有图片放入imageview后存入数组
	for (int i = 0; i < totalPages_; i++) {
		UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"image%d.jpg", i]];
		UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
		[imgViewArray addObject:imgView];
		[imgView release];
	}
	
	//主imageView显示第一张图片
	mImgView.image = [[imgViewArray objectAtIndex:0] image];
	[self.view addSubview:mImgView];
	[self.view sendSubviewToBack:mImgView];
	
	//设置scrollview的宽度，为3页内容
	//当前scrollview位置为第2页
	[self.scView setContentSize:CGSizeMake(320 * 3, 460)];
	self.scView.contentOffset = CGPointMake(320, 0);
	self.scView.delegate = self;

	self.pageCon.numberOfPages = totalPages_;
	self.pageCon.currentPage = 0;
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


#pragma mark -
#pragma mark scroll view delegate

//通过scrollview委托来实现首尾相连的效果
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	
	//开始滑动时，主imageview图片置空
	mImgView.image = nil;
	
	//scrollview上添加三个imageview
	//第一个imageview的图片为当前图片的前一张图片（如果当前图片为第一张则显示最后一张图片）
	//第二个imageview的图片为当前图片
	//第三个imageview的图片为当前图片的后一张图片（如果当前图片为最后一张则显示第一张图片）
	UIImageView *imView1 = [imgViewArray objectAtIndex:(currentPage_ == 0 ? (totalPages_ - 1) : (currentPage_ - 1))];
	UIImageView *imView2 = [imgViewArray objectAtIndex:currentPage_];
	UIImageView *imView3 = [imgViewArray objectAtIndex:(currentPage_ == (totalPages_ - 1) ? 0 : (currentPage_ + 1))];
	[imView1 setFrame:CGRectMake(20.0, 20.0, 280.0, 420.0)];
	[imView2 setFrame:CGRectMake(340.0, 20.0, 280.0, 420.0)];
	[imView3 setFrame:CGRectMake(660.0, 20.0, 280.0, 420.0)];
	[self.scView addSubview:imView1];
	[self.scView addSubview:imView2];	
	[self.scView addSubview:imView3];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	
	//scrollview结束滚动时判断是否已经换页
	if (self.scView.contentOffset.x > 320.0) {
		
		//如果是最后一张图片，则将主imageview内容置为第一张图片
		//如果不是最后一张图片，则将主imageview内容置为下一张图片
		if (currentPage_ < (totalPages_ - 1)) {
			currentPage_ ++;
			mImgView.image = ((UIImageView *)[imgViewArray objectAtIndex:currentPage_]).image;
		} else {
			currentPage_ = 0;
			mImgView.image = ((UIImageView *)[imgViewArray objectAtIndex:currentPage_]).image;
		}

	} else if (self.scView.contentOffset.x < 320.0) {
		
		//如果是第一张图片，则将主imageview内容置为最后一张图片
		//如果不是第一张图片，则将主imageview内容置为上一张图片
		if (currentPage_ > 0) {
			currentPage_ --;
			mImgView.image = ((UIImageView *)[imgViewArray objectAtIndex:currentPage_]).image;
		} else {
			currentPage_ = totalPages_ - 1;
			mImgView.image = ((UIImageView *)[imgViewArray objectAtIndex:currentPage_]).image;
		}

	} else {
		
		//没有换页，则主imageview仍然为之前的图片
		mImgView.image = ((UIImageView *)[imgViewArray objectAtIndex:currentPage_]).image;
		NSLog(@"current offset :%f", self.scView.contentOffset.x);
	}
	
	//始终将scrollview置为第2页
	[self.scView setContentOffset:CGPointMake(320.0, 0.0)];
	
	//移除scrollview上的图片
	for (UIImageView *theView in [self.scView subviews]) {
		[theView removeFromSuperview];
	}
	self.pageCon.currentPage = currentPage_;
}

@end
