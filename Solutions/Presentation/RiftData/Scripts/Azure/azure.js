var azure = {};

azure = function ()
{
	var pub = {};
	var self = {};
	
	
	
	pub.styleSwitcher = function ()
	{
		$.stylesheetInit();
		
		$('.styleswitch').live ( 'click', function()
		{
			$.stylesheetSwitch(this.getAttribute('rel'));
			return false;
		});	
		
		return false;
	}
	
	pub.layoutInit = function ()
	{
		$('body').removeClass ('layout-fixed').removeClass ('layout-fluid');
		
		if ( $.cookie ('layout') != null )
		{
			$('body').addClass ( $.cookie ('layout') );
		}
		else
		{
			$('body').addClass ('layout-fixed');
		}
		
		return false;
	}
	
	pub.layoutSwitcher = function ()
	{
		$('.layout').live ( 'click' , function () 
		{		
			var layoutId = $(this).attr ('rel');			
			$('body').removeClass ('layout-fixed').removeClass ('layout-fluid');		
			$('body').addClass ( layoutId );		
			$.cookie( 'layout' , layoutId);
			setTimeout ( "azure.chart.draw ()", 250 );
			
		});
		
		$(window).bind ( 'resize',  function () 
		{		
			azure.chart.draw ();		
		});
		
		return false;
	}

	
	return pub;
	
}();