// tempos (em segundos convertidos pra frames)
fade_speed = 0.01;
hold_time = room_speed * 1.5;

//controle
alpha = 1;          // começa escuro
state = 0;          // 0 = fade in , 1 = hold , 2 = fade out
timer = 0;

// tocar som uma vez
sound_played = false;
