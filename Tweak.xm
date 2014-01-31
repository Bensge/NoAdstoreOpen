#define KNORMAL  "\x1B[0m"
#define KRED  "\x1B[31m"

%hook SpringBoard

/*
- (BOOL)_requestPermissionToOpenURL:(id)openURL withApplication:(id)application sender:(id)sender
{
	%log;
	return %orig;
}
*/

- (void)applicationOpenURL:(NSURL *)url withApplication:(id)application sender:(NSString *)sender publicURLsOnly:(BOOL)only animating:(BOOL)animating needsPermission:(BOOL)permission additionalActivationFlags:(id)flags activationHandler:(id)handler
{
	//%log;
	if (! (([[url absoluteString] hasPrefix:@"itms-appss"] || [[url absoluteString] hasPrefix:@"itms-apps"]) && [sender isEqualToString:@"com.saurik.Cydia"]) )
	{
		//NSLog(@"%sOKAY%s",KRED,KNORMAL);
		%orig;
	}
	else {
		//NSLog(@"%sNO U SSDIA!!!%s",KRED,KNORMAL);
	}
}

%end
