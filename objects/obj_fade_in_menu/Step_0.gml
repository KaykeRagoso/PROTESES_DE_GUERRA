fade_alpha -= fade_speed;

if (fade_alpha <= 0)
{
    instance_destroy();
}
