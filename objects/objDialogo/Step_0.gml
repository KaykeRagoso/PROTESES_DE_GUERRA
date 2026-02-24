if (keyboard_check_pressed(vk_space)){ // pula pro proximode texto
index++;
index_letra = 1;
//audio_play_sound(sndGeladeiraAbrindo,2,false)
if(index >= array_length(texto)){ // destroi quando acaba 
	
	instance_destroy()
}
}