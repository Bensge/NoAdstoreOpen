#import <Foundation/Foundation.h>
#import <objc/runtime.h>


%group SB70
%hook SpringBoard
//iOS 7.0
- (void)applicationOpenURL:(NSURL *)url withApplication:(id)application sender:(NSString *)sender publicURLsOnly:(BOOL)only animating:(BOOL)animating needsPermission:(BOOL)permission additionalActivationFlags:(id)flags activationHandler:(/*^block*/id)handler
{
	if (!( ([[url absoluteString] hasPrefix:@"itms-appss"] || [[url absoluteString] hasPrefix:@"itms-apps"]) && [sender isEqualToString:@"com.saurik.Cydia"]) )
	{
		%orig;
	}
	else {
		//Don't open
	}
}
%end
%end


%group SB71
%hook SpringBoard
//iOS 7.1
-(void)applicationOpenURL:(NSURL *)url withApplication:(id)application sender:(NSString *)sender publicURLsOnly:(BOOL)only animating:(BOOL)animating needsPermission:(BOOL)permission activationContext:(id)context activationHandler:(/*^block*/ id)handler
{
	if (! (([[url absoluteString] hasPrefix:@"itms-appss"] || [[url absoluteString] hasPrefix:@"itms-apps"]) && [sender isEqualToString:@"com.saurik.Cydia"]) )
	{
		%orig;
	}
	else {
		//Don't open
	}
}
%end
%end


%ctor
{
	Class SpringBoard = objc_getClass("SpringBoard");

	//iOS 7.0
	if ([SpringBoard instancesRespondToSelector:@selector(applicationOpenURL:withApplication:sender:publicURLsOnly:animating:needsPermission:additionalActivationFlags:activationHandler:)])
	{
		%init(SB70);
	}
	//iOS 7.1
	else if ([SpringBoard instancesRespondToSelector:@selector(applicationOpenURL:withApplication:sender:publicURLsOnly:animating:needsPermission:activationContext:activationHandler:)])
	{
		%init(SB71);
	}
	else
	{
		NSLog(@"NoAdstoreOpen: Unsupported SpringBoard Version!");
	}
}