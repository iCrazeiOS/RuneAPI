#import <UIKit/UIKit.h>

@interface BBRBasePanelView : UIView
@end

@interface HRPanelView : BBRBasePanelView
@end

%subclass HRPanelView : BBRBasePanelView
-(void)didMoveToWindow {
	%orig;

	// Create example label
	UILabel *label = [[UILabel alloc] init];
	[label setText:@"Hello, Rune!"];
	[label setTextColor:[UIColor whiteColor]];
	[label setFont:[UIFont boldSystemFontOfSize:24]];
	[label sizeToFit];
	[label setCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)];
	[self addSubview:label];
}
%end
