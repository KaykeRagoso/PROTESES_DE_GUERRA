draw_self();
if (invencivel && current_time mod 100 < 50)
{
    draw_set_alpha(0.5);
}
else
{
    draw_set_alpha(1);
}