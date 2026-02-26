if (place_meeting(x,y,obj_Player)){ // requisito
	
		instance_destroy()
		  
		var dialogo = instance_create_layer(0,0,"dialogo", objDialogo);	
		for(var i = 0;i < array_length(texto);i++){
			array_push(dialogo.texto,texto[i]);
			
		}
	}

		
	