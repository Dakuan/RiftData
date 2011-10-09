azure.nav = function ()
{
	var pub = {};
	var self = {};
	
	
	pub.init = function ()
	{
		$("#nav li").each (function ()
		{
			var target = $(this);
			var child = target.children (".sub_nav");
			
			if (child.is (".sub_nav"))
			{
				target.addClass ("hasSubNav");
			}
			
			var columnCount = target.find ('.sub_nav .col').length;
			
			switch ( columnCount )
			{
				case 1:
					target.find ('.sub_nav').addClass ('one_col');				
				break;
				
				case 2:
					target.find ('.sub_nav').addClass ('two_col');
				break;
				
				case 3:
					target.find ('.sub_nav').addClass ('three_col');
				break;
			}
		});
		
		
		$('#nav li.hasSubNav').hoverIntent ({
			interval: 200, // milliseconds delay before onMouseOver
			over: self.showNav, 
			timeout: 250, // milliseconds delay before onMouseOut
			out: self.hideNav
	
			
			
		});
		
		$('#nav li.hasSubNav').live ( 'click' , self.showNav );
	}
	
	


	self.showNav = function ()
	{
		$(this).addClass ('hover');
		
		$(this).find ('.sub_nav').show ();
		
		return false;
	}
	
	self.hideNav = function ()
	{
		$(this).removeClass ('hover');
		
		$(this).find ('.sub_nav').slideUp ('fast');
		
		return false;
	}
	
	
	return pub;
}();