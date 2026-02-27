if instance_place(x,y,obj_Player){
	global.vida_atual = 0
	obj_Player.state = PlayerState.DEATH
	
}