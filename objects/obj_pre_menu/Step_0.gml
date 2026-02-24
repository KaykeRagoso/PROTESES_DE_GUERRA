switch (state)
{
   // fade in
    case 0:
        alpha -= fade_speed;
        if (alpha <= 0)
        {
            alpha = 0;
            state = 1;
        }

        if (!sound_played)
        {
            audio_play_sound(snd_logo, 1, false);
            sound_played = true;
        }
    break;

   //time parado na logo
    case 1:
        timer++;
        if (timer >= hold_time)
        {
            state = 2;
        }
    break;

  // fade out
    case 2:
        alpha += fade_speed;
        if (alpha >= 1)
        {
            room_goto(menu); //room
        }
    break;
}
