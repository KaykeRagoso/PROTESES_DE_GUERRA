if global.menina_resgatada = true{
if instance_place(x,y,obj_Player){
	instance_destroy()
	instance_create_layer(0, 0, "Instances", obj_fade_missao1);
}
}

if keyboard_check_pressed(vk_f10){
global.menina_resgatada = true
}