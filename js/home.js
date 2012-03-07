$(function() {
	
	$('#accordion').accordion({
		
		autoHeight: false,
		animated: 'easeOutBounce',
		change: function(event, ui) {
			
			var id = ui.newHeader[0].attributes.id.nodeValue;
			
			$('#' + id).slideto({
				highlight: false
			});
		}
	});
	
	$('.tooltip').wTooltip({ 
		
		content: true, 
		className: 'tooltipbox',
		callBefore: function(tooltip, node){ 
			
			$.ajax({
				type: 'POST',
				url: 'ajax/' + $(node).attr('class').split(' ')[1],
				data: 'id=' + $(node).attr('id'),
				cache: false,
				beforeSend: function(){
					
					$(tooltip).html('<div id="loading"></div>');
				},
				success: function(data){
					
					var img = $('<img />').attr('src', 'jpgraph/' + $(node).attr('class').split(' ')[1] + '/' + $(node).attr('id')).load(function() {
						
						//if (this.complete) {
							
							$(tooltip).html(data + '<br/>');
							$(tooltip).append(img);
						//}
					});
				}
			});
		} 
	});
	
	$('#refresh').click(function(){
		
		$.ajax({
			type: 'POST',
			url: 'ajax/captcha',
			cache: false,
			beforeSend: function(){
				
				$('#refresh').attr('src', 'img/refresh.gif');
				$('#captcha-refresh img:not(#refresh)').attr('src', 'img/loading.gif').attr('width', '16').attr('height', '16').addClass('captcha-image-loading');
			},
			success: function(data){
				
				$('#refresh').removeClass('captcha-image-loading');
				$('#refresh').attr('src', 'img/refresh-static.gif');
				$('#captcha-refresh img:not(#refresh)').replaceWith(data);
			}
		});
	});
	
	$('#send').click(function(){
		
		var validation = $("#contact").validationEngine('validate');
		
		if (validation)
		{
			$.ajax({
				type: 'POST',
				url: 'ajax/contact',
				cache: false,
				data: $('#contact').serialize(),
				beforeSend: function(){
					
					$('#feedback').html('');
					
					$('#send').hide();
					$('#sending').show();
				},
				complete: function(data, status){
	        
		            if (status != 'error')
		            {
		            	var JSONtext = data.responseText;
		            	
		            	//convert received string to JavaScript object
		            	var JSONobject = JSON.parse(JSONtext);
		            	
		            	$('#feedback').html(JSONobject.feedback);
		            	
		            	if (JSONobject.error == 1)
		            	{
		            		$('#captcha').val('');
		            		$('#refresh').trigger('click');
		            	}
		            	else if (JSONobject.error == 0)
		            	{
		            		$('#contact inputt[name!=token], textarea').each(function(index) {
								$(this).val('');
							});
		            	}
		            }
		            
		            $('#sending').hide();
					$('#send').show();
		        }
			});
		}
	});
	
	$('.menu ul li').find('a').each(function(index) {
		
		$(this).click(function(){
			
			$(".kaushan." + $(this).attr('id')).slideto({
				slide_duration: 'slow',
				highlight: false
			});
			
			return false;
		});
	});
	
	$("#contact").validationEngine();
});