$(document).ready(function(){
  // Partial Functions
  function closeMain() {
	  
    $(".app").css("display","none");
	
  }
  
  function openMain() { //hide parts of ui etc
  
    $(".app").css("display","block");
	
  }
  
  function closeAll() {
	  
    $(".app").css("display","none");
	
  }
  
  function emptyEditor(){
	  
	$("textarea").val("");
	
  }
  
  function postApplication() {
	
	var _phone = $.trim($(".phone").val());
	var _licenses = $.trim($(".licenses").val());
	var _exp = $.trim($(".exp").val());
	
	var _type = "";
	
	if($("#police").is(":checked")) {
		
		_type = "police";
		
	} else if ($("#ambulance").is(":checked")) {
		
    _type = "ambulance";
    
  } else if ($("#raddningstjansten").is(":checked")) {
		
		_type = "raddningstjansten";
		
  } else if ($("#journalist").is(":checked")) {
		
		_type = "journalist";
		
  } else if ($("#cardealer").is(":checked")) {
		
		_type = "cardealer";
		
  } else if ($("#mechanic").is(":checked")) {
		
		_type = "mechanic";
		
  } else if ($("#forsakring").is(":checked")) {
		
		_type = "forsakring";
		
  } else if ($("#bennys").is(":checked")) {
		
		_type = "bennys";
		
  } else if ($("#securitas").is(":checked")) {
		
    _type = "securitas";

  } else if ($("#lawyer").is(":checked")) {
		
    _type = "lawyer";
    
  } else if ($("#nightclub").is(":checked")) {
		
		_type = "nightclub";
		
	}
	
	$.post('http://esx_joblisting2/postApplication', JSON.stringify({phone : _phone, licenses : _licenses, exp : _exp, type : _type}));
	emptyEditor();
	$.post('http://esx_joblisting2/closeMenu', JSON.stringify({}));
	
  }
  
  // Listen for NUI Events
  window.addEventListener('message', function(event){

	var item = event.data;

    if(item.openMenu == true) {
      
	  openMain();
	  
    }
    
	if(item.openMenu == false) {
	  
      closeMain();
	  
    }


  });
  // On 'Esc' call close method
  document.onkeyup = function (data) {
   
   if (data.which == 27 ) {
      
	  closeMain();
	  $.post('http://esx_joblisting2/closeMenu', JSON.stringify({}));
	  
	}
  };
  
   $(".btnClose").click(function(){
    
		$.post('http://esx_joblisting2/closeMenu', JSON.stringify({}));
    
	});
	
	$(".btnSend").click(function(){
		postApplication();
	});
	

});
 