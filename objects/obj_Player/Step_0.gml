if (keyboard_check(vk_right)){
	hspd = 1;
	x += spd * hspd;
}else if (keyboard_check(vk_left)){
	hspd = 1;
	x -= spd * hspd;
}

if(keyboard_check_pressed(ord("H"))) obj_Inimigo.hpEnemy --;